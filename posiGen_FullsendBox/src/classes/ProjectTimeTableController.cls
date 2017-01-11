public class ProjectTimeTableController
{
    private List<Task__c> projectTasks;
    private List<Time__c> taskTimes;
    private Project__c project;
    
    public ProjectTimeTableController()
    {
        project =	[SELECT Id,Name FROM Project__c WHERE Id = :(IdConversionHelper.ID15to18(ApexPages.currentPage().getParameters().get('id'))) LIMIT 1];
        
        projectTasks = [SELECT 
                        Id, 
                        ProjectID__c,
                        (SELECT Id FROM Time__r) 
                        FROM
                       	Task__c
                       	WHERE
                        ProjectID__c = :project.id
                       ];
        
    
    	taskTimes = [SELECT
                     Id, 
                     Name, 
                     Task__r.ID, 
                     Task__r.Name,
                     Task__r.Project_Name__c,
                     Task__r.ProjectID__c,
                     Date_Incurred__c,
                     Incurred_By__r.Id,
                     Incurred_By__r.Name,
                     Description__c,
                     Hours_Worked__c
                     FROM
                     Time__c
                     WHERE Task__r.ProjectID__c = :project.id
                     ORDER BY Task__r.Project__c, Task__r.Task_Number_Within_Milestone__c
                    ];
    }
    
    public List<Time__c> getTaskTimes()
    {
        return this.taskTimes;
    }
}