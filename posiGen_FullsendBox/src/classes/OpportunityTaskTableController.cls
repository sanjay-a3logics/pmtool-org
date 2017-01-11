public without sharing class OpportunityTaskTableController
{
    public List<Task__c > tasks;
    
    public OpportunityTaskTableController()
    {
        tasks = [
            SELECT
              Id,
              Name,
              Assigned_To__c,
              Assigned_To__r.Name,
              Milestone__c,
              Milestone__r.Name,
              Milestone__r.Milestone_Number__c,
              Milestone__r.Project__c,
              Status__c,
              Task_Number_within_Milestone__c,
              Kickoff__c,
              Deadline__c,
              Approved_Date__c,
              Project_Name__c
            From
              Task__c
            WHERE
              Task_Opportunity__c Like :ApexPages.currentPage().getParameters().get('id') 
            Order By Milestone__r.Project__r.Project_Number__c, Milestone__r.Milestone_Number__c, Task_Number_Within_Milestone__c
            ];
    }
    
    public List<Task__c> getTasks()
    {
        return tasks;
    }
}