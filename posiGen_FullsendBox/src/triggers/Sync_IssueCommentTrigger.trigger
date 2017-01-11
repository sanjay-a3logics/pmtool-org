trigger Sync_IssueCommentTrigger on Issue_Comment__c (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
   
   if(Trigger_Setting__c.getOrgDefaults().Sync_Issue_Comment_Trigger__c){ //do not proceed if custom setting toggled off
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
		    	Sync_IssueCommentTriggerHelper.setLastCaseCommentOnRelatedIssueRecords(trigger.new);
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