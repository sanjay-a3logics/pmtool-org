trigger DealTrigger on Deal__c (before update, after insert, after update, before delete) {

 Trigger_Setting__c ts = Trigger_Setting__c.getInstance();
 
   if(ts.Deal_Trigger__c){         
       if(Trigger.isAfter || (Trigger.isBefore && Trigger.isDelete)){
        TriggerFactory.createHandler(DealTriggerHandler.class);   								
       }          
    }   
     
    
    if(LMITriggerHandler.firstRun){
        if((Trigger.isAfter && Trigger.isInsert) || (Trigger.isBefore && Trigger.isUpdate)){
          UtilityController.calledBy = 'Deal__c';        
          TriggerFactory.createHandler(LMITriggerHandler.class);      
          LMITriggerHandler.firstRun =false; 
        }  
    }        
}