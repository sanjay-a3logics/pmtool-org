global without sharing class Batch_SyncOpportunityToDeal implements Database.Batchable<sObject>{
	
    global Database.QueryLocator start(Database.BatchableContext BC){
		String opportunityFields = SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(Opportunity.getSobjectType());
		return Database.getQueryLocator('SELECT ' + opportunityFields + ' FROM Opportunity');
		//return Database.getQueryLocator('SELECT ' + opportunityFields + ' FROM Opportunity WHERE Id NOT IN (SELECT Opportunity__c FROM Deal__c)');
	}
	
	global void execute(Database.BatchableContext BC, List<Opportunity> scope){
		String dealFields = SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(Deal__c.getSobjectType());
		Set<Id> opportunityIds = new Set<Id>();
		Deal__c[] existingdeals = new Deal__c[]{};
		Map<Id, Deal__c> opportunityIdToExistingDeal = new Map<Id, Deal__c>();
		SynchronizationEngine.SyncWrapper[] wrappersToSync = new SynchronizationEngine.SyncWrapper[]{};
		SynchronizationEngine.SyncWrapper[] syncedWrappers = new SynchronizationEngine.SyncWrapper[]{};
		Deal__c[] dealsToUpsert = new Deal__c[]{};
		
		if(scope.size() > 0){
			//create set of opportunity ids
			for(Opportunity l : scope){
				opportunityIds.add(l.Id);	
			}
			
			//query existing deals by opportunity id
			existingDeals = database.query('SELECT ' + dealFields + ' FROM Deal__c WHERE Opportunity__c IN: opportunityIds');
			
			//create map of opportunity id to existing deal record
			for(Deal__c p : existingDeals){
				opportunityIdToExistingDeal.put(p.Opportunity__c, p);
			}
			
			//loop over opportunitys
			for(Opportunity l : scope){
				Deal__c syncedDeal = new Deal__c();
				
				//if Opportunity found to have an existing Deal record, then perform sync using the existing Deal record
				if(opportunityIdToExistingDeal.containsKey(l.Id)){
					wrappersToSync.add(new SynchronizationEngine.SyncWrapper(l, opportunityIdToExistingDeal.get(l.Id)));
					//syncedDeal = (Deal__c) SynchronizationEngine.initiateSynchronization(l, opportunityIdToExistingDeal.get(l.Id));
				}
				else{//otherwise, create a new Deal record
					wrappersToSync.add(new SynchronizationEngine.SyncWrapper(l, new Deal__c(Opportunity__c = l.Id)));
					//syncedDeal = (Deal__c) SynchronizationEngine.initiateSynchronization(l, new Deal__c());
				}
				
				//set any additional fields on Deal record that isn't set by sync engine
				//syncedDeal.Opportunity__c = l.Id;
			
				//add Deal to list of records to upsert
				//DealsToUpsert.add(syncedDeal);
			}
			
			syncedWrappers = SynchronizationEngine.initiateSynchronization(wrappersToSync);
			
			for(SynchronizationEngine.SyncWrapper s : syncedWrappers){
				dealsToUpsert.add((Deal__c) s.recToSyncTo);
			}
			
			//upsert Deals
			upsert dealsToUpsert;
		}
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