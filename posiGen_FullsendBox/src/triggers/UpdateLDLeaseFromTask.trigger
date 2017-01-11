trigger UpdateLDLeaseFromTask on Task (after insert) {
	/*Set<Id> acctIds = new Set<Id>();
    for (Task task : Trigger.new)
    {
        String whatId = task.WhatId;
        if (whatId.startsWith('001')) {
            String myId = task.WhatId;
            acctIds.add(myId);
        }
    }
    
    Map<Id, Account> accountList = new Map<Id, Account>([SELECT Id, Last_Call_Type__c, Last_Call_Comment__c FROM Account WHERE Id IN :acctIds]);
    
    List<Account> accountToUpdate = new List<Account>();
    
    for (Task task : Trigger.new)
    {
        Account a = accountList.get(task.WhatId);
        System.debug(task.CallType);
        if (task.Description != null)
        {
            a.Last_Call_Comment__c = task.Description;
        }
        if (task.Type != null)
        {
           
            a.Last_Call_Type__c = task.Type;
        }
        accountToUpdate.add(a);
    }
    update accountToUpdate;*/
}