public with sharing class Sync_IssueCommentTriggerHelper {
    
    private static final String ISSUE_OBJECT_KEY_PREFIX = Schema.SObjectType.Issue__c.getKeyPrefix();
    
    public static void setLastCaseCommentOnRelatedIssueRecords(Issue_Comment__c[] trigNew){
    	try{
    		database.SaveResult[] dmlResults;
	    	Issue_Comment__c[] issueCommentsRelatedToIssue = new Issue_Comment__c[]{};
	    	Set<Id> issueIds = new Set<Id>();
	    	Issue__c[] issueRecords = new Issue__c[]{};
	    	Map<Id, Issue__c> issueIdToIssueMap = new Map<Id, Issue__c>();
	    	
	    	//perform check to get all issue comments related to an Issue type record
	    	for(Issue_Comment__c n : trigNew){
	    		String issueIdString = string.valueOf(n.Issue__c);
	    		if(issueIdString.subString(0, 3) == ISSUE_OBJECT_KEY_PREFIX){
	    			issueCommentsRelatedToIssue.add(n); 
	    			issueIds.add(n.Issue__c); //create set of issue ids
	    		}
	    	}
	    	
	    	//only proceed if notes relating to an issue record were found
	    	if(issueCommentsRelatedToIssue.size() > 0){
	    		
	    		//query issue records
	    		issueRecords = [SELECT Id, Last_Case_Comment__c FROM Issue__c WHERE Id IN: issueIds];
	    		
	    		//create map of issue id to issue record
	    		for(Issue__c i : issueRecords){
	    			issueIdToIssueMap.put(i.Id, i);
	    		}
	    		
	    		//loop over notes
	    		for(Issue_Comment__c n : issueCommentsRelatedToIssue){
	    			//set the last case comment field on related issue record
	    			issueIdToIssueMap.get(n.Issue__c).Last_Case_Comment__c = n.Comment__c;
	    		}
	    		
	    		//update issue records, allow partial success
	    		dmlResults = database.update(issueIdToIssueMap.values(), false);
	    		
		    	//check save results for failures and insert errors logs for each record that may have failed
		    	SynchronizationEngine.checkDMLSaveResultsAndInsertSyncErrorLogsForEachFailure(dmlResults, 'An Issue record failed to be update with Last_Case_Comment__c in the Sync_IssueCommentTriggerHelper.', (sObject[]) issueIdToIssueMap.values());	
	    	}
    	}
    	catch(Exception e){
    		//insert error log
    		SynchronizationEngine.insertSyncErrorLog(e.getMessage(), e.getStackTraceString());
    	}
    }
}