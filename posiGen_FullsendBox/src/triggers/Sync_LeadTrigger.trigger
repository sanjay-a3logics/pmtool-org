trigger Sync_LeadTrigger on Lead (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
    
    if(!Sync_ProspectTriggerHelper.sync_ProspectTriggerIsRunning && Trigger_Setting__c.getOrgDefaults().Sync_Lead_Trigger__c){ //do not proceed if opportunity sync trigger is running or if custom setting toggled off
	    Sync_LeadTriggerHelper.sync_LeadTriggerIsRunning = true;
	    
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
		    	Sync_LeadTriggerHelper.delete_LeadToProspectSync(trigger.oldMap);
		    }  
		}
	    
	//------------------------AFTER------------------------
	    if(trigger.isAfter){
		    //====================INSERT====================
		    if(trigger.isInsert){
		    	Sync_LeadTriggerHelper.insert_LeadToProspectSync(trigger.newMap);
		    }
		    //====================UPDATE====================
		    else if(trigger.isUpdate){
		    	Sync_LeadTriggerHelper.update_LeadToProspectSync(trigger.newMap);
		    	Sync_LeadTriggerHelper.insert_LeadToProspectSync(trigger.newMap); //try again to generate prospects for any pre-existing leads that do not relate to a prospect due to a previous failure
		    }
		    //====================DELETE====================
		    else if(trigger.isDelete){
		    	//nothing here
		    }  
		}
    }
}