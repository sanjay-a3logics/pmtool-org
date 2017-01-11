public with sharing class BoxCustomDocsDuplicateBatch implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful{
    
    public String base_url = 'https://app.box.com/files/0/f/';
    public Integer record_count = 0; 
    public Integer record_count_stop = 0;
    
    public BoxCustomDocsDuplicateBatch(Integer record_count_stop){
        this.record_count_stop = record_count_stop;
    } 
    
   
    public List<box_error__c > start(Database.BatchableContext BC){
    
        string query='select Opportunity__c from box_error__c where Type__c =\'Custom Doc\' and Name =\'409\' ';
        return Database.Query(query);
    }
    
    public void execute(Database.BatchableContext BC, List<Box_Error__c> OppList){
        List<Box_Error__c> bxErrList = new List<Box_Error__c>();  
        try{
            
            Set<Id> OppIds = new Set<Id>();
            String parent_folder;
            for(Box_Error__c Opp : OppList){
                OppIds.add(Opp.Opportunity__c);
            }
        
                Map<Id,String> fvSubFoldersMap = new Map<Id,String>();
                for(Sub_folder__c subFolder : [select cf_opportunity__c, cf_box_folder_id__c, name from sub_folder__c where name = 'Funding-Vendor']){
                    fvSubFoldersMap.put(subFolder.cf_opportunity__c, subFolder.cf_box_folder_id__c);
                }
              
              
                
            Map<String,String> customAttachmentsCMap = new Map<String,String>();
            Map<String,String> errorMap = new Map<String,String>();
            for(Attachment__c att : [select id, project__r.opportunity__c from attachment__c where project__r.opportunity__c in:OppIds]){
                 if(fvSubFoldersMap.containsKey(att.project__r.opportunity__c)){
                  
                        customAttachmentsCMap.put(att.id, fvSubFoldersMap.get(att.project__r.opportunity__c));
                        errorMap.put(att.id,att.project__r.opportunity__c);
                 }
            }
            system.debug(' CustomAtt '+customAttachmentsCMap.keyset());
            
            Map<String,List<attachment>> duplicateAttachmentsCMap = new Map<String,List<attachment>>();
            List<attachment> distinctRecords = new List<attachment>();
            List<attachment> duplicateRecords = new List<attachment>();
            for(attachment oppObj: [select id, name,parentid  from attachment where parentid in:customAttachmentsCMap.keyset() order by id desc]){
                Boolean found = false;
            
                  for(Integer i=0; i< distinctRecords.size(); i++){
                        if(oppObj.name.equalsIgnoreCase(distinctRecords[i].name)){ 
                             found=true;
                             duplicateRecords.add(oppObj);
                             if(!duplicateAttachmentsCMap.containsKey(oppObj.parentid)){
                                 duplicateAttachmentsCMap.put(oppObj.parentid,new List<attachment>());
                             }
                             duplicateAttachmentsCMap.get(oppObj.parentid).add(oppObj);
                           }
                    }
                        if(!found){
                           distinctRecords.add(oppObj);
                         }
           
                 }
            set<Id> attIds = new set<Id>();
            
          
            for(attachment att: duplicateRecords){
                attIds.add(att.id);
            }
           
            system.debug('NativeAttchment '+attIds); 
            Box__c bx = Box__c.getInstance();
            
            Integer i = 2;
            
            String parentIdTemp = null;
            String nameTemp = null;
            
            for(Attachment attachmentObj : [select name, body, parentId from Attachment where parentId =:duplicateAttachmentsCMap.keyset()]){
                      if(attachmentObj.body.size()<=4000000){
                         system.debug('######################################## attachmentObj.Name'+ attachmentObj.Name);
                          String boundary = '----------------------------'+String.valueOf(DateTime.now().getTime())+'';
                          
                          if(parentIdTemp == null){
                              parentIdTemp = attachmentObj.parentId;
                              nameTemp = attachmentObj.name;
                          }
                          
                          if(parentIdTemp != attachmentObj.parentId && nameTemp != attachmentObj.name){
                              i = 2;
                           }
                         else if(parentIdTemp == attachmentObj.parentId && nameTemp != attachmentObj.name){
                              i = 2;
                           }
                         else if(parentIdTemp != attachmentObj.parentId && nameTemp == attachmentObj.name){
                              i = 2;
                           }   
                        
                          string s = attachmentObj.name;

                           string[] part = s.split('\\.');
                            
                           s = part[0]+'('+i+')'+'.'+part[1];
                           
                           

                          String header = '--'+boundary+'\nContent-Disposition: form-data; name="file"; filename="'+s+'";\nContent-Type: application/octet-stream';
                          String footer = '--'+boundary+'--';             
                          String headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
                          while(headerEncoded.endsWith('=')){
                           header+=' ';
                           headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
                          }
                          String bodyEncoded = EncodingUtil.base64Encode(attachmentObj.body);
                        
                          Blob bodyBlob = null;
                          String last4Bytes = bodyEncoded.substring(bodyEncoded.length()-4,bodyEncoded.length());
                         if(last4Bytes.endsWith('==')) {
                            last4Bytes = last4Bytes.substring(0,2) + '0K';
                            bodyEncoded = bodyEncoded.substring(0,bodyEncoded.length()-4) + last4Bytes;
                            String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
                            bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);
                          } else if(last4Bytes.endsWith('=')) {
                            last4Bytes = last4Bytes.substring(0,3) + 'N';
                            bodyEncoded = bodyEncoded.substring(0,bodyEncoded.length()-4) + last4Bytes;
                            footer = '\n' + footer;
                            String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
                            bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);              
                          } else {
                            footer = '\r\n' + footer;
                            String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
                            bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);  
                          }
                        
                          String sUrl = 'https://upload.box.com/api/2.0/files/content?parent_id='+customAttachmentsCMap.get(attachmentObj.parentId);
                          HttpRequest req = new HttpRequest();
                          req.setHeader('Content-Type','multipart/form-data; boundary='+boundary);
                          req.setMethod('POST');
                          req.setEndpoint(sUrl);
                          req.setBodyAsBlob(bodyBlob);
                          req.setTimeout(120000);
                          req.setHeader('Authorization', 'Bearer '+bx.BoxAccess_Token__c);
                          req.setHeader('Content-Length',String.valueof(req.getBodyAsBlob().size()));
                          Http http = new Http();
                          HTTPResponse resfile = http.send(req);
                          
                         if(resfile.getStatusCode() == 201){
                         
                             i++;
                             parentIdTemp = attachmentObj.parentId;
                             nameTemp = attachmentObj.name;
                             
                            system.debug('######################################## resfile.getBody()'+ resfile.getBody());
                            FileWrapper fw = (FileWrapper) System.JSON.deserialize(resfile.getBody(), FileWrapper.class);
                            for(Entries_Z entry: fw.entries){
                                
                                system.debug('######################################## entry.parent.id'+ entry.parent.id);
                                system.debug('######################################## parent_folder'+customAttachmentsCMap.get(attachmentObj.parentId));
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
                                    bxerr.Opportunity__c =errorMap.get(attachmentObj.parentId); 
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
                           bxerr.name = 'Exception'; 
                           bxerr.Message__c = 'Attachment id-'+attachmentObj.id; 
                           bxerr.Body__c = 'Heap Limit Exception';
                           bxerr.Type__c = 'Custom Doc';
                           bxerr.Status__c = 'Error';
                     
                           bxErrList.add(bxerr);
                        }                    
                    }
                
        
            
            record_count += OppList.size();
            if(record_count == record_count_stop){
                system.debug('######################################## job aborted record_count is'+ record_count);
                System.abortJob(BC.getJobId());
            }
        }
        catch(Exception e){
            Box_Error__c bxerr = new Box_Error__c();
            bxerr.name = 'Exception';
            bxerr.Status__c = 'Error';
            bxerr.Type__c = 'Custom Doc'; 
            bxerr.Message__c = e.getMessage(); 
            bxerr.Body__c = e.getStackTraceString();
            
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