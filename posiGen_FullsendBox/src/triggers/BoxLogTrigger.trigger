trigger BoxLogTrigger on Box_Error__c (after insert){
  Trigger_Setting__c ts= Trigger_Setting__c.getInstance();
  if(ts.LogsTrigger__c==true){
     TriggerFactory.createHandler(LogsTriggerHandler.class);
    }   
}