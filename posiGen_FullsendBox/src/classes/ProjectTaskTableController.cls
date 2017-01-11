public class ProjectTaskTableController
{
    public Project__c project;
    public List<Task__c> tasks;
    public List<Milestone__c> milestones;
    public String projectID;
    
    public ProjectTaskTableController()
    {
        projectID = IdConversionHelper.ID15to18(ApexPages.currentPage().getParameters().get('id'));
        project = [SELECT Id, Project_Number__c FROM Project__c WHERE ID = :projectId];
        milestones = [Select Id From Milestone__c WHERE Project__r.Project_Number__c = :project.Project_Number__c];
        
        //Pull the current project id,name, and related milestones from database
        tasks = [SELECT 
                 Id, 
                 Name,
                 Assigned_To__c,
                 Assigned_To__r.Name,
                 Milestone__c,
                 Milestone__r.Name,
                 Milestone__r.Id,
                 Milestone__r.Project__c,
                 Status__c,
                 Task_Number_Within_Milestone__c,
                 Kickoff__c,
                 Deadline__c,
                 Approved_Date__c
                 FROM Task__c  
                 WHERE Milestone__c 
                 IN :milestones
                 ORDER BY Milestone__r.Project__r.Project_Number__c, Milestone__r.CreatedDate, Task_Number_Within_Milestone__c
                ];
    }
    
    public List<Task__c> getTasks()
    {
        return tasks;
    }
}