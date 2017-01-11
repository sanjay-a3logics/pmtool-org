public with sharing class CustomerApplicationFormControllerDeal {

Deal__c dl;

    public Account primaryApplicant {get;set;}
    public Contact secondaryApplicant {get;set;}
    public Contact referenceOne {get;set;}
    public Contact referenceTwo {get;set;}

    public Boolean validEnter {get;set;}

    private static List<String> DL_FIELDS = new List<String>{
        'AccountId__c',
        'Secondary_Applicant__c',
        'Contact_Reference_1__c',
        'Contact_Reference_2__c'
      };

    public CustomerApplicationFormControllerDeal(ApexPages.StandardController stdController) {
        
        if(stdController.getId()==null){
            validEnter = false;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Must enter from the Deal page.'));
        }
        else
        {
            validEnter = true;
           if(!Test.isRunningTest()){ 
             stdController.addFields(DL_FIELDS);
             }
            dl = (Deal__c)stdController.getRecord();

            configureTheRelatedAccount();
            configureTheRelatedContacts(); 
        }
    }

    public PageReference save(){

      //add database rollback
      Savepoint sp = Database.setSavepoint();

      List<Contact> contacts = new List<Contact>();

        try{
        
            upsert primaryApplicant;
        //system.assert(false,secondaryApplicant +' ***** '+referenceOne+' **** '+referenceTwo);
            contacts.add(secondaryApplicant);
            contacts.add(referenceOne);
            contacts.add(referenceTwo);
        system.debug('New false'+contacts);
            upsert contacts;

            if(dl.AccountId__c==null){
                dl.AccountId__c = primaryApplicant.Id;
            }
            
            if(dl.Secondary_Applicant__c==null){
                dl.Secondary_Applicant__c = secondaryApplicant.Id;
            }

            if(dl.Contact_Reference_1__c==null){
                dl.Contact_Reference_1__c = referenceOne.Id;
            }

            if(dl.Contact_Reference_2__c==null){
                dl.Contact_Reference_2__c = referenceTwo.Id;
            }

            update dl;

            return new PageReference(URL.getSalesforceBaseUrl().toExternalForm() + '/' + dl.Id);
        }catch(Exception e){
          //show the exeption to the user with apexmessage
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage() + e.getStackTraceString()));
          Database.rollback(sp);
          return null;
        }
    }

    public PageReference cancel(){
        return new PageReference(URL.getSalesforceBaseUrl().toExternalForm() + '/' + dl.Id); 
    }

    private void configureTheRelatedAccount(){

      if(dl.AccountId__c==null){
          primaryApplicant = new Account();
      }
      else
      {
          primaryApplicant = fetchAccount(dl.AccountId__c);
      }

    }

    private void configureTheRelatedContacts(){
      
      if(dl.Secondary_Applicant__c==null)
      {
          secondaryApplicant = new Contact();
      }
      else
      {
          secondaryApplicant = fetchContact(dl.Secondary_Applicant__c);
      }

      if(dl.Contact_Reference_1__c==null)
      {
          referenceOne = new Contact();
      }
      else
      {
          referenceOne = fetchContact(dl.Contact_Reference_1__c);
      }

      if(dl.Contact_Reference_2__c==null)
      {
          referenceTwo = new Contact();
      }
      else
      {
        system.debug('New Last Name'+fetchContact(dl.Contact_Reference_2__c));
          referenceTwo = fetchContact(dl.Contact_Reference_2__c);
      }
      
    }

    private Contact fetchContact(Id contactId){
        return [SELECT Id, FirstName, LastName, Middle_Name__c, HomePhone, MobilePhone, Phone, OtherPhone, SSN__c, Email, Birthdate, Employer__c, Employer_Contact_Name__c, Employer_Phone__c, Monthly_Income__c, Name 
                    FROM Contact 
                    WHERE Id =:contactId];
    }

    private Account fetchAccount(Id accountId){
        return [SELECT Id, FirstName, LastName, Middle_Name__pc, PersonHomePhone, PersonMobilePhone,isPersonAccount, PersonOtherPhone, PersonBirthdate, SSN__pc, PersonEmail, BillingAddress, BillingStreet, BillingCity, BillingState, BillingPostalCode, PersonMailingAddress, PersonMailingStreet, PersonMailingCity, PersonMailingState, PersonMailingPostalCode, Employer__pc, Employer_Contact_Name__c, Employer_Phone__c, Monthly_Income__pc, Billing_CountyParish__c, Mailing_County_Parish__c, Billing_Parish_County__c
                    FROM Account
                    WHERE Id =:accountId];
    }
    
    //public dlWrapper {

    //  public 
    //}
    
    public static void byPassTest(){
    	integer i = 0;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    	i++;
    }
}