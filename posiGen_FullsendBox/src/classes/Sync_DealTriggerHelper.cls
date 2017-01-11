public without sharing class Sync_DealTriggerHelper {
    
    public static boolean sync_DealTriggerIsRunning = false;
    
    //Function: Newly inserted deals will generate, sync, and link a new opportunity record to itself.
    	//Method needs to be called from a BEFORE INSERT trigger. Reason: In order to update the Opportunity__c field on Deals to link to the opportunity that was inserted.
    public static void insert_DealToOpportunitySync(Deal__c[] trigNew){
    	
    	try{
    		database.SaveResult[] dmlResults;
	    	Set<Id> dealIds = new Set<Id>();
	    	Deal__c[] queriedDeals = new Deal__c[]{};
	    	SynchronizationEngine.SyncWrapper[] wrapsToSync = new SynchronizationEngine.SyncWrapper[]{};
	    	SynchronizationEngine.SyncWrapper[] syncedWraps = new SynchronizationEngine.SyncWrapper[]{};
	    	Opportunity[] opportunitiesToInsert = new Opportunity[]{};
	    	
	    	//create sync wrappers
	    	for(Deal__c l : trigNew){
	    		if(l.Opportunity__c == null){ //ONLY generate a new opportunity if one doesn't already exist and related on deal
	    			wrapsToSync.add(new SynchronizationEngine.SyncWrapper(l, new Opportunity())); //SyncWrapper(recToSyncFrom, recToSyncTo)
	    		}
	    	}
	    	
	    	//continue ONLY if there are deals to sync
	    	if(wrapsToSync.size() > 0){
		    	//call to sync engine
		    	syncedWraps = SynchronizationEngine.initiateSynchronization(wrapsToSync);
		    	
		    	//retrieve list of opportunities to insert
		    	for(SynchronizationEngine.SyncWrapper w : syncedWraps){
		    		opportunitiesToInsert.add((Opportunity) w.recToSyncTo);
		    	}
		    	
		    	//insert opportunities, allow partial success
		    	dmlResults = database.insert(opportunitiesToInsert, false); 
		    	
		    	//check save results for failures and insert errors logs for each record that may have failed
		    	SynchronizationEngine.checkDMLSaveResultsAndInsertSyncErrorLogsForEachFailure(dmlResults, 'An opportunity failed to be inserted in the Sync_DealTrigger.', (sObject[]) opportunitiesToInsert);
		    	
		    	//now that the opportunities are created, we need to set the Opportunity__c lookup field on the Deals to link the records
		    	for(SynchronizationEngine.SyncWrapper w : syncedWraps){
		    		//NOTE: if opportunity id doesn't exist, then that means the opportunity failed to be inserted. If this occurs,
		    			//then skip setting the opportunity__c field on deal. This way the deal can still be inserted with no issues.
		    		if(w.recToSyncTo.Id != null){
		    			w.recToSyncFrom.put('Opportunity__c', w.recToSyncTo.Id);
		    		}
		    	}
	    	}
    	}
    	catch(Exception e){
    		//insert error log
    		SynchronizationEngine.insertSyncErrorLog(e.getMessage(), e.getStackTraceString());
    	}
    }
    
    /*Concern: what happens if deal isn't relating to an opportunity? Error will be thrown when trying to access the opportunity__c id field.
    	Fix: we can perform a check to see if the opportunity__c field is null, if yes then input a blank opportunity into the wrapper.
    	Then make the dml an upsert instead of a update of opportunities.
    	Then we also need to set the opportunity lookup field on deal. But to do this the trigger will need to be in a BEFORE trigger.
    */
    //Function: Updated deals will be synced to related opportunity record
    public static void update_DealToOpportunitySync(Map<Id, Deal__c> trigNewMap){
    	try{
    		database.SaveResult[] dmlResults;
	    	Set<Id> dealIds = new Set<Id>();
	    	Set<Id> opportunityIds = new Set<Id>();
	    	Deal__c[] queriedDeals = new Deal__c[]{};
	    	Map<Id, Opportunity> queriedOpportunitiesMap = new Map<Id, Opportunity>();
	    	Opportunity[] queriedOpportunities = new Opportunity[]{};
	    	SynchronizationEngine.SyncWrapper[] wrapsToSync = new SynchronizationEngine.SyncWrapper[]{};
	    	SynchronizationEngine.SyncWrapper[] syncedWraps = new SynchronizationEngine.SyncWrapper[]{};
	    	Opportunity[] opportunitiesToUpdate = new Opportunity[]{};
	    	
	    	//query all fields on deal records
	    	String dealFieldsToQuery = SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(Deal__c.getSobjectType());
	    	dealIds.addAll(trigNewMap.keySet());
			queriedDeals = database.query(SynchronizationEngine.buildQueryString(dealFieldsToQuery, 'Deal__c', 'Id IN: dealIds'));
	    	
	    	//create set list of opportunity ids that are related to the deals that have been updated
	    	for(Deal__c d : queriedDeals){
	    		opportunityIds.add(d.Opportunity__c);
	    	}
	    	
	    	//query all fields on opportunity records where deal relates to the opportunity
	    	String opportunityFieldsToQuery = SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(Opportunity.getSobjectType());
			queriedOpportunities = database.query(SynchronizationEngine.buildQueryString(opportunityFieldsToQuery, 'Opportunity', 'Id IN: opportunityIds'));
	    	
	    	//create map of queried opportunities to easily pull and match opportunity to a deal
	    	queriedOpportunitiesMap = new Map<Id, Opportunity>(queriedOpportunities);
	    	
	    	//create sync wrappers
	    	for(Deal__c p : queriedDeals){
	    		wrapsToSync.add(new SynchronizationEngine.SyncWrapper(p, queriedOpportunitiesMap.get(p.Opportunity__c))); //SyncWrapper(recToSyncFrom, recToSyncTo)
	    	}
	    	
	    	//call to sync engine
	    	syncedWraps = SynchronizationEngine.initiateSynchronization(wrapsToSync);
	    	
	    	//retrieve list of opportunities to insert
	    	for(SynchronizationEngine.SyncWrapper w : syncedWraps){
	    		opportunitiesToUpdate.add((Opportunity) w.recToSyncTo);
	    	}
	    	
	    	//update opportunities, allow partial success
	    	dmlResults = database.update(opportunitiesToUpdate, false); 
	    	
	    	//check save results for failures and insert errors logs for each record that may have failed
	    	SynchronizationEngine.checkDMLSaveResultsAndInsertSyncErrorLogsForEachFailure(dmlResults, 'An opportunity failed to be updated in the Sync_DealTrigger.', (sObject[]) opportunitiesToUpdate);
    	}
    	catch(Exception e){
    		//insert error log
    		SynchronizationEngine.insertSyncErrorLog(e.getMessage(), e.getStackTraceString());
    	}
    }
    
    //Function: Deleted deals will also delete its related opportunity record
    public static void delete_DealToOpportunitySync(Map<Id, Deal__c> trigOldMap){
    	try{
    		database.DeleteResult[] dmlResults;
	    	Opportunity[] opportunitiesToDelete = new Opportunity[]{};
	    	Set<Id> opportunityIds = new Set<Id>();
	    	
	    	//create set list of opportunity ids that are related to the deals that have been issued for deletion
	    	for(Id dealId : trigOldMap.keySet()){
	    		opportunityIds.add(trigOldMap.get(dealId).Opportunity__c);
	    	}
	    	
	    	//query opportunity records that have a deal related to them
			opportunitiesToDelete = database.query(SynchronizationEngine.buildQueryString('Id', 'Opportunity', 'Id IN: opportunityIds'));
	    	
	    	//delete opportunity records, allow partial success
	    	dmlResults = database.delete(opportunitiesToDelete, false);
	    	
	    	//check save results for failures and insert errors logs for each record that may have failed
	    	SynchronizationEngine.checkDMLDeleteResultsAndInsertSyncErrorLogsForEachFailure(dmlResults, 'An opportunity failed to be deleted in the Sync_DealTrigger.');
    	}
    	catch(Exception e){
    		//insert error log
    		SynchronizationEngine.insertSyncErrorLog(e.getMessage(), e.getStackTraceString());
    	}
    }
}