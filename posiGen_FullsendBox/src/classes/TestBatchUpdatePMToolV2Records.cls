@isTest
public class TestBatchUpdatePMToolV2Records{
 
  public static testmethod void Test1() {
  
        String recordTypeId  = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc= new Account(
        RecordTypeID=recordTypeId ,
        FirstName='Test FName',
        LastName='Test LName',
        PersonMailingStreet='test@yahoo.com',
        PersonMailingPostalCode='12345',
        PersonMailingCity='SFO',
        PersonEmail='test@yahoo.com',
        PersonHomePhone='1234567',
        PersonMobilePhone='12345678' 
        );
        insert acc;
      
        Property__c pr = new Property__c(Account__c= acc.id,Address_Line_1__c='New California', State__c='NY',AssessorOwnerName1__c = 'Abhay');
        insert pr;
  
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.property__c=pr.id;
        opp.accountId = acc.id;
        opp.stageName = 'Layout Approval';
        opp.Contracts_Approved_Date__c = date.today();
        opp.Contracts_Signed_Date__c = date.today();
        opp.Property__c=pr.id;
        opp.CloseDate = date.today();
        //opp.Property__r.AssessorOwnerName1__c = 'Abhay';
        insert opp;
        
            
        Business_Market__c bm = new Business_Market__c(name = 'NY');
        insert bm;
        
        Business_Stage__c bst = new Business_Stage__c(name = 'Feasibility',Business_Market__c = bm.id,Execution_sequence__c = 2, Formula_Json__c = '{\"formula\":[{\"condition\":\"AND\",\"rules\":[{\"id\":\"a56R00000004g2VIAQ\",\"field\":\"a56R00000004g2VIAQ\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"4\"}],\"score\":\"1\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"PM_Review__c\",\"field\":\"PM_Review__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"true\"}],\"score\":\"4\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"assessment_req_date__c\",\"field\":\"assessment_req_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"2\"},{\"condition\":\"OR\",\"rules\":[{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"layout_approval_required__c\",\"field\":\"layout_approval_required__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"true\"},{\"id\":\"layout_appr_rec_date__c\",\"field\":\"layout_appr_rec_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}]},{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"layout_approval_required__c\",\"field\":\"layout_approval_required__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"false\"}]}],\"score\":\"3\"}]}', Formula__c = 'if(pmtool.feasibility_project_status__c == \'completed\' && pmtool.feasibility_completed_date__c != null && stage.PM_Review__c == true){result = 4;}else if((pmtool.feasibility_project_status__c == \'completed\' && pmtool.feasibility_completed_date__c != null && pmtool.layout_approval_required__c == true && pmtool.layout_appr_rec_date__c != null) || (pmtool.feasibility_project_status__c == \'completed\' && pmtool.feasibility_completed_date__c != null && pmtool.layout_approval_required__c == false)){result = 3;}else if(pmtool.assessment_req_date__c != null){result = 2;}else if(pmStage.Intro Call-NY == 4){result = 1;}else{result = 0;}');
        insert bst;
      
        Business_Installation_Step__c ist = new Business_Installation_Step__c(name = 'Determination', Execution_sequence__c = 2, Sequence__c = 3, Formula_Json__c = '{\"formula\":[{\"condition\":\"AND\",\"rules\":[{\"id\":\"a55R0000000ClmzIAC\",\"field\":\"a55R0000000ClmzIAC\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"3\"}],\"score\":\"1\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"site_verification_required__c\",\"field\":\"site_verification_required__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"engineering_required__c\",\"field\":\"engineering_required__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"2\"},{\"condition\":\"OR\",\"rules\":[{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"layout_approval_required__c\",\"field\":\"layout_approval_required__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"true\"},{\"id\":\"layout_appr_rec_date__c\",\"field\":\"layout_appr_rec_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}]},{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"layout_approval_required__c\",\"field\":\"layout_approval_required__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"false\"}]}],\"score\":\"3\"}]}', Business_Stage__c = bst.id, Formula__c = 'if((pmtool.feasibility_project_status__c == \'completed\' && pmtool.feasibility_completed_date__c != null && pmtool.layout_approval_required__c == true && pmtool.layout_appr_rec_date__c != null) || (pmtool.feasibility_project_status__c == \'completed\' && pmtool.feasibility_completed_date__c != null && pmtool.layout_approval_required__c == false)){result = 3;}else if(pmtool.site_verification_required__c != null && pmtool.engineering_required__c != null){result = 2;}else if(pmStep.Assessment == 3){result = 1;}else{result = 0;}');
        insert ist;
  
         PM_Tool_V2__c pmt = new PM_Tool_V2__c(Opportunity__c = opp.id);
         insert pmt;
         
         PM_Stage__c pmStage = new PM_Stage__c(PM_Tool_V2__c = pmt.id, Business_Status__c = null, Business_Installation_Stage__c = bst.id);
         insert pmStage;
         
         PM_Steps__c pmstp = new PM_Steps__c();
        pmstp.Business_Installation_Step__c = ist.id;
        pmstp.Business_Status__c = null;
        pmstp.PM_Stage__c = pmStage.id;
        pmstp.PM_Tool_V2__c = pmt.id;
        insert pmstp;
          
       
         BatchUpdatePMToolV2Records rf = new BatchUpdatePMToolV2Records();
         SchedulableContext SC;
        
         Test.startTest(); 
         rf.execute(SC);
         Test.stopTest();
   }
}