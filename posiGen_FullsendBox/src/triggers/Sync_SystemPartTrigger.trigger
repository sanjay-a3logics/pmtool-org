trigger Sync_SystemPartTrigger on System_Part__c (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
   
	if(Trigger_Setting__c.getOrgDefaults().Sync_System_Part_Trigger__c){ //if custom setting toggled off do not run
	    //------------------------BEFORE------------------------
		if(trigger.isBefore){
		    //====================INSERT====================
		    if(trigger.isInsert){
		    	//nothing here
		    }
		    //====================UPDATE====================
		    else if(trigger.isUpdate){
		    	//nothing here
		    }
		    //====================DELETE====================
		    else if(trigger.isDelete){
		    	Sync_SystemPartTriggerHelper.delete_SystemPartToOpportunityLineItemSync(trigger.oldMap);
		    }  
		}
	    
	//------------------------AFTER------------------------
	    if(trigger.isAfter){
		    //====================INSERT====================
		    if(trigger.isInsert){
		    	Sync_SystemPartTriggerHelper.insert_SystemPartToOpportunityLineItemSync(trigger.newMap);
		    }
		    //====================UPDATE====================
		    else if(trigger.isUpdate){
		    	Sync_SystemPartTriggerHelper.update_SystemPartToOpportunityLineItemSync(trigger.newMap);
		    }
		    //====================DELETE====================
		    else if(trigger.isDelete){
		    	//nothing here
		    }  
		}
	}
}