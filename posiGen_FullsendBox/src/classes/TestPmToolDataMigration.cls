@isTest
public with sharing class TestPmToolDataMigration {
  public static testMethod void myUnitTest1() {     
      Integer record_limit = 0;
      String oppId = '';
      Database.BatchableContext BC;
      List<PM_Steps__c> pmStepsList = new List<PM_Steps__c>();
      List<Business_Installation_Step__c> bisList = new List<Business_Installation_Step__c>();
      List<String> allSteps = new List<String>();
      List<PM_Tool_v2__c> pmToolList = new List<PM_Tool_V2__c>();
      String allString = 'Activation,Closing Call,Determination,EE Audit,EA State Application Approval,Electrical Install,Electrical Install,R&P Install,Quality Control,Permitting,Inspection,EE Upgrade,EA State Application Approval,Work Scope Approval,State Initial Approval,Site Verification,Engineering,Intro Call,Assessment,Sales Order Creation,Layout Approval';
      allSteps = allString.split(',');
      
      Business_Market__c bm = new Business_Market__c(name='CT');
      insert bm;
      
      Business_Status__c bs = new Business_Status__c(name='Complete',score__c=3);
      insert bs;
      
      Business_Stage__c bist = new Business_Stage__c(name='test123',Business_market__c = bm.id);
      insert bist;
      
      Opportunity opp = new Opportunity();
      opp.name = 'Test1';
      opp.StageName = 'Layout Approval';
      opp.CloseDate = system.today();
      insert opp;
      
      oppId = String.valueOf(opp.id);
        
      PM_Tool__c pm = new PM_Tool__c();
      pm.Opportunity__c = opp.id;
      pm.Project_Status__c = 'Active';
      pm.Completion_Average__c = 0.0;
      //pm.Lease_Type__c = '';
      insert pm;
        
      PM_Tool_V2__c pmNew = new PM_Tool_V2__c();
      pmNew.Opportunity__c = opp.id;
      pmNew.Project_Status__c = 'Active';
      pmNew.Completion_Average__c = 0.0;
      pmNew.Lease_Type__c = '';
      insert pmNew;
      
      pmToolList.add(pmNew);
      
      //system.assert(false, allSteps);
      
      for(String Name: allSteps) {       
        Business_Installation_Step__c bistep1 = new Business_Installation_Step__c(name=name,Business_Stage__c=bist.id);
        bisList.add(bistep1);
      }  
      
      insert bisList;
      
      //system.assert(false, bisList);
          
      for(Business_Installation_Step__c bistp: bisList) {
            PM_Steps__c pms = new PM_Steps__c();
            pms.Aging__c = 1;
            pms.Business_Installation_Step__c = bistp.id;
            pms.End_Date__c = null; 
            pms.In_Process_Aging__c = 2; 
            pms.In_Process_Aging_Exception__c = false; 
            pms.In_Process_End_Date__c = null; 
            pms.In_Process_Start_Date__c = null; 
            pms.NA_Override__c = false; 
            pms.PM_Review_Aging__c = 3; 
            pms.PM_Review_Aging_Exception__c = true; 
            pms.PM_Review_End_Date__c = null; 
            pms.PM_Review_Start_Date__c = null;
            pms.PM_Tool_V2__c = pmNew.id; 
            pms.Start_Date__c = null;
            pmStepsList.add(pms);
      }
      
      //system.assert(false, pmStepsList);
      insert pmStepsList;
      
      PmToolDataMigration dataMig = new PmToolDataMigration(record_limit, oppId);
      
      datamig.start(BC);
      
      Integer size = pmStepsList.size();
      datamig.execute(BC, pmToolList); 
   }
}