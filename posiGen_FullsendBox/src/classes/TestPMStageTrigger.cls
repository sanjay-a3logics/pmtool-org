@isTest
public with sharing class TestPMStageTrigger {
    public static testMethod void unitTest1() {
        Opportunity opp = new Opportunity();
        opp.name = 'Test1';
        opp.StageName = 'Layout Approval';
        opp.CloseDate = system.today();
        insert opp;
        
        PM_Tool_V2__c pm = new PM_Tool_V2__c();
        pm.Opportunity__c = opp.id;
        pm.Project_Status__c = 'Active';
        pm.Completion_Average__c = 0.0;
        pm.Lease_Type__c = '';
        insert pm;   
    
        Business_Market__c bm = new Business_Market__c(name='CT');
        insert bm;
        
        Business_Stage__c bist = new Business_Stage__c(name='test123',Business_market__c = bm.id);
        insert bist;
        
        PM_Stage__c pmStage = new PM_Stage__c();
        pmStage.Business_Installation_Stage__c = bist.id;
        pmStage.PM_Tool_V2__c = pm.id;
        pmStage.PM_Review__c = true;
        insert pmStage;
        
        PM_Review.pmReviewed = true;
        update pmStage;
    }
}