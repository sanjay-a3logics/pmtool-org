public with sharing class InsertCollaboration implements Database.Batchable<Sobject>, Database.Stateful{
    
    public String folderName;
    public InsertCollaboration(String folderName){
      this.folderName = folderName; 
    } 
    
    public Database.QueryLocator start(Database.BatchableContext BC){
    
            return Database.getQueryLocator('select Sub_Folder__c, BoxCollaboration_Id__c, Profile_Id__c, UserEmail__c  from Opportunity_Collaboration_Recovery__c where Sub_Folder__r.Name =:folderName');
    }
    
    public void execute(Database.BatchableContext BC, List<Opportunity_Collaboration_Recovery__c> ocrList){
        List<Collaboration__c> NewclbList = new List<Collaboration__c>();
        Set<String> subFolderSet = new Set<String>();
        Set<String> collaborationSet = new Set<String>();
        for(Opportunity_Collaboration_Recovery__c clb:ocrList){
            subFolderSet.add(clb.Sub_folder__c);
          }
          
      for(Collaboration__c col : [select BoxCollaboration_Id__c from Collaboration__c where sub_folder__c in:subFolderSet]){
            collaborationSet.add(col.BoxCollaboration_Id__c);
        }
      for(Opportunity_Collaboration_Recovery__c ocr:ocrList) {     
           
            if(!collaborationSet.contains(ocr.BoxCollaboration_Id__c)){
                
                  Collaboration__c clb = new Collaboration__c();
                  clb.BoxUser_Id__c='';
                  clb.BoxCollaboration_Id__c = ocr.BoxCollaboration_Id__c;
                  clb.sub_folder__c= ocr.Sub_Folder__c;
                  clb.SFProfile_Id__c =ocr.Profile_Id__c;
                  clb.SFUser_Email__c =ocr.UserEmail__c;
                  NewclbList.add(clb);
                
              } 
              
            
          }
        insert  NewclbList; 
       
    }
    
    public void finish(Database.BatchableContext BC){}
}