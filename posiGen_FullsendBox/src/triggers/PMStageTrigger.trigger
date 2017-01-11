trigger PMStageTrigger on PM_Stage__c (after update) {
    
    //system.debug('PM_Review.pmReviewed---------'+PM_Review.pmReviewed);
    if(PM_Review.pmReviewed){
        PMToolV2.updateStageFromTrigger(Trigger.NewMap.keySet(), UserInfo.getSessionId());
        PMToolV2.updateStageFromTrigger(Trigger.NewMap.keySet(), UserInfo.getSessionId());
    }
    
}