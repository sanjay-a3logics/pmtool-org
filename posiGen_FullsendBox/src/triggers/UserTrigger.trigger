trigger UserTrigger on User (after insert,after update) {
   Trigger_Setting__c ts = Trigger_Setting__c.getInstance();
  if(ts.User_Trigger__c == true){ 
     TriggerFactory.createHandler(UserTriggerHandler.class);
    } 
}