public class OpportunityTaskAttachmentTableController
{
    public List<Attachment__c > attachments;
    public List<Project__c > projects;
    public Milestone__c milestone;
    
    public OpportunityTaskAttachmentTableController()
    {
        milestone = [SELECT Id FROM Milestone__c WHERE Project__c 
                     IN (SELECT Id FROM Project__c WHERE Opportunity__c = :(ID)(ApexPages.currentPage().getParameters().get('id')))];
        
        attachments = [
            SELECT
              Id,
              Name,
             Type__c,
              CreatedById,
              Submitter_Notes__c,
              CreatedDate,
              Task__r.Name,
              Task__r.Milestone__c
            From
              Attachment__c
            
            	
            ];
    }
    
    public List<Attachment__c> getAttachments()
    {
        return attachments;
    }
}