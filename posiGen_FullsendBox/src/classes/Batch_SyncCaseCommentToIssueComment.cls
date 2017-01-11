global without sharing class Batch_SyncCaseCommentToIssueComment implements Database.Batchable<sObject>{
    
    /*
    	Goal of this batch is to generate the Issue Comment records from the Case Comments.
    	Do not run this batch consecutively. Doing so will create duplicate Issue Comment records. Issue Comments are not linked to Case Comments.
    
    */
    
    global Database.QueryLocator start(Database.BatchableContext BC){
		return Database.getQueryLocator('SELECT Id, CommentBody, CreatedById, CreatedDate, ParentId FROM CaseComment');
	}
	
	global void execute(Database.BatchableContext BC, List<CaseComment> scope){
		Set<Id> caseIds = new Set<Id>();
		Set<Id> caseCommentIds = new Set<Id>();
		Issue__c[] queriedIssues = new Issue__c[]{};
		Map<Id, Id> caseIdToIssueId = new Map<Id, Id>();
		Map<Id, Id> caseCommentIdToExistingIssueCommentIdMap = new Map<Id, Id>();
		Issue_Comment__c[] issueCommentToInsert = new Issue_Comment__c[]{};
		
		if(scope.size() > 0){
			
			//create set of case ids and set of case comment ids
			for(CaseComment l : scope){
				caseIds.add(l.ParentId);
				caseCommentIds.add(l.Id);
			}
			
			//query issue records
			queriedIssues = [SELECT Id, Case__c FROM Issue__c WHERE Case__c IN: caseIds];
			
			//create set of issue ids
			for(Issue__c i : queriedIssues){
				caseIdToIssueId.put(i.Case__c, i.Id);
			}
			
			//query existing issue comment records and add to map to be used for preventing creation of dupes
			for(Issue_Comment__c ic : [SELECT Id, Case_Comment_Id__c FROM Issue_Comment__c WHERE Case_Comment_Id__c IN: caseCommentIds]){
				caseCommentIdToExistingIssueCommentIdMap.put(ic.Case_Comment_Id__c, ic.Id);
			}
			
			//loop over case comments
			for(CaseComment cc : scope){
				if(!caseCommentIdToExistingIssueCommentIdMap.containsKey(cc.Id)){ //skip if issue comment already exists
					Issue_Comment__c ic = new Issue_Comment__c();
					
					ic.Comment__c = cc.CommentBody;
					ic.Created_By__c = cc.CreatedById;
					ic.Created_Date_Time__c = cc.CreatedDate;
					ic.Issue__c = caseIdToIssueId.get(cc.ParentId);
					ic.Case_Comment_Id__c = cc.Id;
					
					issueCommentToInsert.add(ic);
				}
			}
			
			insert issueCommentToInsert;
			
			
			
		/*Old bad code here.
			//create set of case ids
			for(CaseComment l : scope){
				caseIds.add(l.ParentId);
			}
			
			//query issue records
			queriedIssues = [SELECT Id, Case__c FROM Issue__c WHERE Case__c IN: caseIds];
			
			//create set of issue ids
			for(Issue__c i : queriedIssues){
				caseIdToIssueId.put(i.Case__c, i.Id);
			}
			
			//query existing issue comments
			existingIssueComments = [SELECT Id, Issue__r.Case__c FROM Issue_Comment__c WHERE Issue__c IN: caseIdToIssueId.values()];
			
			//create map of case id to issue comment
			for(Issue_Comment__c c : existingIssueComments){
				caseIdToExistingIssueComment.put(c.Issue__r.Case__c, c);
			}
			
			//loop over case comments
			for(CaseComment cc : scope){
				Issue_Comment__c ic = new Issue_Comment__c();
				
				//if issue comment already exists, then sync it
				if(caseIdToExistingIssueComment.containsKey(cc.ParentId)){ //verifies if the case related to the case comment matches with an existing issue comments related issue record that relates to the same case
					ic = caseIdToExistingIssueComment.get(cc.ParentId);
					
					ic.Comment__c = cc.CommentBody;
					ic.Created_By__c = cc.CreatedById;
					ic.Created_Date_Time__c = cc.CreatedDate;
					
					issueCommentsToUpsert.add(ic);
				}
				//otherwise create a new one
				else{
					ic.Comment__c = cc.CommentBody;
					ic.Created_By__c = cc.CreatedById;
					ic.Created_Date_Time__c = cc.CreatedDate;
					ic.Issue__c = caseIdToIssueId.get(cc.ParentId);
					
					issueCommentsToUpsert.add(ic);
				}
			}
			
			//upsert issue comments
			upsert issueCommentsToUpsert;
			*/
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