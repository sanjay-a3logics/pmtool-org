@isTest
public class TestTaskTrigger{
  
 public static testmethod void unitTest1(){
 
   Trigger_Setting__c ts = new Trigger_Setting__c(Task_Trigger__c=true);
   insert ts; 
     
    Account acc = new Account();
    acc.name = 'irfan khan';
    insert acc; 
     
    Opportunity opp = new Opportunity();
    opp.name = 'Test opp';
    opp.accountId = acc.id;
    opp.CloseDate = date.today();
    opp.stageName = 'Closed Won';
    opp.Touch_Milestones__c = '';
    OpportunityTriggerHandler.firstRun =false; 
    insert opp; 
    
    Task tk = new Task();
    tk.type = 'Intro';
    tk.Successful__c = true;
    tk.WhatId = opp.id;
    insert tk;
    
    opp.Touch_Milestones__c = 'Intro Call';
   // update opp;
    
    
    Task tk1 = new Task();
    tk1.type = 'PV Completion/EU Scheduling Call';
    tk1.Successful__c = true;
    tk1.WhatId = opp.id;
    insert tk1;
    
    opp.Touch_Milestones__c = 'Intro Call'+';'+'PV Completion/EU Scheduling Call';
    OpportunityTriggerHandler.firstRun =true; 
   // update opp;
    
    
    tk.type = 'Feasibility Result Call';
    tk.Successful__c = true;
    update tk;
    
    opp.Touch_Milestones__c = 'Feasibility Result Call'+';'+'PV Completion/EU Scheduling Call';
    OpportunityTriggerHandler.firstRun =true; 
   // update opp;
    
    
    delete tk;
    
    opp.Touch_Milestones__c = 'PV Completion/EU Scheduling Call';
    OpportunityTriggerHandler.firstRun =true; 
   // update opp;
    
   } 
  
  
}