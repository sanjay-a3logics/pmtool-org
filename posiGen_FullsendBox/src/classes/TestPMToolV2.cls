@isTest
public class TestPMToolV2{

       @testSetup static void methodName() {
       
            PMToolV2.updateStagesFirstRun = true;
            
            Business_Market__c bm = new Business_Market__c(name = 'CT');
            insert bm;
            
            Business_Status__c busStat5 = new Business_Status__c();
            busStat5.score__c = -1;
            busStat5.Name = 'Not Applicable';
            insert busStat5;
            
            Business_Status__c busStat = new Business_Status__c();
            busStat.score__c = 0;
            busStat.Name = 'Not Started';
            insert busStat;
            
            Business_Status__c busStat1 = new Business_Status__c();
            busStat1.score__c = 1;
            busStat1.Name = 'PM Review';
            insert busStat1;
            
            Business_Status__c busStat2 = new Business_Status__c();
            busStat2.score__c = 2;
            busStat2.Name = 'In Process';
            insert busStat2;
            
            Business_Status__c busStat3 = new Business_Status__c();
            busStat3.score__c = 3;
            busStat3.Name = 'Completed';
            insert busStat3;
            
            Business_Status__c busStat4 = new Business_Status__c();
            busStat4.score__c = 4;
            busStat4.Name = 'Confirmed Completed';
            insert busStat4;
            
            Business_Stage__c bst2 = new Business_Stage__c(name = 'Sales Order Creation-CT',Business_Market__c = bm.id,Execution_sequence__c = 3, Formula_Json__c = '{\"formula\":[{\"condition\":\"OR\",\"rules\":[{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"layout_approval_required__c\",\"field\":\"layout_approval_required__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"true\"},{\"id\":\"layout_appr_rec_date__c\",\"field\":\"layout_appr_rec_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}]},{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"layout_approval_required__c\",\"field\":\"layout_approval_required__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"false\"}]}],\"score\":\"3\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"PM_Review__c\",\"field\":\"PM_Review__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"true\"}],\"score\":\"4\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"assessment_req_date__c\",\"field\":\"assessment_req_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"2\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"a4zm000000027niAAA\",\"field\":\"a4zm000000027niAAA\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"4\"}],\"score\":\"1\"}]}', Formula__c = 'if(pmtool.sales_order_created__c == true && stage.PM_Review__c == true){result = 4;}else if(pmtool.sales_order_created__c == true){result = 3;}else if(pmtool.sales_order_created__c == true){result = 2;}else if(pmStage.Feasibility-CT == 4){result = 1;}else{result = 0;}');
            insert bst2;
            
            Business_Stage__c bst = new Business_Stage__c(name = 'Feasibility-CT',Business_Market__c = bm.id,Execution_sequence__c = 2, Formula_Json__c = '{\"formula\":[{\"condition\":\"OR\",\"rules\":[{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"layout_approval_required__c\",\"field\":\"layout_approval_required__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"true\"},{\"id\":\"layout_appr_rec_date__c\",\"field\":\"layout_appr_rec_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}]},{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"layout_approval_required__c\",\"field\":\"layout_approval_required__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"false\"}]}],\"score\":\"3\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"PM_Review__c\",\"field\":\"PM_Review__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"true\"}],\"score\":\"4\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"assessment_req_date__c\",\"field\":\"assessment_req_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"2\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"a4zm000000027niAAA\",\"field\":\"a4zm000000027niAAA\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"4\"}],\"score\":\"1\"}]}', Formula__c = 'if(pmtool.Feasibility_Completed_Date__c != null && pmtool.Feasibility_Project_Status__c == \'Completed\' && stage.PM_Review__c == True){result = 4;}else if(pmtool.Feasibility_Completed_Date__c != null && pmtool.Feasibility_Project_Status__c == \'Completed\' && pmtool.Layout_Approval_Required__c == True && pmtool.Layout_Appr_Rec_Date__c != null){result = 3;}else if(pmtool.Feasibility_Completed_Date__c != null && pmtool.Feasibility_Project_Status__c == \'Completed\' && pmtool.Layout_Approval_Required__c == False){result = 3;}else if(pmtool.Assessment_Req_Date__c != null){result = 2;}else if(pmtool.Intro_Call__c == True && previousStage.PM_Review__c == True){result = 1;}else{result = 0;}');
            insert bst;
                        
            //Business_Stage__c bst = new Business_Stage__c(name = 'Feasibility',Business_Market__c = bm.id,Execution_sequence__c = 2, Formula_Json__c = '{\"formula\":[{\"condition\":\"AND\",\"rules\":[{\"id\":\"a56R00000004g2VIAQ\",\"field\":\"a56R00000004g2VIAQ\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"4\"}],\"score\":\"1\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"PM_Review__c\",\"field\":\"PM_Review__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"true\"}],\"score\":\"4\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"assessment_req_date__c\",\"field\":\"assessment_req_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"2\"},{\"condition\":\"OR\",\"rules\":[{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"layout_approval_required__c\",\"field\":\"layout_approval_required__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"true\"},{\"id\":\"layout_appr_rec_date__c\",\"field\":\"layout_appr_rec_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}]},{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"layout_approval_required__c\",\"field\":\"layout_approval_required__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"false\"}]}],\"score\":\"3\"}]}', Formula__c = 'if(pmtool.feasibility_project_status__c == \'completed\' && pmtool.feasibility_completed_date__c != null && stage.PM_Review__c == true){result = 4;}else if((pmtool.feasibility_project_status__c == \'completed\' && pmtool.feasibility_completed_date__c != null && pmtool.layout_approval_required__c == true && pmtool.layout_appr_rec_date__c != null) || (pmtool.feasibility_project_status__c == \'completed\' && pmtool.feasibility_completed_date__c != null && pmtool.layout_approval_required__c == false)){result = 3;}else if(pmtool.assessment_req_date__c != null){result = 2;}else if(pmStage.Intro Call-CT == 4){result = 1;}else{result = 0;}');
            //insert bst;
            
            Business_Stage__c bst1 = new Business_Stage__c(name = 'Intro Call-CT',Business_Market__c = bm.id,Execution_sequence__c = 1, Formula_Json__c = '{\"formula\":[{\"condition\":\"OR\",\"rules\":[{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"layout_approval_required__c\",\"field\":\"layout_approval_required__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"true\"},{\"id\":\"layout_appr_rec_date__c\",\"field\":\"layout_appr_rec_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}]},{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"layout_approval_required__c\",\"field\":\"layout_approval_required__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"false\"}]}],\"score\":\"3\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"PM_Review__c\",\"field\":\"PM_Review__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"true\"}],\"score\":\"4\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"assessment_req_date__c\",\"field\":\"assessment_req_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"2\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"a4zm000000027niAAA\",\"field\":\"a4zm000000027niAAA\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"4\"}],\"score\":\"1\"}]}', Formula__c = 'if(pmtool.Feasibility_Completed_Date__c != null && pmtool.Feasibility_Project_Status__c == \'Completed\' && stage.PM_Review__c == True){result = 4;}else if(pmtool.Feasibility_Completed_Date__c != null && pmtool.Feasibility_Project_Status__c == \'Completed\' && pmtool.Layout_Approval_Required__c == True && pmtool.Layout_Appr_Rec_Date__c != null){result = 3;}else if(pmtool.Feasibility_Completed_Date__c != null && pmtool.Feasibility_Project_Status__c == \'Completed\' && pmtool.Layout_Approval_Required__c == False){result = 3;}else if(pmtool.Assessment_Req_Date__c != null){result = 2;}else if(pmtool.Intro_Call__c == True && previousStage.PM_Review__c == True){result = 1;}else{result = 0;}');
            insert bst1;

          
            Business_Installation_Step__c ist = new Business_Installation_Step__c(name = 'Assessment', Execution_sequence__c = 1, Sequence__c = 2, Formula_Json__c = '{\"formula\":[{\"condition\":\"AND\",\"rules\":[{\"id\":\"a4zm000000027niAAA\",\"field\":\"a4zm000000027niAAA\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"4\"}],\"score\":\"1\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"assessment_req_date__c\",\"field\":\"assessment_req_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"2\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"assessment_comp_date__c\",\"field\":\"assessment_comp_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"3\"}]}', Business_Stage__c = bst.id, Formula__c = 'if(pmtool.Assessment_Comp_Date__c != null){result = 3;}else if(pmtool.Assessment_Req_Date__c != null){result = 2;}else if(pmtool.Intro_Call__c == True && previousStage.PM_Review__c == True){result = 1;}else{result = 0;}');
            insert ist;
            
            Business_Installation_Step__c ist1 = new Business_Installation_Step__c(name = 'Layout Approval', Execution_sequence__c = 5, Sequence__c = 2, Formula_Json__c = '{\"formula\":[{\"condition\":\"AND\",\"rules\":[{\"id\":\"a4zm000000027niAAA\",\"field\":\"a4zm000000027niAAA\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"4\"}],\"score\":\"1\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"assessment_req_date__c\",\"field\":\"assessment_req_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"2\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"assessment_comp_date__c\",\"field\":\"assessment_comp_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"3\"}]}', Business_Stage__c = bst.id, Formula__c = 'if(pmtool.layout_appr_rec_date__c != null){result = 3;}else if(pmtool.layout_appr_sub_date__c != null){result = 2;}else if(pmStep.Assessment == 3 && pmtool.initial_determination_result__c == \'feasible\'){result = 1;}else if(pmtool.layout_approval_required__c == False){result = -1;}else{result = 0;}');
            insert ist1;
            
            Profile profiles=[Select Id From Profile Where Name='System Administrator'];
            List<Business_Installation_Step__c> bisFilterList = new List<Business_Installation_Step__c>(); 
            
            String orgId = UserInfo.getOrganizationId(); 
            String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-',''); 
            Integer randomInt = Integer.valueOf(math.rint(math.random()*1000)); 
            String uniqueName = orgId + dateString + randomInt; 
            
            User u = new User(); 
            u.Username =  uniqueName + '@testPMToolV2' + orgId + '.org'; 
            u.ProfileId = profiles.Id; 
            u.LastName = 'test'; 
            u.Alias = 'test1'; 
            u.Email =  uniqueName + '@test' + orgId + '.org'; 
            u.TimeZoneSidKey = 'America/Los_Angeles'; 
            u.localesidkey='en_US'; 
            u.emailencodingkey='UTF-8';
            u.languagelocalekey='en_US'; 
            insert u; 
            
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
            
            Property__c pr = new Property__c(Account__c= acc.id,Address_Line_1__c='New California', State__c='CT', AssessorOwnerName1__c='test');
            insert pr;
            
            Trigger_Setting__c ts = new Trigger_Setting__c(Attachment_Trigger__c=true,BoxAccessMatrixStage_Trigger__c=true,FeedItem_Trigger__c=true,LD_Lease_trigger__c=true,LogsTrigger__c=true,Opportunity_Trigger__c=true,PM_Trigger__c=true,Project_Trigger__c=true,Task_Trigger__c=true,User_Trigger__c=true);
            insert ts; 
            
            Set<Id> opSet = new Set<Id>();
            OpportunityTriggerHandler.firstRun = true;
            Opportunity opp = new Opportunity();
            opp.name = 'Test opp';
            opp.property__c=pr.id;
            opp.accountId = acc.id;
            opp.stageName = 'Layout Approval';
            opp.Contracts_Approved_Date__c = date.today();
            opp.Contracts_Signed_Date__c = date.today();
            opp.Property__c=pr.id;
            opp.Project_Manager__c=u.id;
            opp.CloseDate = date.today();
            insert opp;
            opSet.add(opp.id);
            
            Sales_Order__c so = new Sales_Order__c(Account__c = acc.id,Opportunity__c = opp.id);
            insert so;
            
            
            //Business_Stage__c bst = new Business_Stage__c(name = 'Feasibility',Business_Market__c = bm.id,Execution_sequence__c = 2, Formula_Json__c = '{\"formula\":[{\"condition\":\"OR\",\"rules\":[{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"layout_approval_required__c\",\"field\":\"layout_approval_required__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"true\"},{\"id\":\"layout_appr_rec_date__c\",\"field\":\"layout_appr_rec_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}]},{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"layout_approval_required__c\",\"field\":\"layout_approval_required__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"false\"}]}],\"score\":\"3\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"PM_Review__c\",\"field\":\"PM_Review__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"true\"}],\"score\":\"4\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"assessment_req_date__c\",\"field\":\"assessment_req_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"2\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"a4zm000000027niAAA\",\"field\":\"a4zm000000027niAAA\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"4\"}],\"score\":\"1\"}]}', Formula__c = 'if(pmtool.Feasibility_Completed_Date__c != null && pmtool.Feasibility_Project_Status__c == \'Completed\' && stage.PM_Review__c == True){result = 4;}else if(pmtool.Feasibility_Completed_Date__c != null && pmtool.Feasibility_Project_Status__c == \'Completed\' && pmtool.Layout_Approval_Required__c == True && pmtool.Layout_Appr_Rec_Date__c != null){result = 3;}else if(pmtool.Feasibility_Completed_Date__c != null && pmtool.Feasibility_Project_Status__c == \'Completed\' && pmtool.Layout_Approval_Required__c == False){result = 3;}else if(pmtool.Assessment_Req_Date__c != null){result = 2;}else if(pmtool.Intro_Call__c == True && previousStage.PM_Review__c == True){result = 1;}else{result = 0;}');
            //insert bst;

            
            PM_Stage_Mapping__c pmStageMapping = new PM_Stage_Mapping__c(Business_Stage__c = bst.id, Previous_Business_Stage__c = bst1.id);
            insert pmStageMapping;
            
       } 
     
   /*  public Static testmethod void PMTest1(){
        Boolean result = false;
        Integer fresult = 0;
        Integer size = 0;
        
        Profile profiles=[Select Id From Profile Where Name='System Administrator'];
        List<Business_Installation_Step__c> bisFilterList = new List<Business_Installation_Step__c>(); 
        
        String orgId = UserInfo.getOrganizationId(); 
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-',''); 
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000)); 
        String uniqueName = orgId + dateString + randomInt; 
        
        User u = new User(); 
        u.Username =  uniqueName + '@testPMToolV2' + orgId + '.org'; 
        u.ProfileId = profiles.Id; 
        u.LastName = 'test'; 
        u.Alias = 'test1'; 
        u.Email =  uniqueName + '@test' + orgId + '.org'; 
        u.TimeZoneSidKey = 'America/Los_Angeles'; 
        u.localesidkey='en_US'; 
        u.emailencodingkey='UTF-8';
        u.languagelocalekey='en_US'; 
        insert u; 
        
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
        
        Formula_Result__c formRes = new Formula_Result__c();
        formRes.Result__c=1;
        formRes.Random_No__c='ESL9FrYNc_Assessment';
        insert formRes;
        
        Property__c pr = new Property__c(Account__c= acc.id,Address_Line_1__c='New California', State__c='CT', AssessorOwnerName1__c='test');
        insert pr;
        
        Set<Id> opSet = new Set<Id>();
        OpportunityTriggerHandler.firstRun = true;
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.property__c=pr.id;
        opp.accountId = acc.id;
        opp.stageName = 'Layout Approval';
        opp.Contracts_Approved_Date__c = date.today();
        opp.Contracts_Signed_Date__c = date.today();
        opp.Property__c=pr.id;
        opp.Project_Manager__c=u.id;
        opp.CloseDate = date.today();
        insert opp;
        opSet.add(opp.id);
        
        Sales_Order__c so = new Sales_Order__c(Account__c = acc.id,Opportunity__c = opp.id);
        insert so;
        
        UtilityController.recursive =true;
        UtilityController.pmtool_flag =true;
        
        RecordType rt1 = [Select id,Name  from RecordType where name='PV Install'];
        Project__c pjI = new Project__c(Name='PV Install Project',Opportunity__c = opp.id,RecordTypeId = rt1.id);
        insert pjI;
        
        Set<Id> prjset = new Set<Id>();
        List<Project__c> proj = new List<Project__c>([Select id, Name ,Opportunity__c,RecordType.Name  from Project__c]);
        for(Project__c pro : proj){
            prjset.add(pro.id);
        }
        
        Business_Market__c bm = new Business_Market__c(name = 'CT');
        insert bm;
        
        Business_Stage__c bst = new Business_Stage__c(name = 'Feasibility',Business_Market__c = bm.id,Execution_sequence__c = 2, Formula_Json__c = '{\"formula\":[{\"condition\":\"OR\",\"rules\":[{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"layout_approval_required__c\",\"field\":\"layout_approval_required__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"true\"},{\"id\":\"layout_appr_rec_date__c\",\"field\":\"layout_appr_rec_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}]},{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"layout_approval_required__c\",\"field\":\"layout_approval_required__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"false\"}]}],\"score\":\"3\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"PM_Review__c\",\"field\":\"PM_Review__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"true\"}],\"score\":\"4\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"assessment_req_date__c\",\"field\":\"assessment_req_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"2\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"a4zm000000027niAAA\",\"field\":\"a4zm000000027niAAA\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"4\"}],\"score\":\"1\"}]}', Formula__c = 'if(pmtool.Feasibility_Completed_Date__c != null && pmtool.Feasibility_Project_Status__c == \'Completed\' && stage.PM_Review__c == True){result = 4;}else if(pmtool.Feasibility_Completed_Date__c != null && pmtool.Feasibility_Project_Status__c == \'Completed\' && pmtool.Layout_Approval_Required__c == True && pmtool.Layout_Appr_Rec_Date__c != null){result = 3;}else if(pmtool.Feasibility_Completed_Date__c != null && pmtool.Feasibility_Project_Status__c == \'Completed\' && pmtool.Layout_Approval_Required__c == False){result = 3;}else if(pmtool.Assessment_Req_Date__c != null){result = 2;}else if(pmtool.Intro_Call__c == True && previousStage.PM_Review__c == True){result = 1;}else{result = 0;}');
        insert bst;
      
        Business_Installation_Step__c ist = new Business_Installation_Step__c(name = 'Assessment', Execution_sequence__c = 1, Sequence__c = 2, Formula_Json__c = '{\"formula\":[{\"condition\":\"AND\",\"rules\":[{\"id\":\"a4zm000000027niAAA\",\"field\":\"a4zm000000027niAAA\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"4\"}],\"score\":\"1\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"assessment_req_date__c\",\"field\":\"assessment_req_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"2\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"assessment_comp_date__c\",\"field\":\"assessment_comp_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"3\"}]}', Business_Stage__c = bst.id, Formula__c = 'if(pmtool.Assessment_Comp_Date__c != null){result = 3;}else if(pmtool.Assessment_Req_Date__c != null){result = 2;}else if(pmtool.Intro_Call__c == True && previousStage.PM_Review__c == True){result = 1;}else{result = 0;}');
        insert ist;
      
        PM_Tool_V2__c pmt = new PM_Tool_V2__c(Opportunity__c = opp.id,Project_PV_Install__c = pjI.id, Sales_Order__c=so.id);
        insert pmt;
        
        Map<Id,Id> salesOrder = new Map<Id,Id>();
        salesOrder.put(opp.id, so.id);
        
        PM_Tool_V2__c pmtQ = [Select id ,Name ,State__c, Project_Manager__c from PM_Tool_V2__c where id=:pmt.id];
        Business_Status__c busStat = new Business_Status__c();
        busStat.score__c = 0;
        insert busStat;
        
        PM_Stage__c pmStage = new PM_Stage__c(PM_Tool_V2__c = pmtQ.id, Business_Status__c = busStat.id, Business_Installation_Stage__c = bst.id);
        insert pmStage;
        
        List<PM_Steps__c> pmStepsList = new List<PM_Steps__c>();
        PM_Steps__c pmstp = new PM_Steps__c();
        pmstp.Business_Installation_Step__c = ist.id;
        pmstp.Business_Status__c = busStat.id;
        pmstp.PM_Stage__c = pmStage.id;
        pmstp.PM_Tool_V2__c = pmt.id;
        pmStepsList.add(pmstp);
        insert pmStepsList;
        
        PMToolV2.PMStageWrapper pmstageWrap = new PMToolV2.PMStageWrapper(pmStage, pmStepsList);
      
        PMToolV2 pmTol = new PMToolV2();
        
        pmTol.customerId = pmtQ.id;
        pmTol.selectedMarket = bm.id;
        pmTol.selectedProjectManager = pmt.Project_Manager__c;
        Decimal avg = 1.0;
        List<PMToolV2.PMStageWrapper> pmStageWrapper = new List<PMToolV2.PMStageWrapper>();
        PMToolV2.PMWrapper pmWrap = new PMToolV2.PMWrapper(pmtQ, avg, pmStageWrapper);
        PMToolV2.cls_data clsWrap = new PMToolV2.cls_data();
        PMToolV2.FilterWrapper filterWrap = new PMToolV2.FilterWrapper();

        test.startTest();
        
        PMToolV2.updateStagesFirstRun = true;
        Set<Id> pmToolSet = new Set<Id>();
        PMToolV2.insertPMRecord(opset);
        PMToolV2.updatePMRecordFromProject(opset);
        PMToolV2.updatePMRecordFromOpportunity(opset);
        PMToolV2.updatePMRecordFromSalesOrder(opSet,salesOrder);
        PMToolV2.insertStages(pmToolSet, 'abcd');
        PMToolV2.insertStage(pmt.id,'abcd');
        PMToolV2.updateStages(pmToolSet,'abcd');
        PMToolV2.generateRandomString(5);
        PMToolV2.updateStageFromTrigger(pmToolSet ,'abcd');  
        
         
        
        test.stopTest();
     }
     
     public Static testmethod void PMTest1Stepb() {
         PMToolV2.replaceFormulaString('if(pmtool.electrical_install_completed_date__c != null){result = 3;}else if(pmtool.elec_install_sch_date__c != null){result = 2;}else if(pmStep.R&P Install == 3){result = 1;}else{result = 0;}');
     }
     
     public Static testmethod void PMTest1Stepc() {
         PMToolV2.replaceFormulaString('if(pmtool.layout_appr_rec_date__c != null){result = 3;}else if(pmtool.layout_appr_sub_date__c != null){result = 2;}else if(pmStep.Assessment == 3 && pmtool.initial_determination_result__c == \'feasible\'){result = 1;}else if(pmtool.layout_approval_required__c == False){result = -1;}else{result = 0;}');
     }
     
     public Static testmethod void PMTest1Stepd() {
         PMToolV2.replaceFormulaString('if(pmtool.net_meter_inst_verified_date__c != null || pmStep.Inspection == 3){result = 3;}else if(pmtool.utility_init_appr_sub_date__c != null || (pmtool.utility__c != \'Entergy Louisiana\' || pmtool.utility__c != \'Entergy New Orleans\')){result = 2;}else if((pmtool.utility__c == \'Entergy Louisiana\' || pmtool.utility__c == \'Entergy New Orleans\') || (pmtool.net_meter_inst_sch_date__c != null || pmtool.inf_net_meter_inst_date__c != null)){result = 2;}else if(pmStage.Awaiting PiS-LA == 4 || (pmtool.utility__c != \'Entergy Louisiana\' || pmtool.utility__c != \'Entergy New Orleans\')){result = 1;}else if(pmStep.Inspection == 3 || (pmtool.utility__c == \'Entergy Louisiana\' || pmtool.utility__c == \'Entergy New Orleans\')){result = 1;}else{result = 0;}');
     }
     
     public Static testmethod void PMTest1Stageb() {
         PMToolV2.replaceFormulaString('if(pmtool.sales_order_created__c == true){result = 3;}else if(pmtool.sales_order_created__c == true){result = 2;}else if(pmStage.Feasibility-LA == 4){result = 1;}else{result = 0;}');
     }
     
     public Static testmethod void PMTest1Stagec() {
         PMToolV2.replaceFormulaString('if(pmtool.inspection_completed_date__c != null && pmtool.inspection_result__c == \'passed\'){result = 3;}else if(pmtool.inspection_requested_date__c != null){result = 2;}else if(pmStage.Awaiting PiS-NY == 4 && pmStep.Quality Control == -1){result = 1;}else if(pmStage.Awaiting PiS-NY == 4 && pmStep.Quality Control == 3){result = 1;}else{result = 0;}');
     }
     
     public Static testmethod void PMTest1Staged() {
         PMToolV2.replaceFormulaString('if(pmtool.building_permit_received__c != null || pmtool.electrical_permit_received__c != null){result = 3;}else if(pmtool.building_permit_applied_for__c != null || pmtool.electrical_permit_applied_for__c != null){result = 2;}else if(pmStage.Feasibility-NY == 4 || pmtool.feasibility_result__c.contains(\'feasible\') || (pmtool.hdlc_approval__c == false || pmtool.hoa_approval_required__c == false)){result = 1;}else if(pmStage.Feasibility-NY == 4 || pmtool.feasibility_result__c.contains(\'feasible\') || (pmtool.hdlc_approval__c == true || pmtool.hoa_approval_required__c == true) || pmStep.HOA/Historic District == 3){result = 1;}else{result = 0;}');
         
     }
     
     /*public Static testmethod void CalcStageStatusA() {
         
         Boolean result = false;
        Integer fresult = 0;
        Integer size = 0;
        
        Profile profiles=[Select Id From Profile Where Name='System Administrator'];
        List<Business_Installation_Step__c> bisFilterList = new List<Business_Installation_Step__c>(); 
        
        String orgId = UserInfo.getOrganizationId(); 
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-',''); 
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000)); 
        String uniqueName = orgId + dateString + randomInt; 
        
        User u = new User(); 
        u.Username =  uniqueName + '@testPMToolV2' + orgId + '.org'; 
        u.ProfileId = profiles.Id; 
        u.LastName = 'test'; 
        u.Alias = 'test1'; 
        u.Email =  uniqueName + '@test' + orgId + '.org'; 
        u.TimeZoneSidKey = 'America/Los_Angeles'; 
        u.localesidkey='en_US'; 
        u.emailencodingkey='UTF-8';
        u.languagelocalekey='en_US'; 
        insert u; 
        
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
        
        Formula_Result__c formRes = new Formula_Result__c();
        formRes.Result__c=1;
        formRes.Random_No__c='ESL9FrYNc_Assessment';
        insert formRes;
        
        Property__c pr = new Property__c(Account__c= acc.id,Address_Line_1__c='New California', State__c='CT', AssessorOwnerName1__c='test');
        insert pr;
        
        Set<Id> opSet = new Set<Id>();
        OpportunityTriggerHandler.firstRun = true;
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.property__c=pr.id;
        opp.accountId = acc.id;
        opp.stageName = 'Layout Approval';
        opp.Contracts_Approved_Date__c = date.today();
        opp.Contracts_Signed_Date__c = date.today();
        opp.Property__c=pr.id;
        opp.Project_Manager__c=u.id;
        opp.CloseDate = date.today();
        insert opp;
        opSet.add(opp.id);
        
        Sales_Order__c so = new Sales_Order__c(Account__c = acc.id,Opportunity__c = opp.id);
        insert so;
        
        UtilityController.recursive =true;
        UtilityController.pmtool_flag =true;
        
        RecordType rt1 = [Select id,Name  from RecordType where name='PV Install'];
        Project__c pjI = new Project__c(Name='PV Install Project',Opportunity__c = opp.id,RecordTypeId = rt1.id);
        insert pjI;
        
        Set<Id> prjset = new Set<Id>();
        List<Project__c> proj = new List<Project__c>([Select id, Name ,Opportunity__c,RecordType.Name  from Project__c]);
        for(Project__c pro : proj){
            prjset.add(pro.id);
        }
        
        Business_Market__c bm = new Business_Market__c(name = 'CT');
        insert bm;
        
        Business_Stage__c bst = new Business_Stage__c(name = 'Feasibility',Business_Market__c = bm.id,Execution_sequence__c = 2, Formula_Json__c = '{\"formula\":[{\"condition\":\"OR\",\"rules\":[{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"layout_approval_required__c\",\"field\":\"layout_approval_required__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"true\"},{\"id\":\"layout_appr_rec_date__c\",\"field\":\"layout_appr_rec_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}]},{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"layout_approval_required__c\",\"field\":\"layout_approval_required__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"false\"}]}],\"score\":\"3\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"PM_Review__c\",\"field\":\"PM_Review__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"true\"}],\"score\":\"4\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"assessment_req_date__c\",\"field\":\"assessment_req_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"2\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"a4zm000000027niAAA\",\"field\":\"a4zm000000027niAAA\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"4\"}],\"score\":\"1\"}]}', Formula__c = 'if(pmtool.Feasibility_Completed_Date__c != null && pmtool.Feasibility_Project_Status__c == \'Completed\' && stage.PM_Review__c == True){result = 4;}else if(pmtool.Feasibility_Completed_Date__c != null && pmtool.Feasibility_Project_Status__c == \'Completed\' && pmtool.Layout_Approval_Required__c == True && pmtool.Layout_Appr_Rec_Date__c != null){result = 3;}else if(pmtool.Feasibility_Completed_Date__c != null && pmtool.Feasibility_Project_Status__c == \'Completed\' && pmtool.Layout_Approval_Required__c == False){result = 3;}else if(pmtool.Assessment_Req_Date__c != null){result = 2;}else if(pmtool.Intro_Call__c == True && previousStage.PM_Review__c == True){result = 1;}else{result = 0;}');
        insert bst;
      
        Business_Installation_Step__c ist = new Business_Installation_Step__c(name = 'Assessment', Execution_sequence__c = 1, Sequence__c = 2, Formula_Json__c = '{\"formula\":[{\"condition\":\"AND\",\"rules\":[{\"id\":\"a4zm000000027niAAA\",\"field\":\"a4zm000000027niAAA\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"4\"}],\"score\":\"1\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"assessment_req_date__c\",\"field\":\"assessment_req_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"2\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"assessment_comp_date__c\",\"field\":\"assessment_comp_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"3\"}]}', Business_Stage__c = bst.id, Formula__c = 'if(pmtool.Assessment_Comp_Date__c != null){result = 3;}else if(pmtool.Assessment_Req_Date__c != null){result = 2;}else if(pmtool.Intro_Call__c == True && previousStage.PM_Review__c == True){result = 1;}else{result = 0;}');
        insert ist;
      
        PM_Tool_V2__c pmt = new PM_Tool_V2__c(Opportunity__c = opp.id,Project_PV_Install__c = pjI.id, Sales_Order__c=so.id);
        insert pmt;
        
        Map<Id,Id> salesOrder = new Map<Id,Id>();
        salesOrder.put(opp.id, so.id);
        
        PM_Tool_V2__c pmtQ = [Select id ,Name ,State__c, Project_Manager__c from PM_Tool_V2__c where id=:pmt.id];
        Business_Status__c busStat = new Business_Status__c();
        busStat.score__c = 0;
        insert busStat;
        
        PM_Stage__c pmStage = new PM_Stage__c(PM_Tool_V2__c = pmtQ.id, Business_Status__c = busStat.id, Business_Installation_Stage__c = bst.id);
        insert pmStage;
        
        List<PM_Steps__c> pmStepsList = new List<PM_Steps__c>();
        PM_Steps__c pmstp = new PM_Steps__c();
        pmstp.Business_Installation_Step__c = ist.id;
        pmstp.Business_Status__c = busStat.id;
        pmstp.PM_Stage__c = pmStage.id;
        pmstp.PM_Tool_V2__c = pmt.id;
        pmStepsList.add(pmstp);
        insert pmStepsList;
        
        PMToolV2.PMStageWrapper pmstageWrap = new PMToolV2.PMStageWrapper(pmStage, pmStepsList);
      
        PMToolV2 pmTol = new PMToolV2();
        
        pmTol.customerId = pmtQ.id;
        pmTol.selectedMarket = bm.id;
        pmTol.selectedProjectManager = pmt.Project_Manager__c;
        Decimal avg = 1.0;
        List<PMToolV2.PMStageWrapper> pmStageWrapper = new List<PMToolV2.PMStageWrapper>();
        PMToolV2.PMWrapper pmWrap = new PMToolV2.PMWrapper(pmtQ, avg, pmStageWrapper);
        PMToolV2.cls_data clsWrap = new PMToolV2.cls_data();
        PMToolV2.FilterWrapper filterWrap = new PMToolV2.FilterWrapper();
         
         String formula = 'if(pmtool.Assessment_Comp_Date__c != null){result = 3;}else if(pmtool.Assessment_Req_Date__c != null){result = 2;}else if(pmtool.Intro_Call__c == True && previousStage.PM_Review__c == True){result = 1;}else{result = 0;}';
         Map<Integer,id> bStatusMap = new Map<Integer,id>();
         Map<Integer,Business_Status__c> bStatusMapFormula = new Map<Integer,Business_Status__c>();
         Map<String, String> randomStageNameMap = new Map<String, String>();
         randomStageNameMap.put('Feasibility','d0r9x2sry');
         bStatusMap.put(0,busStat.id);
         bStatusMapFormula.put(0, busStat);
         String random_formula = PMToolV2.generateRandomString(9);
         Map<String, PM_Stage__c> pmsMap = new Map<String, PM_Stage__c>();
         pmsMap.put(bst.name,pmStage);
         String operation = 'insert';
         PMToolV2.calculatePmStageStatus(formula, bStatusMapFormula, randomStageNameMap, random_formula, pmsMap, operation);
     }*//*
     
     public Static testmethod void PMTest2(){
        Boolean result = false;
        Integer fresult = 0;
        
        Profile profiles=[Select Id From Profile Where Name='System Administrator']; 
        
        String orgId = UserInfo.getOrganizationId(); 
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-',''); 
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000)); 
        String uniqueName = orgId + dateString + randomInt; 
        
        User u = new User(); 
        u.Username =  uniqueName + '@testPMToolV2' + orgId + '.org'; 
        u.ProfileId = profiles.Id; 
        u.LastName = 'test'; 
        u.Alias = 'test1'; 
        u.Email =  uniqueName + '@test' + orgId + '.org'; 
        u.TimeZoneSidKey = 'America/Los_Angeles'; 
        u.localesidkey='en_US'; 
        u.emailencodingkey='UTF-8';
        u.languagelocalekey='en_US'; 
        insert u; 
        
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
        
        Formula_Result__c formRes = new Formula_Result__c(Result__c=1,Random_No__c='ESL9FrYNc_Assessment');
        insert formRes;
        
        Property__c pr = new Property__c(Account__c= acc.id,Address_Line_1__c='New California', State__c='NY',AssessorOwnerName1__c = 'Abhay');
        insert pr;
        
        Set<Id> opSet = new Set<Id>();
        OpportunityTriggerHandler.firstRun = true;
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.property__c=pr.id;
        opp.accountId = acc.id;
        opp.stageName = 'Layout Approval';
        opp.Contracts_Approved_Date__c = date.today();
        opp.Contracts_Signed_Date__c = date.today();
        opp.Property__c=pr.id;
        opp.Project_Manager__c=u.id;
        opp.CloseDate = date.today();
        //opp.Property__r.AssessorOwnerName1__c = 'Abhay';
        insert opp;
        opSet.add(opp.id);
        
        Sales_Order__c so = new Sales_Order__c(Account__c = acc.id,Opportunity__c = opp.id);
        insert so;
        
        UtilityController.recursive =true;
        UtilityController.pmtool_flag =true;
        
        String recTypeName = Schema.getGlobalDescribe().get('Project__c').getDescribe().getRecordTypeInfosByName().get('EE Assessment').getRecordTypeId();
        RecordType rt1 = [Select id,Name  from RecordType where id =:recTypeName];
        Project__c pjI = new Project__c(Name='EE Assessment Project',Opportunity__c = opp.id,RecordTypeId = rt1.id);
        insert pjI;
        
        Set<Id> prjset = new Set<Id>();
        List<Project__c> proj = new List<Project__c>([Select id, Name ,Opportunity__c,RecordType.Name  from Project__c]);
        for(Project__c pro : proj){
            prjset.add(pro.id);
        }
        
        Business_Market__c bm = new Business_Market__c(name = 'NY');
        insert bm;
        
        Business_Stage__c bst = new Business_Stage__c(name = 'Feasibility',Business_Market__c = bm.id,Execution_sequence__c = 2, Formula_Json__c = '{\"formula\":[{\"condition\":\"AND\",\"rules\":[{\"id\":\"a56R00000004g2VIAQ\",\"field\":\"a56R00000004g2VIAQ\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"4\"}],\"score\":\"1\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"PM_Review__c\",\"field\":\"PM_Review__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"true\"}],\"score\":\"4\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"assessment_req_date__c\",\"field\":\"assessment_req_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"2\"},{\"condition\":\"OR\",\"rules\":[{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"layout_approval_required__c\",\"field\":\"layout_approval_required__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"true\"},{\"id\":\"layout_appr_rec_date__c\",\"field\":\"layout_appr_rec_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}]},{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"layout_approval_required__c\",\"field\":\"layout_approval_required__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"false\"}]}],\"score\":\"3\"}]}', Formula__c = 'if(pmtool.feasibility_project_status__c == \'completed\' && pmtool.feasibility_completed_date__c != null && stage.PM_Review__c == true){result = 4;}else if((pmtool.feasibility_project_status__c == \'completed\' && pmtool.feasibility_completed_date__c != null && pmtool.layout_approval_required__c == true && pmtool.layout_appr_rec_date__c != null) || (pmtool.feasibility_project_status__c == \'completed\' && pmtool.feasibility_completed_date__c != null && pmtool.layout_approval_required__c == false)){result = 3;}else if(pmtool.assessment_req_date__c != null){result = 2;}else if(pmStage.Intro Call-NY == 4){result = 1;}else{result = 0;}');
        insert bst;
      
        Business_Installation_Step__c ist = new Business_Installation_Step__c(name = 'Determination', Execution_sequence__c = 2, Sequence__c = 3, Formula_Json__c = '{\"formula\":[{\"condition\":\"AND\",\"rules\":[{\"id\":\"a55R0000000ClmzIAC\",\"field\":\"a55R0000000ClmzIAC\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"3\"}],\"score\":\"1\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"site_verification_required__c\",\"field\":\"site_verification_required__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"engineering_required__c\",\"field\":\"engineering_required__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"2\"},{\"condition\":\"OR\",\"rules\":[{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"layout_approval_required__c\",\"field\":\"layout_approval_required__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"true\"},{\"id\":\"layout_appr_rec_date__c\",\"field\":\"layout_appr_rec_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}]},{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"layout_approval_required__c\",\"field\":\"layout_approval_required__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"false\"}]}],\"score\":\"3\"}]}', Business_Stage__c = bst.id, Formula__c = 'if((pmtool.feasibility_project_status__c == \'completed\' && pmtool.feasibility_completed_date__c != null && pmtool.layout_approval_required__c == true && pmtool.layout_appr_rec_date__c != null) || (pmtool.feasibility_project_status__c == \'completed\' && pmtool.feasibility_completed_date__c != null && pmtool.layout_approval_required__c == false)){result = 3;}else if(pmtool.site_verification_required__c != null && pmtool.engineering_required__c != null){result = 2;}else if(pmStep.Assessment == 3){result = 1;}else{result = 0;}');
        insert ist;
      
        PM_Tool_V2__c pmt = new PM_Tool_V2__c(Opportunity__c = opp.id,Project_EE_Assessment__c= pjI.id, Sales_Order__c=so.id);
        insert pmt;
        
        Map<Id,Id> salesOrder = new Map<Id,Id>();
        salesOrder.put(opp.id, so.id);
        
        PM_Tool_V2__c pmtQ = [Select id ,Name ,State__c, Project_Manager__c from PM_Tool_V2__c where id=:pmt.id];
        Business_Status__c busStat = new Business_Status__c();
        busStat.score__c = 0;
        insert busStat;
        PM_Stage__c pmStage = new PM_Stage__c(PM_Tool_V2__c = pmtQ.id, Business_Status__c = busStat.id, Business_Installation_Stage__c = bst.id);
        insert pmStage;
        List<PM_Steps__c> pmStepsList = new List<PM_Steps__c>();
        PM_Steps__c pmstp = new PM_Steps__c();
        pmstp.Business_Installation_Step__c = ist.id;
        pmstp.Business_Status__c = busStat.id;
        pmstp.PM_Stage__c = pmStage.id;
        pmstp.PM_Tool_V2__c = pmt.id;
        pmStepsList.add(pmstp);
        insert pmStepsList;
        
        PMToolV2.PMStageWrapper pmstageWrap = new PMToolV2.PMStageWrapper(pmStage, pmStepsList);
      
        PMToolV2 pmTol = new PMToolV2();
        
        pmTol.customerId = pmtQ.id;
        pmTol.selectedMarket = bm.id;
        pmTol.selectedProjectManager = pmt.Project_Manager__c;
        
        //PM_Tool_V2__c pmtool = new PM_Tool_V2__c();
        Decimal avg = 1.0;
        List<PMToolV2.PMStageWrapper> pmStageWrapper = new List<PMToolV2.PMStageWrapper>();
        PMToolV2.PMWrapper pmWrap = new PMToolV2.PMWrapper(pmtQ, avg, pmStageWrapper);

        //PMToolV2.CustomerDetailFieldWrapper custWrap = new PMToolV2.CustomerDetailFieldWrapper('ex','ex',1,'1',Date.today(),date.today());

        PMToolV2.cls_data clsWrap = new PMToolV2.cls_data();
        PMToolV2.FilterWrapper filterWrap = new PMToolV2.FilterWrapper();

        test.startTest();
        
        PMToolV2.updateStagesFirstRun = true;
        Set<Id> pmToolSet = new Set<Id>();
        //PMToolV2.insertPMRecord(opset);
        PMToolV2.updateStages(pmToolSet,'abcd');
        PMToolV2.updateStagesFirstRun = true;
        PMToolV2.insertStages(pmToolSet, 'abcd');
        PMToolV2.insertStage(pmt.id,'abcd');
        PMToolV2.updatePMRecordFromProject(opset);
        PMToolV2.updatePMRecordFromOpportunity(opset);
        PMToolV2.updatePMRecordFromSalesOrder(opSet,salesOrder);
        //pmTol.loadData();
        //pmTol.viewCustomerDetail();
        PMToolV2.generateRandomString(5);
        PMToolV2.updateStageFromTrigger(pmToolSet ,'abcd');
        List<Business_Installation_Step__c> bisFilterList = new List<Business_Installation_Step__c>();
        //pmTol.populateFilterList(bisFilterList);
        
        test.stopTest();
     } 
     
     public Static testmethod void PMTest3(){
        Boolean result = false;
        Integer fresult = 0;
        
        Profile profiles=[Select Id From Profile Where Name='System Administrator']; 
        
        String orgId = UserInfo.getOrganizationId(); 
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-',''); 
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000)); 
        String uniqueName = orgId + dateString + randomInt; 
        
        User u = new User(); 
        u.Username =  uniqueName + '@testPMToolV2' + orgId + '.org'; 
        u.ProfileId = profiles.Id; 
        u.LastName = 'test'; 
        u.Alias = 'test1'; 
        u.Email =  uniqueName + '@test' + orgId + '.org'; 
        u.TimeZoneSidKey = 'America/Los_Angeles'; 
        u.localesidkey='en_US'; 
        u.emailencodingkey='UTF-8';
        u.languagelocalekey='en_US'; 
        insert u; 
        
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
        
        Property__c pr = new Property__c(Account__c= acc.id,Address_Line_1__c='New California', State__c='CT');
        insert pr;
        
        Set<Id> opSet = new Set<Id>();
        OpportunityTriggerHandler.firstRun = true;
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.property__c=pr.id;
        opp.accountId = acc.id;
        opp.stageName = 'Layout Approval';
        opp.Contracts_Approved_Date__c = date.today();
        opp.Contracts_Signed_Date__c = date.today();
        opp.Property__c=pr.id;
        opp.Project_Manager__c=u.id;
        opp.CloseDate = date.today();
        insert opp;
        opSet.add(opp.id);
        
        Sales_Order__c so = new Sales_Order__c(Account__c = acc.id,Opportunity__c = opp.id);
        insert so;
        
        UtilityController.recursive =true;
        UtilityController.pmtool_flag =true;
        
        RecordType rt1 = [Select id,Name  from RecordType where name='EE Upgrade'];
        Project__c pjI = new Project__c(Name='PV Install Project',Opportunity__c = opp.id,RecordTypeId = rt1.id);
        insert pjI;
        
        Set<Id> prjset = new Set<Id>();
        List<Project__c> proj = new List<Project__c>([Select id, Name ,Opportunity__c,RecordType.Name  from Project__c]);
        for(Project__c pro : proj){
            prjset.add(pro.id);
        }
        
        Business_Market__c bm = new Business_Market__c(name = 'CT');
        insert bm;
        
        Business_Stage__c bst = new Business_Stage__c(name = 'Feasibility',Business_Market__c = bm.id,Execution_sequence__c = 2, Formula_Json__c = '{\"formula\":[{\"condition\":\"OR\",\"rules\":[{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"layout_approval_required__c\",\"field\":\"layout_approval_required__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"true\"},{\"id\":\"layout_appr_rec_date__c\",\"field\":\"layout_appr_rec_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}]},{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"layout_approval_required__c\",\"field\":\"layout_approval_required__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"false\"}]}],\"score\":\"3\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"PM_Review__c\",\"field\":\"PM_Review__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"true\"}],\"score\":\"4\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"assessment_req_date__c\",\"field\":\"assessment_req_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"2\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"a4zm000000027niAAA\",\"field\":\"a4zm000000027niAAA\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"4\"}],\"score\":\"1\"}]}', Formula__c = 'if(pmtool.Feasibility_Completed_Date__c != null && pmtool.Feasibility_Project_Status__c == \'Completed\' && stage.PM_Review__c == True){result = 4;}else if(pmtool.Feasibility_Completed_Date__c != null && pmtool.Feasibility_Project_Status__c == \'Completed\' && pmtool.Layout_Approval_Required__c == True && pmtool.Layout_Appr_Rec_Date__c != null){result = 3;}else if(pmtool.Feasibility_Completed_Date__c != null && pmtool.Feasibility_Project_Status__c == \'Completed\' && pmtool.Layout_Approval_Required__c == False){result = 3;}else if(pmtool.Assessment_Req_Date__c != null){result = 2;}else if(pmtool.Intro_Call__c == True && previousStage.PM_Review__c == True){result = 1;}else{result = 0;}');
        insert bst;
      
        Business_Installation_Step__c ist = new Business_Installation_Step__c(name = 'Assessment', Execution_sequence__c = 1, Sequence__c = 2, Formula_Json__c = '{\"formula\":[{\"condition\":\"AND\",\"rules\":[{\"id\":\"a4zm000000027niAAA\",\"field\":\"a4zm000000027niAAA\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"4\"}],\"score\":\"1\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"assessment_req_date__c\",\"field\":\"assessment_req_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"2\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"assessment_comp_date__c\",\"field\":\"assessment_comp_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"3\"}]}', Business_Stage__c = bst.id, Formula__c = 'if(pmtool.Assessment_Comp_Date__c != null){result = 3;}else if(pmtool.Assessment_Req_Date__c != null){result = 2;}else if(pmtool.Intro_Call__c == True && previousStage.PM_Review__c == True){result = 1;}else{result = 0;}');
        insert ist;
      
        PM_Tool_V2__c pmt = new PM_Tool_V2__c(Opportunity__c = opp.id,Project_EE_Upgrade__c = pjI.id, Sales_Order__c=so.id);
        insert pmt;
        
        Map<Id,Id> salesOrder = new Map<Id,Id>();
        salesOrder.put(opp.id, so.id);
        
        PM_Tool_V2__c pmtQ = [Select id ,Name ,State__c, Project_Manager__c from PM_Tool_V2__c where id=:pmt.id];
        Business_Status__c busStat = new Business_Status__c();
        busStat.score__c = 0;
        insert busStat;
        PM_Stage__c pmStage = new PM_Stage__c(PM_Tool_V2__c = pmtQ.id, Business_Status__c = busStat.id, Business_Installation_Stage__c = bst.id);
        insert pmStage;
        List<PM_Steps__c> pmStepsList = new List<PM_Steps__c>();
        PM_Steps__c pmstp = new PM_Steps__c();
        pmstp.Business_Installation_Step__c = ist.id;
        pmstp.Business_Status__c = busStat.id;
        pmstp.PM_Stage__c = pmStage.id;
        pmstp.PM_Tool_V2__c = pmt.id;
        pmStepsList.add(pmstp);
        insert pmStepsList;
        
        PMToolV2.PMStageWrapper pmstageWrap = new PMToolV2.PMStageWrapper(pmStage, pmStepsList);
      
        PMToolV2 pmTol = new PMToolV2();
        
        pmTol.customerId = pmtQ.id;
        pmTol.selectedMarket = bm.id;
        pmTol.selectedProjectManager = pmt.Project_Manager__c;
        
        //PM_Tool_V2__c pmtool = new PM_Tool_V2__c();
        Decimal avg = 1.0;
        List<PMToolV2.PMStageWrapper> pmStageWrapper = new List<PMToolV2.PMStageWrapper>();
        PMToolV2.PMWrapper pmWrap = new PMToolV2.PMWrapper(pmtQ, avg, pmStageWrapper);

        //PMToolV2.CustomerDetailFieldWrapper custWrap = new PMToolV2.CustomerDetailFieldWrapper('ex','ex',1,'1',Date.today(),date.today());

        PMToolV2.cls_data clsWrap = new PMToolV2.cls_data();
        PMToolV2.FilterWrapper filterWrap = new PMToolV2.FilterWrapper();

        test.startTest();
        
        Formula_Result__c formRes = new Formula_Result__c(Result__c=1,Random_No__c='ESL9FrYNc_Assessment');
        insert formRes;
        PMToolV2.updateStagesFirstRun = true;
        PMToolV2.replaceFormulaString('if(pmtool.electrical_install_completed_date__c != null){result = 3;}else if(pmtool.elec_install_sch_date__c != null){result = 2;}else if(pmStep.R&P Install == 3){result = 1;}else{result = 0;}');
        
        test.stopTest();
     }
     
     
     public Static testmethod void PMTest4(){
        Boolean result = false;
        Integer fresult = 0;
        
        Profile profiles=[Select Id From Profile Where Name='System Administrator']; 
        
        String orgId = UserInfo.getOrganizationId(); 
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-',''); 
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000)); 
        String uniqueName = orgId + dateString + randomInt; 
        
        User u = new User(); 
        u.Username =  uniqueName + '@testPMToolV2' + orgId + '.org'; 
        u.ProfileId = profiles.Id; 
        u.LastName = 'test'; 
        u.Alias = 'test1'; 
        u.Email =  uniqueName + '@test' + orgId + '.org'; 
        u.TimeZoneSidKey = 'America/Los_Angeles'; 
        u.localesidkey='en_US'; 
        u.emailencodingkey='UTF-8';
        u.languagelocalekey='en_US'; 
        insert u; 
        
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
        
        Property__c pr = new Property__c(Account__c= acc.id,Address_Line_1__c='New California', State__c='CT');
        insert pr;
        
        Set<Id> opSet = new Set<Id>();
        OpportunityTriggerHandler.firstRun = true;
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.property__c=pr.id;
        opp.accountId = acc.id;
        opp.stageName = 'Layout Approval';
        opp.Contracts_Approved_Date__c = date.today();
        opp.Contracts_Signed_Date__c = date.today();
        opp.Property__c=pr.id;
        opp.Project_Manager__c=u.id;
        opp.CloseDate = date.today();
        insert opp;
        opSet.add(opp.id);
        
        Sales_Order__c so = new Sales_Order__c(Account__c = acc.id,Opportunity__c = opp.id);
        insert so;
        
        UtilityController.recursive =true;
        UtilityController.pmtool_flag =true;
        
        RecordType rt1 = [Select id,Name  from RecordType where name='PV Removal'];
        Project__c pjI = new Project__c(Name='roject',Opportunity__c = opp.id,RecordTypeId = rt1.id);
        insert pjI;
        
        Set<Id> prjset = new Set<Id>();
        List<Project__c> proj = new List<Project__c>([Select id, Name ,Opportunity__c,RecordType.Name  from Project__c]);
        for(Project__c pro : proj){
            prjset.add(pro.id);
        }
        
        Business_Market__c bm = new Business_Market__c(name = 'CT');
        insert bm;
        
        Business_Stage__c bst = new Business_Stage__c(name = 'Feasibility',Business_Market__c = bm.id,Execution_sequence__c = 2, Formula_Json__c = '{\"formula\":[{\"condition\":\"OR\",\"rules\":[{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"layout_approval_required__c\",\"field\":\"layout_approval_required__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"true\"},{\"id\":\"layout_appr_rec_date__c\",\"field\":\"layout_appr_rec_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}]},{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"layout_approval_required__c\",\"field\":\"layout_approval_required__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"false\"}]}],\"score\":\"3\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"PM_Review__c\",\"field\":\"PM_Review__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"true\"}],\"score\":\"4\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"assessment_req_date__c\",\"field\":\"assessment_req_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"2\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"a4zm000000027niAAA\",\"field\":\"a4zm000000027niAAA\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"4\"}],\"score\":\"1\"}]}', Formula__c = 'if(pmtool.Feasibility_Completed_Date__c != null && pmtool.Feasibility_Project_Status__c == \'Completed\' && stage.PM_Review__c == True){result = 4;}else if(pmtool.Feasibility_Completed_Date__c != null && pmtool.Feasibility_Project_Status__c == \'Completed\' && pmtool.Layout_Approval_Required__c == True && pmtool.Layout_Appr_Rec_Date__c != null){result = 3;}else if(pmtool.Feasibility_Completed_Date__c != null && pmtool.Feasibility_Project_Status__c == \'Completed\' && pmtool.Layout_Approval_Required__c == False){result = 3;}else if(pmtool.Assessment_Req_Date__c != null){result = 2;}else if(pmtool.Intro_Call__c == True && previousStage.PM_Review__c == True){result = 1;}else{result = 0;}');
        insert bst;
      
        Business_Installation_Step__c ist = new Business_Installation_Step__c(name = 'Assessment', Execution_sequence__c = 1, Sequence__c = 2, Formula_Json__c = '{\"formula\":[{\"condition\":\"AND\",\"rules\":[{\"id\":\"a4zm000000027niAAA\",\"field\":\"a4zm000000027niAAA\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"4\"}],\"score\":\"1\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"assessment_req_date__c\",\"field\":\"assessment_req_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"2\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"assessment_comp_date__c\",\"field\":\"assessment_comp_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"3\"}]}', Business_Stage__c = bst.id, Formula__c = 'if(pmtool.Assessment_Comp_Date__c != null){result = 3;}else if(pmtool.Assessment_Req_Date__c != null){result = 2;}else if(pmtool.Intro_Call__c == True && previousStage.PM_Review__c == True){result = 1;}else{result = 0;}');
        insert ist;
      
        PM_Tool_V2__c pmt = new PM_Tool_V2__c(Opportunity__c = opp.id,Project_PV_Removal__c = pjI.id, Sales_Order__c=so.id);
        insert pmt;
        
        Map<Id,Id> salesOrder = new Map<Id,Id>();
        salesOrder.put(opp.id, so.id);
        
        PM_Tool_V2__c pmtQ = [Select id ,Name ,State__c, Project_Manager__c from PM_Tool_V2__c where id=:pmt.id];
        Business_Status__c busStat = new Business_Status__c();
        busStat.score__c = 0;
        insert busStat;
        PM_Stage__c pmStage = new PM_Stage__c(PM_Tool_V2__c = pmtQ.id, Business_Status__c = busStat.id, Business_Installation_Stage__c = bst.id);
        insert pmStage;
        List<PM_Steps__c> pmStepsList = new List<PM_Steps__c>();
        PM_Steps__c pmstp = new PM_Steps__c();
        pmstp.Business_Installation_Step__c = ist.id;
        pmstp.Business_Status__c = busStat.id;
        pmstp.PM_Stage__c = pmStage.id;
        pmstp.PM_Tool_V2__c = pmt.id;
        pmStepsList.add(pmstp);
        insert pmStepsList;
        
        PMToolV2.PMStageWrapper pmstageWrap = new PMToolV2.PMStageWrapper(pmStage, pmStepsList);
      
        PMToolV2 pmTol = new PMToolV2();
        
        pmTol.customerId = pmtQ.id;
        pmTol.selectedMarket = bm.id;
        pmTol.selectedProjectManager = pmt.Project_Manager__c;
        
        //PM_Tool_V2__c pmtool = new PM_Tool_V2__c();
        Decimal avg = 1.0;
        List<PMToolV2.PMStageWrapper> pmStageWrapper = new List<PMToolV2.PMStageWrapper>();
        PMToolV2.PMWrapper pmWrap = new PMToolV2.PMWrapper(pmtQ, avg, pmStageWrapper);

        //PMToolV2.CustomerDetailFieldWrapper custWrap = new PMToolV2.CustomerDetailFieldWrapper('ex','ex',1,'1',Date.today(),date.today());

        PMToolV2.cls_data clsWrap = new PMToolV2.cls_data();
        PMToolV2.FilterWrapper filterWrap = new PMToolV2.FilterWrapper();

        test.startTest();
        
        Formula_Result__c formRes = new Formula_Result__c();
        formRes.Result__c=1;
        formRes.Random_No__c='ESL9FrYNc_Assessment';
        insert formRes;
        PMToolV2.updateStagesFirstRun = true;
        PMToolV2.replaceFormulaString('if(pmtool.electrical_install_completed_date__c != null){result = 3;}else if(pmtool.elec_install_sch_date__c != null){result = 2;}else if(pmStage.Awaiting Approvals-NY == 4){result = 1;}else{result = 0;}');
        
        test.stopTest();
     }
     
     
     public Static testmethod void PMTest5(){
        Boolean result = false;
        Integer fresult = 0;
        Integer size = 0;
        
        Profile profiles=[Select Id From Profile Where Name='System Administrator']; 
        
        String orgId = UserInfo.getOrganizationId(); 
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-',''); 
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000)); 
        String uniqueName = orgId + dateString + randomInt; 
        
        User u = new User(); 
        u.Username =  uniqueName + '@testPMToolV2' + orgId + '.org'; 
        u.ProfileId = profiles.Id; 
        u.LastName = 'test'; 
        u.Alias = 'test1'; 
        u.Email =  uniqueName + '@test' + orgId + '.org'; 
        u.TimeZoneSidKey = 'America/Los_Angeles'; 
        u.localesidkey='en_US'; 
        u.emailencodingkey='UTF-8';
        u.languagelocalekey='en_US'; 
        insert u; 
        
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
        
        Property__c pr = new Property__c(Account__c= acc.id,Address_Line_1__c='New California', State__c='LA');
        insert pr;
        
        Set<Id> opSet = new Set<Id>();
        OpportunityTriggerHandler.firstRun = true;
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.property__c=pr.id;
        opp.accountId = acc.id;
        opp.stageName = 'Layout Approval';
        opp.Contracts_Approved_Date__c = date.today();
        opp.Contracts_Signed_Date__c = date.today();
        opp.Property__c=pr.id;
        opp.Project_Manager__c=u.id;
        opp.CloseDate = date.today();
        insert opp;
        opSet.add(opp.id);
        
        Sales_Order__c so = new Sales_Order__c(Account__c = acc.id,Opportunity__c = opp.id);
        insert so;
        
        UtilityController.recursive =true;
        UtilityController.pmtool_flag =true;
        
        RecordType rt1 = [Select id,Name  from RecordType where name='PV Feasibility'];
        Project__c pjI = new Project__c(Name='PV Feasibility Project',Opportunity__c = opp.id,RecordTypeId = rt1.id);
        insert pjI;
        
        Set<Id> prjset = new Set<Id>();
        List<Project__c> proj = new List<Project__c>([Select id, Name ,Opportunity__c,RecordType.Name  from Project__c]);
        for(Project__c pro : proj){
            prjset.add(pro.id);
        }
        
        Business_Market__c bm = new Business_Market__c(name = 'LA');
        insert bm;
        
        Business_Stage__c bst = new Business_Stage__c(name = 'Awaiting PiS',Business_Market__c = bm.id,Execution_sequence__c = 5, Formula_Json__c = '{\"formula\":[{\"condition\":\"AND\",\"rules\":[{\"id\":\"electrical_install_completed_date__c\",\"field\":\"electrical_install_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"PM_Review__c\",\"field\":\"PM_Review__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"true\"}],\"score\":\"4\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"electrical_install_completed_date__c\",\"field\":\"electrical_install_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"3\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"r_p_inst_sch_date__c\",\"field\":\"r_p_inst_sch_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"2\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"a56R00000004g2GIAQ\",\"field\":\"a56R00000004g2GIAQ\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"4\"}],\"score\":\"1\"}]}', Formula__c = 'if(pmtool.electrical_install_completed_date__c != null && stage.PM_Review__c == true){result = 4;}else if(pmtool.electrical_install_completed_date__c != null){result = 3;}else if(pmtool.r_p_inst_sch_date__c != null){result = 2;}else if(pmStage.Awaiting Approvals-LA == 4){result = 1;}else{result = 0;}');
        insert bst;
      
        Business_Installation_Step__c ist = new Business_Installation_Step__c(name = 'R&P Install', Execution_sequence__c = 8, Sequence__c = 13, Formula_Json__c = '{\"formula\":[{\"condition\":\"AND\",\"rules\":[{\"id\":\"r_p_installed_date__c\",\"field\":\"r_p_installed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"3\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"r_p_inst_sch_date__c\",\"field\":\"r_p_inst_sch_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"2\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"a56R00000004g2GIAQ\",\"field\":\"a56R00000004g2GIAQ\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"4\"}],\"score\":\"1\"}]}', Business_Stage__c = bst.id, Formula__c = 'if(pmtool.r_p_installed_date__c != null){result = 3;}else if(pmtool.r_p_inst_sch_date__c != null){result = 2;}else if(pmStage.Awaiting Approvals-LA == 4){result = 1;}else{result = 0;}');
        insert ist;
      
        PM_Tool_V2__c pmt = new PM_Tool_V2__c(Opportunity__c = opp.id,Project_PV_Install__c = pjI.id, Sales_Order__c=so.id);
        insert pmt;
        
        Map<Id,Id> salesOrder = new Map<Id,Id>();
        salesOrder.put(opp.id, so.id);
        
        PM_Tool_V2__c pmtQ = [Select id ,Name ,State__c, Project_Manager__c from PM_Tool_V2__c where id=:pmt.id];
        Business_Status__c busStat = new Business_Status__c();
        busStat.score__c = 0;
        insert busStat;
        PM_Stage__c pmStage = new PM_Stage__c(PM_Tool_V2__c = pmtQ.id, Business_Status__c = busStat.id, Business_Installation_Stage__c = bst.id);
        insert pmStage;
        List<PM_Steps__c> pmStepsList = new List<PM_Steps__c>();
        PM_Steps__c pmstp = new PM_Steps__c();
        pmstp.Business_Installation_Step__c = ist.id;
        pmstp.Business_Status__c = busStat.id;
        pmstp.PM_Stage__c = pmStage.id;
        pmstp.PM_Tool_V2__c = pmt.id;
        pmStepsList.add(pmstp);
        insert pmStepsList;
        
        PMToolV2.PMStageWrapper pmstageWrap = new PMToolV2.PMStageWrapper(pmStage, pmStepsList);
      
        PMToolV2 pmTol = new PMToolV2();
        
        pmTol.customerId = pmtQ.id;
        pmTol.selectedMarket = bm.id;
        pmTol.selectedProjectManager = pmt.Project_Manager__c;
        
        //PM_Tool_V2__c pmtool = new PM_Tool_V2__c();
        Decimal avg = 1.0;
        List<PMToolV2.PMStageWrapper> pmStageWrapper = new List<PMToolV2.PMStageWrapper>();
        PMToolV2.PMWrapper pmWrap = new PMToolV2.PMWrapper(pmtQ, avg, pmStageWrapper);

        //PMToolV2.CustomerDetailFieldWrapper custWrap = new PMToolV2.CustomerDetailFieldWrapper('ex','ex',1,'1',Date.today(),date.today());

        PMToolV2.cls_data clsWrap = new PMToolV2.cls_data();
        PMToolV2.FilterWrapper filterWrap = new PMToolV2.FilterWrapper();

        test.startTest();
        
        PMToolV2.updateStagesFirstRun = true;
        Set<Id> pmToolSet = new Set<Id>();
        //pmTol.getBusinessMarkets();
        PMToolV2.insertPMRecord(opset);
        PMToolV2.updateStages(pmToolSet,'abcd');
        PMToolV2.insertStages(pmToolSet, 'abcd');
        PMToolV2.insertStage(pmt.id,'abcd');
        PMToolV2.updatePMRecordFromProject(opset);
        PMToolV2.updatePMRecordFromOpportunity(opset);
        PMToolV2.updatePMRecordFromSalesOrder(opSet,salesOrder);
        //pmTol.loadData();
        //pmTol.viewCustomerDetail();
        PMToolV2.generateRandomString(5);
        PMToolV2.updateStageFromTrigger(pmToolSet ,'abcd');
        List<Business_Installation_Step__c> bisFilterList = new List<Business_Installation_Step__c>();
        //pmTol.populateFilterList(bisFilterList);
        
        PMToolV2.BusinessStageWrapper bsw = new PMToolV2.BusinessStageWrapper(new Business_Stage__c(), new List<Business_Installation_Step__c> ());
        bsw.size = 0;
        pmTol.filterText = '';
        pmTol.filterConditions ='';
        //pmTol.projectManagerList.add(new SelectOption('',''));       
        test.stopTest();
     }
     
     public Static testmethod void PMTest6(){
        Boolean result = false;
        Integer fresult = 0;
        Integer size = 0;
        
        Profile profiles=[Select Id From Profile Where Name='System Administrator']; 
        
        String orgId = UserInfo.getOrganizationId(); 
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-',''); 
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000)); 
        String uniqueName = orgId + dateString + randomInt; 
        
        User u = new User(); 
        u.Username =  uniqueName + '@testPMToolV2' + orgId + '.org'; 
        u.ProfileId = profiles.Id; 
        u.LastName = 'test'; 
        u.Alias = 'test1'; 
        u.Email =  uniqueName + '@test' + orgId + '.org'; 
        u.TimeZoneSidKey = 'America/Los_Angeles'; 
        u.localesidkey='en_US'; 
        u.emailencodingkey='UTF-8';
        u.languagelocalekey='en_US'; 
        insert u; 
        
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
        
        Formula_Result__c formRes = new Formula_Result__c();
        formRes.Result__c=1;
        formRes.Random_No__c='ESL9FrYNc_Assessment';
        insert formRes;
        
        Property__c pr = new Property__c(Account__c= acc.id,Address_Line_1__c='New California', State__c='CT');
        insert pr;
        
        Set<Id> opSet = new Set<Id>();
        OpportunityTriggerHandler.firstRun = true;
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.property__c=pr.id;
        opp.accountId = acc.id;
        opp.stageName = 'Layout Approval';
        opp.Contracts_Approved_Date__c = date.today();
        opp.Contracts_Signed_Date__c = date.today();
        opp.Property__c=pr.id;
        opp.Project_Manager__c=u.id;
        opp.CloseDate = date.today();
        insert opp;
        opSet.add(opp.id);
        
        Sales_Order__c so = new Sales_Order__c(Account__c = acc.id,Opportunity__c = opp.id);
        insert so;
        
        UtilityController.recursive =true;
        UtilityController.pmtool_flag =true;
        
        RecordType rt1 = [Select id,Name  from RecordType where name='PV Install'];
        Project__c pjI = new Project__c(Name='PV Install Project',Opportunity__c = opp.id,RecordTypeId = rt1.id);
        insert pjI;
        
        Set<Id> prjset = new Set<Id>();
        List<Project__c> proj = new List<Project__c>([Select id, Name ,Opportunity__c,RecordType.Name  from Project__c]);
        for(Project__c pro : proj){
            prjset.add(pro.id);
        }
        
        Business_Market__c bm = new Business_Market__c(name = 'CT');
        insert bm;
        
        Business_Stage__c bst = new Business_Stage__c(name = 'Feasibility',Business_Market__c = bm.id,Execution_sequence__c = 2, Formula_Json__c = '{\"formula\":[{\"condition\":\"OR\",\"rules\":[{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"layout_approval_required__c\",\"field\":\"layout_approval_required__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"true\"},{\"id\":\"layout_appr_rec_date__c\",\"field\":\"layout_appr_rec_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}]},{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"layout_approval_required__c\",\"field\":\"layout_approval_required__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"false\"}]}],\"score\":\"3\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"PM_Review__c\",\"field\":\"PM_Review__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"true\"}],\"score\":\"4\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"assessment_req_date__c\",\"field\":\"assessment_req_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"2\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"a4zm000000027niAAA\",\"field\":\"a4zm000000027niAAA\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"4\"}],\"score\":\"1\"}]}', Formula__c = 'if(pmtool.Feasibility_Completed_Date__c != null && pmtool.Feasibility_Project_Status__c == \'Completed\' && stage.PM_Review__c == True){result = 4;}else if(pmtool.Feasibility_Completed_Date__c != null && pmtool.Feasibility_Project_Status__c == \'Completed\' && pmtool.Layout_Approval_Required__c == True && pmtool.Layout_Appr_Rec_Date__c != null){result = 3;}else if(pmtool.Feasibility_Completed_Date__c != null && pmtool.Feasibility_Project_Status__c == \'Completed\' && pmtool.Layout_Approval_Required__c == False){result = 3;}else if(pmtool.Assessment_Req_Date__c != null){result = 2;}else if(pmtool.Intro_Call__c == True && previousStage.PM_Review__c == True){result = 1;}else{result = 0;}');
        insert bst;
      
        Business_Installation_Step__c ist = new Business_Installation_Step__c(name = 'Assessment', Execution_sequence__c = 1, Sequence__c = 2, Formula_Json__c = '{\"formula\":[{\"condition\":\"AND\",\"rules\":[{\"id\":\"a4zm000000027niAAA\",\"field\":\"a4zm000000027niAAA\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"4\"}],\"score\":\"1\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"assessment_req_date__c\",\"field\":\"assessment_req_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"2\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"assessment_comp_date__c\",\"field\":\"assessment_comp_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"3\"}]}', Business_Stage__c = bst.id, Formula__c = 'if(pmtool.Assessment_Comp_Date__c != null){result = 3;}else if(pmtool.Assessment_Req_Date__c != null){result = 2;}else if(pmtool.Intro_Call__c == True && previousStage.PM_Review__c == True){result = 1;}else{result = 0;}');
        insert ist;
      
        PM_Tool_V2__c pmt = new PM_Tool_V2__c(Opportunity__c = opp.id,Project_PV_Install__c = pjI.id, Sales_Order__c=so.id);
        insert pmt;
        
        Map<Id,Id> salesOrder = new Map<Id,Id>();
        salesOrder.put(opp.id, so.id);
        
        PM_Tool_V2__c pmtQ = [Select id ,Name ,State__c, Project_Manager__c from PM_Tool_V2__c where id=:pmt.id];
        Business_Status__c busStat = new Business_Status__c();
        busStat.score__c = 0;
        insert busStat;
        PM_Stage__c pmStage = new PM_Stage__c(PM_Tool_V2__c = pmtQ.id, Business_Status__c = busStat.id, Business_Installation_Stage__c = bst.id);
        insert pmStage;
        List<PM_Steps__c> pmStepsList = new List<PM_Steps__c>();
        PM_Steps__c pmstp = new PM_Steps__c();
        pmstp.Business_Installation_Step__c = ist.id;
        pmstp.Business_Status__c = busStat.id;
        pmstp.PM_Stage__c = pmStage.id;
        pmstp.PM_Tool_V2__c = pmt.id;
        pmStepsList.add(pmstp);
        insert pmStepsList;
        
        PMToolV2.PMStageWrapper pmstageWrap = new PMToolV2.PMStageWrapper(pmStage, pmStepsList);
      
        PMToolV2 pmTol = new PMToolV2();
        
        pmTol.customerId = pmtQ.id;
        pmTol.selectedMarket = bm.id;
        pmTol.selectedProjectManager = pmt.Project_Manager__c;
        
        //PM_Tool_V2__c pmtool = new PM_Tool_V2__c();
        Decimal avg = 1.0;
        List<PMToolV2.PMStageWrapper> pmStageWrapper = new List<PMToolV2.PMStageWrapper>();
        PMToolV2.PMWrapper pmWrap = new PMToolV2.PMWrapper(pmtQ, avg, pmStageWrapper);

        //PMToolV2.CustomerDetailFieldWrapper custWrap = new PMToolV2.CustomerDetailFieldWrapper('ex','ex',1,'1',Date.today(),date.today());

        PMToolV2.cls_data clsWrap = new PMToolV2.cls_data();
        PMToolV2.FilterWrapper filterWrap = new PMToolV2.FilterWrapper();

        test.startTest();
        
        PMToolV2.updateStagesFirstRun = false;
        Set<Id> pmToolSet = new Set<Id>();
        //pmTol.getBusinessMarkets();
        PMToolV2.insertPMRecord(opset);
        PMToolV2.updateStages(pmToolSet,'abcd');
        PMToolV2.insertStages(pmToolSet, 'abcd');
        PMToolV2.insertStage(pmt.id,'abcd');
        PMToolV2.updatePMRecordFromProject(opset);
        PMToolV2.updatePMRecordFromOpportunity(opset);
        PMToolV2.updatePMRecordFromSalesOrder(opSet,salesOrder);
        //pmTol.loadData();
        //pmTol.viewCustomerDetail();
        PMToolV2.generateRandomString(5);
        PMToolV2.updateStageFromTrigger(pmToolSet ,'abcd');
        List<Business_Installation_Step__c> bisFilterList = new List<Business_Installation_Step__c>();
        //pmTol.populateFilterList(bisFilterList);
        
        PMToolV2.BusinessStageWrapper bsw = new PMToolV2.BusinessStageWrapper(new Business_Stage__c(), new List<Business_Installation_Step__c> ());
        bsw.size = 0;
        pmTol.filterText = '';
        pmTol.filterConditions ='';
        //pmTol.projectManagerList.add(new SelectOption('',''));       
        test.stopTest();
     }
     
     public Static testmethod void PMTest7(){
        Boolean result = false;
        Integer fresult = 0;
        Integer size = 0;
        
        Profile profiles=[Select Id From Profile Where Name='System Administrator']; 
        
        String orgId = UserInfo.getOrganizationId(); 
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-',''); 
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000)); 
        String uniqueName = orgId + dateString + randomInt; 
        
        User u = new User(); 
        u.Username =  uniqueName + '@testPMToolV2' + orgId + '.org'; 
        u.ProfileId = profiles.Id; 
        u.LastName = 'test'; 
        u.Alias = 'test1'; 
        u.Email =  uniqueName + '@test' + orgId + '.org'; 
        u.TimeZoneSidKey = 'America/Los_Angeles'; 
        u.localesidkey='en_US'; 
        u.emailencodingkey='UTF-8';
        u.languagelocalekey='en_US'; 
        insert u; 
        
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
        
        Formula_Result__c formRes = new Formula_Result__c();
        formRes.Result__c=1;
        formRes.Random_No__c='ESL9FrYNc_Assessment';
        insert formRes;
        
        Property__c pr = new Property__c(Account__c= acc.id,Address_Line_1__c='New California', State__c='CT');
        insert pr;
        
        Set<Id> opSet = new Set<Id>();
        OpportunityTriggerHandler.firstRun = true;
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.property__c=pr.id;
        opp.accountId = acc.id;
        opp.stageName = 'Layout Approval';
        opp.Contracts_Approved_Date__c = date.today();
        opp.Contracts_Signed_Date__c = date.today();
        opp.Property__c=pr.id;
        opp.Project_Manager__c=u.id;
        opp.CloseDate = date.today();
        insert opp;
        opSet.add(opp.id);
        
        Sales_Order__c so = new Sales_Order__c(Account__c = acc.id,Opportunity__c = opp.id);
        insert so;
        
        UtilityController.recursive =true;
        UtilityController.pmtool_flag =true;
        
        RecordType rt1 = [Select id,Name  from RecordType where name='PV Install'];
        Project__c pjI = new Project__c(Name='PV Install Project',Opportunity__c = opp.id,RecordTypeId = rt1.id);
        insert pjI;
        
        Set<Id> prjset = new Set<Id>();
        List<Project__c> proj = new List<Project__c>([Select id, Name ,Opportunity__c,RecordType.Name  from Project__c]);
        for(Project__c pro : proj){
            prjset.add(pro.id);
        }
        
        Business_Market__c bm = new Business_Market__c(name = 'CT');
        insert bm;
        
        Business_Stage__c bst = new Business_Stage__c(name = 'Feasibility',Business_Market__c = bm.id,Execution_sequence__c = 2, Formula_Json__c = '{\"formula\":[{\"condition\":\"OR\",\"rules\":[{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"layout_approval_required__c\",\"field\":\"layout_approval_required__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"true\"},{\"id\":\"layout_appr_rec_date__c\",\"field\":\"layout_appr_rec_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}]},{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"layout_approval_required__c\",\"field\":\"layout_approval_required__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"false\"}]}],\"score\":\"3\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"feasibility_completed_date__c\",\"field\":\"feasibility_completed_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null},{\"id\":\"feasibility_project_status__c\",\"field\":\"feasibility_project_status__c\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"completed\"},{\"id\":\"PM_Review__c\",\"field\":\"PM_Review__c\",\"type\":\"boolean\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"true\"}],\"score\":\"4\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"assessment_req_date__c\",\"field\":\"assessment_req_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"2\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"a4zm000000027niAAA\",\"field\":\"a4zm000000027niAAA\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"4\"}],\"score\":\"1\"}]}', Formula__c = 'if(pmtool.Feasibility_Completed_Date__c != null && pmtool.Feasibility_Project_Status__c == \'Completed\' && stage.PM_Review__c == True){result = 4;}else if(pmtool.Feasibility_Completed_Date__c != null && pmtool.Feasibility_Project_Status__c == \'Completed\' && pmtool.Layout_Approval_Required__c == True && pmtool.Layout_Appr_Rec_Date__c != null){result = 3;}else if(pmtool.Feasibility_Completed_Date__c != null && pmtool.Feasibility_Project_Status__c == \'Completed\' && pmtool.Layout_Approval_Required__c == False){result = 3;}else if(pmtool.Assessment_Req_Date__c != null){result = 2;}else if(pmtool.Intro_Call__c == True && previousStage.PM_Review__c == True){result = 1;}else{result = 0;}');
        insert bst;
      
        Business_Installation_Step__c ist = new Business_Installation_Step__c(name = 'Assessment', Execution_sequence__c = 1, Sequence__c = 2, Formula_Json__c = '{\"formula\":[{\"condition\":\"AND\",\"rules\":[{\"id\":\"a4zm000000027niAAA\",\"field\":\"a4zm000000027niAAA\",\"type\":\"string\",\"input\":\"text\",\"operator\":\"equal\",\"value\":\"4\"}],\"score\":\"1\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"assessment_req_date__c\",\"field\":\"assessment_req_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"2\"},{\"condition\":\"AND\",\"rules\":[{\"id\":\"assessment_comp_date__c\",\"field\":\"assessment_comp_date__c\",\"type\":\"date\",\"input\":\"text\",\"operator\":\"is_not_null\",\"value\":null}],\"score\":\"3\"}]}', Business_Stage__c = bst.id, Formula__c = 'if(pmtool.Assessment_Comp_Date__c != null){result = 3;}else if(pmtool.Assessment_Req_Date__c != null){result = 2;}else if(pmtool.Intro_Call__c == True && previousStage.PM_Review__c == True){result = 1;}else{result = 0;}');
        insert ist;
      
        PM_Tool_V2__c pmt = new PM_Tool_V2__c(Opportunity__c = opp.id,Project_PV_Install__c = pjI.id, Sales_Order__c=so.id);
        insert pmt;
        
        Map<Id,Id> salesOrder = new Map<Id,Id>();
        salesOrder.put(opp.id, so.id);
        
        PM_Tool_V2__c pmtQ = [Select id ,Name ,State__c, Project_Manager__c from PM_Tool_V2__c where id=:pmt.id];
        Business_Status__c busStat = new Business_Status__c();
        busStat.score__c = 0;
        insert busStat;
        PM_Stage__c pmStage = new PM_Stage__c(PM_Tool_V2__c = pmtQ.id, Business_Status__c = busStat.id, Business_Installation_Stage__c = bst.id);
        insert pmStage;
        List<PM_Steps__c> pmStepsList = new List<PM_Steps__c>();
        PM_Steps__c pmstp = new PM_Steps__c();
        pmstp.Business_Installation_Step__c = ist.id;
        pmstp.Business_Status__c = busStat.id;
        pmstp.PM_Stage__c = pmStage.id;
        pmstp.PM_Tool_V2__c = pmt.id;
        pmStepsList.add(pmstp);
        insert pmStepsList;
        
        PMToolV2.PMStageWrapper pmstageWrap = new PMToolV2.PMStageWrapper(pmStage, pmStepsList);
      
        PMToolV2 pmTol = new PMToolV2();
        
        pmTol.customerId = pmtQ.id;
        pmTol.selectedMarket = bm.id;
        pmTol.selectedProjectManager = pmt.Project_Manager__c;
        
        //PM_Tool_V2__c pmtool = new PM_Tool_V2__c();
        Decimal avg = 1.0;
        List<PMToolV2.PMStageWrapper> pmStageWrapper = new List<PMToolV2.PMStageWrapper>();
        PMToolV2.PMWrapper pmWrap = new PMToolV2.PMWrapper(pmtQ, avg, pmStageWrapper);

        //PMToolV2.CustomerDetailFieldWrapper custWrap = new PMToolV2.CustomerDetailFieldWrapper('ex','ex',1,'1',Date.today(),date.today());

        PMToolV2.cls_data clsWrap = new PMToolV2.cls_data();
        PMToolV2.FilterWrapper filterWrap = new PMToolV2.FilterWrapper();

        test.startTest();
        
        PMToolV2.updateStagesFirstRun = true;
        Set<Id> pmToolSet = new Set<Id>();
        //pmTol.getBusinessMarkets();
        PMToolV2.insertPMRecord(opset);
        PMToolV2.updateStages(pmToolSet,'abcd');
        PMToolV2.insertStages(pmToolSet, 'abcd');
        PMToolV2.insertStage(pmt.id,'abcd');
        PMToolV2.updatePMRecordFromProject(opset);
        PMToolV2.updatePMRecordFromOpportunity(opset);
        PMToolV2.updatePMRecordFromSalesOrder(opSet,salesOrder);
        //pmTol.loadData();
        //pmTol.viewCustomerDetail();
        PMToolV2.generateRandomString(5);
        PMToolV2.updateStageFromTrigger(pmToolSet ,'abcd');
        List<Business_Installation_Step__c> bisFilterList = new List<Business_Installation_Step__c>();
        //pmTol.populateFilterList(bisFilterList);
        
        PMToolV2.BusinessStageWrapper bsw = new PMToolV2.BusinessStageWrapper(new Business_Stage__c(), new List<Business_Installation_Step__c> ());
        bsw.size = 0;
        pmTol.filterText = '';
        pmTol.filterConditions ='';
        //PMToolV2.calculatePmStageStatus('if(pmtool.electrical_install_completed_date__c != null){result = 3;}else if(pmtool.elec_install_sch_date__c != null){result = 2;}else if(pmStep.R&P Install == 3){result = 1;}else{result = 0;}',new Map<Integer,Business_Status__c>(),new Map<String, String>(), 'random',new Map<String, PM_Stage__c>(), 'insert');
        //pmTol.projectManagerList.add(new SelectOption('',''));       
        test.stopTest();
     }*/
     
     public Static testmethod void PMTest1(){

        List<Opportunity> oppList = [select id from opportunity];
        PMToolV2.updateStagesFirstRun = true;
        Set<Id> pmToolSet = new Set<Id>();
        for(PM_Tool_V2__c pm : [select id from PM_Tool_V2__c]){
           
            PMToolV2.updateStages(pm.id, UserInfo.getSessionId());
        }
        
        

     }
     
     public Static testmethod void PMTest2(){

        List<Opportunity> oppList = [select id from opportunity];
        PMToolV2.updateStagesFirstRun = true;
        RecordType rt1 = [Select id,Name  from RecordType where name='PV Install'];
        Project__c pjI = new Project__c(Name='PV Install Project',Opportunity__c = oppList.get(0).id,RecordTypeId = rt1.id);
        insert pjI;
     }
     
     public Static testmethod void PMTest3(){

       
        PMToolV2 pm = new PMToolV2();
        
        List<Opportunity> oppList = [select id from opportunity];
        Set<Id> pmStageSet = new Set<Id>();
        for(PM_Stage__c pmStage : [select id, PM_Tool_V2__c, PM_Tool_V2__r.opportunity__c from PM_Stage__c where PM_Tool_V2__r.opportunity__c in : oppList ]){
            pmStageSet.add(pmStage.id);
        }
        
        PMToolV2.updateStageFromTrigger(pmStageSet, UserInfo.getSessionId());

     }
     
     public Static testmethod void PMTest4(){

        List<Opportunity> oppList = [select id from opportunity];
        PMToolV2.updateStagesFirstRun = true;
        RecordType rt1 = [Select id,Name  from RecordType where name='PV Feasibility'];
        Project__c pjI = new Project__c(Name='PV Feasibility Project',Opportunity__c = oppList.get(0).id,RecordTypeId = rt1.id);
        insert pjI;
     }
     
     public Static testmethod void PMTest5(){

        List<Opportunity> oppList = [select id from opportunity];
        PMToolV2.updateStagesFirstRun = true;
        RecordType rt1 = [Select id,Name  from RecordType where name='EE Assessment'];
        Project__c pjI = new Project__c(Name='PV Feasibility Project',Opportunity__c = oppList.get(0).id,RecordTypeId = rt1.id);
        insert pjI;
     }
     
     public Static testmethod void PMTest6(){

        List<Opportunity> oppList = [select id from opportunity];
        PMToolV2.updateStagesFirstRun = true;
        RecordType rt1 = [Select id,Name  from RecordType where name='EE Upgrade'];
        Project__c pjI = new Project__c(Name='PV Feasibility Project',Opportunity__c = oppList.get(0).id,RecordTypeId = rt1.id);
        insert pjI;
     }
     
     public Static testmethod void PMTest7(){

        List<Opportunity> oppList = [select id from opportunity];
        PMToolV2.updateStagesFirstRun = true;
        RecordType rt1 = [Select id,Name  from RecordType where name='PV Removal'];
        Project__c pjI = new Project__c(Name='PV Feasibility Project',Opportunity__c = oppList.get(0).id,RecordTypeId = rt1.id);
        insert pjI;
     }
     

     
}