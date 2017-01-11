public with sharing class Batch_UpdateEmailCollaboration implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful{
 
  public String base_url = 'https://app.box.com/files/0/f/';
  public List<BoxAccessMatrix_Stage__c> bxStageList;
  public String UserEmail;
  public String role;
  Box__c box ;
  List<Box_Error__c> bxErrList ;
  public Map<String,String> roleMap;
   
  public Batch_UpdateEmailCollaboration(List<BoxAccessMatrix_Stage__c> bxStageList,String UserEmail,String role){
    this.bxStageList =bxStageList;
    roleMap = new Map<String,String>();
    this.UserEmail = UserEmail;
    this.role = role;
  } 
  
  public Database.QueryLocator start(Database.BatchableContext BC){
        box = Box__c.getInstance();
        Set<String> stageSet = new Set<String>();
        Set<String> profileSet = new Set<String>();
        Set<String> NameSet = new Set<String>();
        Set<String> folderIdSet = new Set<String>();
        roleMap = new Map<String,String>(); 
        for(BoxAccessMatrix_Stage__c bstge:[select id, Box_Permission__c,BoxAccessMatrix_Profile__r.BoxAccessMatrix_SubFolder__r.SubFolder_Name__c,BoxAccessMatrix_Profile__r.Lookup_field_Name__c,BoxAccessMatrix_Profile__r.Profile_Name__c, BoxAccessMatrix_Profile__r.Profile_Id__c, Stage__c,check__c from BoxAccessMatrix_Stage__c where id in:bxStageList]){
            stageSet.add(bstge.Stage__c);
            profileSet.add(bstge.BoxAccessMatrix_Profile__r.Profile_Id__c);
            NameSet.add(bstge.BoxAccessMatrix_Profile__r.BoxAccessMatrix_SubFolder__r.SubFolder_Name__c);
            roleMap.put(bstge.BoxAccessMatrix_Profile__r.Profile_Id__c,bstge.Box_Permission__c);
            
         }
      for(Sub_folder__c sf:[Select id,CF_Box_Folder_Id__c,cf_opportunity__r.Pipeline_Stage__c from Sub_Folder__c where name in:NameSet and cf_opportunity__r.Pipeline_Stage__c in:stageSet]){
        
           folderIdSet.add(sf.CF_Box_Folder_Id__c);
         }   
  
        return Database.getQueryLocator('select BoxUser_Id__c,BoxFolder_Id__c ,role__c, SFProfile_Id__c, BoxCollaboration_Id__c from Collaboration__c  where BoxCollaboration_Id__c!= null and SFProfile_Id__c in:profileSet and BoxFolder_Id__c in:folderIdSet and SfUser_email__c=:UserEmail and role__c!=:role');
  }
  
  public void execute(Database.BatchableContext BC, List<Collaboration__c> collaborations){
     bxErrList = new List<Box_Error__c>();
        
     for(Collaboration__c clb :collaborations){
       system.debug('------'+roleMap.get(clb.SFProfile_Id__c)); 
        Batch_UpdateEmailCollaboration.updateCollaboration(clb,roleMap.get(clb.SFProfile_Id__c), box, bxErrList ); 
      } 
   
     update collaborations;
     insert bxErrList; 
          
  } 
  
  public void finish(Database.BatchableContext BC){
   
   
  
  }
  
  
  
   
   public static void updateCollaboration(Collaboration__c colb,String role,Box__c box,List<Box_Error__c> bxErrList){
     try{
        
            boolean isCallSuccess = true;

            
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://api.box.com/2.0/collaborations/'+colb.BoxCollaboration_Id__c);
            req.setMethod('PUT');
            req.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
            req.setBody('{"role": "'+role+'"}');
            HTTPResponse res = new Http().send(req);
            if(res.getStatuscode()==200){
                 colb.role__c = role;
               }
            else if(res.getStatusCode() == 401){
                BoxREFRESHAccessTokenScheduler.getToken();
             }
            else{
             Box_Error__c bxerr = new Box_Error__c();
             bxerr.name = ''+res.getStatusCode();
             bxerr.Message__c ='' ; 
             bxerr.Body__c = ''+res.getBody();
             bxerr.Type__c = 'Update Collaboration';
             bxerr.Status__c = 'Error';
             bxErrList.add(bxerr); 
            }    
           
        }
        catch(Exception e){
            Box_Error__c bxerr = new Box_Error__c();
             bxerr.name = 'Col Exception';
             bxerr.Message__c ='' ; 
             bxerr.Body__c = '';
             bxerr.Type__c = 'Collaboration';
             bxerr.Status__c = 'Error';
             bxErrList.add(bxerr); 
        }
        finally{
         
         
         }
   }  
  
      
   
 }