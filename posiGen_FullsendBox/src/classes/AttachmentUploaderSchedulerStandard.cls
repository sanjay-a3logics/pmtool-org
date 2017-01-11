public without sharing class AttachmentUploaderSchedulerStandard implements Schedulable,Database.AllowsCallouts {
    public static String base_url = 'https://app.box.com/files/0/f/';
    
    public AttachmentUploaderSchedulerStandard() {
            
    }		
    
    public void execute(SchedulableContext sc) {
        AttachmentUploaderSchedulerStandard.getTest();
    }
    
    public static void getTest(){
        try{
           system.debug('AttachmentUploaderSchedulerStandard----------------'+datetime.now());
            Set<String> boxErrorList = new Set<String>();
            for(Box_Error__c bxer:[Select Id,Deal__c ,name ,Type__c ,Status__c , Message__c, body__c from Box_Error__c where name like 'Exception%' and Type__c = 'Docusign Doc'and Status__c = 'Error' limit 49]){
                if(bxer.body__c.contains('Heap Limit Exception')){
                    system.debug('##################################'+ bxer.id);
                    boxErrorList.add(String.valueOf(bxer.id)); 
                }
             }
             AttachmentUploaderSchedulerStandard.uploadattachments(boxErrorList);

        }
        catch(Exception e){
            system.debug('AttachmentUploaderSchedulerStandard Exception----------------'+e.getMessage());
        }
        
    }
    
    @future(callout=true)
    public static void uploadattachments(Set<String> bxErrSet){
        Set<String> attachmentIdSet = new Set<String>();
        List<Box_Error__c> updateBoxErrorList = new List<Box_Error__c>();
        List<Box_Error__c> bxErrList = new List<Box_Error__c>();
        
        try{
        
            List<Box_Error__c> boxErrorList = new List<Box_Error__c>();
            for(Box_Error__c bxer:[Select Id,Deal__c ,name ,Type__c ,Status__c , Message__c, body__c from Box_Error__c where id in: bxErrSet]){
                if(bxer.body__c.contains('Heap Limit Exception')){
                    boxErrorList.add(bxer); 
                }
             }
 
              Map<String,Box_Error__c> bxAttachMap = new Map<String,Box_Error__c>();
              Set<String> attachmentSet = new Set<String>();
              for(Box_Error__c bx: boxErrorList){
                  List<String> a1 = bx.Message__c.split('-');
                  List<string> a2 = a1[1].split(',');
                  attachmentSet.add(a2[0]);
                  bxAttachMap.put(a2[0], bx); 
              }
              
              Map<Id,String> salesSubFoldersMap = new Map<Id,String>();
              for(Sub_folder__c subFolder : [select cf_Deal__c, cf_box_folder_id__c, name from sub_folder__c where name = 'Sales']){
                  salesSubFoldersMap.put(subFolder.cf_Deal__c, subFolder.cf_box_folder_id__c);
              }
        
            for(Attachment attachmentObj : [select id, name, body, parentId from Attachment where id in: attachmentSet]){
            if(attachmentIdSet == null || !attachmentIdSet.contains(attachmentObj.id)){
                      system.debug('################################## attachmentObj2 '+ attachmentObj.id);
                      attachmentIdSet.add(attachmentObj.id);
               if(attachmentObj.body.size()>3500000 && attachmentObj.body.size()<12000000 || Test.isRunningTest()){
               
                     system.debug('######################################## attachmentObj.Name'+ attachmentObj.Name);
                      String boundary = '----------------------------'+String.valueOf(DateTime.now().getTime())+'';
                      String header = '--'+boundary+'\nContent-Disposition: form-data; name="file"; filename="'+attachmentObj.name+'";\nContent-Type: application/octet-stream';
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
                    
                      Box__c bx = Box__c.getInstance();
                      String sUrl = 'https://upload.box.com/api/2.0/files/content?parent_id='+salesSubFoldersMap.get(attachmentObj.parentId);
                      HttpRequest req = new HttpRequest();
                      req.setHeader('Content-Type','multipart/form-data; boundary='+boundary);
                      req.setMethod('POST');
                      req.setEndpoint(sUrl);
                      req.setBodyAsBlob(bodyBlob);
                      req.setTimeout(60000);
                      req.setHeader('Authorization', 'Bearer '+bx.BoxAccess_Token__c);
                      req.setHeader('Content-Length',String.valueof(req.getBodyAsBlob().size()));
                      Http http = new Http();
                      HTTPResponse resfile = http.send(req);
                      
                     if(resfile.getStatusCode() == 201){
                        
                        system.debug('######################################## resfile.getBody()'+ resfile.getBody());
                        FileWrapper fw = (FileWrapper) System.JSON.deserialize(resfile.getBody(), FileWrapper.class);
                        for(Entries_Z entry: fw.entries){
                            
                            if(entry.parent.id == salesSubFoldersMap.get(attachmentObj.parentId)){
                                
                                Box_Error__c bxerr = bxAttachMap.get(attachmentObj.id);
                                bxerr.Deal__c = attachmentObj.parentId; 
                                bxerr.name = String.valueOf(resfile.getStatusCode()); 
                                bxerr.Message__c = 'Attachment id-'+attachmentObj.id; 
                                bxerr.Body__c = resfile.getBody();
                                bxerr.Type__c = 'Standard Doc';
                                bxerr.Status__c = 'Success';
                                
                                // constructing manual url
                                String manual_url = base_url;
                                manual_url += salesSubFoldersMap.get(attachmentObj.parentId);
                                manual_url += '/1/';
                                manual_url += 'f_'+entry.id;
                                
                                bxerr.Manual_Url__c = manual_url;
                                
                                system.debug('######################################## manual_url'+ manual_url);
                                
                                updateBoxErrorList.add(bxerr);
                            }
                            else{
                                Box_Error__c bxerr = new Box_Error__c();
                                bxerr.Deal__c = attachmentObj.parentId; 
                                bxerr.name = String.valueOf(resfile.getStatusCode()); 
                                bxerr.Message__c = 'Parent not matched for attachment-'+attachmentObj.id; 
                                bxerr.Body__c = resfile.getBody();
                                bxerr.Type__c = 'Standard Doc';
                                bxerr.Status__c = 'Error';
                    
                                bxErrList.add(bxerr);
                            
                            }
                        }
                     }
                     else{
                            Box_Error__c bxerr = new Box_Error__c();
                            bxerr.Deal__c = attachmentObj.parentId; 
                            bxerr.name = String.valueOf(resfile.getStatusCode()); 
                            bxerr.Message__c = 'Attachment id-'+attachmentObj.id; 
                            bxerr.Body__c = resfile.getBody();
                            bxerr.Type__c = 'Standard Doc';
                            bxerr.Status__c = 'Error';
                
                            bxErrList.add(bxerr);
                    }
                   }
                }
               }
            }
            catch(Exception e){
                 system.debug('######################################## Exception '+ e.getMessage());
                 system.debug('######################################## Exception '+ e.getStackTraceString());
                 Box_Error__c bxerr = new Box_Error__c();
                 bxerr.name = 'Exception';
                 bxerr.Status__c = 'Error';
                 bxerr.Type__c = 'Docusign Doc'; 
                 bxerr.Message__c = e.getMessage(); 
                 bxerr.Body__c = e.getStackTraceString();
                 
                 bxErrList.add(bxerr);
            }
            finally{
                    upsert updateBoxErrorList;
                    insert bxErrList;
                    
                    AttachmentUploaderSchedulerStandard scheduleObject = new AttachmentUploaderSchedulerStandard();
                    Datetime newTime = datetime.now().addSeconds(5);    
                    String sch= String.valueOf(newtime.second()) +' ' + String.valueOf(newtime.minute()) + ' ' + String.valueOf(newTime.hour()) + ' ' + String.valueOf(newTime.day()) + ' ' + String.valueOf(newTime.month()) + ' ? ' +  String.valueOf(newTime.year());  
        
                    Double st = Math.random();
                    system.schedule('AttachmentUploaderSchedulerStandard '+newTime+String.valueOf(st) , sch, scheduleObject );
                    try{
                        for(CronTrigger ct:[Select Id From CronTrigger where state='DELETED' AND CronJobDetail.Name like 'AttachmentUploaderSchedulerStandard%' limit 100]){
                            System.abortJob(ct.id);
                        }
                    }
                    catch(Exception e){}
               }
          
      }
      
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