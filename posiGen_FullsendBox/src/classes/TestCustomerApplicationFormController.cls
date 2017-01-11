@isTest
public class TestCustomerApplicationFormController{
  
  public static testmethod void Test1(){
     
        Account acc =new Account();
        acc.name = 'irfan khan';
        insert acc;
    
        List<String> opplst = new List<String>{'AccountId',
        'Secondary_Applicant__c',
        'Contact_Reference_1__c',
        'Contact_Reference_2__c'};
        
        
        Contact con = new Contact(LastName='Ly', FirstName='Tung',Email='tly@abc.com');
        insert con;
        
        Opportunity opp = new Opportunity();
        opp.Name = 'Test OPP';
        opp.StageName ='Closed Won';
        opp.CloseDate= date.Today();
        opp.AccountId = acc.id;
        opp.Secondary_Applicant__c=con.id;
        opp.Contact_Reference_1__c=con.id;
        insert opp;
       
       
        
        
        
        
        
        ApexPages.StandardController sc = new ApexPages.StandardController(opp);
        CustomerApplicationFormController  caf= new CustomerApplicationFormController(sc);
        caf.save();
        caf.cancel();
     
  
  }
 public static testmethod void Test2(){
     
        Account acc =new Account();
        acc.name = 'irfan khan';
        insert acc; 
    
        List<String> opplst = new List<String>{'AccountId',
        'Secondary_Applicant__c',
        'Contact_Reference_1__c',
        'Contact_Reference_2__c'};
        
        Opportunity opp = new Opportunity();
       
        
        Contact con = new Contact(LastName='Ly', FirstName='Tung',Email='tly@abc.com');
        insert con;
        
        ApexPages.StandardController sc = new ApexPages.StandardController(opp);
        CustomerApplicationFormController  caf= new CustomerApplicationFormController(sc);
        caf.save();
       // caf.cancel(); 
  }
 
  public static testmethod void Test3(){
     
        Account acc =new Account();
        acc.name = 'irfan khan';
        
    
        List<String> opplst = new List<String>{'AccountId',
        'Secondary_Applicant__c',
        'Contact_Reference_1__c',
        'Contact_Reference_2__c'};
        
        Contact con = new Contact(LastName='Ly', FirstName='Tung',Email='tly@abc.com');
        
        
        Opportunity opp = new Opportunity();
        opp.Name = 'Test OPP';
        opp.StageName ='Closed Won';
        opp.CloseDate= date.Today();
        opp.AccountId = acc.id;
        opp.Secondary_Applicant__c=con.id;
        opp.Contact_Reference_1__c=con.id;
        insert opp;
        
        
        
        ApexPages.StandardController sc = new ApexPages.StandardController(opp);
        CustomerApplicationFormController  caf= new CustomerApplicationFormController(sc);
        caf.save();
       // caf.cancel(); 
  } 


}