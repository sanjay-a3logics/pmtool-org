@isTest
private class ZD_Tests {

    static testMethod void projectTriggerTest() {
        test.startTest();

        // create a new account
        Account oAccount = new Account(Name = 'ZD Test');
        insert oAccount;
        
        // create an opportunity
        
        // get any opportunity stage
        List<OpportunityStage> lStage = [SELECT Id FROM OpportunityStage WHERE Id != NULL LIMIT 1]; 
        if(lStage.size() < 1) {
            throw new ZD_Exception('Error stage');
        }
        Id nStageId = lStage[0].Id;
        
        Opportunity oOpportunity = new Opportunity(
            Name = 'ZD Test',
            Account = oAccount,
            StageName = nStageId,
            CloseDate = date.today()
        );
        insert oOpportunity;
        
        // get Project record types
        Map<ID,RecordType> mRecordTypes = new Map<ID,RecordType>([Select ID, Name From RecordType Where sObjectType = 'Project__c']);
        
        // create an install project
        Project__c oInstallProject = null;
        for(String sId : mRecordTypes.keySet())
        {
            if(mRecordTypes.get(sId).name.containsIgnoreCase('PV Install'))
            {
                oInstallProject = new Project__c(RecordTypeId = sId, Opportunity__c = oOpportunity.Id);
                break;
            }
        }
        insert oInstallProject;
        
        // create a system        
        Systems__c oSystem = new Systems__c(Install_Project_Created_On__c = oInstallProject.Id);
        insert oSystem;
        
        // create a removal project that is linked to system        
        Project__c oRemovalProject = null;
        for(String sId : mRecordTypes.keySet())
        {
            if(mRecordTypes.get(sId).name.containsIgnoreCase('PV Removal'))
            {
         		oRemovalProject = new Project__c(RecordTypeId = sId, Opportunity__c = oOpportunity.Id, System_Removed__c = oSystem.Id, R_P_Removal_Date__c = date.today());
                break;
            }
        }
        insert oRemovalProject;
        
        // assert that project removal date is stored on system object
        Systems__c oUpdatedSystem = [SELECT Id, System_Removal_Date__c FROM Systems__c WHERE Id = :oSystem.Id];
                
        System.assert(oUpdatedSystem.System_Removal_Date__c == date.today());
                
        test.stopTest();
    }
    
    static testMethod void systemEfficiencyTest() {
        test.startTest();
        
        // create a new account
        Account oAccount = new Account(Name = 'ZD Test');
        insert oAccount;
        
        // create an opportunity
        
        // get any opportunity stage
        List<OpportunityStage> lStage = [SELECT Id FROM OpportunityStage WHERE Id != NULL LIMIT 1]; 
        if(lStage.size() < 1) {
            throw new ZD_Exception('Error stage');
        }
        Id nStageId = lStage[0].Id;
        
        Opportunity oOpportunity = new Opportunity(
            Name = 'ZD Test',
            Account = oAccount,
            StageName = nStageId,
            CloseDate = date.today()
        );
        insert oOpportunity;
        
        // get Project record types
        Map<ID,RecordType> mRecordTypes = new Map<ID,RecordType>([Select ID, Name From RecordType Where sObjectType = 'Project__c']);
        
        // create an install project
        Project__c oInstallProject = null;
        for(String sId : mRecordTypes.keySet())
        {
            if(mRecordTypes.get(sId).name.containsIgnoreCase('PV Install'))
            {
                oInstallProject = new Project__c(RecordTypeId = sId, Opportunity__c = oOpportunity.Id);
                break;
            }
        }
        insert oInstallProject;
        
        // create a system        
        Systems__c oSystem = new Systems__c(Install_Project_Created_On__c = oInstallProject.Id);
        insert oSystem;
        
        // create a system channel
        System_Channel__c oSystemChannel = new System_Channel__c(System__c = oSystem.Id);
        insert oSystemChannel;
        
        // create sysem PV Production
        System_PV_Production__c oSystemProduction = new System_PV_Production__c(System__c = oSystem.Id, Production_W__c = 25, System_Channel__c = oSystemChannel.Id);
        insert oSystemProduction;
        
        // set system id GET parameter
        ApexPages.currentPage().getParameters().put('id', oSystem.Id);
             
        // as long as we throw no exceptions there are no errors
        ZD_System_Detail_Controller controller = new ZD_System_Detail_Controller();
        
        test.stopTest();
    }
    
    /*
    static testMethod void projectExtensionTest() {
        test.startTest();
        
        // create a new account
        Account oAccount = new Account(Name = 'ZD Test');
        insert oAccount;
        
        // create an opportunity
        
        // get any opportunity stage
        List<OpportunityStage> lStage = [SELECT Id FROM OpportunityStage WHERE Id != NULL LIMIT 1]; 
        if(lStage.size() < 1) {
            throw new ZD_Exception('Error stage');
        }
        Id nStageId = lStage[0].Id;
        
        Opportunity oOpportunity = new Opportunity(
            Name = 'ZD Test',
            Account = oAccount,
            StageName = nStageId,
            CloseDate = date.today()
        );
        insert oOpportunity;
        
        // get Project record types
        Map<ID,RecordType> mRecordTypes = new Map<ID,RecordType>([Select ID, Name From RecordType Where sObjectType = 'Project__c']);
        
        // create an install project
        Project__c oInstallProject = null;
        for(String sId : mRecordTypes.keySet())
        {
            if(mRecordTypes.get(sId).name.containsIgnoreCase('PV Install'))
            {
                oInstallProject = new Project__c(RecordTypeId = sId, Opportunity__c = oOpportunity.Id);
                break;
            }
        }
        insert oInstallProject;
        
        // create a system        
        Systems__c oSystem = new Systems__c(Install_Project_Created_On__c = oInstallProject.Id);
        insert oSystem;
        
        // create a system channel
        System_Channel__c oSystemChannel = new System_Channel__c(System__c = oSystem.Id);
        insert oSystemChannel;
        
        // create sysem PV Production
        System_PV_Production__c oSystemProduction = new System_PV_Production__c(System__c = oSystem.Id, Production_W__c = 25, System_Channel__c = oSystemChannel.Id);
        insert oSystemProduction;
        
        // create an ee assessment project
        Project__c oAssessmentProject = null;
        for(String sId : mRecordTypes.keySet())
        {
            if(mRecordTypes.get(sId).name.containsIgnoreCase('EE Assessment'))
            {
                oAssessmentProject = new Project__c(RecordTypeId = sId, Opportunity__c = oOpportunity.Id);
                break;
            }
        }
        insert oAssessmentProject;
        
        // create standard controller
        ApexPages.StandardController oStandardController = new ApexPages.StandardController(oAssessmentProject);
        
        // create controller extension
        ZD_EEProject_System_Controller oController = new ZD_EEProject_System_Controller(oStandardController);
        
        oController.getSystemId();
        
        test.stopTest();
    }
	*/
}