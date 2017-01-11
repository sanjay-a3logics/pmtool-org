@isTest
public with sharing class TestPM_Review {
    public static testMethod void unitTest1() {
    
        ApexPages.StandardController controller;
        
        PM_Review pmRev = new PM_Review(controller);
        
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
        
        ApexPages.currentPage().getParameters().put('id',pm.id);
        
        Business_Market__c bm = new Business_Market__c(name='CT');
        insert bm;
        
        Business_Stage__c bist = new Business_Stage__c(name='test123',Business_market__c = bm.id);
        insert bist;
        
        Business_Status__c bs = new Business_Status__c(name='Complete',score__c=3);
        insert bs;
        
        PM_Stage__c pmStage = new PM_Stage__c();
        pmStage.Business_Installation_Stage__c = bist.id; 
        pmStage.Business_Status__c = bs.id;    
        pmStage.PM_Review__c = true; 
        pmStage.PM_Tool_V2__c = pm.id;
        insert pmStage;

        pmRev.loadPmReview();
        pmRev.saveStages();
    }
    
    public static testMethod void unitTest2() {
    
        ApexPages.StandardController controller;
        
        PM_Review pmRev = new PM_Review(controller);
        
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
        
        ApexPages.currentPage().getParameters().put('id','');
        
        Business_Market__c bm = new Business_Market__c(name='CT');
        insert bm;
        
        Business_Stage__c bist = new Business_Stage__c(name='test123',Business_market__c = bm.id);
        insert bist;
        
        Business_Status__c bs = new Business_Status__c(name='Complete',score__c=3);
        insert bs;
        
        PM_Stage__c pmStage = new PM_Stage__c();
        pmStage.Business_Installation_Stage__c = bist.id; 
        pmStage.Business_Status__c = bs.id;    
        pmStage.PM_Review__c = true; 
        pmStage.PM_Tool_V2__c = pm.id;
        insert pmStage;
        
        pmRev.pmStageList = null;
        
        pmRev.loadPmReview();
        pmRev.saveStages();
    }
    
}