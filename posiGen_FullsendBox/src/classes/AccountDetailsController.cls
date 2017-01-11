//Controller Class for AccountDetails

Public without sharing class AccountDetailsController{

   
    //Class Instances (get,set)
    Public String accountId {get;set;}  
    Public List<Account > allAccounts {get;set;}    
    Public String selMan {get;set;}
    Public String selAcc {get;set;}
    Public List<SelectOption> listProjMan {get;set;} 
    Public List<SelectOption> listAccMan {get;set;} 
    Public Account accRecord {get;set;}     
    Public transient List<wrapaccount> wrapperList{get;set;} 
      
    //constructor
    Public AccountDetailsController()
    {    
        
      try{  selMan = '-None-';
            selAcc = '-None-';
            accountId ='';
            wrapperList = new List<wrapaccount>();
            /*
               Account Manager List
            */
            listProjMan = new List<SelectOption>();
            listProjMan.add(new SelectOption('-None-','-None-'));
            for(User u : [select id, name from user where userrole.name ='Account Manager' AND IsActive =true]) {    
                listProjMan.add(new SelectOption(u.id,u.name));
            }
            
            /*
                 Lease Days Delinquent List
            */  
            listAccMan = new List<SelectOption>();          
            listAccMan.add(new SelectOPtion('-None-','-None-'));
            listAccMan.add(new SelectOption('11-30','11-30'));
            listAccMan.add(new SelectOption('31-60','31-60'));
            listAccMan.add(new SelectOption('61-90','61-90'));
            listAccMan.add(new SelectOption('91-180','91-180'));
            listAccMan.add(new SelectOption('180+','180+'));
            /**
                Load Accounts
            **/
            loadAccounts();
            accountId = UserInfo.getUserId();
      }
      catch (QueryException e) {
             //ApexPages.addMessages(e);   
             system.assert(false, e.getLineNumber()+'--'+e.getMessage());
      }
    }
    
    public void loadAccounts(){         
        try{
            resetAccs();
           
           string query='Select id,Days_Delinquent__c,LD_Lease_Total_Past_Due__c, LastActivityDate, Name,BillingCountry, phone,BillingStreet, AccountNumber,BillingCity, BillingAddress, BillingState, BillingPostalCode, PersonMobilePhone, PersonEmail, PersonHomePhone, (Select id, Last_Interaction__c, Committed_Date__c From LD_Leases__r order by LastModifiedDate desc limit 1 ) From Account ';
           
           if(selMan != '-None-' && selAcc == '-None-'){    
              query += 'where OwnerId =: selMan order by name';
           }else if(selMan == '-None-' && selAcc != '-None-'){
                if(selAcc == '180+'){
                	query += 'where Days_Delinquent__c >= 180 order by name';                    
                }else{
                    List<String> daysValue = selAcc.split('-');
                    Decimal strt= Decimal.ValueOF(daysValue[0].trim());
                    Decimal stp =Decimal.ValueOF(daysValue[1].trim());  
                    query += 'where Days_Delinquent__c >=:strt and Days_Delinquent__c <=:stp order by name';                      
                }
            }else if(selMan != '-None-' && selAcc != '-None-'){    
                if(selAcc == '180+'){
                	query += 'where Days_Delinquent__c >= 180 and OwnerId =: selMan order by name';                    
                }else{
                    List<String> daysValue = selAcc.split('-');
                    Decimal strt= Decimal.ValueOF(daysValue[0].trim());
                    Decimal stp =Decimal.ValueOF(daysValue[1].trim());  
                    query += 'where Days_Delinquent__c >=:strt and Days_Delinquent__c <=:stp and OwnerId =: selMan order by name';                     
                }  
            }
            
            if(selMan == '-None-' && selAcc == '-None-') {
                wrapperList = new List<wrapaccount>();  
            }else{
            	for(Account a : Database.query(query)){
            		wrapperList.add(new wrapaccount(a));    
            	}
            }         
        }  			
        catch (Exception ex) {  
             system.assert(false, ex.getLineNumber()+'--'+ex.getMessage());  
        }
    }
      
    
    /*  
    Fetch specific account details when clicked on Account name
    */  
    Public void getAccountDetails(){  
       try{              
           accRecord = [Select id, NVMContactWorld__NVM_Phone__c, Secondary_Phone__c, Employer_Phone__c, PersonAssistantPhone, phone, Name,  BillingCountry, BillingStreet, AccountNumber,BillingCity, BillingAddress, BillingState, BillingPostalCode, PersonMobilePhone, PersonEmail, PersonHomePhone, LastActivityDate , (Select id, Name, Status__c, RecordType.Name, createdDate from Projects__r),  (Select id, Name,  Days_Delinquent__c, Total_Past_Due__c, Contract_No__c From LD_Leases__r),(Select id, Name, System_Size_in_KW__c, Solar_Product__c, Numeric_ID__c from Deals__r), (Select id, CaseNumber__c, CaseAgeDays__c, Status__c From Issues__r), (select id, Type, ActivityDate, Description, Owner.Name from tasks order by ActivityDate desc) From Account Where Id =: accountId];         
       }
       catch (Exception ex) {
             system.assert(false, ex.getLineNumber()+'--'+ex.getMessage());  
        }  
        
    }       
    Public void resetAccs() {
        accRecord = null;
        wrapperList = new List<wrapaccount>();        
       // accountId = null;
    }
    
    //##THIS IS WRAPPER CLASS			  
    public class wrapaccount{
    
	    public Id accId{get;set;}
	    public string accName{get;set;}
	    public string accPhone{get;set;}
	    public Decimal accDaysDelinquent{get;set;}  
	    public Decimal accLeaseTotalPastDue{get;set;}
	    public Date accLastActivity{get;set;}  	    
	    public string ldLeaseLastInteraction{get;set;}
	    public Date ldCommittedDate{get;set;}    
     
	    public wrapaccount(account acc){    	 
		     this.accId=acc.Id;
		     this.accName=acc.Name;
		     this.accPhone=acc.phone;
		     this.accDaysDelinquent=acc.Days_Delinquent__c;
		     this.accLeaseTotalPastDue=acc.LD_Lease_Total_Past_Due__c;
		     this.accLastActivity=acc.LastActivityDate;
		     
		     if(acc.LD_Leases__r.size()> 0)
		     {
			     this.ldLeaseLastInteraction=acc.LD_Leases__r[0].Last_Interaction__c;
			     this.ldCommittedDate=acc.LD_Leases__r[0].Committed_Date__c;			    
		     }	     
	   }   
    }   
    
    
}