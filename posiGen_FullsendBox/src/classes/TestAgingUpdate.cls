@isTest
public class TestAgingUpdate{
     public Static testmethod void unitTest1() {
        Database.BatchableContext BC;
     
        Business_Market__c bm = new Business_Market__c(name='CT');
        insert bm;
        
        Business_Status__c busStatus = new Business_Status__c(name='Complete',score__c=3);
        insert busStatus;
        
        PMToolV2.runStepTrigger = true;
        
        Business_Stage__c bs = new Business_Stage__c(Name='Feasibility', Business_Market__c = bm.id, Display_In_Tracker__c=true);
        insert bs;
        
        Business_Installation_Step__c bis = new Business_Installation_Step__c();
        bis.name = 'Assessment';
        bis.Business_Stage__c = bs.id;
        insert bis;
        
        Exception_Threshold__c ex = new Exception_Threshold__c();
        ex.In_Process_Threshold__c = 2; 
        ex.PM_Review_Threshold__c = 3;
        ex.Business_Installation_Step__c = bis.id;
        insert ex;
        
        PM_Steps__c pms = new PM_Steps__c();
        List<PM_Steps__c> pmList = new List<PM_Steps__c>();
        pms.Aging__c = 1;
        pms.Business_Installation_Step__c = bis.id;
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
        pms.Start_Date__c = null;
        insert pms;
        
        pmList.add(pms);
        
        AgingUpdate agingUpt = new AgingUpdate();
        
        agingUpt.start(BC);
        agingUpt.execute(BC, pmList);
        agingUpt.finish(BC);
     }
}