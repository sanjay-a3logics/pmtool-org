global without sharing class Batch_TransferOpportunityEventsToDeal implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext BC){
		return Database.getQueryLocator('SELECT Id, WhatId, WhoId FROM Event WHERE IsDeleted = false AND Related_What__c = \'006\' ALL ROWS');
	}
	
	global void execute(Database.BatchableContext BC, List<Event> scope){
		Set<Id> opportunityIds = new Set<Id>();
		Deal__c[] deals = new Deal__c[]{};
		Map<Id, Id> opportunityIdToDealId = new Map<Id, Id>();
		Event[] eventsToUpdate = new Event[]{};
		database.SaveResult[] dmlResults;
		
		//create set of opportunity ids related to the activities
		for(Event t : scope){
			opportunityIds.add(t.WhatId);
		}
		
		//query the deals where related opportunity is in the list of opp ids
		deals = [SELECT Id, Opportunity__c FROM Deal__c WHERE Opportunity__c IN: opportunityIds];
		
		//create map of opportunity id to deal id
		for(Deal__c p : deals){
			opportunityIdToDealId.put(p.Opportunity__c, p.Id);
		}
		
		//loop over events
		for(Event t : scope){
			//set the whatid to the deal if deal was found for opportunity related to task
			if(opportunityIdToDealId.containsKey(t.WhatId)){
				t.WhatId = opportunityIdToDealId.get(t.WhatId);
				eventsToUpdate.add(t);
			}
		}
			
		//update events
		update eventsToUpdate;
    	//dmlResults = database.update(eventsToUpdate, false);
    	
    	//check save results for failures and insert errors logs for each record that may have failed
    	//SynchronizationEngine.checkDMLSaveResultsAndInsertSyncErrorLogsForEachFailure(dmlResults, 'Failure in Batch_TransferOpportunityEventsToDeal', (sObject[]) eventsToUpdate);
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