public without sharing class OppTaskAttachmentController
{
    public List<Attachment__c > taskAttachments;
    
    
    public OppTaskAttachmentController()
    {
        taskAttachments = [
            SELECT
              Id,
              Name,
              Type__c,
              CreatedById,
              CreatedBy.Name,
              Submitter_Notes__c,
              CreatedDate,
              Task__c,
              Task__r.Name,
              Task__r.Milestone__c,
              Task__r.Milestone__r.Name,
              Task__r.Milestone__r.Project__c,
              Task__r.Project_Name__c
            From
              Attachment__c
            WHERE
              Task__r.Task_Opportunity__c Like :ApexPages.currentPage().getParameters().get('id') 
            ORDER BY 
              Task__r.Milestone__r.Project__r.Project_Number__c,
              Task__r.Milestone__r.Milestone_Number__c,
              Task__r.Task_Number_Within_Milestone__c,
              CreatedDate
            ];
    }
    
    public List<Attachment__c> getTaskAttachments()
    {
        return taskAttachments;
    }
}