@isTest
public class TestCensusTract{ 
    @testSetup static void myUnitTest() {
    
    
        Account acc= new Account(
          FirstName='Test FName',
          LastName='Test LName',
          PersonMailingStreet='test@yahoo.com',
          PersonMailingPostalCode='12345',
          PersonMailingCity='SFO',
          PersonEmail='test@yahoo.com',
          PersonHomePhone='1234567',
          PersonMobilePhone='12345678' 
        );
 
        insert acc;
        
        Property__c property = new Property__c();
        property.Assessor_City__c = 'LA';
        property.Assessor_House__c = '311';
        property.Assessor_Street_Direction__c = 'ssa';
        property.Assessor_Street_Name__c = 'asasa';
        property.Assessor_Street_Type__c = 'hhh';
        property.Assessor_State__c = 'LA';
        property.name= 'Property test';
        property.Address_Line_1__c = 'asadsjds';
        property.Account__c = acc.id;
        insert property;
        
        
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed Won';
        opp.Census_Tract__c = null;
        opp.Property__c = property.id;
        insert opp;
        
        
        
    }
    
    static testMethod void myUnitTest2(){
        
        Opportunity opp = [select id,stageName,Census_Tract__c from opportunity][0];
        Map<Id,String> oldOppStageMap = new Map<Id,String>();
        oldOppStageMap.put(opp.id,opp.stageName);
        
        Map<Id,String> oldCensusTractMap = new Map<Id,String>();
        oldCensusTractMap.put(opp.id,opp.Census_Tract__c);
        
        Trigger_Setting__c ts = new Trigger_Setting__c(Attachment_Trigger__c=true, BoxAccessMatrixStage_Trigger__c=true, FeedItem_Trigger__c=true, LD_Lease_trigger__c=true, Opportunity_Trigger__c=true, PM_Trigger__c=true, Project_Trigger__c=true, Task_Trigger__c=true, User_Trigger__c=true );
        insert ts;
        
        //opp.stageName = 'Contracts Approved';
        //update opp;
        //System.assert(false,opp.stageName);
        
        Set<Id> oppSet = new Set<Id>();  
        oppSet.add(opp.id);
        
        Test.startTest();
        CensusTract.updateCensusTract(oppSet, oldOppStageMap, oldCensusTractMap);
        Test.stopTest();
        
    }
}