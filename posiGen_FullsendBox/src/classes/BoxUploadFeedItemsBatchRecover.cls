public with sharing class BoxUploadFeedItemsBatchRecover implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful{
  public static String base_url = 'https://app.box.com/files/0/f/';
  public Integer record_count = 0; 
  public Integer record_count_stop = 0;
  
  public BoxUploadFeedItemsBatchRecover(Integer record_count_stop){
    this.record_count_stop = record_count_stop;
  } 
  
  public Database.QueryLocator start(Database.BatchableContext BC){

       return Database.getQueryLocator('select id, name, message__c, type__c  from box_error__c where type__c = \'Feed Item Standard\' and name = \'401\'');
  }
    
  public void execute(Database.BatchableContext BC, List<Box_error__c> boxErrorList){
      List<box_error__c> bxErrList = new List<box_error__c>();
       try{
               
               Set<String> attachmentSet = new Set<String>();
               Map<String,Box_error__c> bxErrorMap = new Map<String,Box_error__c>();
               for(Box_error__c bx: boxErrorList){
                  List<String> a1 = bx.Message__c.split('-');
                  if(a1 != null && a1.size()>1){
                      attachmentSet.add(a1[1]);
                      bxErrorMap.put(a1[1],bx); 
                  }
        
               }
               
              
                    
               Map<id,String> subFolderMap = new Map<id,String>();
               for(Sub_folder__c sf: [select cf_opportunity__c, cf_box_folder_id__c from sub_folder__c where name = 'Sales']){
                   subFolderMap.put(sf.cf_opportunity__c, sf.cf_box_folder_id__c);
               }
            
               Map<String,Integer> dupNameList = new Map<String,Integer>();
               List<FeedItem> distinctRecords = new List<FeedItem>();
               List<FeedItem> duplicateRecords = new List<FeedItem>();
               Integer count = 0;
               for(FeedItem oppObj:  [Select id, ContentFileName from FeedItem where id in: attachmentSet]){ 
                      Boolean found = false;
                      
                      for(Integer i=0; i< distinctRecords.size(); i++){
                            if(oppObj.ContentFileName.equalsIgnoreCase(distinctRecords[i].ContentFileName)){ 
                                found=true;
                                duplicateRecords.add(oppObj);
                                if(!dupNameList.containsKey(oppObj.ContentFileName)){
                                    dupNameList.put(oppObj.ContentFileName,1);
                                }
                                Integer c = dupNameList.get(oppObj.ContentFileName);
                                c++;
                                dupNameList.put(oppObj.ContentFileName,c);
                            }
                      }
                      if(!found){
                        distinctRecords.add(oppObj);
                      }
               } 
                
               for(FeedItem att: [SELECT id, ContentFileName, ContentData, ContentSize, contenttype, ParentId FROM FeedItem WHERE id in: attachmentSet]){
               
                     Schema.SObjectType sobjectType = att.ParentId.getSObjectType();
                     String sobjectName = sobjectType.getDescribe().getName();
               
                     if(sobjectName == 'Opportunity'){  
               
                     if(att.ContentSize<=4000000){
                       
                        Integer namecount = dupNameList.get(att.ContentFileName);
                        String subFolderId = subFolderMap.get(att.parentId);
                        if(subFolderId!=null){ 
                       
                            if(namecount > 1){
                                uploadDocument(2,att, subFolderId, bxErrList, bxErrorMap);
                            }
                            else{
                                uploadDocument(1,att, subFolderId, bxErrList, bxErrorMap);
                            }
                        }  

                    }
                   else{
                         Box_Error__c bxerr = new Box_Error__c();
                         bxerr.Opportunity__c = att.parentId;
                         bxerr.name = 'Heap Size Exceed'; 
                         bxerr.Message__c = 'Feed Item id-'+att.id; 
                         bxerr.Body__c = '';
                         bxerr.Type__c ='Feed Item Standard';
                         bxerr.Status__c = 'Error';
                   
                         bxErrList.add(bxerr);
                  
                     }
                 }
             }
             record_count += boxErrorList.size();
             if(record_count == record_count_stop){
               system.debug('######################################## job aborted record_count is'+ record_count);
               System.abortJob(BC.getJobId());
             }
         }

       catch(Exception e){
         Box_Error__c bxerr = new Box_Error__c();
         bxerr.name = 'Batch error'; 
         bxerr.Message__c = e.getMessage(); 
         bxerr.Body__c = e.getStackTraceString();
         bxerr.Type__c ='Feed Item Standard';
         bxerr.Status__c = 'Error';
         bxErrList.add(bxerr);
         
       }
       
       finally{
         upsert bxErrList;   
       }
    }
    
 /* Author: Irfan Khan (Appcino Technologies Pvt. Ltd.)
  * Function for uploading documents 
  */
  public static void uploadDocument(Integer count, FeedItem att, String subFolderId, List<box_error__c> bxErrList, Map<String,Box_error__c> bxErrorMap){
    
    try{
          system.debug('################################ count'+count);
          String boundary = '----------------------------'+String.valueOf(DateTime.now().getTime())+'';
          String attName ='';
              if(count>1){
              
                        string s = att.ContentFileName;
                        string sext = att.contenttype;
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
                            //system.assert(false,name);
                            if(partext[1]==part[part.size()-1]){
                                name = name+'('+count+').'+part[part.size()-1];
                            }
                            else{
                                String extension = ''; 
                                if(partext[1] == 'plain' && part[part.size()-1] == 'txt'){
                                    extension = 'txt';
                                    name = name+'('+count+')'+'.'+extension;
                                }
                                else if(partext[1] == 'plain' && part[part.size()-1] !='txt'){
                                    extension = 'txt';
                                    name = name+'.'+part[part.size()-1]+'('+count+')'+'.'+extension;
                                }
                                else if(partext[1] == 'jpeg' && part[part.size()-1] == 'jpg'){
                                    extension = 'jpg';
                                    name = name+'('+count+')'+'.'+extension;
                                }
                                else{
                                    extension = partext[1];
                                    name = name+'.'+part[part.size()-1]+'('+count+')'+'.'+extension;
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
                            name = s+'('+count+').'+extension;
                        }
    
                       attName =name;
                        
                }
                else{
                 
                    string s = att.ContentFileName;
                        string sext = att.contenttype;
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
                    
                    }  
                    String header = '--'+boundary+'\nContent-Disposition: form-data; name="file"; filename="'+attName+'";\nContent-Type: application/octet-stream';
                    String footer = '--'+boundary+'--';
                    String headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
                    transient String bodyEncoded='';
                    transient String last4Bytes ='';
                    while(headerEncoded.endsWith('=')){
                        header+=' ';
                        headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
                    }
                     bodyEncoded = EncodingUtil.base64Encode(att.ContentData);
                       
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
                
                
                  Box__c bx = Box__c.getInstance();
                
                  HttpRequest reqfile = new HttpRequest();
                                        
                                    
                reqfile.setHeader('Content-Type', 'multipart/form-data; boundary=' + boundary);
                reqfile.setMethod('POST');
                reqfile.setEndpoint('https://upload.box.com/api/2.0/files/content?parent_id='+subFolderId);
                reqfile.setBodyAsBlob(bodyBlob);
                reqfile.setHeader('Authorization','Bearer '+bx.BoxAccess_Token__c);        
                reqfile.setHeader('Content-Length',String.valueof(reqfile.getBodyAsBlob().size()));
                
                // Send HTTP request and get HTTP response
                Http httpfile = new Http();
                HTTPResponse resfile = httpfile.send(reqfile);
        
                if(resfile.getStatusCode() == 201){
                    FileWrapper fw = (FileWrapper) System.JSON.deserialize(resfile.getBody(), FileWrapper.class);
                     for(Entries_Z entry: fw.entries){
                   
                   system.debug('######################################## entry.parent.id'+ entry.parent.id);
                   system.debug('######################################## parent_folder'+ subFolderId);
                   //System.assert(false,entry.parent.id+'         '+att.parentId);
                 if(entry.parent.id == subFolderId){
                     
                     Box_Error__c bxerr = bxErrorMap.get(att.id);
                     bxerr.Opportunity__c =att.parentId; 
                     bxerr.name = String.valueOf(resfile.getStatusCode()); 
                     bxerr.Message__c = 'Feed Item Id-'+att.id; 
                     bxerr.Body__c = resfile.getBody();
                     bxerr.Type__c = 'Feed Item Standard';
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
                else{
                   Box_Error__c bxerr = new Box_Error__c();
                   bxerr.Opportunity__c = att.parentId; 
                   bxerr.name = String.valueOf(resfile.getStatusCode()); 
                   bxerr.Message__c = 'parent not match-'+att.id; 
                   bxerr.Body__c = resfile.getBody();
                   bxerr.Type__c ='Feed Item Standard';
                   bxerr.Status__c = 'Error';
             
                   bxErrList.add(bxerr);
            
               } 
                
      
            } 
      
        }
        else if(resfile.getStatusCode() == 409){
            system.debug('####################################### recursive');
            count++;
            system.debug('####################################### recursive count'+count);
            uploadDocument(count, att, subFolderId, bxErrList, bxErrorMap);
        }
        else{
           Box_Error__c bxerr = new Box_Error__c();
           bxerr.Opportunity__c = att.parentId; 
           bxerr.name = String.valueOf(resfile.getStatusCode()); 
           bxerr.Message__c = 'Attachment id-'+att.id; 
           bxerr.Body__c = resfile.getBody();
           bxerr.Type__c ='Feed Item Standard';
           bxerr.Status__c = 'Error';
     
           bxErrList.add(bxerr);
    
       }
       }
       catch(Exception e){
                
             Box_Error__c bxerr = new Box_Error__c();
             bxerr.name = 'FeedItem Batch Exception'; 
             bxerr.Message__c = e.getMessage(); 
             bxerr.Body__c = e.getStackTraceString();
             bxerr.Type__c ='Feed Item Standard';
             bxerr.Status__c = 'Error';
             bxErrList.add(bxerr);
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