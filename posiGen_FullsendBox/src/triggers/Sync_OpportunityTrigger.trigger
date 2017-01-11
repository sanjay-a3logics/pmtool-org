trigger Sync_OpportunityTrigger on Opportunity (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
   
   if(!Sync_DealTriggerHelper.sync_DealTriggerIsRunning && Trigger_Setting__c.getOrgDefaults().Sync_Opportunity_Trigger__c){ //do not proceed if deal sync trigger is running or if custom setting toggled off
	   Sync_OpportunityTriggerHelper.sync_OpportunityTriggerIsRunning = true;
	   
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
		    	//nothing here
		    }  
		}
	    
//------------------------AFTER------------------------
	    if(trigger.isAfter){
		    //====================INSERT====================
		    if(trigger.isInsert){
		    	Sync_OpportunityTriggerHelper.insert_OpportunityToDealSync(trigger.newMap);
		    }
		    //====================UPDATE====================
		    else if(trigger.isUpdate){
		    	//nothing here
		    }
		    //====================DELETE====================
		    else if(trigger.isDelete){
		    	//nothing here
		    }  
		}
   }
}