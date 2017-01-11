@isTest
private class TestTriggers{
    static testMethod void testLeadTrigger(){
        test.startTest();
            Lead l = new Lead();
            l.Status = 'Open';
            l.Company = 'Test Company';
            l.Firstname = 'first';
            l.LastName = 'Tester';
            l.Street = '1245 A Street';
            l.City = 'San Francisco';
            l.State = 'California';
            l.PostalCode = '94123';
            l.Country = 'United States';
            l.LeadSource = 'Web';
            l.SNSolutionID__c = '5254';
            l.SNProjectID__c = '19151';
            l.SolarNexus_Proposal_Fetched__c = false;
            insert l;
            system.assert(l.id!=null);
            
       test.stopTest();
    }
    
    static testMethod void testTaskger(){
        test.startTest();
            Lead l = new Lead();
            l.Status = 'Open';
            l.Company = 'Test Company';
            l.Firstname = 'first';
            l.LastName = 'Tester';
            l.Street = '1245 A Street';
            l.City = 'San Francisco';
            l.State = 'California';
            l.PostalCode = '94123';
            l.Country = 'United States';
            l.LeadSource = 'Web';
            l.SNSolutionID__c = '5254';
            l.SNProjectID__c = '19151';
            l.SolarNexus_Proposal_Fetched__c = false;
            insert l;
            system.assert(l.id!=null);
            
            Task task = new Task();
            task.Subject = 'Call';
            task.Status = 'Completed';
            task.WhoId = l.id;
            insert task;
            system.assert(task.id!=null);
            
            Task task1 = new Task();
            task1.Subject = 'Call';
            task1.Status = 'Completed';
            task1.WhoId = l.id;
            insert task1;
            system.assert(task1.id!=null);
            
       test.stopTest();
    }
}