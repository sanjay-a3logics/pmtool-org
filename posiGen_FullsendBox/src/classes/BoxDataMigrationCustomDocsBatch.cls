public with sharing class BoxDataMigrationCustomDocsBatch implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful{
  
  public String base_url = 'https://app.box.com/files/0/f/';
  public Integer record_count = 0; 
  public Integer record_count_stop = 0;
  
  public BoxDataMigrationCustomDocsBatch(Integer record_count_stop){
    this.record_count_stop = record_count_stop;
  } 
  
  public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('select id, name, body,bodylength , parentId from Attachment where parentId in (select id from Attachment__c)');
  }
    
    public void execute(Database.BatchableContext BC, List<Attachment> attachmentList){
      List<Box_Error__c> bxErrList = new List<Box_Error__c>();  
       try{
         
            Map<Id,String> fvSubFoldersMap = new Map<Id,String>();
            for(Sub_folder__c subFolder : [select cf_opportunity__c, cf_box_folder_id__c, name from sub_folder__c where name = 'Funding-Vendor']){
                fvSubFoldersMap.put(subFolder.cf_opportunity__c, subFolder.cf_box_folder_id__c);
            }
            
            Map<String,String> customAttachmentsCMap = new Map<String,String>();
             Map<String,String> errorMap = new Map<String,String>();
            for(Attachment__c att : [select id, project__r.opportunity__c from attachment__c]){
                 if(fvSubFoldersMap.containsKey(att.project__r.opportunity__c)){
                  
                        customAttachmentsCMap.put(att.id, fvSubFoldersMap.get(att.project__r.opportunity__c));
                        errorMap.put(att.id,att.project__r.opportunity__c);
                 }
            }
  
            Box__c bx = Box__c.getInstance();
            
            for(Attachment attachmentObj : attachmentList){
               if(errorMap.get(attachmentObj.parentId) != null){
               if(attachmentObj.body.size()<=4000000){
                    system.debug('############################### attachmentObj name'+attachmentObj.name); 
                
                    String boundary = '----------------------------'+String.valueOf(DateTime.now().getTime())+'';
                    String header = '--'+boundary+'\nContent-Disposition: form-data; name="file"; filename="'+attachmentObj.name+'";\nContent-Type: application/octet-stream';
                    String footer = '--'+boundary+'--';
                    String headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
                    transient String bodyEncoded='';
                    transient String last4Bytes ='';
                    while(headerEncoded.endsWith('=')){
                        header+=' ';
                        headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
                    }
                   bodyEncoded = EncodingUtil.base64Encode(attachmentObj.body);
                   
                   Blob bodyBlob = null;
                 if(bodyEncoded!=null && bodyEncoded!='') 
                   last4Bytes = bodyEncoded.substring(bodyEncoded.length()-4,bodyEncoded.length());
                 if(last4Bytes.endsWith('==')) {
                    last4Bytes = last4Bytes.substring(0,2) + '0K';
                
                    bodyEncoded = bodyEncoded.substring(0,bodyEncoded.length()-4) + last4Bytes; 
                    String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
                    bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);
                  } 
                 else if(last4Bytes.endsWith('=')) {
                    last4Bytes = last4Bytes.substring(0,3) + 'N';
                    bodyEncoded = bodyEncoded.substring(0,bodyEncoded.length()-4) + last4Bytes;
                    footer = '\n' + footer;
                    String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer)); 
                    bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);
                   }
                 else{
                    footer = '\r\n' + footer;
                    String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
                    bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);  
                  }                
                HttpRequest reqfile = new HttpRequest();
             
                reqfile.setHeader('Content-Type', 'multipart/form-data; boundary=' + boundary);
                // Set method and endpoint
                reqfile.setMethod('POST');
                reqfile.setEndpoint('https://upload.box.com/api/2.0/files/content?parent_id='+customAttachmentsCMap.get(attachmentObj.parentId));
                reqfile.setBodyAsBlob(bodyBlob);
                reqfile.setTimeout(120000);
                reqfile.setHeader('Authorization','Bearer '+bx.BoxAccess_Token__c);        
                reqfile.setHeader('Content-Length',String.valueof(reqfile.getBodyAsBlob().size()));
                // Send HTTP request and get HTTP response
                Http httpfile = new Http();
                HTTPResponse resfile = httpfile.send(reqfile);
                if(resfile.getStatusCode() == 201){
                      system.debug('######################################## resfile.getBody()'+ resfile.getBody());
                             FileWrapper fw = (FileWrapper) System.JSON.deserialize(resfile.getBody(), FileWrapper.class);
                             for(Entries_Z entry: fw.entries){
                               
                               system.debug('######################################## entry.parent.id'+ entry.parent.id);
                               system.debug('######################################## parent_folder'+ customAttachmentsCMap.get(attachmentObj.parentId));
                             if(entry.parent.id == customAttachmentsCMap.get(attachmentObj.parentId)){
                                 
                                 Box_Error__c bxerr = new Box_Error__c();
                                 bxerr.Opportunity__c = errorMap.get(attachmentObj.parentId); 
                                 bxerr.name = String.valueOf(resfile.getStatusCode()); 
                                 bxerr.Message__c = 'Attachment id-'+attachmentObj.id; 
                                 bxerr.Body__c = resfile.getBody();
                                 bxerr.Type__c = 'Custom Doc';
                                 bxerr.Status__c = 'Success';
                                 
                              // constructing manual url
                                 String manual_url = base_url;
                                 manual_url += customAttachmentsCMap.get(attachmentObj.parentId);
                                 manual_url += '/1/';
                                 manual_url += 'f_'+entry.id;
                                 
                                 bxerr.Manual_Url__c = manual_url;
                                 
                                 system.debug('######################################## manual_url'+ manual_url);
                                 
                                 bxErrList.add(bxerr);
                               }
                               else{
                                 Box_Error__c bxerr = new Box_Error__c();
                                 bxerr.Opportunity__c = errorMap.get(attachmentObj.parentId);
                                 bxerr.name = String.valueOf(resfile.getStatusCode()); 
                                 bxerr.Message__c = 'Parent not matched for attachment-'+attachmentObj.id; 
                                 bxerr.Body__c = resfile.getBody();
                                 bxerr.Type__c = 'Custom Doc';
                                 bxerr.Status__c = 'Error';
                           
                                 bxErrList.add(bxerr);
                               
                             }     
                      }
                    
                  }
                 else{
                          Box_Error__c bxerr = new Box_Error__c();
                           bxerr.Opportunity__c = errorMap.get(attachmentObj.parentId); 
                           bxerr.name = String.valueOf(resfile.getStatusCode()); 
                           bxerr.Message__c = 'Attachment id-'+attachmentObj.id; 
                           bxerr.Body__c = resfile.getBody();
                           bxerr.Type__c = 'Custom Doc';
                           bxerr.Status__c = 'Error';
                     
                           bxErrList.add(bxerr);
                    }  
                }                    
             else{
                    Box_Error__c bxerr = new Box_Error__c();
                     bxerr.Opportunity__c = errorMap.get(attachmentObj.parentId);
                     bxerr.name = 'Heap Size Exceed'; 
                     bxerr.Message__c = 'Attachment id-'+attachmentObj.id; 
                     bxerr.Body__c = '';
                     bxerr.Type__c = 'Custom Doc';
                     bxerr.Status__c = 'Error';
               
                     bxErrList.add(bxerr);
               
             
                 }   
               }
            }
            record_count += attachmentList.size();
            if(record_count == record_count_stop){
               system.debug('######################################## job aborted record_count is'+ record_count);
               System.abortJob(BC.getJobId()); 
             }
       }
       catch(Exception e){
                system.debug('###############################'+e.getMessage()); 
                Box_Error__c bxerr = new Box_Error__c();
                bxerr.name = 'Exception'; 
                bxerr.Message__c = e.getMessage(); 
                bxerr.Body__c = e.getStackTraceString();
                bxerr.Type__c = 'Custom Doc';
                bxerr.Status__c = 'Error';
                bxErrList.add(bxerr);
         
       }
       
       finally{
         insert bxErrList;
       }
    }
    
    public void finish(Database.BatchableContext BC){}
    
    public class FileWrapper {
    public Integer total_count;
    public List<Entries_Z> entries;
  }
  
  public class Parent {
    public String type;
    public String id;
    public String sequence_id;
    public String etag;
    public String name;
  }


  public class Entries_Z {
    public String type;
    public String id;
    public String sequence_id;
    public String etag;
    public String sha1;
    public String name;
    public String description;
    public Integer size;
    public String created_at;
    public String modified_at;
    public Object trashed_at;
    public Object purged_at;
    public String content_created_at;
    public String content_modified_at;
    public Object shared_link;
    public Parent parent;
    public String item_status;
  }
}