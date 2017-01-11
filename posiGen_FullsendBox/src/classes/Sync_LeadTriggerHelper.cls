public without sharing class Sync_LeadTriggerHelper {
    
    public static boolean sync_LeadTriggerIsRunning = false;
    
    //Function: Newly inserted leads will generate, sync, and link a new prospect record to itself
    public static void insert_LeadToProspectSync(Map<Id, Lead> trigNewMap){
    	try{
    		database.SaveResult[] dmlResults;
	    	Set<Id> leadIds = new Set<Id>();
	    	Lead[] queriedLeads = new Lead[]{};
	    	Prospect__c[] existingProspects = new Prospect__c[]{};
	    	Map<Id, Id> leadIdToExistingProspectIdMap = new Map<Id, Id>();
	    	SynchronizationEngine.SyncWrapper[] wrapsToSync = new SynchronizationEngine.SyncWrapper[]{};
	    	SynchronizationEngine.SyncWrapper[] syncedWraps = new SynchronizationEngine.SyncWrapper[]{};
	    	Prospect__c[] prospectsToInsert = new Prospect__c[]{};
	    	
	    	//query all fields on lead records
	    	String fieldsToQuery = SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(Lead.getSobjectType());
	    	leadIds.addAll(trigNewMap.keySet());
			queriedLeads = database.query(SynchronizationEngine.buildQueryString(fieldsToQuery, 'Lead', 'Id IN: leadIds'));
	    	
	    	//query prospects that relate to leads
	    	existingProspects = [SELECT Id, Lead__c FROM Prospect__c WHERE Lead__c IN: leadIds];
	    	
	    	//create map of lead id to prospect id, to be used to determine whether a new prospect record needs to be created or not on the lead
	    	for(Prospect__c p : existingProspects){
	    		leadIdToExistingProspectIdMap.put(p.Lead__c, p.Id);
	    	}
	    	
	    	//create sync wrappers
	    	for(Lead l : queriedLeads){
	    		//ONLY process leads that do NOT have a prospect already related to them
	    		if(!leadIdToExistingProspectIdMap.containsKey(l.Id)){
	    			wrapsToSync.add(new SynchronizationEngine.SyncWrapper(l, new Prospect__c())); //SyncWrapper(recToSyncFrom, recToSyncTo)
	    		}
	    	}
	    	
	    	//continue ONLY if there are leads to sync
	    	if(wrapsToSync.size() > 0){
		    	//call to sync engine
		    	syncedWraps = SynchronizationEngine.initiateSynchronization(wrapsToSync);
		    	
		    	//retrieve list of prospects to insert
		    	for(SynchronizationEngine.SyncWrapper w : syncedWraps){
		    		prospectsToInsert.add((Prospect__c) w.recToSyncTo);
		    	}
		    	
		    	//insert prospects, allow partial success
		    	dmlResults = database.insert(prospectsToInsert, false); 
		    	
		    	/*note: in the error log we can actually input the lead id that is associated to the prospect to know which lead failed to insert a prospect*/
		    	//check save results for failures and insert errors logs for each record that may have failed
		    	SynchronizationEngine.checkDMLSaveResultsAndInsertSyncErrorLogsForEachFailure(dmlResults, 'A prospect failed to be inserted in the Sync_LeadTrigger.', (sObject[]) prospectsToInsert);
	    	}
    	}
    	catch(Exception e){
    		//insert error log
    		SynchronizationEngine.insertSyncErrorLog(e.getMessage(), e.getStackTraceString());
    	}
    }
    
    //Function: Updated leads will be synced to related prospect record
    public static void update_LeadToProspectSync(Map<Id, Lead> trigNewMap){
    	try{
    		database.SaveResult[] dmlResults;
	    	Set<Id> leadIds = new Set<Id>();
	    	Lead[] queriedLeads = new Lead[]{};
	    	Map<Id, Lead> queriedLeadsMap = new Map<Id, Lead>();
	    	Prospect__c[] queriedProspects = new Prospect__c[]{};
	    	SynchronizationEngine.SyncWrapper[] wrapsToSync = new SynchronizationEngine.SyncWrapper[]{};
	    	SynchronizationEngine.SyncWrapper[] syncedWraps = new SynchronizationEngine.SyncWrapper[]{};
	    	Prospect__c[] prospectsToUpdate = new Prospect__c[]{};
	    	
	    	//query all fields on lead records
	    	String leadFieldsToQuery = SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(Lead.getSobjectType());
	    	leadIds.addAll(trigNewMap.keySet());
			queriedLeads = database.query(SynchronizationEngine.buildQueryString(leadFieldsToQuery, 'Lead', 'Id IN: leadIds'));
	    	
	    	//query all fields on prospect records related to leads
	    	String prospectFieldsToQuery = SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(Prospect__c.getSobjectType());
			queriedProspects = database.query(SynchronizationEngine.buildQueryString(prospectFieldsToQuery, 'Prospect__c', 'Lead__c IN: leadIds'));
	    	
	    	//create map of queried leads to easily pull and match lead to a prospect
	    	queriedLeadsMap = new Map<Id, Lead>(queriedLeads);
	    	
	    	//create sync wrappers
	    	for(Prospect__c p : queriedProspects){
	    		wrapsToSync.add(new SynchronizationEngine.SyncWrapper(queriedLeadsMap.get(p.Lead__c), p)); //SyncWrapper(recToSyncFrom, recToSyncTo)
	    	}
	    	
	    	//call to sync engine
	    	syncedWraps = SynchronizationEngine.initiateSynchronization(wrapsToSync);
	    	
	    	//retrieve list of prospects to insert
	    	for(SynchronizationEngine.SyncWrapper w : syncedWraps){
	    		prospectsToUpdate.add((Prospect__c) w.recToSyncTo);
	    	}
	    	
	    	//update prospects, allow partial success
	    	dmlResults = database.update(prospectsToUpdate, false); 
	    	
	    	//check save results for failures and insert errors logs for each record that may have failed
	    	SynchronizationEngine.checkDMLSaveResultsAndInsertSyncErrorLogsForEachFailure(dmlResults, 'A prospect failed to be updated in the Sync_LeadTrigger.', (sObject[]) prospectsToUpdate);
    	}
    	catch(Exception e){
    		//insert error log
    		SynchronizationEngine.insertSyncErrorLog(e.getMessage(), e.getStackTraceString());
    	}
    }
    
    //Function: Deleted leads will also delete its related prospect record
    public static void delete_LeadToProspectSync(Map<Id, Lead> trigOldMap){
    	try{
    		database.DeleteResult[] dmlResults;
	    	Prospect__c[] prospectsToDelete = new Prospect__c[]{};
	    	Set<Id> leadIds = new Set<Id>();
	    	
	    	//create list of lead ids to query related prospects with
	    	leadIds.addAll(trigOldMap.keySet());
	    	
	    	//query prospect records related to leads
			prospectsToDelete = database.query(SynchronizationEngine.buildQueryString('Id', 'Prospect__c', 'Lead__c IN: leadIds'));
	    	
	    	//delete prospect records, allow partial success
	    	dmlResults = database.delete(prospectsToDelete, false);
	    	
	    	//check save results for failures and insert errors logs for each record that may have failed
	    	SynchronizationEngine.checkDMLDeleteResultsAndInsertSyncErrorLogsForEachFailure(dmlResults, 'A prospect failed to be deleted in the Sync_LeadTrigger.');
    	}
    	catch(Exception e){
    		//insert error log
    		SynchronizationEngine.insertSyncErrorLog(e.getMessage(), e.getStackTraceString());
    	}
    }
}