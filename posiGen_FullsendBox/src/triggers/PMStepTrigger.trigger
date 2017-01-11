trigger PMStepTrigger on PM_Steps__c (before update, after update) {

    if(PMToolV2.runStepTrigger){
        if(Trigger.isBefore){
        
            Map<Integer,id> bStatusMap = new Map<Integer,id>();
            Map<Id, Exception_Threshold__c> excepMap = new Map<Id, Exception_Threshold__c>();
            
            for(Business_Status__c status : [select id, Score__c from Business_Status__c]){
                bStatusMap.put(Integer.valueOf(status.Score__c), status.id);
            }
            for(Exception_Threshold__c ex : [select id, In_Process_Threshold__c, PM_Review_Threshold__c, Business_Installation_Step__c from Exception_Threshold__c]){
                excepMap.put(ex.Business_Installation_Step__c, ex);
            }
            
            for(PM_Steps__c pmStep : Trigger.New) {
                PM_Steps__c oldPmStep = Trigger.OldMap.get(pmStep.id);
                
                if((pmStep.End_Date__c != oldPmStep.End_Date__c) || (pmStep.Start_Date__c != oldPmStep.Start_Date__c)) {
                    
                    if(pmStep.Start_Date__c != null && pmStep.End_Date__c == null){
                        pmStep.Aging__c =  pmStep.Start_Date__c.daysBetween(Date.Today());
                    }
                    else if(pmStep.Start_Date__c != null && pmStep.End_Date__c!= null){
                        pmStep.Aging__c =  pmStep.Start_Date__c.daysBetween(pmStep.End_Date__c);
                    }
                    else{
                        pmStep.Aging__c = null;
                    }    
                }
                
                if((pmStep.In_Process_End_Date__c != oldPmStep.In_Process_End_Date__c) || (pmStep.In_Process_Start_Date__c != oldPmStep.In_Process_Start_Date__c)){
                    
                    if(pmStep.In_Process_Start_Date__c != null && pmStep.In_Process_End_Date__c == null){
                        pmStep.In_Process_Aging__c =  pmStep.In_Process_Start_Date__c.daysBetween(Date.Today());
                    }
                    else if(pmStep.In_Process_Start_Date__c != null && pmStep.In_Process_End_Date__c!= null){
                        pmStep.In_Process_Aging__c =  pmStep.In_Process_Start_Date__c.daysBetween(pmStep.In_Process_End_Date__c);
                    }
                    else{
                        pmStep.In_Process_Aging__c = null;
                    }
                    
                    if(excepMap.containsKey(pmStep.Business_Installation_Step__c)) {
                        if(excepMap.get(pmStep.Business_Installation_Step__c).In_Process_Threshold__c < pmStep.In_Process_Aging__c) {
                            pmStep.In_Process_Aging_Exception__c= true;
                        }
                    }
                }
                //system.assert(false, 'pmStep.Business_Status__r.Name' +pmStep.Business_Status__r.Name);
                if((pmStep.PM_Review_End_Date__c != oldPmStep.PM_Review_End_Date__c) || (pmStep.PM_Review_Start_Date__c != oldPmStep.PM_Review_Start_Date__c)) {
                    
                    if(pmStep.PM_Review_Start_Date__c != null && pmStep.PM_Review_End_Date__c == null){
                        pmStep.PM_Review_Aging__c =  pmStep.PM_Review_Start_Date__c.daysBetween(Date.Today());
                    }
                    else if(pmStep.PM_Review_Start_Date__c != null && pmStep.PM_Review_End_Date__c != null){
                        pmStep.PM_Review_Aging__c =  pmStep.PM_Review_Start_Date__c.daysBetween(pmStep.PM_Review_End_Date__c);
                    }
                    else{
                        pmStep.PM_Review_Aging__c = null;
                    }
                    
                    if(excepMap.containsKey(pmStep.Business_Installation_Step__c)) {
                        if(excepMap.get(pmStep.Business_Installation_Step__c).PM_Review_Threshold__c < pmStep.PM_Review_Aging__c) {
                            pmStep.PM_Review_Aging_Exception__c= true;
                        }
                    }
                }
                
                if((pmStep.NA_Override__c != oldPmStep.NA_Override__c) && pmStep.NA_Override__c == true){
                
                     pmStep.Start_Date__c = null;
                     pmStep.End_Date__c = null;
                     pmStep.Aging__c = null;
                     pmStep.In_Process_Aging__c = null;
                     pmStep.In_Process_Aging_Exception__c = false;
                     pmStep.In_Process_End_Date__c = null;
                     pmStep.In_Process_Start_Date__c = null;
                     pmStep.PM_Review_Aging__c = null;
                     pmStep.PM_Review_Aging_Exception__c = false;
                     pmStep.PM_Review_End_Date__c = null;
                     pmStep.PM_Review_Start_Date__c = null;                                 
                     
                     if(pmStep.NA_Override__c == true){
                         pmStep.Business_Status__c = bStatusMap.get(-1);
                     }
                }
            }
        }
        
        if(Trigger.isAfter){
            if(PMToolV2.updateStagesFirstRun){
                for(PM_Steps__c pmStep : Trigger.New){
                    PMToolV2.updateStages(pmStep.PM_Tool_V2__c ,UserInfo.getSessionId());
                }
                
                PMToolV2.updateStagesFirstRun = false;
            }
        }
    }
}