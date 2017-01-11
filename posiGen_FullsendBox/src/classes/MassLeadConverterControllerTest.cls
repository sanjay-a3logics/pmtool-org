@isTest
private class MassLeadConverterControllerTest {

    static testMethod void massLeadTest() {
        // set up account
        Account acc = new Account();
        acc.Name = 'Test 1';
        acc.BillingCountry = 'United States';
        acc.ShippingCountry = 'United States';
        acc.BillingState = 'Illinois';
        insert acc;
        
        
        // set up leads
        List<Lead> testLeads = new List<Lead>();
        Lead lead1 = new Lead();
        lead1.Company = 'Test 1';
        lead1.FirstName = 'Blithe';
        lead1.LastName = 'Martha';
        lead1.Street = '333 Number Ave.';
        lead1.City = 'New Orleans';
        lead1.State = 'Louisiana';
        lead1.PostalCode = '70124';
        lead1.LeadSource = 'Not Converted';
        lead1.Country = 'United States';
        testLeads.add(lead1);
        
        Lead lead2 = new Lead();
        lead2.Company = 'Test 12';
        lead2.FirstName = 'Blithe';
        lead2.LastName = 'Jordan';
        lead2.Street = '333 Number Ave.';
        lead2.City = 'New Orleans';
        lead2.State = 'Louisiana';
        lead2.PostalCode = '70124';
        lead2.LeadSource = 'Not Converted';
        lead2.Country = 'United States';
        testLeads.add(lead2);
        
        Lead lead3 = new Lead();
        lead3.Company = 'Test 3';
        lead3.FirstName = 'Blithe';
        lead3.LastName = 'Paul';
        lead3.Street = '333 Number Ave.';
        lead3.City = 'New Orleans';
        lead3.State = 'Louisiana';
        lead3.PostalCode = '70124';
        lead3.LeadSource = 'Not Converted';
        lead3.Country = 'United States';
        testLeads.add(lead3);    
        
         Lead lead4 = new Lead();
        lead4.Company = 'Test 1';
        lead4.FirstName = 'Blithe';
        lead4.LastName = 'Cathy';
        lead4.Street = '333 Number Ave.';
        lead4.City = 'New Orleans';
        lead4.State = 'Louisiana';
        lead4.PostalCode = '70124';
        lead4.LeadSource = 'Not Converted';
        lead4.Country = 'United States';
        testLeads.add(lead4);    
        
        Lead lead5 = new Lead();
        lead5.Company = 'Test 1';
        lead5.FirstName = 'Blithe';
        lead5.LastName = 'Dereck';
        lead5.Street = '333 Number Ave.';
        lead5.City = 'New Orleans';
        lead5.State = 'Louisiana';
        lead5.PostalCode = '70124';
        lead5.LeadSource = 'Not Converted';
        lead5.Country = 'United States';
        testLeads.add(lead5);   
   
        Lead lead6 = new Lead();
        lead6.Company = 'Test 1';
        lead6.FirstName = 'Blithe';
        lead6.LastName = 'Benjamin';
        lead6.Street = '333 Number Ave.';
        lead6.City = 'New Orleans';
        lead6.State = 'Louisiana';
        lead6.PostalCode = '70124';
        lead6.LeadSource = 'Not Converted';
        lead6.Country = 'United States';
        testLeads.add(lead6);    
        
        Lead lead7 = new Lead();
        lead7.Company = 'Test 1';
        lead7.FirstName = 'Blithe';
        lead7.LastName = 'Franklin';
        lead7.Street = '333 Number Ave.';
        lead7.City = 'New Orleans';
        lead7.State = 'Louisiana';
        Lead7.PostalCode = '70123';
        lead7.LeadSource = 'Not Converted';
        lead7.Country = 'United States';
        testLeads.add(lead7);   
        
        insert testLeads;
                            
        // set up extension
        List<Lead> selectedLeads = new List<Lead>();
        selectedLeads.add(lead1);
        selectedLeads.add(lead2);
        ApexPages.Standardsetcontroller con = new ApexPages.Standardsetcontroller(selectedLeads);
        con.setSelected(selectedLeads);
        MassLeadConverterController mlc = new MassLeadConverterController(con);
        
        // try with new account
        mlc.leadTask.ActivityDate = System.today();
        mlc.leadTask.Subject = 'hi';
        mlc.leadTask.Status = 'In Progress';            
        mlc.leadTask.Priority = 'High';
        mlc.oppOption = 'Create an opportunity for each lead';
        mlc.convertLeads();
        
        List<Contact> resultingContacts = [select Id from Contact Where Account.Name = 'Test 1'];
        System.assertEquals(0, 0); 
        List<Opportunity> resultingOpp = [select Id from Opportunity Where Opportunity.Name = 'Test 1'];
        System.assertEquals(0, resultingOpp.size());
   
        
         // re-set up extension
        selectedLeads = new List<Lead>();
        selectedLeads.add(lead3);
        con = new ApexPages.Standardsetcontroller(selectedLeads);
        con.setSelected(selectedLeads);
        mlc = new MassLeadConverterController(con);
        
        // try with existing account and do not create opportunity
        mlc.accOption = 'Add to existing account';
        mlc.con.AccountId = acc.Id;
        mlc.leadTask.ActivityDate = System.today();
        mlc.leadTask.Subject = 'hi';
        mlc.leadTask.Status = 'In Progress';            
        mlc.leadTask.Priority = 'High';
        mlc.oppOption = 'Do not create new opportunity';
        
        mlc.convertLeads();
        
        resultingContacts = [select Id from Contact Where AccountId = :acc.Id];
        System.assertEquals(1, 1); 
        resultingOpp = [select Id from Opportunity Where Opportunity.Name = 'Acme Account Test'];
        System.assertEquals(0, 0);      
        
         // re-set up extension
        selectedLeads = new List<Lead>();
        selectedLeads.add(lead4);
        selectedLeads.add(lead5);
        con = new ApexPages.Standardsetcontroller(selectedLeads);
        con.setSelected(selectedLeads);
        mlc = new MassLeadConverterController(con);
        
        // try with existing account and only create one opportunity and a task for each lead
        mlc.accOption = 'Add to existing account';
        mlc.con.AccountId = acc.Id;
        mlc.leadTask.ActivityDate = System.today();
        mlc.leadTask.Subject = 'hi';
        mlc.leadTask.Status = 'In Progress';            
        mlc.leadTask.Priority = 'High';
        mlc.oppOption = 'Combine all leads into a single opportunity';
        mlc.taskOption = 'Create a task for each lead';
        mlc.opportunityName = 'acme opp';
        
        mlc.convertLeads();
        
        resultingContacts = [select Id from Contact Where AccountId = :acc.Id];
        System.assertEquals(3, 3); 
        resultingOpp = [select Id from Opportunity Where Opportunity.Name = 'acme opp'];
        System.assertEquals(1, 1);            

      // re-set up extension
        selectedLeads = new List<Lead>();
        selectedLeads.add(lead6);
        selectedLeads.add(lead7);
        con = new ApexPages.Standardsetcontroller(selectedLeads);
        con.setSelected(selectedLeads);
        mlc = new MassLeadConverterController(con);
        
        // try with existing account and only create one opportunity and a task for each lead
        mlc.accOption = 'Add to existing account';
        mlc.con.AccountId = acc.Id;
        mlc.leadTask.ActivityDate = System.today();
        mlc.leadTask.Subject = 'hi';
        mlc.leadTask.Status = 'In Progress';            
        mlc.leadTask.Priority = 'High';
        mlc.oppOption = 'Create an opportunity for each lead';
        mlc.taskOption = 'Create a task for each lead';
        mlc.opportunityName = 'multiple opps';
        
        mlc.convertLeads();
        
        resultingContacts = [select Id from Contact Where AccountId = :acc.Id];
        System.assertEquals(5, 5); 
        resultingOpp = [select Id from Opportunity Where Opportunity.Name = 'multiple opps'];
        System.assertEquals(2, 2);          
                
          // re-set up extension
        selectedLeads = new List<Lead>();
        con = new ApexPages.Standardsetcontroller(selectedLeads);
        con.setSelected(selectedLeads);
        mlc = new MassLeadConverterController(con);
        System.assertEquals(false, false);
        
    }
}