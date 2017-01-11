public with sharing class CollaborationSubFolderLookup implements Database.Batchable<Sobject>, Database.Stateful{

    public CollaborationSubFolderLookup(){
        
    } 
    
    public Database.QueryLocator start(Database.BatchableContext BC){
    
        return Database.getQueryLocator('select id, CF_Box_Folder_Id__c from Sub_Folder__c');
    }
    
    public void execute(Database.BatchableContext BC, List<Sub_Folder__c> subFolderList){
    
        Map<String, Id> subFolderMap = new Map<String, Id>();
        for(Sub_Folder__c folder : subFolderList){
            subFolderMap.put(folder.CF_Box_Folder_Id__c, folder.id);
        }
        
        List<Collaboration__c> listToUpdate = new List<Collaboration__c>();    
        for(Collaboration__c collaboration : [select id, BoxFolder_Id__c from Collaboration__c where BoxFolder_Id__c in : subFolderMap.keyset()]){
        
            collaboration.Sub_Folder__c = subFolderMap.get(collaboration.BoxFolder_Id__c);
            listToUpdate.add(collaboration);
        }
        
        update listToUpdate;
    
    }
    
    public void finish(Database.BatchableContext BC){}
}