public class BoxRenamefolderBatch implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful{
    public String base_url = 'https://posigen.app.box.com/files/0/f/';
    public Integer record_count = 0; 
    public Integer record_count_stop = 0;
    public string folderName ;
    public List<Sub_Folder__c> folderList;
    public List<Box_Error__c> bxErrList;
   
  public BoxRenamefolderBatch(String folderName,Integer record_count_stop){
    this.record_count_stop = record_count_stop;
    this.folderName = folderName;
  } 
    
    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('Select Id,Name,CF_Opportunity__c,CF_Box_Folder_Id__c,CF_Opportunity__r.Name from Sub_Folder__c where Name=:folderName and CF_Opportunity__c!=null');
    }
    
    public void execute(Database.BatchableContext BC, List<Sub_Folder__c> folderList){
        bxErrList = new List<Box_Error__c>();
       try{
         
           system.debug('######'+folderList.size());
            Box__c box = Box__c.getInstance();             
        boolean isCallSuccess = true;
        Integer lastIndex = -1;
        Sub_Folder__c fld;
        for(integer i=0; i<folderList.size(); i++){
            if(!isCallSuccess)
                i = lastIndex; 
            lastIndex = i;
            fld= folderList[i];
            
                
                String oppName = fld.CF_Opportunity__r.name;
                System.debug('############## name before replace'+oppName);
                oppName = oppName.replace('\t', '');
               
                oppName = oppName.replace('"', '\'');
                oppName = oppName.replace('\\', '-');
                oppName = oppName.replace('/', '-');
                System.debug('############## name after replace'+oppName);
               
            
                String NewfolderName = oppName+' - '+fld.Name;
                       
                HttpRequest req = new HttpRequest();
                req.setEndpoint('https://api.box.com/2.0/folders/'+fld.CF_Box_Folder_Id__c);
                req.setMethod('PUT');
                req.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
                req.setBody('{"name" : "'+NewfolderName+'"}');
            
                Http httpName = new Http();
                HTTPResponse res = httpName.send(req);
                system.debug('UpdateName'+res+res.getbody());  
                FolderWrapper fw = (FolderWrapper) System.JSON.deserialize(res.getBody(), FolderWrapper.class);
                if(res.getStatusCode() == 200){
                    
                     Box_Error__c bxerr = new Box_Error__c();
                     bxerr.Opportunity__c = fld.CF_Opportunity__c; 
                     bxerr.name = String.valueOf(res.getStatusCode()); 
                     bxerr.Message__c = 'Folder'+fw.name; 
                     bxerr.Body__c = res.getBody();
                     bxerr.Type__c = 'Update Folder Name';
                     bxerr.Not_Uploaded_Id__c=''+fw.id;
                     bxerr.Status__c = 'Success';
                     bxErrList.add(bxerr);
                     
                  }
                else If(res.getStatusCode()== 401){
                   BoxREFRESHAccessTokenScheduler.getToken();
                   isCallSuccess = false;
                  } 
                else{
                     Box_Error__c bxerr = new Box_Error__c();
                     bxerr.Opportunity__c = fld.CF_Opportunity__c; 
                     bxerr.name = String.valueOf(res.getStatusCode()); 
                     bxerr.Message__c = ''+fw.name; 
                     bxerr.Body__c = res.getBody();
                     bxerr.Type__c = 'Not Update Folder Name';
                     bxerr.Not_Uploaded_Id__c=''+fw.id;
                     bxerr.Status__c = 'Error';
                     bxErrList.add(bxerr);
                   }
              
                
              
              }
            
            record_count += folderList.size();
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
             bxerr.Type__c = 'Not Update Folder name'; 
             bxerr.Message__c = e.getMessage(); 
             bxerr.Body__c = e.getStackTraceString();
             
             bxErrList.add(bxerr);
        }
       finally{
          insert bxErrList;
          } 
    }
    
    
  public void finish(Database.BatchableContext BC){}     
  
  public class FolderWrapper{
    public String type; 
    public String id;   
    public String name; 
    }
   
     
}