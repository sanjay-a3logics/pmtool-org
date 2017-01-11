public class BoxRenameattachmentsBatch implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful{
    
    public String base_url = 'https://app.box.com/files/0/f/';
    public Integer record_count = 0; 
    public Integer record_count_stop = 0;
    
    public BoxRenameattachmentsBatch(Integer record_count_stop){
        this.record_count_stop = record_count_stop;
    }
    
    public List<box_error__c > start(Database.BatchableContext BC){
    
        string query='Select id, name, parentId, contenttype from attachment where (name = \'Panel Photo\' or name = \'House Photo\') and parentId not in (select opportunity__c from box_error__c where type__c = \'Rename file\' and status__c = \'Success\')';
        return Database.Query(query);
    }
    
    public void execute(Database.BatchableContext BC, List<Attachment> attList){
          List<Box_Error__c> bxErrList = new List<Box_Error__c>();  
          try{
            
              Map<Id,String> salesSubFoldersMap = new Map<Id,String>();
              for(Sub_folder__c subFolder : [select cf_opportunity__c, cf_box_folder_id__c, name from sub_folder__c where name = 'Sales']){
                  salesSubFoldersMap.put(subFolder.cf_opportunity__c, subFolder.cf_box_folder_id__c);
              }
              
              

              for(Attachment attachmentObj : attList){
              
                    Box__c box = Box__c.getInstance();  
              
                    String salesfolderId = salesSubFoldersMap.get(attachmentObj.parentId);
                   
                    HttpRequest hreq3 = new HttpRequest();
                    hreq3.setEndpoint('https://api.box.com/2.0/folders/'+salesfolderId+'/items?fields=name');
                    hreq3.setMethod('GET');
                    hreq3.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
                    Http http4 = new Http();
                    HTTPResponse res4 = http4.send(hreq3);
                    System.debug('*********'+res4.getStatusCode()+' ----- '+res4.getBody());
                    if(res4.getStatusCode() == 200){
                        FileInfoWrapper fileInfo = (FileInfoWrapper) System.JSON.deserialize(res4.getBody(), FileInfoWrapper.class);
                        if(fileInfo.total_count >= 1){
                            for(Entries entry: fileInfo.entries){
                                if(entry.type == 'file')
                                    if(entry.name == 'Panel Photo' || entry.name == 'House Photo'){
                                    
                                        String extension = null;
                                        if(attachmentObj.contentType != null){
                                            String contenttyp = attachmentObj.contentType;
                                            string[] partext = contenttyp.split('\\/');
                                            extension = partext[1];
                                        }
                                        if(extension != null){
                                            HttpRequest hreq = new HttpRequest();
                                            hreq.setEndpoint('https://api.box.com/2.0/files/'+entry.id);
                                            hreq.setMethod('PUT');
                                            hreq.setBody('{"name":"'+entry.name+'.'+extension+'"}');
                                            hreq.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
                                            Http http = new Http();
                                            HTTPResponse res = http.send(hreq);
                                            if(res.getStatusCode() == 200){
                                                 Box_Error__c bxerr = new Box_Error__c();
                                                 bxerr.Opportunity__c = attachmentObj.parentId; 
                                                 bxerr.name = String.valueOf(res.getStatusCode()); 
                                                 bxerr.Message__c = 'Attachment id-'+attachmentObj.id; 
                                                 bxerr.Body__c = res.getBody();
                                                 bxerr.Type__c = 'Rename File';
                                                 bxerr.Status__c = 'Success';
                                                 
                                                 bxErrList.add(bxerr);                 
                                            }
                                        }
                                    }
                                }
                            }
                    }
                    else{
                        System.debug(' *** Error *** '+res4.getBody());
                        Box_Error__c bxerr = new Box_Error__c();
                        bxerr.Opportunity__c = attachmentObj.parentId;
                        bxerr.name = String.valueOf(res4.getStatusCode()); 
                        bxerr.Message__c = ''; 
                        bxerr.Body__c = res4.getBody();
                        bxerr.Type__c = 'Rename File';
                        bxerr.Status__c = 'Error';
                        
                        bxErrList.add(bxerr); 
                   }   
                 }
             
          }
          catch(Exception e){
               system.debug('###############################'+e.getMessage()); 
                Box_Error__c bxerr = new Box_Error__c();
                bxerr.name = 'Exception'; 
                bxerr.Message__c = e.getMessage(); 
                bxerr.Body__c = e.getStackTraceString();
                bxerr.Type__c = 'Rename File';
                bxerr.Status__c = 'Error';
                bxErrList.add(bxerr);
          }
          
          finally{
              insert bxErrList;
          }
          
    }
    
    public void finish(Database.BatchableContext BC){}
    
    public class FileInfoWrapper {

        public Integer total_count;
        public List<Entries> entries;
        public Integer offset;
   
    }

    public class Entries {
        public String type;
        public String id;
        public String etag;
        public String name;
    }
}