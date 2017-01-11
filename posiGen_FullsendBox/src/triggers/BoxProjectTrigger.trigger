trigger BoxProjectTrigger on Project__c (after insert,after update,before delete) {
 Trigger_Setting__c ts= Trigger_Setting__c.getInstance();
  if(ts.Project_Trigger__c){      
      
      if(UtilityController.recursive == true || UtilityController.pmtool_flag == true){
          UtilityController.recursive = false;
          UtilityController.pmtool_flag = false;
          
          TriggerFactory.createHandler(ProjectTriggerHandler.class);
      }
      
  }     
}