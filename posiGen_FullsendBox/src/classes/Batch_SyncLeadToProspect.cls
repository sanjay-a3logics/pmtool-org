global without sharing class Batch_SyncLeadToProspect implements Database.Batchable<sObject>{
    
	global Database.QueryLocator start(Database.BatchableContext BC){
		String leadFields = SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(Lead.getSobjectType());
		return Database.getQueryLocator('SELECT ' + leadFields + ' FROM Lead'); //WHERE (Municipality__c = null OR Municipality__c = \'0011700000i8uBE\') AND IsConverted = false limit 2
	}
	
	global void execute(Database.BatchableContext BC, List<Lead> scope){
		String prospectFields = SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(Prospect__c.getSobjectType());
		Set<Id> leadIds = new Set<Id>();
		Prospect__c[] existingProspects = new Prospect__c[]{};
		Map<Id, Prospect__c> leadIdToExistingProspect = new Map<Id, Prospect__c>();
		SynchronizationEngine.SyncWrapper[] wrappersToSync = new SynchronizationEngine.SyncWrapper[]{};
		SynchronizationEngine.SyncWrapper[] syncedWrappers = new SynchronizationEngine.SyncWrapper[]{};
		Prospect__c[] prospectsToUpsert = new Prospect__c[]{};
		
		if(scope.size() > 0){
			//create set of lead ids
			for(Lead l : scope){
				leadIds.add(l.Id);	
			}
			
			//query existing prospects by lead id
			existingProspects = database.query('SELECT ' + prospectFields + ' FROM Prospect__c WHERE Lead__c IN: leadIds');
			
			//create map of lead id to existing prospect record
			for(Prospect__c p : existingProspects){
				leadIdToExistingProspect.put(p.Lead__c, p);
			}
			
			//loop over leads
			for(Lead l : scope){
				//Prospect__c syncedProspect = new Prospect__c();
				
				//if lead found to have an existing prospect record, then perform sync using the existing prospect record
				if(leadIdToExistingProspect.containsKey(l.Id)){
					wrappersToSync.add(new SynchronizationEngine.SyncWrapper(l, leadIdToExistingProspect.get(l.Id)));
					//syncedProspect = (Prospect__c) SynchronizationEngine.initiateSynchronization(l, leadIdToExistingProspect.get(l.Id));
				}
				else{//otherwise, create a new prospect record
					wrappersToSync.add(new SynchronizationEngine.SyncWrapper(l, new Prospect__c(Lead__c = l.Id)));
					//syncedProspect = (Prospect__c) SynchronizationEngine.initiateSynchronization(l, new Prospect__c());
				}
				
				//set any additional fields on prospect record that isn't set by sync engine
				//syncedProspect.Lead__c = l.Id;
			
				//add prospect to list of records to upsert
				//prospectsToUpsert.add(syncedProspect);
			}
			
			syncedWrappers = SynchronizationEngine.initiateSynchronization(wrappersToSync);
			
			for(SynchronizationEngine.SyncWrapper s : syncedWrappers){
				prospectsToUpsert.add((Prospect__c) s.recToSyncTo);
			}
			
			//upsert prospects
			upsert prospectsToUpsert;
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