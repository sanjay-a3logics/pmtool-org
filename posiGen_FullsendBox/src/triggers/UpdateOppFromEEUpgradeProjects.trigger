trigger UpdateOppFromEEUpgradeProjects on Project__c (after update) {
    Trigger_Setting__c ts= Trigger_Setting__c.getInstance();
        if(!ts.Project_Trigger__c){     
         List<Project__c> projsWithSavings = [SELECT Id, EU_Projected_Elec_Savings_DlrsPerYr__c,
                                              EU_Projected_Elec_kWh_perYear_Savings__c,
                                              EU_Projected_Nat_Gas_Savings_yr__c,
                                              EU_Projected_NG_Therms_PerYear_Savings__c,
                                              EE_Completed_Date__c,
                                              Status__c,
                                              Opportunity__c, Opportunity__r.Id FROM Project__c WHERE Project__c.Record_Type_Name__c
                                              LIKE '%EE%Upgrade%' AND Id IN :Trigger.newMap.keySet()];
        List<Opportunity> oppsToUpdate = new List<Opportunity>{};
        for(Project__c p: projsWithSavings)
        {
            Opportunity o = p.Opportunity__r;
            if (p.EU_Projected_Elec_Savings_DlrsPerYr__c != null)
            {
                o.EU_Projected_Elec_Savings_DlrsPerYr__c = p.EU_Projected_Elec_Savings_DlrsPerYr__c;
            }
            if (p.EU_Projected_Elec_kWh_perYear_Savings__c != null)
            {
                o.EU_Projected_Elec_kWh_perYear_Savings__c = p.EU_Projected_Elec_kWh_perYear_Savings__c;
            }
            if (p.EU_Projected_Nat_Gas_Savings_yr__c != null) 
            {
                o.EU_Projected_Nat_Gas_Savings_yr__c = p.EU_Projected_Nat_Gas_Savings_yr__c;
            }
            if (p.EU_Projected_NG_Therms_PerYear_Savings__c != null) 
            {
                o.EU_Projected_NG_Therms_PerYear_Savings__c = p.EU_Projected_NG_Therms_PerYear_Savings__c;
            }
            if (p.EE_Completed_Date__c != null)
            {
                o.EU_Completed_Date__c = p.EE_Completed_Date__c;
            }
            if (p.Status__c != null)
            {
                o.EU_Status__c = p.Status__c;
            }
            oppsToUpdate.add(o);
        }
        update oppsToUpdate;
    }
}