@isTest 
public class testOpportunityTriggers {
    static testMethod void testUpdateIntacctEntityFromAcctState()
    {
        /*
         *  Constants
         */
        
        final Date closeDate = date.newInstance(2014,11, 18);
        
        /*
         *  User running the test.
         */ 
        
        User u1 = [SELECT Id FROM User WHERE Alias = 'susco'];
        
        /*
         *  Begin test.
         */ 
        
        System.runAs(u1) 
        {
/*
             *  Test Intacct Entity initiations.
            */
            
            Intacct_Entity__c testIntacctEntity = new Intacct_Entity__c(Name = 'PG of LA');
            insert testIntacctEntity;
            
            Intacct_Entity__c testIntacctEntity2 = new Intacct_Entity__c(Name = 'PG of CT');
            insert testIntacctEntity2;
            
            Intacct_Entity__c testIntacctEntity3 = new Intacct_Entity__c(Name = 'PG of NY');
            insert testIntacctEntity3;
            
            /*
             *  Test Account initiations.
             */ 
            
            Account testAcct = new Account(LastName = 'Test Account', FirstName = 'Trigger', BillingState = 'Louisiana', BillingCountry = 'United States');
            insert testAcct;
            System.debug(testAcct.BillingState);
            
            Account testAcct2 = new Account(LastName = 'Test Account 2', FirstName = 'Trigger', BillingState = 'Connecticut', BillingCountry = 'United States');
            insert testAcct2;
            
            Account testAcct3 = new Account(LastName = 'Test Account 3', FirstName = 'Trigger', BillingState = 'New York', BillingCountry = 'United States');
            insert testAcct3;
            
            /*
             *  Test Opportunity initiations.
             */ 
            
            Opportunity testOpp = new Opportunity(Name = 'Test Opp', AccountId = testAcct.Id, StageName = 'Schedule Appointment', CloseDate = closeDate);
            insert testOpp;
            System.debug(testOpp.Account_State__c);
            
            Opportunity testOpp2 = new Opportunity(Name = 'Test Opp 2', AccountId = testAcct2.Id, StageName = 'Schedule Appointment', CloseDate = closeDate);
            insert testOpp2;
            
            Opportunity testOpp3 = new Opportunity(Name = 'Test Opp 3', AccountId = testAcct3.Id, StageName = 'Schedule Appointment', CloseDate = closeDate);
            insert testOpp3;
            

			
            
            /*
             *  Update Opportunities to run trigger.
             */ 
            Test.startTest();
            
            testOpp.StageName = 'Reschedule Appointment';
            update testOpp;
            //System.debug(testOpp.Intacct_Entity__c);
            testOpp2.StageName = 'Reschedule Appointment';
            update testOpp2;
            
            testOpp3.StageName = 'Reschedule Appointment';
            update testOpp3;
            
            Test.stopTest();
            
            Opportunity testOppLA = [SELECT Id, Intacct_Entity__c, Account_State__c, AccountId FROM Opportunity WHERE Id = :testOpp.Id];
            //System.debug(testOppLA.AccountId);
            Opportunity testOppCT = [SELECT Id, Intacct_Entity__c FROM Opportunity WHERE Id = :testOpp2.Id];
            Opportunity testOppNY = [SELECT Id, Intacct_Entity__c FROM Opportunity WHERE Id = :testOpp3.Id];
            
            testIntacctEntity = [SELECT Id, Name FROM Intacct_Entity__c WHERE Name = 'PG of LA'];
            testIntacctEntity2 = [SELECT Id, Name FROM Intacct_Entity__c WHERE Name = 'PG of CT'];
            testIntacctEntity3 = [SELECT Id, Name FROM Intacct_Entity__c WHERE Name = 'PG of NY'];
            //System.debug(testOppLA.Intacct_Entity__c);
            System.assertEquals(testOppLA.Intacct_Entity__c, testIntacctEntity.Id);
            System.assertEquals(testOppCT.Intacct_Entity__c, testIntacctEntity2.Id);
            System.assertEquals(testOppNY.Intacct_Entity__c, testIntacctEntity3.Id);
        }
    }
}