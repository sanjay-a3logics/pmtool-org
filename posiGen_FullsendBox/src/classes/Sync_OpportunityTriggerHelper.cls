public without sharing class Sync_OpportunityTriggerHelper {
	
    public static boolean sync_OpportunityTriggerIsRunning = false;
    
    //Function: Newly inserted opportunities will generate, sync, and link a new deal record to itself
    public static void insert_OpportunityToDealSync(Map<Id, Opportunity> trigNewMap){
    	try{
    		database.SaveResult[] dmlResults;
	    	Set<Id> opportunityIds = new Set<Id>();
	    	Opportunity[] queriedOpportunities = new Opportunity[]{};
	    	SynchronizationEngine.SyncWrapper[] wrapsToSync = new SynchronizationEngine.SyncWrapper[]{};
	    	SynchronizationEngine.SyncWrapper[] syncedWraps = new SynchronizationEngine.SyncWrapper[]{};
	    	Deal__c[] dealsToInsert = new Deal__c[]{};
	    	
	    	//query all fields on opportunity records
	    	String fieldsToQuery = SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(Opportunity.getSobjectType());
	    	opportunityIds.addAll(trigNewMap.keySet());
			queriedOpportunities = database.query(SynchronizationEngine.buildQueryString(fieldsToQuery, 'Opportunity', 'Id IN: opportunityIds'));
	    	
	    	//create sync wrappers
	    	for(Opportunity l : queriedOpportunities){
	    		wrapsToSync.add(new SynchronizationEngine.SyncWrapper(l, new Deal__c())); //SyncWrapper(recToSyncFrom, recToSyncTo)
	    	}
	    	
	    	//call to sync engine
	    	syncedWraps = SynchronizationEngine.initiateSynchronization(wrapsToSync);
	    	
	    	//retrieve list of deals to insert
	    	for(SynchronizationEngine.SyncWrapper w : syncedWraps){
	    		dealsToInsert.add((Deal__c) w.recToSyncTo);
	    	}
	    	
	    	//insert deals, allow partial success
	    	dmlResults = database.insert(dealsToInsert, false);
	    	
	    	//check save results for failures and insert errors logs for each record that may have failed
	    	SynchronizationEngine.checkDMLSaveResultsAndInsertSyncErrorLogsForEachFailure(dmlResults, 'A deal failed to be inserted in the Sync_OpportunityTrigger.', (sObject[]) dealsToInsert);
    	}
    	catch(Exception e){
    		//insert error log
    		SynchronizationEngine.insertSyncErrorLog(e.getMessage(), e.getStackTraceString());
    	}
    }
}