public class ProjectDocusignStatusTableController
{
    List<dsfs__Docusign_Status__C> documents;
    Opportunity relatedOpp;
    Project__c currentProject;
    
    public ProjectDocusignStatusTableController()
    {
        currentProject = [SELECT id, Opportunity__c FROM Project__c WHERE id = :(IdConversionHelper.Id15to18(ApexPages.currentPage().getParameters().get('id')))];
        
        relatedOpp = [SELECT id FROM Opportunity WHERE Id = :currentProject.Opportunity__c];
        
        documents = [SELECT dsfs__Opportunity__c, dsfs__Opportunity__r.Name, Id, Name, dsfs__Subject__c, CreatedDate FROM dsfs__DocuSign_Status__c 
                     WHERE dsfs__Opportunity__c = :relatedOpp.id]; 
    }
    
    public List<dsfs__Docusign_Status__c> getDocuments()
    {
        return documents;
    }
}