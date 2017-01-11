public class BoxDuplicateEEUnmatchedfolder implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful{
    public String base_url = 'https://posigen.app.box.com/files/0/f/';
    public Integer record_count = 0; 
    public Integer record_count_stop = 0;
    public string folderName ;
    public List<Box_Error__c> bxErrList;
   
  public BoxDuplicateEEUnmatchedfolder(Integer record_count_stop){
    this.record_count_stop = record_count_stop;
  } 
    
    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('Select id,Body__c,Message__c,name ,Status__c  from Box_error__c where Name=\'409\' and type__c = \'KDH Folder move\'');
    }
    
    public void execute(Database.BatchableContext BC, List<Box_Error__c> EEboxErrList){
        bxErrList = new List<Box_Error__c>();
       try{
         
           
            Box__c box = Box__c.getInstance();             
            
            for(Box_Error__c EEBoxErrFile : EEboxErrList){
           
                system.debug('EEBody'+EEBoxErrFile.body__c);
                FolderNameWrapper fnw = (FolderNameWrapper)JSON.deserialize(EEBoxErrFile.body__c,FolderNameWrapper.class);
                system.debug('Json'+fnw);
                
                folderName = fnw.context_info.conflicts.name +' (2)';
                       
                HttpRequest req = new HttpRequest();
                req.setEndpoint('https://api.box.com/2.0/folders/'+fnw.context_info.conflicts.id);
                req.setMethod('PUT');
                req.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
                req.setBody('{"name" : "'+folderName+'", "parent": {"id": "4408116546"}}');
            
                Http httpName = new Http();
                HTTPResponse res = httpName .send(req);
                system.debug('UpdateName'+res+res.getbody());  
                if(res.getStatusCode() == 200){
                  EEBoxErrFile.done__c=true;
                 }
                else{
                     Box_Error__c bxerr = new Box_Error__c();
                     bxerr.Opportunity__c = EEBoxErrFile.opportunity__c; 
                     bxerr.name = String.valueOf(res.getStatusCode()); 
                     bxerr.Message__c = 'Rename Folder'; 
                     bxerr.Body__c = res.getBody();
                     bxerr.Type__c = 'EE-Duplicate unamatched';
                     bxerr.Status__c = 'Error';
                     bxErrList.add(bxerr);
                   }
              
                
              
              }
            update EEboxErrList;
            insert bxErrList;
            
            record_count += EEboxErrList.size();
            if(record_count == record_count_stop){
           system.debug('######################################## job aborted record_count is'+ record_count);
           System.abortJob(BC.getJobId());
            }
    
        }
        catch(Exception e){
            System.debug(' ***Error '+e.getMessage());
             Box_Error__c bxerr = new Box_Error__c();
             bxerr.name = 'Exception';
             bxerr.Status__c = 'Error';
             bxerr.Type__c = 'EE'; 
             bxerr.Message__c = e.getMessage(); 
             bxerr.Body__c = e.getStackTraceString();
             
             bxErrList.add(bxerr);
        }
    }
    
    
  public void finish(Database.BatchableContext BC){}     
  
  public class FolderWrapper{
        public String Type;
        public String Id;
        public String Name;
    }
   public class FolderNameWrapper{
 
    public cls_context_info context_info;
   } 
  public class cls_context_info {
        public conflicts conflicts;
    }  
  public  class   conflicts {
        public String type; 
        public String id;  
        public String name; 
    }  
     
}