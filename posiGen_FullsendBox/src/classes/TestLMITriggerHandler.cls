@isTest()
public class TestLMITriggerHandler{ 
    static testMethod void myUnitTest() {
        
        Account acc = new Account(
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
        
        Municipality__c mun = new Municipality__c();
        mun.Household_Size_01__c = 20000;
        mun.Household_Size_02__c = 20000;
        mun.Household_Size_03__c = 20000;
        mun.Household_Size_04__c = 20000;
        mun.Household_Size_05__c = 20000;
        mun.Household_Size_06__c = 20000;
        mun.Household_Size_07__c = 20000;
        mun.Household_Size_08__c = 20000;
        insert mun;
        
        Property__c property = new Property__c();
        property.name = 'Test Property';
        property.Account__c = acc.id;
        property.Number_of_Units__c = 1;
        property.Address_Line_1__c = 'Sample address';
        property.City__c = 'Test';
        property.State__c = 'LA';
        Property.AHJ__c = mun.id;
        Property.ZipCode__c = '12345';
        insert property;
    
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed won';
        opp.Property__c = property.id;
        opp.People_In_Household__c = 4;
        opp.Annual_Household_Income__c = 50000; 
        insert opp;
    }
    
    static testMethod void myUnitTest2() {
        
        Account acc = new Account(
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
        
        Municipality__c mun = new Municipality__c();
        mun.Household_Size_01__c = 20000;
        mun.Household_Size_02__c = 20000;
        mun.Household_Size_03__c = 20000;
        mun.Household_Size_04__c = 20000;
        mun.Household_Size_05__c = 20000;
        mun.Household_Size_06__c = 20000;
        mun.Household_Size_07__c = 20000;
        mun.Household_Size_08__c = 20000;
        insert mun;
        
        Municipality__c mun1 = new Municipality__c();
        mun1.Household_Size_01__c = 70000;
        mun1.Household_Size_02__c = 7000;
        mun1.Household_Size_03__c = 70000;
        mun1.Household_Size_04__c = 70000;
        mun1.Household_Size_05__c = 70000;
        mun1.Household_Size_06__c = 70000;
        mun1.Household_Size_07__c = 70000;
        mun1.Household_Size_08__c = 70000;
        insert mun1;
        
        Property__c property = new Property__c();
        property.name = 'Test Property';
        property.Account__c = acc.id;
        property.Number_of_Units__c = 1;
        property.Address_Line_1__c = 'Sample address';
        property.City__c = 'Test';
        property.State__c = 'LA';
        Property.AHJ__c = mun.id;
        Property.ZipCode__c = '12345';
        insert property;
    
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed won';
        opp.Property__c = property.id;
        opp.People_In_Household__c = 4;
        opp.Annual_Household_Income__c = 50000; 
        insert opp;
        
        LMITriggerHandler.firstRun = true;
        
        property.AHJ__c = mun1.id;
        update property;
    }
    
    static testMethod void myUnitTest3() {
        
        Account acc = new Account(
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
        
        Municipality__c mun = new Municipality__c();
        mun.Household_Size_01__c = 20000;
        mun.Household_Size_02__c = 20000;
        mun.Household_Size_03__c = 20000;
        mun.Household_Size_04__c = 20000;
        mun.Household_Size_05__c = 20000;
        mun.Household_Size_06__c = 20000;
        mun.Household_Size_07__c = 20000;
        mun.Household_Size_08__c = 20000;
        insert mun;
        
        Municipality__c mun1 = new Municipality__c();
        mun1.Household_Size_01__c = 70000;
        mun1.Household_Size_02__c = 7000;
        mun1.Household_Size_03__c = 70000;
        mun1.Household_Size_04__c = 70000;
        mun1.Household_Size_05__c = 70000;
        mun1.Household_Size_06__c = 70000;
        mun1.Household_Size_07__c = 70000;
        mun1.Household_Size_08__c = 70000;
        insert mun1;
        
        Property__c property = new Property__c();
        property.name = 'Test Property';
        property.Account__c = acc.id;
        property.Number_of_Units__c = 1;
        property.Address_Line_1__c = 'Sample address';
        property.City__c = 'Test';
        property.State__c = 'LA';
        Property.AHJ__c = mun1.id;
        Property.ZipCode__c = '12345';
        insert property;
    
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed won';
        opp.Property__c = property.id;
        opp.People_In_Household__c = 4;
        opp.Annual_Household_Income__c = 50000; 
        insert opp;
        
        LMITriggerHandler.firstRun = true;
        
        property.AHJ__c = mun.id;
        update property;
    }
}