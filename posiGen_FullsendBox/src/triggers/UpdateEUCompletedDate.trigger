trigger UpdateEUCompletedDate on Project__c (before update) {
    Trigger_Setting__c ts= Trigger_Setting__c.getInstance();
    if(!ts.Project_Trigger__c){     
     for( Project__c project : trigger.new)
        {         
            //Get the old version of the project from the collection of old versions of the record
            Project__c oldProject = trigger.oldMap.get(project.Id);
            
            // EE Upgrade, SHW  project types
            if( (project.EE_Completed_Date__c != null && oldProject.EE_Completed_Date__c == null) && 
                (project.Record_Type_Name__c == 'EE Upgrade' || project.Record_Type_Name__c == 'SHW Install' || project.Record_Type_Name__c == 'SHW Feasibility')  
              )
            {
                //Initialise an Opportunity sObject using the id stored in the updated project
                Opportunity relatedOpp = [SELECT Id,EU_Completed_Date__c FROM Opportunity WHERE ID = :project.Opportunity__c LIMIT 1]; //Add the fieldname of the date field you want to update after the Id in the select statement
               
                //Assign project's *date field* value to the Opportunity's *date field* value
                relatedOpp.EU_Completed_Date__c = project.EE_Completed_Date__c; //NOT ACTUAL FIELD VALUES. CHANGE TO ACTUAL FIELD VALUES OR ELSE!!!!!
               
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
    }
}