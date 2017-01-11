trigger PropertyTrigger on Property__c (after update) {

    if(LMITriggerHandler.firstRun){
        UtilityController.calledBy = 'Property';  
        TriggerFactory.createHandler(LMITriggerHandler.class);      
        LMITriggerHandler.firstRun =false; 
    }
}