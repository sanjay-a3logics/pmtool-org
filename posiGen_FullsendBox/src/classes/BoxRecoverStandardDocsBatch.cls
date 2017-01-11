public with sharing class BoxRecoverStandardDocsBatch implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful{

  public String base_url = 'https://app.box.com/files/0/f/';
  public Integer record_count = 0; 
  public Integer record_count_stop = 0;
  public string current_attachment;
  public string current_opportunity;
  
  public BoxRecoverStandardDocsBatch(Integer record_count_stop){
    this.record_count_stop = record_count_stop;
  } 
  
  public Database.QueryLocator start(Database.BatchableContext BC){
     
     return Database.getQueryLocator('select id, parentId from attachment where parentid in (select id from opportunity)');
  }
  
  public void execute(Database.BatchableContext BC, List<Attachment> attachmentList){
       List<Box_Error__c> bxErrList = new List<Box_Error__c>();  
       try{
       
            Set<String> parentIdSet = new Set<String>();
            Set<String> attachmentIdSet = new Set<String>();
            for(Attachment att: attachmentList){
                parentIdSet.add(att.parentId);
                attachmentIdSet.add(att.id);
            }
         
            Map<Id,String> salesSubFoldersMap = new Map<Id,String>();
            for(Sub_folder__c subFolder : [select cf_opportunity__c, cf_box_folder_id__c, name from sub_folder__c where name = 'sales' and cf_opportunity__c in: parentIdSet]){
                salesSubFoldersMap.put(subFolder.cf_opportunity__c, subFolder.cf_box_folder_id__c);
            }
           
  
            Box__c bx = Box__c.getInstance();
            
            for(Attachment attachmentObj : [select id, parentId, name, body, contenttype from attachment where id in: attachmentIdSet]){
               
               if(attachmentObj.body.size()<=4000000){
                   
                   current_attachment = attachmentObj.id;
                   current_opportunity = attachmentObj.parentId;
                   String subFolderId = salesSubFoldersMap.get(attachmentObj.parentId);
                    String attName ='';
                    string s = attachmentObj.name;
                        string sext = attachmentObj.contenttype;
                        string[] part = s.split('\\.');
                        string[] partext = sext.split('\\/');
                        string name = '';
                        if(part.size() > 1){
                            for(integer j=0; j<=part.size()-2;j++){
                                if(j==part.size()-2){
                                    name += part[j];    
                                }
                                else{
                                    name += part[j]+'.';
                                }
                            }
                            
                            if(partext[1]==part[part.size()-1]){
                               name = name+'.'+part[part.size()-1];
                            }
                            else{
                                String extension = ''; 
                                if(partext[1] == 'plain' && part[part.size()-1] == 'txt'){
                                    extension = 'txt';
                                    name = name+'.'+extension;
                                }
                                else if(partext[1] == 'plain' && part[part.size()-1] !='txt'){
                                    extension = 'txt';
                                    name = name+'.'+part[part.size()-1]+'.'+extension;
                                }
                                else if(partext[1] == 'jpeg' && part[part.size()-1] == 'jpg'){
                                    extension = 'jpg';
                                    name = name+'.'+extension;
                                }
                                else{
                                    extension = partext[1];
                                    name = name+'.'+part[part.size()-1]+'.'+extension;
                                }
                            }
                        }
                        else{
                           
                            String extension = ''; 
                            if(partext[1] == 'plain'){
                                extension = 'txt';
                            }
                            else{
                                extension = partext[1];
                            }
                            name = s+'.'+extension;
                        }
        
                    attName = name;
               
                    system.debug('############################### attachmentObj name'+attName); 
                
                    String boundary = '----------------------------'+String.valueOf(DateTime.now().getTime())+'';
                    String header = '--'+boundary+'\nContent-Disposition: form-data; name="file"; filename="'+attName+'";\nContent-Type: application/octet-stream';
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
                reqfile.setEndpoint('https://upload.box.com/api/2.0/files/content?parent_id='+subFolderId);
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
                               system.debug('######################################## parent_folder'+ subFolderId);
                             if(entry.parent.id == subFolderId){
                                 
                                 Box_Error__c bxerr = new Box_Error__c();
                                 bxerr.Opportunity__c = attachmentObj.parentId; 
                                 bxerr.name = String.valueOf(resfile.getStatusCode()); 
                                 bxerr.Message__c = 'Attachment id-'+attachmentObj.id; 
                                 bxerr.Body__c = resfile.getBody();
                                 bxerr.Type__c = 'Standard Doc Recover';
                                 bxerr.Status__c = 'Success';
                                 
                              // constructing manual url
                                 String manual_url = base_url;
                                 manual_url += subFolderId;
                                 manual_url += '/1/';
                                 manual_url += 'f_'+entry.id;
                                 
                                 bxerr.Manual_Url__c = manual_url;
                                 
                                 system.debug('######################################## manual_url'+ manual_url);
                                 
                                 bxErrList.add(bxerr);
                               }
                                
                      }
                    
                  }
                 else{
                          Box_Error__c bxerr = new Box_Error__c();
                           bxerr.Opportunity__c = attachmentObj.parentId; 
                           bxerr.name = String.valueOf(resfile.getStatusCode()); 
                           bxerr.Message__c = attachmentObj.id; 
                           bxerr.Body__c = resfile.getBody();
                           bxerr.Type__c = 'Standard Doc Recover';
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
                bxerr.Opportunity__c = current_opportunity; 
                bxerr.name = 'Exception'; 
                bxerr.Message__c = current_attachment; 
                bxerr.Body__c = e.getMessage()+'--'+e.getStackTraceString();
                bxerr.Type__c = 'Standard Doc Recover';
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