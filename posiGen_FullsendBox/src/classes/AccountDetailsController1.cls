//Controller Class for AccountDetails

Public without sharing class AccountDetailsController1{

    public AccountDetailsController1(ApexPages.StandardController controller) {

    }
       
    //Class Instances (get,set)
    
    Public String accountId {get;set;}  
    Public Account accRecord {get;set;} 
    Public List<SelectOption> listProjMan {get;set;} 
    Public String selMan {get;set;}
    Public List<SelectOption> listAccMan {get;set;} 
    Public String selAcc {get;set;}
    Public List<Account > allAccounts {get;set;}  
    Set<String> lstPMSet = new Set<String>();  
    
    private integer counter=0;  //keeps track of the offset
    private integer list_size=11; //sets the page size or number of rows
    Public integer total_size;  
    
         
    //constructor
    Public AccountDetailsController1()
    {         
        List<opportunity> lstPM = new List<opportunity >();   
        lstPM = [select Project_manager__r.name from opportunity where Project_manager__r.name != null limit 1000]; 
        
        List<Account> accountRecords = [Select id, Name,BillingCountry,phone, BillingStreet, AccountNumber,BillingCity, BillingAddress, BillingState, BillingPostalCode, PersonMobilePhone, PersonEmail, PersonHomePhone From Account order by name limit 1];
        accountId = accountRecords[0].Id;  
        getAccountDetails();       
                       
        lstPMSet.add('-None-');                       
        for(Opportunity op : lstPM) {  
            lstPMSet.add(op.Project_manager__r.name);            
        }
       
        listProjMan = new List<SelectOption>();
        for(String op : lstPMSet) {
            listProjMan.add(new SelectOption(op,op));
        }
        selMan = '-None-';
        listAccMan = new List<SelectOption>(); 
        selAcc = '-None-';            
        
        listAccMan.add(new SelectOPtion('-None-','-None-'));
        listAccMan.add(new SelectOption('I am Account Manager, 11-30','I am Account Manager, 11-30'));
        listAccMan.add(new SelectOption('I am Account Manager, 31-60','I am Account Manager, 31-60'));
        listAccMan.add(new SelectOption('I am Account Manager, 61-90','I am Account Manager, 61-90'));
        listAccMan.add(new SelectOption('I am Account Manager, 91-180','I am Account Manager, 91-180'));
        listAccMan.add(new SelectOption('I am Account Manager, 180+','I am Account Manager, 180+'));
        
        total_size = [Select count() From Account]; 

    }
    
    
    Public List<Account> getAccounts() {
      try {
         List<Account> accountRecords = [Select id, Name,BillingCountry, phone,BillingStreet, AccountNumber,BillingCity, BillingAddress, BillingState, BillingPostalCode, PersonMobilePhone, PersonEmail, PersonHomePhone From Account order by name limit :list_size offset :counter];
           
         return accountRecords;
         
      } catch (QueryException e) {
         ApexPages.addMessages(e);   
         return null;
      }
   }
   
   Public PageReference first() { //user clicked beginning
      counter = 0;
      return null;
   }

   Public PageReference Previous() { //user clicked previous button
      counter -= list_size;
      return null;
   }

   Public PageReference Next() { //user clicked next button
      counter += list_size;
      return null;
   }

   Public PageReference last() { //user clicked end
      counter = total_size - math.mod(total_size, list_size);
      counter = counter - 1;
      return null;
   }

   Public Boolean getDisablePrevious() { 
      //this will disable the previous and beginning buttons
      if (counter>0) return false; else return true;
   }

   Public Boolean getDisableNext() { //this will disable the next and end buttons
      if (counter + list_size < total_size) return false; else return true;
   }  
   
   Public Integer getTotal_size() {
      return total_size;
   }

      
    /*
    Fetch specific account details when clicked on Account name
    */  
    Public void getAccountDetails()                         
    {                 
        accRecord = [Select id, NVMContactWorld__NVM_Phone__c, phone, Name,  BillingCountry, BillingStreet, AccountNumber,BillingCity, BillingAddress, BillingState, BillingPostalCode, PersonMobilePhone, PersonEmail, PersonHomePhone,  (Select id, Name from Contacts), (Select id, CaseNumber, CaseAgeDays__c, Status From cases), (Select id, Name,  Days_Delinquent__c, Total_Past_Due__c From LD_Leases__r), (Select id, Name, System_Size_in_KW__c, Solar_Product__c, Numeric_ID__c from opportunities) From Account Where Id =: accountId];  
    }  
    Public void resetAccs() {
        accRecord = null;
    }
    
    /*
    Filter accounts when different filters are selected
    */
    
    Public void filterAccs()
    {   
       
        List<LD_Lease__c> lease = new List<LD_Lease__c>();
        Set<ID> leaseId = new Set<Id>();
        Set<ID> leaseAccsSet = new Set<Id>();
        accRecord = null;
        try {
            
            //If Both filters are not selected
            
            if(selMan == '-None-' && selAcc == '-None-') {
                allAccounts = [Select id, Name,BillingCountry, BillingStreet, AccountNumber,BillingCity, BillingAddress, BillingState, BillingPostalCode, PersonMobilePhone, PersonEmail, PersonHomePhone,  (Select id, Name from Contacts), (Select id, CaseNumber, CaseAgeDays__c, Status From cases), (Select id, Name,  Days_Delinquent__c, Total_Past_Due__c From LD_Leases__r), (Select id, Name, System_Size_in_KW__c, Solar_Product__c, Numeric_ID__c from opportunities) From Account order by name];
            }
            
            //when Project manager is filtered but account manager is not selected
            
            else if(selMan != '-None-' && selAcc == '-None-'){
                allAccounts = [Select id, Name, BillingCountry, BillingStreet, AccountNumber, BillingCity, BillingAddress, BillingState, BillingPostalCode, PersonMobilePhone, PersonEmail, PersonHomePhone,  (Select id, Name from Contacts), (Select id, CaseNumber, CaseAgeDays__c, Status From cases), (Select id, Name,  Days_Delinquent__c, Total_Past_Due__c From LD_Leases__r), (Select id, Name, project_manager__c, System_Size_in_KW__c, Solar_Product__c, Numeric_ID__c from opportunities) From Account where id in (select AccountId from opportunity where project_manager__r.name =: selMan) order by name];
            }
            
            //when Project manager is not filtered but account manager is selected
            
            else if(selMan == '-None-' && selAcc != '-None-'){
                
                if(selAcc.contains('11-30')) {
                    lease = [Select id,name,Account__c,Am_I_Concierge__c,Days_Delinquent__c From LD_Lease__c where Am_I_Concierge__c = true AND Days_Delinquent__c >= 10 AND Days_Delinquent__c <= 30 order by name];
                }
                else if(selAcc.contains('31-60')) {
                    lease = [Select id,name,Account__c,Am_I_Concierge__c,Days_Delinquent__c From LD_Lease__c where Am_I_Concierge__c = true AND Days_Delinquent__c >= 31 AND Days_Delinquent__c <= 60 order by name];
                }
                else if(selAcc.contains('61-90')) {
                    lease = [Select id,name,Account__c,Am_I_Concierge__c,Days_Delinquent__c From LD_Lease__c where Am_I_Concierge__c = true AND Days_Delinquent__c >= 61 AND Days_Delinquent__c <= 90 order by name];
                }
                else if(selAcc.contains('91-180')) {
                    lease = [Select id,name,Account__c,Am_I_Concierge__c,Days_Delinquent__c From LD_Lease__c where Am_I_Concierge__c = true AND Days_Delinquent__c >= 91 AND Days_Delinquent__c <= 180 order by name];
                }
                else {
                    lease = [Select id,name,Account__c,Am_I_Concierge__c,Days_Delinquent__c From LD_Lease__c where Am_I_Concierge__c = true AND Days_Delinquent__c > 180 order by name];
                }
                
                for(LD_Lease__c LDObj: lease) {
                    leaseId.add(LDObj.id);
                }
                
                lease = [select id, name, Account__c from LD_Lease__c where id in : leaseId];
                
                for(LD_Lease__c LD : lease) {
                    leaseAccsSet.add(LD.Account__c);
                }
                
                allAccounts = [Select id, Name, BillingCountry, BillingStreet, AccountNumber, BillingCity, BillingAddress, BillingState, BillingPostalCode, PersonMobilePhone, PersonEmail, PersonHomePhone,  (Select id, Name from Contacts), (Select id, CaseNumber, CaseAgeDays__c, Status From cases), (Select id, Name,  Days_Delinquent__c, Total_Past_Due__c From LD_Leases__r), (Select id, Name, project_manager__c, System_Size_in_KW__c, Solar_Product__c, Numeric_ID__c from opportunities) From Account where id IN : leaseAccsSet order by name];           
            }
            
            //Both filters are selected
            
            else {
            
                if(selAcc.contains('11-30')) {
                    lease = [Select id,name,Account__c,Am_I_Concierge__c,Days_Delinquent__c From LD_Lease__c where Am_I_Concierge__c = true AND Days_Delinquent__c >= 10 AND Days_Delinquent__c <= 30 order by name];
                }
                else if(selAcc.contains('31-60')) {
                    lease = [Select id,name,Account__c,Am_I_Concierge__c,Days_Delinquent__c From LD_Lease__c where Am_I_Concierge__c = true AND Days_Delinquent__c >= 31 AND Days_Delinquent__c <= 60 order by name];
                }
                else if(selAcc.contains('61-90')) {
                    lease = [Select id,name,Account__c,Am_I_Concierge__c,Days_Delinquent__c From LD_Lease__c where Am_I_Concierge__c = true AND Days_Delinquent__c >= 61 AND Days_Delinquent__c <= 90 order by name];
                }
                else if(selAcc.contains('91-180')) {
                    lease = [Select id,name,Account__c,Am_I_Concierge__c,Days_Delinquent__c From LD_Lease__c where Am_I_Concierge__c = true AND Days_Delinquent__c >= 91 AND Days_Delinquent__c <= 180 order by name];
                }
                else {
                    lease = [Select id,name,Account__c,Am_I_Concierge__c,Days_Delinquent__c From LD_Lease__c where Am_I_Concierge__c = true AND Days_Delinquent__c > 180 order by name];
                }
                for(LD_Lease__c LDObj: lease) {
                    leaseID.add(LDObj.id);
                }
                
                lease = [select id, name, Account__c from LD_Lease__c where id in : leaseId];
                
                for(LD_Lease__c LD : lease) {
                    leaseAccsSet.add(LD.Account__c);
                }
                
                allAccounts = [Select id, Name, BillingCountry, BillingStreet, AccountNumber, BillingCity, BillingAddress, BillingState, BillingPostalCode, PersonMobilePhone, PersonEmail, PersonHomePhone,  (Select id, Name from Contacts), (Select id, CaseNumber, CaseAgeDays__c, Status From cases), (Select id, Name,  Days_Delinquent__c, Total_Past_Due__c From LD_Leases__r), (Select id, Name, project_manager__c, System_Size_in_KW__c, Solar_Product__c, Numeric_ID__c from opportunities) From Account where id IN (select AccountId from opportunity where project_manager__r.name =: selMan) AND id IN : leaseAccsSet order by name];
            }
        }      
        catch(Exception ex) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Something\'s Wrong. Contact Administrator.'));
        }  
    }
}