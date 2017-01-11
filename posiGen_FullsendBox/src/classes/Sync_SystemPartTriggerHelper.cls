public with sharing class Sync_SystemPartTriggerHelper {
    
    /*
    	IMPORTANT NOTE:
    		-when dynamically retrieving all fields for opportunity line items, salesforce returns a few fields that don't actually exist 
    			on the object and will throw errors when trying to query them. Because of this, we are NOT dynamically querying all fields
    			on the opportunity line item object. Instead we are only selecting the fields that will be expected to sync.
    			
    
    	Additional note:
    		-the insert_SystemPartToOpportunityLineItemSync() method can function one of 2 ways. 
    			1.) We can use the relational field Deal__r.Opportunity field on the system part obj to get the opportunity id OR 
    			2.) we can query the deals related to the system parts and get the opportunity id that way.
    		
    		For simplicity, I am going with approach #1. But doing so will require the system part records to be queried, otherwise we don't have access to the 
    		relational field Deal__r.Opportunity. In addition, the method MUST be called from an AFTER trigger in order for the system part record to exist in system for query to be issued.
    */
    
	//Function: Newly inserted system parts will generate and sync to a new opp line item record 
		//can be done in an AFTER INSERT trigger. Since we aren't linking the records together
    public static void insert_SystemPartToOpportunityLineItemSync(Map<Id, System_Part__c> trigNewMap){
    	
    	try{
    		database.SaveResult[] dmlResults;
	    	Set<Id> systemPartIds = new Set<Id>();
	    	System_Part__c[] queriedSystemParts = new System_Part__c[]{};
	    	SynchronizationEngine.SyncWrapper[] wrapsToSync = new SynchronizationEngine.SyncWrapper[]{};
	    	SynchronizationEngine.SyncWrapper[] syncedWraps = new SynchronizationEngine.SyncWrapper[]{};
	    	OpportunityLineItem[] opportunityLineItemsToInsert = new OpportunityLineItem[]{};
	    	
	    	//query all fields on system part records
	    	String systemPartFieldsToQuery = SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(System_Part__c.getSobjectType());
	    	//also need to query a relationship field to get the opportunity id from related deal record. 
	    	systemPartFieldsToQuery += ',Deal__r.Opportunity__c'; 
	    	
	    	systemPartIds.addAll(trigNewMap.keySet());
			queriedSystemParts = database.query(SynchronizationEngine.buildQueryString(systemPartFieldsToQuery, 'System_Part__c', 'Id IN: systemPartIds'));
	    	
	    	//create sync wrappers
	    	for(System_Part__c l : queriedSystemParts){
	    		wrapsToSync.add(new SynchronizationEngine.SyncWrapper(l, new OpportunityLineItem())); //SyncWrapper(recToSyncFrom, recToSyncTo)
	    	}
	    	
	    	//call to sync engine
	    	syncedWraps = SynchronizationEngine.initiateSynchronization(wrapsToSync);
	    	
	    	//retrieve list of opportunityLineItems to insert
	    	for(SynchronizationEngine.SyncWrapper w : syncedWraps){
	    		opportunityLineItemsToInsert.add((OpportunityLineItem) w.recToSyncTo);
	    	}
	    	
	    	//insert opportunityLineItems, allow partial success
	    	dmlResults = database.insert(opportunityLineItemsToInsert, false); 
	    	
	    	//check save results for failures and insert errors logs for each record that may have failed
	    	SynchronizationEngine.checkDMLSaveResultsAndInsertSyncErrorLogsForEachFailure(dmlResults, 'An opportunity line item failed to be inserted in the Sync_SystemPartTrigger.', (sObject[]) opportunityLineItemsToInsert);
    	}
    	catch(Exception e){
    		//insert error log
    		SynchronizationEngine.insertSyncErrorLog(e.getMessage(), e.getStackTraceString());
    	}
    }
    
    //Function: Updated system parts will be synced to related opportunity line item record
    public static void update_SystemPartToOpportunityLineItemSync(Map<Id, System_Part__c> trigNewMap){
    	try{
    		database.SaveResult[] dmlResultsForUpdate;
    		database.SaveResult[] dmlResultsForInsert;
	    	Set<Id> systemPartIds = new Set<Id>();
	    	System_Part__c[] queriedSystemParts = new System_Part__c[]{};
	    	OpportunityLineItem[] queriedOpportunityLineItems = new OpportunityLineItem[]{};
	    	SynchronizationEngine.SyncWrapper[] wrapsToSyncForUpdate = new SynchronizationEngine.SyncWrapper[]{};
	    	SynchronizationEngine.SyncWrapper[] syncedWraps = new SynchronizationEngine.SyncWrapper[]{};
	    	SynchronizationEngine.SyncWrapper[] wrapsToSyncForItemInsert = new SynchronizationEngine.SyncWrapper[]{};
	    	SynchronizationEngine.SyncWrapper[] syncedWrapsForItemInsert = new SynchronizationEngine.SyncWrapper[]{};
	    	OpportunityLineItem[] opportunityLineItemsToUpdate = new OpportunityLineItem[]{};
	    	OpportunityLineItem[] opportunityLineItemsToInsert = new OpportunityLineItem[]{};
	    	
	    	//query all fields on system part records
	    	String systemPartFieldsToQuery = SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(System_Part__c.getSobjectType());
	    	//also need to query a relationship field to get the opportunity id from related deal record. 
	    	systemPartFieldsToQuery += ',Deal__r.Opportunity__c';
	    	
	    	systemPartIds.addAll(trigNewMap.keySet());
			queriedSystemParts = database.query(SynchronizationEngine.buildQueryString(systemPartFieldsToQuery, 'System_Part__c', 'Id IN: systemPartIds'));
	    	
	    	//query the opportunity line items found corresponding to a system part record based on product code and opportunity
	    	queriedOpportunityLineItems = fetchOpportunityLineItemsCorrespondingToSystemParts(queriedSystemParts);
	    	
	    	//create sync wrappers
	    	for(System_Part__c p : queriedSystemParts){
	    		boolean matchFound = false;
	    		
	    		for(OpportunityLineItem item : queriedOpportunityLineItems){
		    		if(item.OpportunityId == p.Deal__r.Opportunity__c && item.ProductCode == p.Part_Code__c){ //match line item to system part based on opportunity and product code
		    			wrapsToSyncForUpdate.add(new SynchronizationEngine.SyncWrapper(p, item)); //SyncWrapper(recToSyncFrom, recToSyncTo)
		    			matchFound = true;
		    			break;
		    		}
	    		}
	    		
	    		//if system part not matched to line item, then line item must be generated
	    		if(matchFound == false){
	    			wrapsToSyncForItemInsert.add(new SynchronizationEngine.SyncWrapper(p, new OpportunityLineItem()));
	    		}
	    	}
	    	
	    	//call to sync engine for update
	    	syncedWraps = SynchronizationEngine.initiateSynchronization(wrapsToSyncForUpdate);
	    	
	    	//retrieve list of opportunity line items to update
	    	for(SynchronizationEngine.SyncWrapper w : syncedWraps){
	    		opportunityLineItemsToUpdate.add((OpportunityLineItem) w.recToSyncTo);
	    	}
	    	
	    	//update opportunity line items, allow partial success
	    	dmlResultsForUpdate = database.update(opportunityLineItemsToUpdate, false); 
	    	
	    	//check save results for failures and insert errors logs for each record that may have failed
	    	SynchronizationEngine.checkDMLSaveResultsAndInsertSyncErrorLogsForEachFailure(dmlResultsForUpdate, 'An opportunity line item failed to be updated in the Sync_SystemPartTrigger.', (sObject[]) opportunityLineItemsToUpdate);
	    	
	    	
	    	//ONLY continue if there were system parts not containing a matching opportunity line item
	    	if(wrapsToSyncForItemInsert.size() > 0){
		    	//call to sync engine for insertion of line item for system parts that don't have a corresponding line item matched
		    	syncedWrapsForItemInsert = SynchronizationEngine.initiateSynchronization(wrapsToSyncForItemInsert);
	    		
	    		//retrieve list of opportunity line items to insert
		    	for(SynchronizationEngine.SyncWrapper w : syncedWrapsForItemInsert){
		    		opportunityLineItemsToInsert.add((OpportunityLineItem) w.recToSyncTo);
		    	}
		    	
		    	//insert opportunity line items, allow partial success
	    		dmlResultsForInsert = database.insert(opportunityLineItemsToInsert, false); 
	    		
	    		//check save results for failures and insert errors logs for each record that may have failed
	    		SynchronizationEngine.checkDMLSaveResultsAndInsertSyncErrorLogsForEachFailure(dmlResultsForInsert, 'An opportunity line item failed to be inserted in the Sync_SystemPartTrigger.', (sObject[]) opportunityLineItemsToInsert);
	    	}
    	}
    	catch(Exception e){
    		//insert error log
    		SynchronizationEngine.insertSyncErrorLog(e.getMessage(), e.getStackTraceString());
    	}
    }
    
    //Function: Deleted system parts will also delete the corresponding opportunity line item record
    public static void delete_SystemPartToOpportunityLineItemSync(Map<Id, System_Part__c> trigOldMap){
    	try{
    		database.DeleteResult[] dmlResults;
	    	OpportunityLineItem[] opportunityLineItemsToDelete = new OpportunityLineItem[]{};
	    	
	    	/*
	    	//create set list of opportunity line item ids that are related to the system parts that have been issued for deletion
	    	for(Id dealId : trigOldMap.keySet()){
	    		opportunityLineItemIds.add(trigOldMap.get(dealId).Opportunity__c);
	    	}
	    	
	    	//query opportunity records that have a deal related to them
			opportunityLineItemsToDelete = database.query(SynchronizationEngine.buildQueryString('Id', 'Opportunity', 'Id IN: opportunityLineItemIds'));
	    	*/
	    	
	    	//query the opportunity line items found corresponding to a system part record based on product code and opportunity
	    	opportunityLineItemsToDelete = fetchOpportunityLineItemsCorrespondingToSystemParts(trigOldMap.values());
	    	
	    	//delete opportunity records, allow partial success
	    	dmlResults = database.delete(opportunityLineItemsToDelete, false);
	    	
	    	//check save results for failures and insert errors logs for each record that may have failed
	    	SynchronizationEngine.checkDMLDeleteResultsAndInsertSyncErrorLogsForEachFailure(dmlResults, 'An opportunity line item failed to be deleted in the Sync_SystemPartTrigger.');
    	}
    	catch(Exception e){
    		//insert error log
    		SynchronizationEngine.insertSyncErrorLog(e.getMessage(), e.getStackTraceString());
    	}
    }
    
    private static OpportunityLineItem[] fetchOpportunityLineItemsCorrespondingToSystemParts(System_Part__c[] sysParts){
    	Set<Id> sysPartIds = new Set<Id>();
    	System_Part__c[] queriedSysParts = new System_Part__c[]{};
    	Set<Id> opportunityIds = new Set<Id>();
    	Set<String> productCodes = new Set<String>();
    	
    	//get list of system part ids
    	for(System_Part__c s : sysParts){
    		sysPartIds.add(s.Id);
    	}
    	
    	//query the system parts in order to gain access to the relational field Deal__r.Opportunity__c
    	queriedSysParts = [SELECT Id, Deal__r.Opportunity__c, Part_Code__c FROM System_Part__c WHERE Id IN: sysPartIds];
    	
    	//create list of opportunityIds pulled from the system parts relationship with deal and a list of product codes pulled from system part
    	for(System_Part__c s : queriedSysParts){
    		opportunityIds.add(s.Deal__r.Opportunity__c);
    		productCodes.add(s.Part_Code__c);
    	}
    	
    	//query the opportunity line items
    	return [SELECT Id, Quantity, PricebookEntryId, OpportunityId, ProductCode 
			    FROM OpportunityLineItem 
			    WHERE ProductCode IN: productCodes AND OpportunityId IN: opportunityIds];
    }
    
}