public without sharing class AccountProjectTableController
{
    public List<Project__c> projects;
    private List<Opportunity> AccountOppIds;
    private ID[] oppIds;
    //

    public AccountProjectTableController()
    {
        AccountOppIds = [SELECT Id FROM Opportunity WHERE Account.Id IN (:(Id)ApexPages.currentPage().getParameters().get('id'))];

        oppIds = new List<Id>();


        for(Opportunity oppId: AccountOppIds)
        {
            oppIds.add(oppId.Id);
        }

        //Pull the current project id,name, and related milestones from database
        projects = [SELECT
         Id,
         Name,
         Subcontractor__r.Id,
         Subcontractor__r.Name,
         Opportunity__c,
         Opportunity__r.Name,
         Kickoff__c,
         Deadline__c,
         Status__c,
         RecordType.Name
         FROM Project__c
         WHERE Opportunity__c
         IN :oppIds
         ORDER BY Project_Number__c
               ];
    }

    public List<Project__c> getprojects()
    {
        return projects;
    }
}