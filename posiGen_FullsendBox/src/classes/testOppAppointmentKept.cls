@isTest
public class testOppAppointmentKept {
    /*static testMethod void testTaskToOppTriggers() 
    {
        final Date opportunityDate = date.newInstance(2014,11,3);
        
        User u1 = [SELECT Id FROM User WHERE Alias='susco'];
        
        System.RunAs(u1) 
        {
            User LAOwner = [SELECT Id, Division FROM User WHERE Division = 'Metairie' LIMIT 1];
            
            Account testAcct = new Account(LastName = 'Test Account', FirstName = 'Trigger');
            insert testAcct;
            
			Opportunity testOpp = new Opportunity(Name = 'Test', Account = testAcct, StageName = 'Schedule Appointment', CloseDate = opportunityDate);
            insert testOpp;
            
            Intacct_Entity__c testLAIntacctEntity = new Intacct_Entity__c(Name = 'PG of LA');
            insert testLAIntacctEntity;
            Intacct_Entity__c testCTIntacctEntity = new Intacct_Entity__c(Name = 'PG of CT');
            insert testCTIntacctEntity;
            Intacct_Entity__c testNYIntacctEntity = new Intacct_Entity__c(Name = 'PG of NY');
            insert testNYIntacctEntity;
            
            RecordType salesAppointmentRecordType = [SELECT Id FROM RecordType WHERE Name = 'Sales Appointment' AND SobjectType='Event' LIMIT 1];
            
			
            
            Date startDate = Date.newInstance(2014, 11, 5);
            Time startTime = Time.newInstance(1, 0, 0, 0);
            Date endDate = Date.newInstance(2014, 11, 5);
            Time endTime = Time.newInstance(2, 0, 0, 0);
            
            Event testEvent = new Event();
            testEvent.WhatId = testOpp.Id;
            testEvent.OwnerId = LAOwner.Id;
            testEvent.Subject = 'Appointment';
            testEvent.Type = 'Call - Scheduled';
            testEvent.StartDateTime = Datetime.newInstance(startDate, startTime);
            testEvent.EndDateTime = Datetime.newInstance(endDate, endTime);
            testEvent.RecordTypeId = salesAppointmentRecordType.Id;
            //testEvent.Status = 'Not Started';
            //testEvent.Priority = 'Normal';
            testEvent.Client_Signed__c = 'Yes';
            insert testEvent;
            
            testEvent.Appointment_Kept__c = 'Yes';
            update testEvent;
            
            testOpp = [SELECT Id, Name, Appointment_Kept__c FROM Opportunity WHERE Id = :testOpp.Id];
            
            //Intacct_Entity__c testIntacctEntity = [SELECT Id, Name FROM Intacct_Entity__c WHERE Name = 'PG of LA' LIMIT 1];

            System.assertEquals(testOpp.Appointment_Kept__c, TRUE);
        }
    }*/
}