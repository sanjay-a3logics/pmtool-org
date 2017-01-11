public with sharing class Sync_ProspectTriggerHelper {
    
    public static boolean sync_ProspectTriggerIsRunning = false;
    
    //Function: Newly inserted prospects will generate, sync, and link a new lead record to itself.
    	//Method needs to be called from a BEFORE INSERT trigger. Reason: In order to update the Lead__c field on Prospects to link to the lead that was inserted.
    public static void insert_ProspectToLeadSync(Prospect__c[] trigNew){
    	
    	try{
    		database.SaveResult[] dmlResults;
	    	Set<Id> prospectIds = new Set<Id>();
	    	Prospect__c[] queriedProspects = new Prospect__c[]{};
	    	SynchronizationEngine.SyncWrapper[] wrapsToSync = new SynchronizationEngine.SyncWrapper[]{};
	    	SynchronizationEngine.SyncWrapper[] syncedWraps = new SynchronizationEngine.SyncWrapper[]{};
	    	Lead[] leadsToInsert = new Lead[]{};
	    	
	    	//create sync wrappers
	    	for(Prospect__c l : trigNew){
	    		if(l.Lead__c == null){ //ONLY generate a new lead if one doesn't already exist and related on prospect
	    			wrapsToSync.add(new SynchronizationEngine.SyncWrapper(l, new Lead())); //SyncWrapper(recToSyncFrom, recToSyncTo)
	    		}
	    	}
	    	
	    	//continue ONLY if there are prospects to sync
	    	if(wrapsToSync.size() > 0){
		    	//call to sync engine
		    	syncedWraps = SynchronizationEngine.initiateSynchronization(wrapsToSync);
		    	
		    	//retrieve list of leads to insert
		    	for(SynchronizationEngine.SyncWrapper w : syncedWraps){
		    		leadsToInsert.add((Lead) w.recToSyncTo);
		    	}
		    	
		    	//insert leads, allow partial success
		    	dmlResults = database.insert(leadsToInsert, false); 
		    	
		    	//check save results for failures and insert errors logs for each record that may have failed
		    	SynchronizationEngine.checkDMLSaveResultsAndInsertSyncErrorLogsForEachFailure(dmlResults, 'A lead failed to be inserted in the Sync_ProspectTrigger.', (sObject[]) leadsToInsert);
		    	
		    	//now that the leads are created, we need to set the Lead__c lookup field on the Prospects to link the records
		    	for(SynchronizationEngine.SyncWrapper w : syncedWraps){
		    		//NOTE: if lead id doesn't exist, then that means the lead failed to be inserted. If this occurs,
		    			//then skip setting the lead__c field on prospect. This way the prospect can still be inserted with no issues.
		    		if(w.recToSyncTo.Id != null){
		    			w.recToSyncFrom.put('Lead__c', w.recToSyncTo.Id);
		    		}
		    	}
	    	}
    	}
    	catch(Exception e){
    		//insert error log
    		SynchronizationEngine.insertSyncErrorLog(e.getMessage(), e.getStackTraceString());
    	}
    }
    
    //Function: Updated prospects will be synced to related lead record
    public static void update_ProspectToLeadSync(Map<Id, Prospect__c> trigNewMap){
    	try{
    		database.SaveResult[] dmlResults;
	    	Set<Id> prospectIds = new Set<Id>();
	    	Set<Id> leadIds = new Set<Id>();
	    	Prospect__c[] queriedProspects = new Prospect__c[]{};
	    	Map<Id, Lead> queriedLeadsMap = new Map<Id, Lead>();
	    	Lead[] queriedLeads = new Lead[]{};
	    	SynchronizationEngine.SyncWrapper[] wrapsToSync = new SynchronizationEngine.SyncWrapper[]{};
	    	SynchronizationEngine.SyncWrapper[] syncedWraps = new SynchronizationEngine.SyncWrapper[]{};
	    	Lead[] leadsToUpdate = new Lead[]{};
	    	
	    	//query all fields on prospect records
	    	String prospectFieldsToQuery = SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(Prospect__c.getSobjectType());
	    	prospectIds.addAll(trigNewMap.keySet());
			queriedProspects = database.query(SynchronizationEngine.buildQueryString(prospectFieldsToQuery, 'Prospect__c', 'Id IN: prospectIds'));
	    	
	    	//create set list of lead ids that are related to the prospects that have been updated. If not related to lead, then add to list of prospects that need lead generated
	    	for(Prospect__c d : queriedProspects){
	    		if(d.Lead__c != null){
	    			leadIds.add(d.Lead__c);
	    		}
	    	}
	    	
	    	//query all fields on lead records where prospect relates to the lead
	    	String leadFieldsToQuery = SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(Lead.getSobjectType());
			queriedLeads = database.query(SynchronizationEngine.buildQueryString(leadFieldsToQuery, 'Lead', 'Id IN: leadIds'));
	    	
	    	//create map of queried leads to easily pull and match lead to a prospect
	    	queriedLeadsMap = new Map<Id, Lead>(queriedLeads);
	    	
	    	//create sync wrappers
	    	for(Prospect__c p : queriedProspects){
	    		wrapsToSync.add(new SynchronizationEngine.SyncWrapper(p, queriedLeadsMap.get(p.Lead__c))); //SyncWrapper(recToSyncFrom, recToSyncTo)
	    	}
	    	
	    	//call to sync engine
	    	syncedWraps = SynchronizationEngine.initiateSynchronization(wrapsToSync);
	    	
	    	//retrieve list of leads to insert
	    	for(SynchronizationEngine.SyncWrapper w : syncedWraps){
	    		leadsToUpdate.add((Lead) w.recToSyncTo);
	    	}
	    	
	    	//update leads, allow partial success
	    	dmlResults = database.update(leadsToUpdate, false); 
	    	
	    	//check save results for failures and insert errors logs for each record that may have failed
	    	SynchronizationEngine.checkDMLSaveResultsAndInsertSyncErrorLogsForEachFailure(dmlResults, 'A lead failed to be updated in the Sync_ProspectTrigger.', (sObject[]) leadsToUpdate);
    	}
    	catch(Exception e){
    		//insert error log
    		SynchronizationEngine.insertSyncErrorLog(e.getMessage(), e.getStackTraceString());
    	}
    }
    
    //Function: Deleted prospects will also delete its related lead record
    public static void delete_ProspectToLeadSync(Map<Id, Prospect__c> trigOldMap){
    	try{
    		database.DeleteResult[] dmlResults;
	    	Lead[] leadsToDelete = new Lead[]{};
	    	Set<Id> leadIds = new Set<Id>();
	    	
	    	//create set list of lead ids that are related to the prospects that have been issued for deletion
	    	for(Id prospectId : trigOldMap.keySet()){
	    		leadIds.add(trigOldMap.get(prospectId).Lead__c);
	    	}
	    	
	    	//query lead records that have a prospect related to them
			leadsToDelete = database.query(SynchronizationEngine.buildQueryString('Id', 'Lead', 'Id IN: leadIds'));
	    	
	    	//delete lead records, allow partial success
	    	dmlResults = database.delete(leadsToDelete, false);
	    	
	    	//check save results for failures and insert errors logs for each record that may have failed
	    	SynchronizationEngine.checkDMLDeleteResultsAndInsertSyncErrorLogsForEachFailure(dmlResults, 'A lead failed to be deleted in the Sync_ProspectTrigger.');
    	}
    	catch(Exception e){
    		//insert error log
    		SynchronizationEngine.insertSyncErrorLog(e.getMessage(), e.getStackTraceString());
    	}
    }
}