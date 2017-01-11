trigger UpdateOppFromLockoutAndRemovalProject on Project__c (after update) {
    Trigger_Setting__c ts= Trigger_Setting__c.getInstance();
    if(!ts.Project_Trigger__c){     
        List<Project__c> lockoutProjects = [SELECT Id
                                           ,Name
                                           ,Request_Type__c
                                           ,Status__c
                                           ,R_P_Removal_Date__c
                                           ,Permanent_Removal__c
                                           ,Opportunity__c
                                           ,Record_Type_Name__c
                                           ,Opportunity__r.Id
                                           FROM Project__c
                                           WHERE (Project__c.Record_Type_Name__c LIKE '%Lockout%' OR Project__c.Record_Type_Name__c LIKE '%PV%Removal%') 
                                           AND Id IN : Trigger.newMap.keySet()];
        
        List<Opportunity> oppsToUpdate = new List<Opportunity>();
        
        for (Project__c p : lockoutProjects)
        {
            Opportunity o = p.Opportunity__r;
            if (p.Request_Type__c == 'Disconnect' && p.Status__c == 'Completed' && p.Record_Type_Name__c == 'Lockout')
            {
                o.Disconnect_Status__c = 'Disconnected';
            }
            if (p.Request_Type__c == 'Reconnect' && p.Status__c == 'Completed' && p.Record_Type_Name__c == 'Lockout')
            {
                o.Disconnect_Status__c = 'Reconnected';
            }
            if (p.R_P_Removal_Date__c != null) 
            {
                o.R_P_Removal_Date__c = p.R_P_Removal_Date__c;
                
            }
            if (p.Permanent_Removal__c == TRUE )
            {
                o.Permanent_Removal__c = TRUE;
               
            }
            if (p.Permanent_Removal__c == FALSE)
            {
                o.Permanent_Removal__c = FALSE;
                
            }
            oppsToUpdate.add(o);
        }
        update oppsToUpdate;
    }
}