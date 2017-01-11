@isTest (SeeAllData=true)
public class Test_ReferralManagementApp {
    
static testMethod void testReferralInsertion()
    {
        final Date closeDate = date.newInstance(2014, 8, 11);
        
        
        User u1 = [SELECT Id FROM User WHERE Alias='susco'];
        
        System.runAs(u1) {
            
            test.startTest();
            Intacct_Entity__c testIntacctEntity = new Intacct_Entity__c(Name = 'PG of LA');
            insert testIntacctEntity;
            
            Intacct_Entity__c testIntacctEntity2 = new Intacct_Entity__c(Name = 'PG of CT');
            insert testIntacctEntity2;
            
            Intacct_Entity__c testIntacctEntity3 = new Intacct_Entity__c(Name = 'PG of NY');
            insert testIntacctEntity3; 
            
            RecordType referralProgramCampaign = [SELECT Id FROM RecordType WHERE Name = 'Referral Programs' AND sObjectType = 'Campaign' LIMIT 1];
            
            Campaign referralCampaign = new Campaign (Name = 'Test Referral Campaign', IsActive = TRUE, Type = 'Referral Campaign', Amount_Paid_Out_For_Each_Referee__c = 100, StartDate = closeDate
                                                     , RecordTypeId = referralProgramCampaign.Id, Allows_For_Multiple_Members__c = FALSE);
            insert referralCampaign;
            
            Opportunity testOpp = [SELECT Id, Name, Referrer__c, LeadSource, Referral_Type__c FROM Opportunity WHERE Name = 'Brock Lee- 12345 Main St.'];
            Account testReferrer = [SELECT Id, FirstName, LastName FROM Account WHERE LastName = 'Jones' LIMIT 1];
            Account testReferrer2 = [SELECT Id, FirstName, LastName FROM Account WHERE LastName = 'Smith' LIMIT 1];
            
            
            
            testOpp.Referrer__c = testReferrer.Id;
            testOpp.LeadSource = 'Referral';
            testOpp.Referral_Type__c = 'Single';
            update testOpp;
            
            
            
            testOpp = [SELECT Id, Referral__c, Referrer__c FROM Opportunity WHERE Id = : testOpp.Id ];
            Test.stopTest();
            
            //Campaign referral = [SELECT Id, HierarchyNumberOfContacts FROM Campaign WHERE Opportunity_For_Single_Referral__c = : testOpp.Id];
            
            System.assert(testOpp.Referral__c != null,  testOpp.Referrer__c);
            //System.assertEquals(1, referral.HierarchyNumberOfContacts);
            /*
            Campaign referral = [SELECT Id, Referrer__c FROM Campaign WHERE Opportunity_For_Single_Referral__c = : testOpp.Id];
            referral.Referrer__c = testReferrer2.Id;
            update referral;
            
            referral = [SELECT Id, Referrer__c FROM Campaign WHERE Id = : referral.Id];
            System.assertEquals(testReferrer2.Id, referral.Referrer__c);*/
 			/*
            RecordType referralAccount = [SELECT Id FROM RecordType WHERE Name = 'Referral Account' AND sObjectType = 'Account' LIMIT 1];
            RecordType referralProgramCampaign = [SELECT Id FROM RecordType WHERE Name = 'Referral Programs' AND sObjectType = 'Campaign' LIMIT 1];
            RecordType personAccount = [SELECT Id FROM RecordType WHERE Name = 'Person Account' AND sObjectType = 'Account' LIMIT 1];
            
            Account municipality = [SELECT Id FROM Account WHERE Name = 'Orleans Parish, LA'];
            Account testReferrer = new Account (LastName = 'Referrer', FirstName = 'Jeff');
            insert testReferrer;
            
            Campaign referralCampaign = new Campaign (Name = 'Test Referral Campaign', IsActive = TRUE, Type = 'Referral Campaign', Amount_Paid_Out_For_Each_Referee__c = 100, StartDate = closeDate
                                                      , RecordTypeId = referralProgramCampaign.Id, Allows_For_Multiple_Members__c = FALSE);
            insert referralCampaign;
            
            Lead testLead = new Lead();
            testLead.FirstName = 'Mike';
            testLead.LastName = 'The Referred';
            testLead.Municipality__c = municipality.id;
            testLead.Status = 'Open';
            testLead.Phone = '(504)555-1234';
            testLead.LeadSource = 'Referral';
            testLead.Referral_Type__c = 'Single';
            testLead.Referring_Customer__c = testReferrer.Id;
            insert testLead;
            
            Database.LeadConvert lc = new Database.LeadConvert();
            lc.setLeadId(testLead.Id);
                    
            LeadStatus convertStatus = [Select Id, MasterLabel FROM LeadStatus WHERE MasterLabel = 'Qualified' LIMIT 1];
        	lc.setConvertedStatus(convertStatus.MasterLabel);
            
            Database.LeadConvertResult lcr = Database.convertLead(lc);
            
            

            
           // Account testAccount = [new Account (LastName = 'The Referred', FirstName = 'Mike', RecordTypeId = personAccount.Id)];
            //insert testAccount;
            //System.debug(testAccount);
            

            
            //Opportunity testOpp = new Opportunity (Name = 'Test Opp at Blank Location', Account = testAccount, Referrer__c = testReferrer.Id, LeadSource = 'Referral', Referral_Type__c = 'Single'
            //                                       , StageName = 'Schedule Appointment', CloseDate = closeDate);
            //insert testOpp;
            
            //testOpp.Are_black_panels_required__c = TRUE;
            //update testOpp;
            
            Opportunity testOpp = [SELECT Id, Referral__c FROM Opportunity WHERE Name = : lc.OpportunityName ];
            
            Campaign referral = [SELECT Id FROM Campaign WHERE Opportunity_For_Single_Referral__c = : testOpp.Id];
            
            System.assert(testOpp.Referral__c != null);
            System.assertEquals(1, referral.HierarchyNumberOfContacts);
*/
        }
    }
}