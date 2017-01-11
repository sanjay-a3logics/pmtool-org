public with sharing class BatchDeleteLogRecords implements Database.Batchable<Sobject>,Database.Stateful{
    
    public String query_string;
    public String sObj;
    
    public BatchDeleteLogRecords(String query_string, String sObj){
        
        this.sObj = sObj;
        this.query_string = query_string;
        
        system.debug('sObj============='+sObj);
        system.debug('query_string============'+query_string);
    } 
    
    public Database.QueryLocator start(Database.BatchableContext BC){
        
        //select id, createddate from box_log__c where createddate < LAST_N_MONTHS:2
        system.debug('sObj='+sObj);
        system.debug('query_string='+query_string);
        return Database.getQueryLocator(query_string);
    }
    
    public void execute(Database.BatchableContext BC,List<sObject> deleteList){
        
        try{
        
            delete deleteList;
            DataBase.emptyRecycleBin(deleteList);
        }
        catch(Exception e){
            system.debug('Error in BatchDeleteLogRecords - '+e.getMessage()+' - '+e.getStackTraceString());
        }
    }
    
     public void finish(Database.BatchableContext BC){
        
    }
    
}