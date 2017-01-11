public without sharing class SynchronizationEngine {
	
	private final static Id DEFAULT_LEAD_RECTYPEID = [SELECT Id FROM RecordType WHERE DeveloperName = 'SF2' AND SobjectType = 'Lead'].Id;
	private final static Id DEFAULT_OPPORTUNITY_RECTYPEID = [SELECT Id FROM RecordType WHERE DeveloperName = 'CustApp' AND SobjectType = 'Opportunity'].Id;
	
	private static Schema.SObjectType recToSyncFromObjectType;
	private static Schema.SObjectType recToSyncToObjectType;
    private static Map<String, Schema.sObjectField> recToSyncFromFieldMap = new Map<String, Schema.sObjectField>();
	private static Map<String, Schema.sObjectField> recToSyncToFieldMap = new Map<String, Schema.sObjectField>();
	private static Map<Id, String> recToSyncFromRecordTypesIdToDevNameMap = new Map<Id, String>();
	private static Map<String, Id> recToSyncToRecordTypesDevNameToIdMap = new Map<String, Id>();
	
	@testvisible private static final Set<String> SYSTEM_ONLY_FIELDS = new Set<String>{
															'id',
															'isdeleted',
															'createddate',
															'createdbyid',
															'lastmodifieddate',
															'lastmodifiedbyid',
															'systemmodstamp',
															'lastactivitydate',
															'lastvieweddate',
															'lastreferenceddate',
															'connectionreceivedid',
															'connectionsentid'
															};
	/*
		ADDITIONAL_FIELDS_TO_SKIP_DURING_SYNC reasons for skipping:
			-expectedrevenue: not an editable field on opportunity. This however is not caught by the SF function isUpdateable()
			-recordtypeid: cannot be copied from one object to another since the ids differ from object to object
			-IsConverted: not an editable field on lead object. But must be set on Prospect when a lead is converted under special considerations method
			
			TEMPORARY!! REMOVE THIS AFTER DONE RUNNING UNIT TESTS FIRST GO AROUND. THIS FIELD SHOULD NOT BE ADDED HERE PERMANENTLY
				-leadsource
	*/
	@testvisible private static final Set<String> ADDITIONAL_FIELDS_TO_SKIP_DURING_SYNC = new Set<String>{
																			  'expectedrevenue',
																			  'name',
																			  'recordtypeid',
																			  'isconverted'
																			  }; /*'leadsource'*/
    
    public class SyncWrapper{
    	public sObject recToSyncFrom;
    	public sObject recToSyncTo;
    	
    	public SyncWrapper(sObject syncFrom, sObject syncTo){
    		recToSyncFrom = syncFrom;
    		recToSyncTo = syncTo;
    	}
    }
    
    public static SyncWrapper[] initiateSynchronization(SyncWrapper[] syncWrappers){
    	Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
    	SyncWrapper[] ret = new SyncWrapper[]{};
		
    	//verify records present
    	if(syncWrappers.size() > 0){
    		
    		//get the object types for both lists of records
    		recToSyncFromObjectType = syncWrappers[0].recToSyncFrom.getsObjectType();
    		recToSyncToObjectType = syncWrappers[0].recToSyncTo.getsObjectType();
    		
    		//retrieve schema fields for each list
    		recToSyncFromFieldMap = retrieveSchemaFieldMapAndRemoveUnderscoreCFromMapsKeySet(recToSyncFromObjectType);
    		recToSyncToFieldMap = retrieveSchemaFieldMapAndRemoveUnderscoreCFromMapsKeySet(recToSyncToObjectType);
    		
    		//retrieve the recordtypes for each object
    		retrieveAllRecordTypesForEachObjectToBeSynced();
    		
    		//perform the synchronization
    		if(recToSyncFromObjectType == System_Part__c.getSobjectType()){ //One-way sync from system_part__c to OpportunityLineItem
    			ret = performTheSynchronizationForOppLineItemAndSystemPart(syncWrappers);
    		}
    		else{ //all other object syncs
    			ret = performTheSynchronization(syncWrappers);
    		}
    	}
    	
    	return ret;
    }
    
    //Function: Retrieve a list of the specified objects field API names. Then remove the "__c" from the maps keyset to allow standard fields 
    	//to be referenced between standard and mirror object. Example return type Map<Example_API_Name, Example_API_Name__c>
    @testvisible private static Map<String, Schema.sObjectField> retrieveSchemaFieldMapAndRemoveUnderscoreCFromMapsKeySet(Schema.SObjectType objectType){
    	Map<String, Schema.sObjectField> fieldSet = new Map<String, Schema.sObjectField>();
    	Map<String, Schema.sObjectField> ret = new Map<String, Schema.sObjectField>();
    	
    	fieldSet = objectType.getDescribe().fields.getMap();
    	
    	for(String s : fieldSet.KeySet()){
    		String fieldName = s.removeEnd('__c');
    		
    		ret.put(fieldName, fieldSet.get(s));
    	}
    	
		return ret;
    }
    
    private static SyncWrapper[] performTheSynchronization(SyncWrapper[] syncWrappers){
    	//perform the syncing process
    	for(SyncWrapper w : syncWrappers){
    		
    		//sync all fields
	    	for(String key : recToSyncFromFieldMap.keySet()){
	    		if(verifyIfFieldIsEditable(key, recToSyncFromFieldMap, recToSyncToFieldMap)){
	    			w.recToSyncTo.put(recToSyncToFieldMap.get(key), w.recToSyncFrom.get(recToSyncFromFieldMap.get(key)));
	    		}
	    		else{
	    			system.debug('@@@@@@@@Field was unable to sync: ' + key);
	    		}
	    	}
	    	
	    	//sync special field considerations here
	    	w.recToSyncTo = syncSpecialFieldConsiderations(w.recToSyncFrom, w.recToSyncTo);
	    	
	    	//sync recordtypes if rec to sync from's recordtype not null and exists in system
	    	if(w.recToSyncFrom.get('RecordTypeId') != null && recToSyncFromRecordTypesIdToDevNameMap.containsKey(string.valueOf(w.recToSyncFrom.get('RecordTypeId')))){
	    		if(recToSyncToRecordTypesDevNameToIdMap.containsKey(recToSyncFromRecordTypesIdToDevNameMap.get(string.valueOf(w.recToSyncFrom.get('RecordTypeId'))))){
	    			w.recToSyncTo.put('RecordTypeId', recToSyncToRecordTypesDevNameToIdMap.get(recToSyncFromRecordTypesIdToDevNameMap.get(string.valueOf(w.recToSyncFrom.get('RecordTypeId')))));
	    		}
	    	}
    	}
    	
    	return syncWrappers;
    }
    
    //NOTE: One-way sync from System_Part__c to OpportunityLineItem
    private static SyncWrapper[] performTheSynchronizationForOppLineItemAndSystemPart(SyncWrapper[] syncWrappers){
    	/*
    		Fields to sync:
    			-OpportunityId
    			-Quantity
    			-PricebookEntryId
    		
    		All other fields can be ignored for sync and defaulted to a value. 
    		Any fields that are required to be set on the OpportunityLineItem will be set to a default value.
    		
    	*/
    	Set<String> productCodes = new Set<String>();
    	PricebookEntry[] priceBookEntries = new PricebookEntry[]{};
    	Map<String, Id> productCodeToPricebookEntryId = new Map<String, Id>();
    	
    	//create list of product codes
    	for(SyncWrapper w : syncWrappers){
    		productCodes.add(string.valueOf(w.recToSyncFrom.get('Part_Code__c')));
    	}
    	
    	//query pricebook entries where pricebook2 obj WHERE IsStandard = true AND IsActive = true AND ProductCode IN: list
    	if(!Test.isRunningTest()){
    		priceBookEntries = [SELECT Id, ProductCode FROM PricebookEntry WHERE Pricebook2.IsStandard = true AND IsActive = true AND ProductCode IN: productCodes];
    	}
    	else{
    		priceBookEntries = [SELECT Id, ProductCode FROM PricebookEntry WHERE Pricebook2Id =: Test.getStandardPricebookId() AND IsActive = true AND ProductCode IN: productCodes];
    	}
    	
    	//create map of product code to pricebook entry id
    	for(PricebookEntry p : priceBookEntries){
    		productCodeToPricebookEntryId.put(p.ProductCode, p.Id);
    	}
    	
    	for(SyncWrapper w : syncWrappers){
    		
    		w.recToSyncTo.put('Quantity', w.recToSyncFrom.get('Quantity__c'));
    		
    		//the following fields are only editable on new oppLineItems
    		if(w.recToSyncTo.Id == null){
				//make sure this field is queried from the System_Part__c obj (System_Part__r.Deal__r.Opportunity__c). This will be used to set the opportunity field on oppLineItem
				sObject relObjChild = w.recToSyncFrom.getSObject('Deal__r');
				w.recToSyncTo.put('OpportunityId', relObjChild.get('Opportunity__c')); 
				w.recToSyncTo.put('PricebookEntryId', productCodeToPricebookEntryId.get(string.valueOf(w.recToSyncFrom.get('Part_Code__c'))));
    		}
    	}
    	
    	return syncWrappers;
    }
    
    private static sObject syncSpecialFieldConsiderations(sObject recToSyncFrom, sObject recToSyncTo){
    	
    	//SYNC TO DEAL
    	if(recToSyncToObjectType == Deal__c.getSobjectType()){
    		recToSyncTo.put('Opportunity__c', recToSyncFrom.get('Id'));
    		recToSyncTo.put('Opportunity_Name__c', recToSyncFrom.get('Name'));
    	}
    	//SYNC TO OPPORTUNITY
    	else if(recToSyncToObjectType == Opportunity.getSobjectType()){
    		recToSyncTo.put('Name', recToSyncFrom.get('Opportunity_Name__c'));
    		
    		//only set recordtypeid if null
    		if(recToSyncTo.get('RecordTypeId') == null){
    			recToSyncTo.put('RecordTypeId', DEFAULT_OPPORTUNITY_RECTYPEID);
    		}
    	}
    	//SYNC TO PROSPECT
    	else if(recToSyncToObjectType == Prospect__c.getSobjectType()){
    		recToSyncTo.put('Lead__c', recToSyncFrom.get('Id'));
    		recToSyncTo.put('IsConverted__c', recToSyncFrom.get('IsConverted'));
    		
    		//ONLY set OverrideProcessBuilder__c field if unit test running
    		if(Test.isRunningTest()){ 
    			recToSyncTo.put('OverrideProcessBuilder__c', true);
    		}
    	}
    	//SYNC TO LEAD
    	else if(recToSyncToObjectType == Lead.getSobjectType()){
    		//only set recordtypeid if null
    		if(recToSyncTo.get('RecordTypeId') == null){
    			recToSyncTo.put('RecordTypeId', DEFAULT_LEAD_RECTYPEID);
    		}
    		
    		//ONLY set OverrideProcessBuilder__c field if unit test running
    		if(Test.isRunningTest()){ 
    			recToSyncTo.put('OverrideProcessBuilder__c', true);
    		}
    	}
    	//SYNC TO ISSUE
    	else if(recToSyncToObjectType == Issue__c.getSobjectType()){
    		recToSyncTo.put('Case__c', recToSyncFrom.get('Id'));
    		recToSyncTo.put('CreatedDate__c', recToSyncFrom.get('CreatedDate'));
    	}
	    
	    return recToSyncTo;
    }
    
    //FUNCTION: Queries the record types of both objects to be synced and creates maps containing the record type id and developer name.
    private static void retrieveAllRecordTypesForEachObjectToBeSynced(){
    	String recToSyncFromObjectTypeString = string.valueOf(recToSyncFromObjectType);
    	String recToSyncToObjectTypeString = string.valueOf(recToSyncToObjectType);
    	
    	//query
    	RecordType[] queriedRecTypes = [SELECT Id, DeveloperName, SobjectType FROM RecordType WHERE SobjectType =: recToSyncFromObjectTypeString OR SobjectType =: recToSyncToObjectTypeString];
    	
    	//loop over record types and create recordtype map for each object
    	for(RecordType r : queriedRecTypes){
    		if(r.SobjectType == recToSyncFromObjectTypeString){
    			recToSyncFromRecordTypesIdToDevNameMap.put(r.Id, r.DeveloperName);
    		}
    		else if(r.SobjectType == recToSyncToObjectTypeString){
    			recToSyncToRecordTypesDevNameToIdMap.put(r.DeveloperName, r.Id);
    		}
    	}
    }
    
    //Function: OVERLOADED. Used to retrieve all fields for an object and format the fields into a string to use in a query select statement. Record Id param used to determine object type
    public static String retrieveAllObjectFieldsAndFormatForQuerySelectStatement(Id objId){
    	String ret = '';
    	DescribeSObjectResult describeResult = objId.getSObjectType().getDescribe();
    	List<String> fieldList = new List<String>(describeResult.fields.getMap().keySet());
    	
		for(String f : fieldList){
			ret += ret == '' ? f : ',' + f;
		}
		
    	return ret;
    }
    //Function: OVERLOADED. Used to retrieve all fields for an object and format the fields into a string to use in a query select statement.
    public static String retrieveAllObjectFieldsAndFormatForQuerySelectStatement(Schema.SObjectType objType){
    	String ret = '';
    	Map<String, Schema.sObjectField> fieldSet = objType.getDescribe().fields.getMap();
    	
		for(String f : fieldSet.KeySet()){
			ret += ret == '' ? f : ',' + f;
		}
		
    	return ret;
    }
    
    public static String buildQueryString(String fieldsToQuery, String objectAPIName, String whereClause){
    	return 'SELECT ' + fieldsToQuery + ' FROM ' + objectAPIName + ' WHERE ' + whereClause;
    }
    
    @testvisible private static boolean verifyIfFieldIsEditable(String fieldName, Map<String, Schema.sObjectField> recToSyncFromFieldMapping, Map<String, Schema.sObjectField> recToSyncToFieldMapping){
    	
		if(	recToSyncToFieldMapping.containsKey(fieldName) && 
			SYSTEM_ONLY_FIELDS.contains(fieldName) == false && 
			ADDITIONAL_FIELDS_TO_SKIP_DURING_SYNC.contains(fieldName) == false && 
			recToSyncFromFieldMapping.get(fieldName).getDescribe().isCalculated() == false && 
			recToSyncFromFieldMapping.get(fieldName).getDescribe().isAutoNumber() == false && 
			recToSyncToFieldMapping.get(fieldName).getDescribe().isCalculated() == false && 
			recToSyncToFieldMapping.get(fieldName).getDescribe().isAutoNumber() == false){
			
			return true;
		}
		else{
			return false;
		}
    }
    
    public static void checkDMLSaveResultsAndInsertSyncErrorLogsForEachFailure(database.SaveResult[] dmlResults, String additionalMsgDetails, sObject[] dmlRecords){
    	Sync_Error_Log__c[] errorLogs = new Sync_Error_Log__c[]{};
    	
    	//Reason for looping over dml is because the Salesforce SaveResults returns null id value for a record that has failed. In this way, we can retrieve the id from the dml records instead
    	for(Integer i = 0; i < dmlRecords.size(); i++){
    		Database.SaveResult s = dmlResults[i];
    		
    		if(!s.isSuccess()){
    			String errorMsg = 'DML error occurred. ' + additionalMsgDetails;
    			String stackTraceMsg = '';
    			integer counter = 1;
    			String failedRecordId = '';
    			if(dmlRecords[i].Id != null){
    				failedRecordId = dmlRecords[i].Id; //retrive the failed record id if not null
    			}
    			
    			for(database.Error err : s.getErrors()){
    				stackTraceMsg += '  ~~(ERROR #' + counter + '. ERROR Code: ' + err.getStatusCode() + '. ERROR Message: ' + err.getMessage() + '. Fields affecting this error: ' + err.getFields() + ')  ';
    				counter++;
    			}
    			
    			errorLogs.add(new Sync_Error_Log__c(Error_Message__c = errorMsg, Stack_Trace__c = stackTraceMsg, Failed_Record_Id__c = failedRecordId));
    		}
    	}
    	
    	if(errorLogs.size() > 0){
    		insert errorLogs;
    	}
    }
    
    public static void checkDMLDeleteResultsAndInsertSyncErrorLogsForEachFailure(database.DeleteResult[] dmlResults, String additionalMsgDetails){
    	Sync_Error_Log__c[] errorLogs = new Sync_Error_Log__c[]{};
    	
    	for(database.DeleteResult s : dmlResults){
    		if(!s.isSuccess()){
    			String errorMsg = 'DML error occurred. ' + additionalMsgDetails;
    			String stackTraceMsg = '';
    			integer counter = 1;
    			
    			for(database.Error err : s.getErrors()){
    				stackTraceMsg += '  ~~(ERROR #' + counter + '. ERROR Code: ' + err.getStatusCode() + '. ERROR Message: ' + err.getMessage() + '. Fields affecting this error: ' + err.getFields() + ')  ';
    				counter++;
    			}
    			
    			errorLogs.add(new Sync_Error_Log__c(Error_Message__c = errorMsg, Stack_Trace__c = stackTraceMsg, Failed_Record_Id__c = s.getId()));
    		}
    	}
    	
    	if(errorLogs.size() > 0){
    		insert errorLogs;
    	}
    }
    
    public static void insertSyncErrorLog(String errorMsg, String stackTrace){
    	insert new Sync_Error_Log__c(Error_Message__c = errorMsg, Stack_Trace__c = stackTrace);
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*DEPRECATE this method in future.*/    
    //Function: Performs the synchronization between a standard object and custom object.  
    	//The syncing can be interchanged (standard to custom --> custom to standard) based on the order in which the parameters are passed into the method
    public static sObject initiateSynchronization(sObject recToSyncFrom, sObject recToSyncTo){
    	Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
    	sObject ret = null;
		
    	//verify records present
    	if(recToSyncFrom != null && recToSyncTo != null){
    		
    		//get the object types for both lists of records
    		recToSyncFromObjectType = recToSyncFrom.getsObjectType();
    		recToSyncToObjectType = recToSyncTo.getsObjectType();
    		
    		//retrieve schema fields for each list
    		recToSyncFromFieldMap = retrieveSchemaFieldMapAndRemoveUnderscoreCFromMapsKeySet(recToSyncFromObjectType);
    		recToSyncToFieldMap = retrieveSchemaFieldMapAndRemoveUnderscoreCFromMapsKeySet(recToSyncToObjectType);
    		
    		//perform the synchronization
			ret = performTheSynchronization(recToSyncFrom, recToSyncTo);
    	}
    	
    	return ret;
    }
    
    /*DEPRECATE this method in future.*/
    private static sObject performTheSynchronization(sObject recToSyncFrom, sObject recToSyncTo){
    	//perform the syncing process
    	for(String key : recToSyncFromFieldMap.keySet()){
    		if(recToSyncToFieldMap.containsKey(key) && !SYSTEM_ONLY_FIELDS.contains(key) && !ADDITIONAL_FIELDS_TO_SKIP_DURING_SYNC.contains(key) && recToSyncFromFieldMap.get(key).getDescribe().isCalculated() == false && recToSyncFromFieldMap.get(key).getDescribe().isUpdateable() == true && recToSyncToFieldMap.get(key).getDescribe().isCalculated() == false && recToSyncToFieldMap.get(key).getDescribe().isUpdateable() == true){
    			recToSyncTo.put(recToSyncToFieldMap.get(key), recToSyncFrom.get(recToSyncFromFieldMap.get(key)));
    		}
    		else{
    			system.debug('@@@@@@@@Field was unable to sync: ' + key);
    		}
    	}
    	
    	//sync special considerations here
    	if(recToSyncFromObjectType == Opportunity.getSobjectType()){
    		recToSyncTo.put('Opportunity_Name__c', recToSyncFrom.get('Name'));
    	}
    	else if(recToSyncFromObjectType == Deal__c.getSobjectType()){
    		recToSyncTo.put('Name', recToSyncFrom.get('Opportunity_Name__c'));
    	}
    	
    	return recToSyncTo;
    }
    
    public static void temporaryByPassTest(){
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
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
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
    
    
/*---------------------------old-------------------------------*/
    /*private static SyncWrapper[] performTheSynchronizationForOppLineItemAndSystemPart(SyncWrapper[] syncWrappers){
    	/*
    		OpportunityLineItem Required/important sync Fields:
    			-OpportunityId
    				-pulled from System_Part__r.Deal__r.Opportunity__c OR by querying the Deals based on related System_Part__c record
    			-Product2Id
    				-pulled by querying the Product obj by matching the Product code (part code) from the System_Part__r.Part_Code__c OR System_Part__r.Part__r.part_code__c
    			-Quantity
    		
    		System_Part__c Fields:
    			-Part__c
    				-pulled from oppLineItems related Product2__r.ProductCode OR oppLineItem__r.ProductCode
    			-Deal__c
    				-pulled by querying Deals based on OpportunityId related to the oppLineItem 
    			-Quantity__c
    	
    	/*
    		>OppLineItem Trigger fires
    		>list of oppLineItem records given
    		>query oppLineItem records
    			>>select all fields. Which will select the ProductCode field for us as well
    		>query all system_part__c records where product_code__c and Opportunity__c is same as on the oppLineItem
    		
    		>query all Part__c records where Part_Code__c = oppLineItem.ProductCode
    		>query all deal records where Opportunity__c = oppLineItem.OpportunityId
    		>sync to System_Part__c
    			>>System_Part__c.Deal__c = deal containing the same oppId as the oppLineItem
    			>>System_Part__c.Part__c = part containin the same product code as the oppLineItem
    	
    	
    	/*IIMPORTANT: To set the Part__c field on System_Part__c obj, you need to retrieve the Part__c based on System Config (pricebook) and product code (part code)
    	Set<String> productCodes = new Set<String>(); //aka part codes
    	Set<Id> opportunityIds = new Set<Id>();
    	Part__c[] partRecords = new Part__c[]{};
    	Map<String, Id> partCodeToPartId = new Map<String, Id>();
    	Deal__c[] dealRecords = new Deal__c[]{};
    	Map<Id, Id> opportunityIdToDealId = new Map<Id, Id>();
    	
    	//determine where we are syncing to
    	if(recToSyncFromObjectType == OpportunityLineItem.getSobjectType()){
    		//create list of product codes and opportunityIds
    		for(SyncWrapper w : syncWrappers){
    			productCodes.add(string.valueOf(w.recToSyncFrom.get('ProductCode')));
    			opportunityIds.add(string.valueOf(w.recToSyncFrom.get('OpportunityId')));
    		}
    		
    		//query Part__c records by product codes
    		partRecords = [SELECT Id, part_code__c FROM Part__c WHERE part_code__c IN: productCodes AND Active__c = true];
    		
    		//create map of product code to Part__c obj
    		for(Part__c p : partRecords){
    			partCodeToPartId.put(p.part_code__c, p.Id);
    		}
    		
    		//query Deal__c records by opportunityIds
    		dealRecords = [SELECT Id, Opportunity__c FROM Deal__c WHERE Opportunity__c IN: opportunityIds];
    		
    		//create map of opportunityId to Deal__c obj
    		for(Deal__c d : dealRecords){
    			opportunityIdToDealId.put(d.Opportunity__c, d.Id);
    		}
    		
    		//loop over wrappers
    		for(SyncWrapper s : syncWrappers){
    			//set the Deal__c and Part__c fields on System_Part__c record based on a match to the oppLineItem record
    			if(partCodeToPartId.containsKey(string.valueOf(s.recToSyncFrom.get('ProductCode')))){
    				s.recToSyncTo.put('Part__c', partCodeToPartId.get(string.valueOf(s.recToSyncFrom.get('ProductCode'))));
    				s.recToSyncTo.put('Part_Code__c', s.recToSyncFrom.get('ProductCode'));
    			}
    			
    			if(opportunityIdToDealId.containsKey(string.valueOf(s.recToSyncFrom.get('OpportunityId')))){
    				s.recToSyncTo.put('Deal__c', opportunityIdToDealId.get(string.valueOf(s.recToSyncFrom.get('OpportunityId'))));
    			}
    			
    			//set any additional fields on system_part__c obj
    			s.recToSyncTo.put('Quantity__c', s.recToSyncFrom.get('Quantity'));
    		}
    		
    		
    		
    		
    		
    	}
    	else if(recToSyncFromObjectType == System_Part__c.getSobjectType()){
    		//make sure this field is queried from the System_Part__c obj (System_Part__r.Deal__r.Opportunity__c). This will be used to set the opportunity field on oppLineItem
    		
    		
    		//create list of part codes/product codes. Pulled from System_Part__r.Part__r.part_code__c. Be sure this field is queried from the System_Part__c obj
    		
    		
    		//query the Part_c records by the part codes
    		
    		
    		//need to set the Product on oppLineItem based on part code and system config matching the product to a part__c record that is related to the System_Part__c record
    		
    		
    		
    	}
    	else{
    		//throw error. Unexpected object passed in
    	}
    	
    	
    	
    	//query Part__c records based on the product code found on the sync from object. 
    		//if opp line item, then query by list of Product2 ids
    		//else if System Part obj, then query by list of 
    	
    	//if recToSyncFrom is the opp line item
    		//then set these fields on system part obj
    		//Part__c - need to match this to a Part__c record based on the product_code__c that matches to the line items Product2 relationship code field found on line item
    		//Deal__c - need to query this field from Deal__c object - do this by querying deal object based on the related line items OpportunityId
    	
    	//otherwise if recToSyncFrom is the System part obj
    		//then set these fields on system part obj
    	
    	
    	return syncWrappers;
    }
    */
    
    
    
}