trigger UpdateEAProjectFields on Project__c (after update) 
{   
   Trigger_Setting__c ts= Trigger_Setting__c.getInstance();
   if(!ts.Project_Trigger__c){      
        // Grab all related projects 
        List<Project__c> projsWithSavings = [SELECT Id, EE_Completed_Date__c, Opportunity__c, Opportunity__r.Id, Status__c FROM Project__c WHERE Project__c.Record_Type_Name__c
                                             LIKE '%EE%Assessment%' AND Id IN :Trigger.newMap.keySet()];
        //List<Project__c> projsWithSavings = Trigger.new;
        List<Opportunity> oppsToUpdate = new List<Opportunity>{};
        //  For loop to iterate through all the queried Project__c record
        for(Project__c p: projsWithSavings)
        {
            //  Syntax on the table relationship may need to be adjusted; the example was from a parent-child update, while this is a child-to-parent update.
            Opportunity o = p.Opportunity__r;
            if (p.EE_Completed_Date__c != null)
            {
                o.EA_Completed_Date__c = p.EE_Completed_Date__c;
            }
            if (p.Status__c != null)
            {
                o.EA_Status__c = p.Status__c;    
            }
            oppsToUpdate.add(o);
        }
        update oppsToUpdate;
    }
}

// OLD TRIGGER CODE
/*{
    for( Project__c project : trigger.new)
    {         
        //Get the old version of the project from the collection of old versions of the record
        Project__c oldProject = trigger.oldMap.get(project.Id);
        if( (project.EE_Completed_Date__c != null && oldProject.EE_Completed_Date__c == null) && (project.Record_Type_Name__c == 'EE Assessment')  )
        {
            //Initialise an Opportunity sObject using the id stored in the updated project
            Opportunity relatedOpp = [SELECT Id,EA_Completed_Date__c FROM Opportunity WHERE ID = :project.Opportunity__c LIMIT 1]; //Add the fieldname of the date field you want to update after the Id in the select statement
           
            //Assign project's *date field* value to the Opportunity's *date field* value
            relatedOpp.EA_Completed_Date__c = project.EE_Completed_Date__c; //NOT ACTUAL FIELD VALUES. CHANGE TO ACTUAL FIELD VALUES OR ELSE!!!!!
           
            //Attempt to update the Opportunity record using DML statements
            try
            {  //DML updated on opportunity record
                update relatedOpp;
            }
            catch(DmlException e)
            {
                System.Debug(e.getCause());
            }
        }
    }
}*/