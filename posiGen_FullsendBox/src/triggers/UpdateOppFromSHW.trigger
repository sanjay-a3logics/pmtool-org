trigger UpdateOppFromSHW on Project__c (after update) {

    List<Project__c> lProjects = [
        SELECT 
        	Id, 
        	PVI_Placed_In_Service_Date__c,
        	Opportunity__c, 
        	Opportunity__r.Id 
        FROM 
        	Project__c 
        WHERE 
        	(Project__c.Record_Type_Name__c = 'SHW Install' 
             OR Project__c.Record_Type_Name__c = 'SHW Feasibility')
            AND Id IN :Trigger.newMap.keySet()
    ];
    
    List<Opportunity> lOppsToUpdate = new List<Opportunity>{};
    for(Project__c p: lProjects)
    {
        Opportunity o = p.Opportunity__r;
        if (p.PVI_Placed_In_Service_Date__c != null)
        {
            o.PVI_Placed_In_Service_Date__c = p.PVI_Placed_In_Service_Date__c;
        }
        lOppsToUpdate.add(o);
    }
    update lOppsToUpdate;
}