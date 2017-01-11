trigger updatePVIRPLWHDate on Project__c (before update) {
    for ( Project__c project : trigger.new )
    {
    Project__c oldProject = trigger.oldMap.get(project.Id);
    if(project.PVI_Rails_and_Panels_Left_Warehouse_Date__c != null && oldProject.PVI_Rails_and_Panels_Left_Warehouse_Date__c == null)
    {
        //Initialize an Opportunity sObject using the id stored in the updated project
        Opportunity relatedOpp = [SELECT Id, PVI_Rails_and_Panels_Left_WH_Date__c FROM Opportunity WHERE ID = :project.Opportunity__c LIMIT 1]; 
        
        //Assign project's *date field* value to the Opportunity's *date field* value
        relatedOpp.PVI_Rails_and_Panels_Left_WH_Date__c = project.PVI_Rails_and_Panels_Left_Warehouse_Date__c;
        
        //Attempt to update the Opportunity record using DML statements
        try
        {
            //DML updated on opportunity record
            update relatedOpp;
        }
        catch(DmlException e)
        {
            System.Debug(e.getCause());
        }
    }   
}
}