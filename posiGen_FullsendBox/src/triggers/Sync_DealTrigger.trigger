trigger Sync_DealTrigger on Deal__c (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
   
   if(!Sync_OpportunityTriggerHelper.sync_OpportunityTriggerIsRunning && Trigger_Setting__c.getOrgDefaults().Sync_Deal_Trigger__c){ //do not proceed if opportunity sync trigger is running or if custom setting toggled off
	   Sync_DealTriggerHelper.sync_DealTriggerIsRunning = true;
	   
	    //------------------------BEFORE------------------------
		if(trigger.isBefore){
		    //====================INSERT====================
		    if(trigger.isInsert){
		    	Sync_DealTriggerHelper.insert_DealToOpportunitySync(trigger.new);
		    }
		    //====================UPDATE====================
		    else if(trigger.isUpdate){
		    	Sync_DealTriggerHelper.insert_DealToOpportunitySync(trigger.new); //generate opportunities for any pre-existing deals that do not relate to an oppotunity
		    }
		    //====================DELETE====================
		    else if(trigger.isDelete){
		    	Sync_DealTriggerHelper.delete_DealToOpportunitySync(trigger.oldMap);
		    }  
		}
	    
	//------------------------AFTER------------------------
	    if(trigger.isAfter){
		    //====================INSERT====================
		    if(trigger.isInsert){
		    	//nothing here
		    }
		    //====================UPDATE====================
		    else if(trigger.isUpdate){
		    	Sync_DealTriggerHelper.update_DealToOpportunitySync(trigger.newMap);
		    }
		    //====================DELETE====================
		    else if(trigger.isDelete){
		    	//nothing here
		    }  
		}
   }
}