@isTest
public with sharing class TestLDLeaseTrigger{
  public static testMethod void myUnitTest1(){
  
      Account acc =new Account();
      acc.name = 'irfan khan';
      insert acc;
      
      Opportunity opp = new Opportunity();
      opp.name = 'Test opp';
      opp.accountId = acc.id;
      opp.CloseDate = date.today();
      opp.stageName = 'Closed Won';
      insert opp;
      
      System.assertEquals(null, opp.Numeric_id__c);
      
      Trigger_Setting__c ts = new Trigger_Setting__c(LD_Lease_trigger__c=true);
      insert ts; 

      List<LD_Lease__c> ldLeaseList = new List<LD_Lease__c>();
      ldLeaseList.add(new LD_Lease__c(Contract_No__c='12346744',Name='aaaa',opportunity__c=opp.id,account__c=acc.id,Customer_No__c='22'+opp.Numeric_id__c,Next_Pay_Due_Dte__c=System.today(),Total_Late_Fees__c=500.00,Due_Day__c=5,Ach_Debit__c='452134545',Total_Paid_Lr__c=1000.00));
      ldLeaseList.add(new LD_Lease__c(Contract_No__c='12346733',Name='bbbb',opportunity__c=opp.id,account__c=acc.id,Customer_No__c='44'+opp.Numeric_id__c,Next_Pay_Due_Dte__c=System.today(),Total_Late_Fees__c=400.00,Due_Day__c=4,Ach_Debit__c='4aa2134545',Total_Paid_Lr__c=500.00));
      ldLeaseList.add(new LD_Lease__c(Contract_No__c='12346722',Name='cccc',opportunity__c=opp.id,account__c=acc.id,Customer_No__c='55'+opp.Numeric_id__c,Next_Pay_Due_Dte__c=System.today(),Total_Late_Fees__c=600.00,Due_Day__c=3,Ach_Debit__c='452341545',Total_Paid_Lr__c=7000.00));
      ldLeaseList.add(new LD_Lease__c(Contract_No__c='12346711',Name='dddd',opportunity__c=opp.id,account__c=acc.id,Customer_No__c='66'+opp.Numeric_id__c,Next_Pay_Due_Dte__c=System.today(),Total_Late_Fees__c=700.00,Due_Day__c=1,Ach_Debit__c='4523sss545',Total_Paid_Lr__c=8000.00));
      
      upsert ldLeaseList;
  }
}