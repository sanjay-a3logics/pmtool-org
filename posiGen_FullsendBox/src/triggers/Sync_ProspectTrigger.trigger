trigger Sync_ProspectTrigger on Prospect__c (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
      
   if(!Sync_LeadTriggerHelper.sync_LeadTriggerIsRunning && Trigger_Setting__c.getOrgDefaults().Sync_Prospect_Trigger__c){ //do not proceed if lead sync trigger is running or if custom setting toggled off
   		Sync_ProspectTriggerHelper.sync_ProspectTriggerIsRunning = true; 
   		
	    //------------------------BEFORE------------------------
		if(trigger.isBefore){
		    //====================INSERT====================
		    if(trigger.isInsert){
		    	Sync_ProspectTriggerHelper.insert_ProspectToLeadSync(trigger.new);
		    }
		    //====================UPDATE====================
		    else if(trigger.isUpdate){
		    	Sync_ProspectTriggerHelper.insert_ProspectToLeadSync(trigger.new); //generate leads for any pre-existing prospects that do not relate to a lead
		    }
		    //====================DELETE====================
		    else if(trigger.isDelete){
		    	Sync_ProspectTriggerHelper.delete_ProspectToLeadSync(trigger.oldMap);
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
		    	Sync_ProspectTriggerHelper.update_ProspectToLeadSync(trigger.newMap);
		    }
		    //====================DELETE====================
		    else if(trigger.isDelete){
		    	//nothing here
		    }
		}
   }
}