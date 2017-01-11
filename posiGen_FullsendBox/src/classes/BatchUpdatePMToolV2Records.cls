public without sharing class BatchUpdatePMToolV2Records implements Schedulable,Database.AllowsCallouts {

    public BatchUpdatePMToolV2Records() {
        
    }
    
    public void execute(SchedulableContext sc) {
        BatchUpdatePMToolV2Records.updatePmTool();
    }
    
    public static void updatePmTool(){
        try{
            for(PM_Tool_v2__c pmtool : [select id from PM_Tool_v2__c where id in(select PM_Tool_v2__c from pm_stage__c where business_status__c = null and PM_Tool_v2__c != null) limit 50]){
                Set<Id> pmToolIds = new Set<Id>();
                pmToolIds.add(pmtool.id);   //change
                PMToolV2.updateStages(pmtool.id, UserInfo.getSessionId());
            } 
            
            if([select id from PM_Tool_v2__c where id in(select PM_Tool_v2__c from pm_steps__c where business_status__c = null and PM_Tool_v2__c != null)].size() != 0){
            
                Datetime newTime = datetime.now().addMinutes(5); 
                Double st = Math.random();   
                String sched= String.valueOf(newtime.second()) +' ' + String.valueOf(newtime.minute()) + ' ' + String.valueOf(newTime.hour()) + ' ' + String.valueOf(newTime.day()) + ' ' + String.valueOf(newTime.month()) + ' ? ' +  String.valueOf(newTime.year()); 
                BatchUpdatePMToolV2Records SC = new BatchUpdatePMToolV2Records(); 
                System.schedule('BatchUpdatePMToolV2Records - '+newTime+String.valueOf(st), sched, SC);
            
            }
            
        }
        
        catch(Exception e){
            system.assert(false, e.getMessage()+'--'+e.getStackTraceString());
        }
    }

}