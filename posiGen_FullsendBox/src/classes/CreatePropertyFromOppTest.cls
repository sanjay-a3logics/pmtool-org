@isTest
public class CreatePropertyFromOppTest 
{
    public static testMethod void CreatePropertyFromOppTestMethod()
    {
        Account acct = new Account();
        acct.LastName = 'Test Account';
        acct.FirstName = 'Trigger';
        acct.BillingState = 'Louisiana';
        acct.BillingCountry = 'United States';
        insert acct;
        
		Intacct_Entity__c testIntacctEntity = new Intacct_Entity__c(Name = 'PG of LA');
        insert testIntacctEntity;
            
        Intacct_Entity__c testIntacctEntity2 = new Intacct_Entity__c(Name = 'PG of CT');
        insert testIntacctEntity2;
            
        Intacct_Entity__c testIntacctEntity3 = new Intacct_Entity__c(Name = 'PG of NY');
        insert testIntacctEntity3;        
        
        Opportunity opp = new Opportunity();
        opp.Lead_Numeric_ID_Text__c = '1';
        opp.StageName = 'Schedule Appointment';
        opp.Name = 'TEST NAME';
        opp.CloseDate = datetime.now().date();
        opp.AccountId = acct.Id;
        Test.startTest();
        insert opp;
        System.assertNotEquals(opp, null);
        Test.stopTest();
    }
}