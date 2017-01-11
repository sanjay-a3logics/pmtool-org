@isTest
class AccountDetailsControllerTest{

    @testSetup
    static void dataSetup() {
    
     Account acc= new Account(name='test1');
     insert acc;
     
     Opportunity opp = new Opportunity(name='test1', accountId=acc.Id, StageName='Schedule Appointment', Project_Manager__c=UserInfo.getUserId(), CloseDate=system.today());
     insert opp;
     
     Contact conTest= new Contact (
        FirstName = 'xyzFirst',
        LastName = 'XyZLast',
        //line changed - waveoc
        AccountId = acc.Id,
        Email = 'xyzmail@mail.com'
     );
     insert conTest;
     
     Case caseObj = new Case(
        ContactId = conTest.Id,
        AccountId = acc.Id,
        Status = 'Working',
        Origin = 'Phone'
     );
     insert caseObj; 
     
     //LD_Lease__c leaseTest= new LD_Lease__c(opportunity__c=opp.Id, Account__c= acc.Id);
     //insert leaseTest;
            
    }

    static testMethod void method1(){ 

        String accId= [Select id From Account].Id;
        AccountDetailsController adc= new AccountDetailsController();  
        adc.loadAccounts();
        adc.accountId= accId;  
        adc.getAccountDetails();
        
        adc.selAcc = '11-30';
        adc.loadAccounts();
        adc.selAcc = '31-60';
        adc.loadAccounts();
        adc.selAcc = '61-90';
        adc.loadAccounts(); 
        adc.selAcc = '91-180';
        adc.loadAccounts();
        adc.selAcc = '181-200';
        adc.loadAccounts();   
        
        adc.selMan ='I am Account Manager';
        adc.selAcc = '11-30';
        adc.loadAccounts();
        adc.selAcc = '31-60';
        adc.loadAccounts();
        adc.selAcc = '61-90';
        adc.loadAccounts(); 
        adc.selAcc = '91-180';
        adc.loadAccounts();  
        adc.selAcc = '181-200';
        adc.loadAccounts(); 
         
        adc.resetAccs();
    }
}