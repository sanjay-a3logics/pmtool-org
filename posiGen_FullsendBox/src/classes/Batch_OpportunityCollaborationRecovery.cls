public class Batch_OpportunityCollaborationRecovery implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful{
    public string folderName ;
    public Map<String, String> profileMap; 

  public Batch_OpportunityCollaborationRecovery (String folderName){
    this.folderName = folderName;
  } 
    
  public Database.QueryLocator start(Database.BatchableContext BC){
         profileMap = new Map<String, String>();
         for(Profile prf : [select id, name from profile]){
             profileMap.put(prf.name, prf.id);    
         }
        
        return Database.getQueryLocator('Select Id,Name,CF_Opportunity__c,CF_Box_Folder_Id__c,CF_Opportunity__r.Name from Sub_Folder__c where Name=:folderName and CF_Opportunity__c!=null');
  }
    
  public void execute(Database.BatchableContext BC, List<Sub_Folder__c> folderList){
        List<Box_Error__c> bxErrList = new List<Box_Error__c>();
        Set<String>BoxCollList = new Set<String>(); 
        List<Opportunity_Collaboration_Recovery__c> lstcollab = new List<Opportunity_Collaboration_Recovery__c>();

        system.debug('######'+folderList.size());
                   
            
        for(Sub_Folder__c  fld : folderList){
            
            try{
                                      
              Batch_OpportunityCollaborationRecovery.getcollaboration(fld,lstcollab,profileMap);
            }
            catch(Exception e){
                System.debug(' ***Error '+e.getMessage());
                 Box_Error__c bxerr = new Box_Error__c();
                 bxerr.name = 'Exception';
                 bxerr.Status__c = 'Error';
                 bxerr.Type__c = 'Batch_OpportunityCollaborationRecovery'; 
                 bxerr.Message__c = e.getMessage(); 
                 bxerr.Body__c = e.getStackTraceString();
             
                 bxErrList.add(bxerr);
            }
              
        }
        insert lstcollab;
        insert bxErrList; 
    }
    
    
  public void finish(Database.BatchableContext BC){}   
  
  
  public static void getcollaboration(sub_folder__c fld, List<Opportunity_Collaboration_Recovery__c> lstcollab,Map<String, String> profileMap){
        
                Box__c box = Box__c.getInstance();  
                HttpRequest req = new HttpRequest();
                req.setEndpoint('https://api.box.com/2.0/folders/'+fld.CF_Box_Folder_Id__c+'/'+'collaborations');
                req.setMethod('GET');
                req.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
                Http httpName = new Http();
                HTTPResponse res = httpName.send(req);
                if(res.getStatusCode() == 200){
                    FolderWrapper fw = (FolderWrapper) System.JSON.deserialize(res.getBody(), FolderWrapper.class);
                      

                    system.debug('======'+fw.entries);    
                    for(cls_entries enn:fw.entries){
                        Opportunity_Collaboration_Recovery__c ocr = new Opportunity_Collaboration_Recovery__c();
                        ocr.BoxCollaboration_Id__c = enn.id;
                        ocr.Sub_Folder__c = fld.id;
                        
                        if(enn.status=='accepted'){
                            if(enn.accessible_by.type=='user'){
                                ocr.UserEmail__c = enn.accessible_by.login;
                            }
                            else if(enn.accessible_by.type=='group'){
                                ocr.Profile_Id__c = profileMap.get(enn.accessible_by.name);
                            }
                        } 
                       lstcollab.add(ocr); 
                    } 
                 } 
               else if(res.getStatusCode() == 401){
                  Batch_OpportunityCollaborationRecovery.getcollaboration(fld,lstcollab,profileMap);
               
                  }
   
     }  
  
   
  public class FolderWrapper{
    public Integer total_count; 
    public cls_entries[] entries;
    
   } 
  public class cls_entries {
        public String type;
        public String id;   
        public String status;   
        public String role; 
        public cls_accessible_by accessible_by;
    }
 public class cls_accessible_by {
        public String type;
        public String id;  
        public String name;
        public String login;    
    }   
   
}