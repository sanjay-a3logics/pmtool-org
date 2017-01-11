public class AgingUpdate implements Database.Batchable<Sobject>, Database.Stateful{
     
    Map<id, Exception_Threshold__c> exceptionMap;
    
    public AgingUpdate(){
          
    }
    
    public Database.QueryLocator start(Database.BatchableContext BC){
    
        exceptionMap = new Map<id, Exception_Threshold__c>();
        for(Exception_Threshold__c et: [select id, Business_Installation_Step__c, In_Process_Threshold__c, PM_Review_Threshold__c from Exception_Threshold__c]){
              exceptionMap.put(et.Business_Installation_Step__c, et);              
        }
        
        String query='SELECT Id,Aging__c,Business_Installation_Step__c,Business_Status__c,End_Date__c,In_Process_Aging__c,In_Process_Aging_Exception__c,In_Process_End_Date__c,In_Process_Start_Date__c,NA_Override__c,PM_Review_Aging__c,PM_Review_Aging_Exception__c,PM_Review_End_Date__c,PM_Review_Start_Date__c,PM_Stage__c,PM_Tool_V2__c,Start_Date__c from PM_Steps__c where End_Date__c = null and Business_status__r.Score__c != 0 and Business_status__r.Score__c != -1';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext BC,List<PM_Steps__c> scope) {
        
        List<PM_Steps__c> pmAgingList = new List<PM_Steps__c>();

        for(PM_Steps__c pm : scope){
        
           try{
            
               // Calculation for aging
               Integer aging = 0;
               
               if(pm.Start_Date__c != null) {
                  aging = Integer.valueOf(pm.Start_Date__c.daysBetween(System.today()));
               }
               pm.Aging__c = aging;
            
               // Calculation for pm review aging
               Integer pm_review_aging = 0;
               
               if(pm.PM_Review_Start_Date__c != null && pm.PM_Review_End_Date__c == null) {
                  pm_review_aging = Integer.valueOf(pm.PM_Review_Start_Date__c.daysBetween(System.today()));
               }
               pm.PM_Review_Aging__c = pm_review_aging;
               
               // Calculation for in process aging
               Integer in_process_aging = 0;
               
               if(pm.In_Process_Start_Date__c != null && pm.In_Process_End_Date__c == null) {
                  in_process_aging = Integer.valueOf(pm.In_Process_Start_Date__c.daysBetween(System.today()));
               }
               pm.In_Process_Aging__c = in_process_aging;
               
               // Calculation for pm review exception
               if(exceptionMap.containsKey(pm.Business_Installation_Step__c)){
                    if(exceptionMap.get(pm.Business_Installation_Step__c).PM_Review_Threshold__c < pm.PM_Review_Aging__c){
                        pm.PM_Review_Aging_Exception__c = true;
                    }
                   
                    if(exceptionMap.get(pm.Business_Installation_Step__c).In_Process_Threshold__c < pm.In_Process_Aging__c){
                        pm.In_Process_Aging_Exception__c = true;
                    }
                    
                }
                      
                pmAgingList.add(pm);
            }
            catch(Exception e){
                system.debug('Following Error has Occured'+ e.getMessage());
            } 
        }
        
        try{
            update pmAgingList;
        }
        catch(Exception e){
            system.debug('Following Error has Occured'+ e.getMessage());
        }
        
    }

    public void finish(Database.BatchableContext BC){
    }
}