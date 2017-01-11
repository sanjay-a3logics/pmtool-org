@isTest
class TestDocuSignStatusTrigger {
    static testMethod void populateAccountLookup() {
        Opportunity opp = new Opportunity();
        opp.name = 'test123';
        opp.StageName = 'Layout Approval'; 
        opp.CloseDate = System.today();
        insert opp;
        dsfs__DocuSign_Status__c dsfs = new dsfs__DocuSign_Status__c();
        dsfs.dsfs__Opportunity__c = opp.id;
        insert dsfs;
    }
}