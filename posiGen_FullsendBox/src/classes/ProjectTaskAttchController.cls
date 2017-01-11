public class ProjectTaskAttchController
{
    public List<Attachment__c> taskAttachments;
    public String projectId;
    
    public ProjectTaskAttchController()
    {
        projectId = IdConversionHelper.ID15to18(ApexPages.currentPage().getParameters().get('id'));
        
        //Pull the current project id,name, and related milestones from database
        taskAttachments = [SELECT 
                 Id,
              Name,
             Type__c,
              CreatedById,
              Submitter_Notes__c,
              CreatedDate,
              Task__r.Name,
              Task__r.Task_Number_Within_Milestone__c,
              Task__r.Project_Name__c,
              Task__r.ProjectId__c
                 FROM Attachment__c  
                 WHERE Task__r.ProjectId__c 
                 = :projectId
                 ORDER BY Task__r.CreatedDate, Task__r.Task_Number_Within_Milestone__c, CreatedDate
                ];
    }
    
    public List<Attachment__c> getTaskAttachments()
    {
        return taskAttachments;
    }
}