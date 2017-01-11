trigger OpportunityTrigger on Opportunity (before update, after insert, after update, before delete) {
   Trigger_Setting__c ts = Trigger_Setting__c.getInstance();
   if(ts.Opportunity_Trigger__c){ 
       if(Trigger.isAfter || (Trigger.isBefore && Trigger.isDelete)){
        //system.assert(false,'testttt');  
        TriggerFactory.createHandler(OpportunityTriggerHandler.class);
       }
    } 
      
    
    if(LMITriggerHandler.firstRun){
        if((Trigger.isAfter && Trigger.isInsert) || (Trigger.isBefore && Trigger.isUpdate)){
          UtilityController.calledBy = 'Opportunity';               
          //TriggerFactory.createHandler(LMITriggerHandler.class);      
          LMITriggerHandler.firstRun =false; 
        }  
    }
}