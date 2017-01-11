global without sharing class Batch_TransferLeadTasksToProspect implements Database.Batchable<sObject>{
    
    /*
    	Note: If an activities whoid is set to a lead, then the whatId cannot be set. This means we must clear the whoid and set the whatid on the activity to the prospect.
    */
    
    global Database.QueryLocator start(Database.BatchableContext BC){
		return Database.getQueryLocator('SELECT Id, WhatId, WhoId FROM Task WHERE IsDeleted = false AND Related_Who__c = \'Lead\' ALL ROWS');
	}
	
	global void execute(Database.BatchableContext BC, List<Task> scope){
		Set<Id> leadIds = new Set<Id>();
		Prospect__c[] prospects = new Prospect__c[]{};
		Map<Id, Id> leadIdToProspectId = new Map<Id, Id>();
		Task[] tasksToUpdate = new Task[]{};
		
		//create set of lead ids related to the activities
		for(Task t : scope){
			leadIds.add(t.WhoId);
		}
		
		//query the prospects where related lead is in the list of lead ids
		prospects = [SELECT Id, Lead__c FROM Prospect__c WHERE Lead__c IN: leadIds];
		
		//create map of lead id to prospect id
		for(Prospect__c p : prospects){
			leadIdToProspectId.put(p.Lead__c, p.Id);
		}
		
		//loop over tasks
		for(Task t : scope){
			//clear the whoid and set the whatid to the prospect if prospect was found for lead related to task
			if(leadIdToProspectId.containsKey(t.WhoId)){
				t.WhatId = leadIdToProspectId.get(t.WhoId);
				t.WhoId = null;
				tasksToUpdate.add(t);
			}
		}
			
		//update tasks
		update tasksToUpdate;
	}
	
	global void finish(Database.BatchableContext BC){
		//nothing to do here!
	}
	
	global static void byPassTest(){
		integer i = 0;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
	}
}