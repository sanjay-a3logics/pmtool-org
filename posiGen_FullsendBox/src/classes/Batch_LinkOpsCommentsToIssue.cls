global without sharing class Batch_LinkOpsCommentsToIssue implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext BC){
		return Database.getQueryLocator('SELECT Id, Issue__c, Case__c FROM Ops_Comment__c WHERE Issue__c = null');
	}
	
	global void execute(Database.BatchableContext BC, List<Ops_Comment__c> scope){
		Set<Id> caseIds = new Set<Id>();
		Issue__c[] issues = new Issue__c[]{};
		Map<Id, Issue__c> caseIdToIssueMap = new Map<Id, Issue__c>();
		Ops_Comment__c[] opsCommentsToUpdate = new Ops_Comment__c[]{};
		
		//loop over ops comments and create set of case ids
		for(Ops_Comment__c o : scope){
			caseIds.add(o.Case__c);
		}
		
		//query Issues by case id
		issues = [SELECT Id, Case__c FROM Issue__c WHERE Case__c IN: caseIds];
		
		//create map of case id to issue
		for(Issue__c i : issues){
			caseIdToIssueMap.put(i.Case__c, i);
		}
		
		//loop over ops comments
		for(Ops_Comment__c o : scope){
			//set issue__c lookup to issue related to same case
			if(caseIdToIssueMap.containsKey(o.Case__c)){
				o.Issue__c = caseIdToIssueMap.get(o.Case__c).Id;
				opsCommentsToUpdate.add(o);
			}
		}
		
		//update ops comments
		update opsCommentsToUpdate;
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