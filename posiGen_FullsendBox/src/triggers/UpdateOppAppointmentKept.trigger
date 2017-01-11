trigger UpdateOppAppointmentKept on Task (before update) {
    Set<Id> oppIds = new Set<Id>();
    for (Task task : Trigger.new)
    {
        String myId = task.WhatId;
        oppIds.add(myId);
    }
    Map<Id, Opportunity> entries = new Map<Id, Opportunity>(
    [SELECT Id, Appointment_Kept__c FROM Opportunity WHERE Id in :oppIds ]
    );
    List<Opportunity> oppToUpdate = new List<Opportunity>();
    
    for (Task task : Trigger.new)
    {
        if (task.Appointment_Kept__c == 'Yes' )
        {
            Opportunity o = entries.get(task.WhatId);
            o.Appointment_Kept__c = TRUE;
           // entries.get(task.WhatId).Intacct_Entity__c = 'a3VJ000000012yF';
            oppToUpdate.add(o);
        }        
    }
    update oppToUpdate;
}