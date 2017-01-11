/* Using UpdateLeadCountInMunicipality Apex trigger as the template.
   Updates the Num_Of_Open_Cases__c field on Account from the Count of open Cases. 
*/

trigger updateCaseCountToAccount on Case (after update) {
	/* Grab all Case Ids in the update */
    Set<Id> caseIds = new Set<Id>();
    for (Case ca : Trigger.new) 
    {
        if (ca.AccountId != null)
        {
            String myId = ca.AccountId;
            caseIds.add(myId);
        }
    }
    
    /* Map the Ids */
    Map<Id, Account> entries = new Map<Id, Account>(
    	[SELECT Id, Num_Of_Open_Cases__c 
         FROM Account WHERE Id IN :caseIds]
    );
    
    /* Get the Count of the Cases */
    List<Case> caseCount = [SELECT Id, Status FROM Case WHERE AccountId in :caseIds AND Status != ''];
    
    /* Container for the Accounts that will be updated. */
    List<Account> acctsToUpdate = new List<Account>();
    
    for (Case ca: Trigger.new) 
    {
        Account a = entries.get(ca.AccountId);
        a.Num_Of_Open_Cases__c = caseCount.size();
        acctsToUpdate.add(a);
    }
    update acctsToUpdate;
}