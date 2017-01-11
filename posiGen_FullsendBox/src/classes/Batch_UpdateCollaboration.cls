public with sharing class Batch_UpdateCollaboration implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful{
 
  public String base_url = 'https://app.box.com/files/0/f/';
  public List<BoxAccessMatrix_Stage__c> bxStageList;
  public Map<String,String> roleMap;      			
        
  public Batch_UpdateCollaboration(List<BoxAccessMatrix_Stage__c> bxStageList){
    this.bxStageList =bxStageList;
    roleMap = new Map<String,String>();
  } 
  
  public Database.QueryLocator start(Database.BatchableContext BC){
        
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
      for(Sub_folder__c sf:[Select id,CF_Box_Folder_Id__c,cf_Deal__r.Opp_Pipeline_Stage__c from Sub_Folder__c where name in:NameSet and cf_Deal__r.Opp_Pipeline_Stage__c in:stageSet ]){
          
           folderIdSet.add(sf.CF_Box_Folder_Id__c);
         }   
      
        return Database.getQueryLocator('select sub_folder__r.cf_Deal__c, BoxUser_Id__c,BoxFolder_Id__c ,role__c, SFProfile_Id__c, BoxCollaboration_Id__c from Collaboration__c  where BoxCollaboration_Id__c!= null and SFProfile_Id__c in:profileSet and BoxFolder_Id__c in:folderIdSet');
  }
  
  public void execute(Database.BatchableContext BC, List<Collaboration__c> collaborations){
     List<Box_Log__c> bxErrList = new List<Box_Log__c>();
     List<Collaboration__c> updateCollaborationsList = new List<Collaboration__c>();
     
     Box__c  box = Box__c.getInstance();  
     for(Collaboration__c clb :collaborations){
        
        Batch_UpdateCollaboration.updateCollaboration(clb,roleMap.get(clb.SFProfile_Id__c), box, bxErrList, updateCollaborationsList  ); 
      } 
   
    
     insert bxErrList;
     update updateCollaborationsList; 
          
  } 
  
  public void finish(Database.BatchableContext BC){
   
    /*List<Messaging.SingleEmailMessage> msgList = new List<Messaging.SingleEmailMessage>(); 
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    mail.setTargetObjectId(UserInfo.getUserId());  
    mail.setToAddresses(new String[]{UserInfo.getUserEmail()});
    mail.setSaveasactivity(false);
    mail.setSubject('Update Collabration Batch Status');
    mail.setPlainTextBody('Update Permission Batch Completed successfully');
    msgList.add(mail);
    Messaging.sendEmail(msgList);*/
  
  }
  
  
  
   
   public static void updateCollaboration(Collaboration__c colb,String role,Box__c box,List<Box_Log__c> lstBoxLogs,List<Collaboration__c> updateCollaborationsList){
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
                 updateCollaborationsList.add(colb);
                 
                 BoxLogs.createLogs('Batch_UpdateCollaboration.updateCollaboration',colb.sub_folder__r.cf_Deal__c, colb.sub_folder__c, res.getBody(), 'Update Collaboration' , 'Success', res.getStatusCode()+'', '', role, lstBoxLogs);

               }
          else{
             
                BoxLogs.createLogs('Batch_UpdateCollaboration.updateCollaboration',colb.sub_folder__r.cf_Deal__c, colb.sub_folder__c, res.getBody(), 'Update Collaboration' , 'Error', res.getStatusCode()+'', '', role, lstBoxLogs);
             }     
           
        }
        catch(Exception e){
           
           BoxLogs.createLogs('Batch_UpdateCollaboration.updateCollaboration',colb.sub_folder__r.cf_Deal__c, colb.sub_folder__c, e.getMessage() +'#' +e.getStacktraceString(), 'Update Collaboration' , 'Exception', '', '', role, lstBoxLogs);
 
        }
        
   }  
  
      
   
 }