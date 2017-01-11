trigger UpdateOppFromRemovalProject on Project__c (after update) {
	/*List<Project__c> removalProjects = [SELECT Id
                                        	   ,Name
                                        	   ,R_P_Removal_Date__c
                                        	   ,Permanent_Removal__c
                                        	   ,Opportunity__c
                                        	   ,Opportunity__r.Id
                                        	   FROM Project__c 
                                        	   WHERE Project__c.Record_Type_Name__c 
                                        	   LIKE '%PV%Removal%' AND Id IN :Trigger.newMap.keySet()];
    

    
    List<Opportunity> oppsToUpdate = new List<Opportunity>();
    
    for (Project__c p : removalProjects)
    {
        Opportunity o = p.Opportunity__r;
        
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
    
    update oppsToUpdate;*/
    
}