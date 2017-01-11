public with sharing class UploadUnlogAttachemntsDocusign implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful{
    public  String base_url = 'https://app.box.com/files/0/f/';
    public  Integer record_count = 0; 
    public  Integer record_count_stop = 0;
    public  List<String> attlst;
    public  Set <String> parentlst;
    public  Set<String> opplst;
    public Map<Id,String> salesSubFoldersMap;
    public Map<Id,String> applicationSubFoldersMap;
   
   public  UploadUnlogAttachemntsDocusign(List<String>attlst,Set <String> parentlst,Set<String> opplst, Integer record_count_stop){
      this.record_count_stop = record_count_stop;
      this.attlst =attlst;
      this.parentlst=parentlst;
      this.opplst = opplst;
      
    } 
   
    public Database.QueryLocator start(Database.BatchableContext BC){
            salesSubFoldersMap = new Map<Id,String>();
            for(Sub_folder__c subFolder : [select cf_opportunity__c, cf_box_folder_id__c, name from sub_folder__c where name = 'Sales' and cf_opportunity__c in:opplst]){
                salesSubFoldersMap.put(subFolder.cf_opportunity__c, subFolder.cf_box_folder_id__c);
            }
            
            system.debug('######################################## salesSubFoldersMap '+salesSubFoldersMap );

            applicationSubFoldersMap = new Map<Id,String>();
            for(Sub_folder__c subFolder : [select cf_opportunity__c, cf_box_folder_id__c, name from sub_folder__c where name = 'Application' and cf_opportunity__c in:opplst]){
                applicationSubFoldersMap.put(subFolder.cf_opportunity__c, subFolder.cf_box_folder_id__c);
            }        
        
         return Database.getQueryLocator('select id, name, body,bodylength , parentId from Attachment where id in :attlst');
     } 
    
    public void execute(Database.BatchableContext BC, List<Attachment> attachmentList){
      List<Box_Error__c> bxErrList = new List<Box_Error__c>();  
       try{
         
            
            Map<String,String> docuSignMap = new  Map<String,String>();
            Map<String,String> docuSignSubjectMap = new  Map<String,String>();
            for(dsfs__DocuSign_Status__c docSign: [select id, dsfs__Subject__c, dsfs__Opportunity__c from dsfs__DocuSign_Status__c where id in:parentlst]){
               
                    docuSignMap.put(docSign.id,docSign.dsfs__Opportunity__c);
                    docuSignSubjectMap.put(docSign.id,docSign.dsfs__Subject__c);
               }
               
            
  
            Box__c bx = Box__c.getInstance();
            system.debug('hiiiiiii'+attachmentList.size());
            for(Attachment attachmentObj : attachmentList){
            system.debug('delllll'+docuSignMap.get(attachmentObj.parentId));
               if(docuSignMap.get(attachmentObj.parentId)!= null){
               if(attachmentObj.body.size()<=10000000){
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
               
               String parent_folder;
               system.debug('heee'+docuSignSubjectMap.get(attachmentObj.parentId));
              if(docuSignSubjectMap.get(attachmentObj.parentId)=='Application'){
                 parent_folder = applicationSubFoldersMap.get(docuSignMap.get(attachmentObj.parentId));
                 }
               else{
                 parent_folder = salesSubFoldersMap.get(docuSignMap.get(attachmentObj.parentId));
                  }   
               
                HttpRequest reqfile = new HttpRequest();
                reqfile.setHeader('Content-Type', 'multipart/form-data; boundary=' + boundary);
                // Set method and endpoint
                reqfile.setMethod('POST');
                reqfile.setEndpoint('https://upload.box.com/api/2.0/files/content?parent_id='+parent_folder);
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
                               system.debug('######################################## parent_folder'+ parent_folder);
                          
                             if(entry.parent.id == parent_folder ){
                                 
                                 Box_Error__c bxerr = new Box_Error__c();
                                 bxerr.Opportunity__c = docuSignMap.get(attachmentObj.parentId); 
                                 bxerr.name = String.valueOf(resfile.getStatusCode()); 
                                 bxerr.Message__c = 'Attachment id-'+attachmentObj.id; 
                                 bxerr.Body__c = resfile.getBody();
                                 bxerr.Type__c = 'Docusign Doc Uploaded';
                                 bxerr.Not_Uploaded_Id__c=attachmentObj.id;
                                 bxerr.Status__c = 'Success';
                                 bxerr.done__c =true;
                                 
                              // constructing manual url
                                 String manual_url = base_url;
                                 manual_url += parent_folder;
                                 manual_url += '/1/';
                                 manual_url += 'f_'+entry.id;
                                 
                                 bxerr.Manual_Url__c = manual_url;
                                 
                                 system.debug('######################################## manual_url'+ manual_url);
                                 
                                 bxErrList.add(bxerr);
                               }
                               else{
                                 Box_Error__c bxerr = new Box_Error__c();
                                 bxerr.Opportunity__c = docuSignMap.get(attachmentObj.parentId);
                                 bxerr.name = String.valueOf(resfile.getStatusCode()); 
                                 bxerr.Message__c = 'Parent not matched for attachment-'+attachmentObj.id; 
                                 bxerr.Type__c = 'Docusign Doc Not Uploaded';
                                 bxerr.Not_Uploaded_Id__c=attachmentObj.id;
                                 bxerr.Status__c = 'Error';
                                 bxerr.done__c =false;
                                 bxErrList.add(bxerr);
                               
                             }     
                      }
                    
                  }
                 else{
                          Box_Error__c bxerr = new Box_Error__c();
                           bxerr.Opportunity__c = docuSignMap.get(attachmentObj.parentId); 
                           bxerr.name = String.valueOf(resfile.getStatusCode()); 
                           bxerr.Message__c = 'Attachment id-'+attachmentObj.id; 
                           bxerr.Body__c = resfile.getBody();
                           bxerr.Type__c = 'Docusign Doc Not Uploaded';
                           bxerr.Not_Uploaded_Id__c=attachmentObj.id;
                           bxerr.Status__c = 'Error';
                           bxerr.done__c =false;
                     
                           bxErrList.add(bxerr);
                    }  
                }                    
             else{
                    Box_Error__c bxerr = new Box_Error__c();
                     bxerr.Opportunity__c = docuSignMap.get(attachmentObj.parentId);
                     bxerr.name = 'Heap Size Exceed'; 
                     bxerr.Message__c = 'Attachment id-'+attachmentObj.id; 
                     bxerr.Body__c = ''+attachmentObj.body.size();
                     bxerr.Type__c = 'Docusign Doc Not Uploaded';
                     bxerr.Not_Uploaded_Id__c=attachmentObj.id;
                     bxerr.Status__c = 'Error';
                     bxerr.done__c =false;
               
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
                bxerr.Type__c = 'Docusign Doc Not Uploaded';
                bxerr.Not_Uploaded_Id__c='';
                bxerr.Status__c = 'Error';
                bxerr.done__c =false;
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