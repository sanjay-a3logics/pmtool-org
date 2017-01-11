trigger UpdateIntacctEntityFromSalesAppointment on Event (before update, before insert) {
     Set<Id> oppIds = new Set<Id>();
    for (Event event : Trigger.new)
    {
        String myId = event.WhatId;
        oppIds.add(myId);
    }
    Map<Id, Opportunity> entries = new Map<Id, Opportunity>(
    [SELECT Id, Intacct_Entity__c FROM Opportunity WHERE Id in :oppIds ]
    );
    List<Opportunity> oppToUpdate = new List<Opportunity>();
    
    
    Intacct_Entity__c entityLouisiana = [SELECT Id, Name FROM Intacct_Entity__c WHERE Name = 'PG of LA' LIMIT 1];
    Intacct_Entity__c entityConnecticut = [SELECT Id, Name FROM Intacct_Entity__c WHERE Name = 'PG of CT' LIMIT 1];
    Intacct_Entity__c entityNewYork = [SELECT Id, Name FROM Intacct_Entity__c WHERE Name = 'PG of NY' LIMIT 1];
    
    //Event salesAppointmentRecordType = [SELECT RecordTypeId FROM Event WHERE RecordType.Name = 'Sales Appointment' LIMIT 1];
    
    for (Event event : Trigger.new)
    {
        //if (event.RecordTypeId == salesAppointmentRecordType.Id) {
            if (event.Assigned_To_Location__c == 'Metairie' || event.Assigned_To_Location__c == 'Baton Rouge' || 
                event.Assigned_To_Location__c == 'Houma' || event.Assigned_To_Location__c == 'Shreveport')
            {
                Opportunity o = entries.get(event.WhatId);
                o.Intacct_Entity__c = entityLouisiana.Id;
               // entries.get(task.WhatId).Intacct_Entity__c = 'a3VJ000000012yF';
                oppToUpdate.add(o);
            }
            // PG of CT
            if (event.Assigned_To_Location__c == 'Bridgeport')
            {
                Opportunity o = entries.get(event.WhatId);
                o.Intacct_Entity__c = entityConnecticut.Id;
                oppToUpdate.add(o);
            }
            // PG of NY a3VJ000000012yA
            if (event.Assigned_To_Location__c == 'Albany')
            {
                Opportunity o = entries.get(event.WhatId);
                o.Intacct_Entity__c = entityNewYork.Id;
                oppToUpdate.add(o);
            }
      //  }
    }
    update oppToUpdate;
}