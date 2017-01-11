public with sharing class BoxDeleteCollobrationBatch implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful{
    public String base_url = 'https://posigen.app.box.com/files/0/f/';
   
    public Set<String>ProfIdSet;
    public String oldStage;     
    public String newStage;
    public Sub_folder__c subfolder;
    public String subfolderId;
  
    public BoxDeleteCollobrationBatch(Sub_folder__c subfolder,String newStage,String oldStage){
        ProfIdSet  = new Set<String>();
        this.subfolder= subfolder;
        this.oldStage = oldStage;
        this.newStage = newStage;
        this.subfolderId= subfolder.cf_box_folder_id__c;
        
        
        
    } 
    
    public Database.QueryLocator start(Database.BatchableContext BC){
        for(BoxAccessMatrix_stage__c bam: [select  stage__c, check__c,  BoxAccessMatrix_Profile__r.Profile_id__c from BoxAccessMatrix_stage__c where check__c=true and  BoxAccessMatrix_Profile__r.BoxAccessMatrix_SubFolder__r.SubFolder_Name__c=:subfolder.Name and stage__c =:oldStage]){
                 ProfIdSet.add(bam.BoxAccessMatrix_Profile__r.Profile_id__c); 
             }
        
        return Database.getQueryLocator('Select id,SFProfile_id__c,BoxFolder_Id__c,SFUser_Email__c,BoxCollaboration_Id__c from Collaboration__c where SFProfile_id__c in:ProfIdSet and BoxFolder_Id__c =:subfolderId');
    }
    
    public void execute(Database.BatchableContext BC, List<Collaboration__c> collList){
        system.debug('======'+ProfIdSet);
        system.debug('hiiiiiii'+collList+'-----'+collList.size());
        Set<Collaboration__c> collSet = new Set<Collaboration__c>(collList);
        system.debug('hiiiiiii'+collSet);
        List<Collaboration__c> lstCollaborations = new List<Collaboration__c>();
        List<Box_Log__c> lstBoxLogs = new List<Box_Log__c>(); 
      
        BoxCollaboration.deleteCollaboration('BoxDeleteCollobrationBatch-execute',subfolder.cf_Deal__c, subfolder.id, collSet, lstBoxLogs, lstCollaborations);
     
        delete lstCollaborations;
        insert lstBoxLogs;
        
  }  
   
    
   public void finish(Database.BatchableContext BC){
              
          Database.executeBatch(New CreateCollaborationOnStageChangeBatch(subfolder.Name,newStage,subfolder.CF_Box_Folder_Id__c),1);
       }
     
   
   
   
   
   
  
    
  
}