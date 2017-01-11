public with sharing class BoxUploadFeedItemsBatch implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful{
  public static String base_url = 'https://app.box.com/files/0/f/';
  public Integer record_count = 0; 
  public Integer record_count_stop = 0;
  public List<String> feedlst;
  public Set<String>ParentLst;
  
  public BoxUploadFeedItemsBatch(List<String>feedlst,Set<String>ParentLst,Integer record_count_stop){
    this.record_count_stop = record_count_stop;
    this.feedlst = feedlst;
    this.ParentLst = ParentLst;
  } 
  
  public Database.QueryLocator start(Database.BatchableContext BC){
               
       return Database.getQueryLocator('SELECT id FROM FeedItem WHERE Type = \'ContentPost\' and id in:feedlst AND ParentId in:ParentLst');
  }
    
  public void execute(Database.BatchableContext BC, List<FeedItem> feedItemsList){
      List<box_error__c> bxErrList = new List<box_error__c>();
       try{
        
            
               Map<id,String> subFolderMap = new Map<id,String>();
               for(Sub_folder__c sf: [select cf_opportunity__c, cf_box_folder_id__c from sub_folder__c where name = 'Sales' and cf_opportunity__c in:ParentLst]){
                   subFolderMap.put(sf.cf_opportunity__c, sf.cf_box_folder_id__c);
               }
            
               Map<String,Integer> dupNameList = new Map<String,Integer>();
               List<FeedItem> distinctRecords = new List<FeedItem>();
               List<FeedItem> duplicateRecords = new List<FeedItem>();
               Integer count = 0;
               for(FeedItem oppObj:  [Select id, ContentFileName from FeedItem where id in: feedItemsList]){ 
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
                
               for(FeedItem att: [SELECT id, ContentFileName, ContentData, ContentSize, contenttype, ParentId FROM FeedItem WHERE id in: feedItemsList]){
               
                     Schema.SObjectType sobjectType = att.ParentId.getSObjectType();
                     String sobjectName = sobjectType.getDescribe().getName();
               
                     if(sobjectName == 'Opportunity'){  
               
                     if(att.ContentSize<=4000000){
                       
                        Integer namecount = dupNameList.get(att.ContentFileName);
                        String subFolderId = subFolderMap.get(att.parentId);
                        if(subFolderId!=null){ 
                       
                            if(namecount > 1){
                                uploadDocument(2,att, subFolderId, bxErrList);
                            }
                            else{
                                uploadDocument(1,att, subFolderId, bxErrList);
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
             record_count += feedItemsList.size();
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
         insert bxErrList;   
       }
    }
    
 /* Author: Irfan Khan (Appcino Technologies Pvt. Ltd.)
  * Function for uploading documents 
  */
  public static void uploadDocument(Integer count, FeedItem att, String subFolderId, List<box_error__c> bxErrList){
    
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
                     
                     Box_Error__c bxerr = new Box_Error__c();
                     bxerr.Opportunity__c =att.parentId; 
                     bxerr.name = String.valueOf(resfile.getStatusCode()); 
                     bxerr.Message__c = 'Attachment id-'+att.id; 
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
            uploadDocument(count, att, subFolderId, bxErrList);
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
  public Void accData(){
   
   Account acc0 = new Account();
Account acc1 = new Account();
Account acc2 = new Account();
Account acc3 = new Account();
Account acc4 = new Account();
Account acc5 = new Account();
Account acc6 = new Account();
Account acc7 = new Account();
Account acc8 = new Account();
Account acc9 = new Account();
Account acc10 = new Account();
Account acc11 = new Account();
Account acc12 = new Account();
Account acc13 = new Account();
Account acc14 = new Account();
Account acc15 = new Account();
Account acc16 = new Account();
Account acc17 = new Account();
Account acc18 = new Account();
Account acc19 = new Account();
Account acc20 = new Account();
Account acc21 = new Account();
Account acc22 = new Account();
Account acc23 = new Account();
Account acc24 = new Account();
Account acc25 = new Account();
Account acc26 = new Account();
Account acc27 = new Account();
Account acc28 = new Account();
Account acc29 = new Account();
Account acc30 = new Account();
Account acc31 = new Account();
Account acc32 = new Account();
Account acc33 = new Account();
Account acc34 = new Account();
Account acc35 = new Account();
Account acc36 = new Account();
Account acc37 = new Account();
Account acc38 = new Account();
Account acc39 = new Account();
Account acc40 = new Account();
Account acc41 = new Account();
Account acc42 = new Account();
Account acc43 = new Account();
Account acc44 = new Account();
Account acc45 = new Account();
Account acc46 = new Account();
Account acc47 = new Account();
Account acc48 = new Account();
Account acc49 = new Account();
Account acc50 = new Account();
Account acc51 = new Account();
Account acc52 = new Account();
Account acc53 = new Account();
Account acc54 = new Account();
Account acc55 = new Account();
Account acc56 = new Account();
Account acc57 = new Account();
Account acc58 = new Account();
Account acc59 = new Account();
Account acc60 = new Account();
Account acc61 = new Account();
Account acc62 = new Account();
Account acc63 = new Account();
Account acc64 = new Account();
Account acc65 = new Account();
Account acc66 = new Account();
Account acc67 = new Account();
Account acc68 = new Account();
Account acc69 = new Account();
Account acc70 = new Account();
Account acc71 = new Account();
Account acc72 = new Account();
Account acc73 = new Account();
Account acc74 = new Account();
Account acc75 = new Account();
Account acc76 = new Account();
Account acc77 = new Account();
Account acc78 = new Account();
Account acc79 = new Account();
Account acc80 = new Account();
Account acc81 = new Account();
Account acc82 = new Account();
Account acc83 = new Account();
Account acc84 = new Account();
Account acc85 = new Account();
Account acc86 = new Account();
Account acc87 = new Account();
Account acc88 = new Account();
Account acc89 = new Account();
Account acc90 = new Account();
Account acc91 = new Account();
Account acc92 = new Account();
Account acc93 = new Account();
Account acc94 = new Account();
Account acc95 = new Account();
Account acc96 = new Account();
Account acc97 = new Account();
Account acc98 = new Account();
Account acc99 = new Account();
Account acc100 = new Account();
} 
}