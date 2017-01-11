trigger UpdateEEStatusFromProjectInsert on Project__c (after insert) {
    Trigger_Setting__c ts= Trigger_Setting__c.getInstance();
    if(!ts.Project_Trigger__c){     
        List<Project__c> projsToUpdate = [SELECT Id, Status__c, Record_Type_Name__c, Opportunity__r.Id, EE_Completed_Date__c
                                          FROM Project__c 
                                          WHERE (Project__c.Record_Type_Name__c LIKE '%EE%Assessment%' OR Project__c.Record_Type_Name__c LIKE '%EE%Upgrade%') AND Id IN : Trigger.newMap.keySet()];
        
        List<Opportunity> oppsToUpdate = new List<Opportunity>();
        
        for (Project__c p : projsToUpdate)
        {
            Opportunity o = p.Opportunity__r;
            if (p.Status__c != null && p.Record_Type_Name__c == 'EE Assessment')
            {
                o.EA_Status__c = p.Status__c;
            }
            if (p.EE_Completed_Date__c != null && p.Record_Type_Name__c == 'EE Assessment')
            {
                o.EA_Completed_Date__c = p.EE_Completed_Date__c;    
            }
            if (p.Status__c != null && p.Record_Type_Name__c == 'EE Upgrade') 
            {
                o.EU_Status__c = p.Status__c;
            }
            if (p.EE_Completed_Date__c != null && p.Record_Type_Name__c == 'EE Upgrade')
            {
                o.EU_Completed_Date__c = p.EE_Completed_Date__c;
            }
            oppsToUpdate.add(o);
        }
        update oppsToUpdate;
    }
}