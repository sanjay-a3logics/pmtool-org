trigger UpdateOppSalesAppointmentKept on Event (before update) {
    Set<Id> oppIds = new Set<Id>();
    for (Event event : Trigger.new)
    {
        String myId = event.WhatId;
        oppIds.add(myId);
    }
    Map<Id, Opportunity> entries = new Map<Id, Opportunity>(
    [SELECT Id, Appointment_Kept__c FROM Opportunity WHERE Id in :oppIds ]
    );
    List<Opportunity> oppToUpdate = new List<Opportunity>();
    
    Event salesAppointmentRecordType = [SELECT RecordTypeId FROM Event WHERE RecordType.Name = 'Sales Appointment' LIMIT 1];
    id salesAppointmentRecordTypeId = salesAppointmentRecordType.RecordTypeId;
    
    for (Event event : Trigger.new)
    {
        if (event.Appointment_Kept__c == 'Yes' && event.RecordTypeId == salesAppointmentRecordTypeId )
        {
            Opportunity o = entries.get(event.WhatId);
            o.Appointment_Kept__c = TRUE;
           // entries.get(task.WhatId).Intacct_Entity__c = 'a3VJ000000012yF';
            oppToUpdate.add(o);
        }        
    }
    update oppToUpdate;
}