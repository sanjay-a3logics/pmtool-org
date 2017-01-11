trigger updatePVIRailsPanelsLeftWHDate on Project__c (after update) 
{
// Grab all related projects 
    List<Project__c> projsWithSavings = [SELECT Id, PVI_Rails_and_Panels_Left_Warehouse_Date__c, Opportunity__c, Opportunity__r.Id FROM Project__c WHERE Project__c.Record_Type_Name__c
                                         LIKE '%PV%Install%' AND Id IN :Trigger.newMap.keySet()];
    //List<Project__c> projsWithSavings = Trigger.new;
    List<Opportunity> oppsToUpdate = new List<Opportunity>{};
    //  For loop to iterate through all the queried Project__c record
    for(Project__c p: projsWithSavings)
    {
        //  Syntax on the table relationship may need to be adjusted; the example was from a parent-child update, while this is a child-to-parent update.
        Opportunity o = p.Opportunity__r;
        o.PVI_Rails_and_Panels_Left_WH_Date__c = p.PVI_Rails_and_Panels_Left_Warehouse_Date__c;
        oppsToUpdate.add(o);
    }
    update oppsToUpdate;
}
// OLD TRIGGER CODE
/*trigger updatePVIRPLWHDate on Project__c (before update) {
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
}*/