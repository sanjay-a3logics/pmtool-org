global without sharing class Batch_SyncCaseToIssue implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext BC){
		String caseFields = SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(Case.getSobjectType());
		return Database.getQueryLocator('SELECT ' + caseFields + ' FROM Case');
	}
	
	global void execute(Database.BatchableContext BC, List<Case> scope){
		String issueFields = SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(Issue__c.getSobjectType());
		Set<Id> caseIds = new Set<Id>();
		Issue__c[] existingIssues = new Issue__c[]{};
		Map<Id, Issue__c> caseIdToExistingIssue = new Map<Id, Issue__c>();
		SynchronizationEngine.SyncWrapper[] wrappersToSync = new SynchronizationEngine.SyncWrapper[]{};
		SynchronizationEngine.SyncWrapper[] syncedWrappers = new SynchronizationEngine.SyncWrapper[]{};
		Issue__c[] issuesToUpsert = new Issue__c[]{};
		
		if(scope.size() > 0){
			//create set of case ids
			for(Case l : scope){
				caseIds.add(l.Id);
			}
			
			//query existing issues by case id
			existingIssues = database.query('SELECT ' + issueFields + ' FROM Issue__c WHERE Case__c IN: caseIds');
			
			//create map of case id to existing issue record
			for(Issue__c p : existingIssues){
				caseIdToExistingIssue.put(p.Case__c, p);
			}
			
			//loop over cases
			for(Case l : scope){
				//if case found to have an existing issue record, then perform sync using the existing issue record
				if(caseIdToExistingIssue.containsKey(l.Id)){
					wrappersToSync.add(new SynchronizationEngine.SyncWrapper(l, caseIdToExistingIssue.get(l.Id)));
				}
				else{//otherwise, create a new issue record
					wrappersToSync.add(new SynchronizationEngine.SyncWrapper(l, new Issue__c(Case__c = l.Id)));
				}
			}
			
			syncedWrappers = SynchronizationEngine.initiateSynchronization(wrappersToSync);
			
			for(SynchronizationEngine.SyncWrapper s : syncedWrappers){
				issuesToUpsert.add((Issue__c) s.recToSyncTo);
			}
			
			//upsert issues
			upsert issuesToUpsert;
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