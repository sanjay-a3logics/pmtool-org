@isTest //(SeeAllData=true)
public class TestTaskToOppTriggers {
/*    static testMethod void testTaskToOppTriggers() 
    {
        final Date opportunityDate = date.newInstance(2014,10,6);
        final Date startDate = date.newInstance(2014, 11, 5);
        final Date endDate = date.newInstance(2014, 11, 5);
        final Time startTime = time.newInstance(1, 0, 0, 0);
        final Time endTime = time.newInstance(1, 0, 0, 0);
        
        
        
        User u1 = [SELECT Id FROM User WHERE Alias='susco'];
        
        System.RunAs(u1) 
        {
            User LAOwner = [SELECT Id, Division FROM User WHERE Division = 'Metairie' LIMIT 1];
            
            Intacct_Entity__c testLAIntacctEntity = new Intacct_Entity__c(Name = 'PG of LA');
            insert testLAIntacctEntity;
            Intacct_Entity__c testCTIntacctEntity = new Intacct_Entity__c(Name = 'PG of CT');
            insert testCTIntacctEntity;
            Intacct_Entity__c testNYIntacctEntity = new Intacct_Entity__c(Name = 'PG of NY');
            insert testNYIntacctEntity;
            
            Account testAcct = new Account(LastName = 'Test Account', FirstName = 'Trigger');
            insert testAcct;
            
			Opportunity testOpp = new Opportunity(Name = 'Test', Account = testAcct, StageName = 'Schedule Appointment', CloseDate = opportunityDate);
            insert testOpp;
            
            RecordType salesAppointmentRecordType = [SELECT Id FROM RecordType WHERE Name = 'Sales Appointment' AND SobjectType='Event' LIMIT 1];
            
            Event testEvent = new Event();
            testEvent.WhatId = testOpp.Id;
            testEvent.OwnerId = LAOwner.Id;
            testEvent.Subject = 'Appointment';
            testEvent.Type = 'Call - Scheduled';
            testEvent.StartDateTime = Datetime.newInstance(startDate, startTime);
            testEvent.EndDateTime = Datetime.newInstance(endDate, endTime);
            testEvent.RecordTypeId = salesAppointmentRecordType.Id;
            insert testEvent;
            /*
            Task testTask = new Task();
            testTask.WhatId = testOpp.Id;
            testTask.OwnerId = LAOwner.Id;
            testTask.Subject = 'Appointment';
            testTask.Type = 'Call - Scheduled';
            testTask.Status = 'Not Started';
            testTask.Priority = 'Normal';
            insert testTask;
            
            testOpp = [SELECT Id, Name, Intacct_Entity__c FROM Opportunity WHERE Id = :testOpp.Id];
            Intacct_Entity__c entityLouisiana = [SELECT Id, Name FROM Intacct_Entity__c WHERE Name = 'PG of LA'];
            
            //Intacct_Entity__c testIntacctEntity = [SELECT Id, Name FROM Intacct_Entity__c WHERE Name = 'PG of LA' LIMIT 1];

            System.assertEquals(testOpp.Intacct_Entity__c, entityLouisiana.Id);
        }
    }*/
}