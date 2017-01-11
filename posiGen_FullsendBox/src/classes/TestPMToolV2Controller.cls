@isTest
public with sharing class TestPMToolV2Controller {
    public static testMethod void unitTest1() {
        List<Business_Installation_Step__c> bisFilterList = new List<Business_Installation_Step__c>();
        
        Business_Status__c bStatus1 = new  Business_Status__c(name='Not Applicable',score__c=-1);
        insert bStatus1;
        Business_Status__c bStatus2 = new  Business_Status__c(name='Not Started',score__c=0);
        insert bStatus2;
        Business_Status__c bStatus3 = new  Business_Status__c(name='PM Review',score__c=1);
        insert bStatus3;
        Business_Status__c bStatus4 = new  Business_Status__c(name='In Process',score__c=2);
        insert bStatus4;
        Business_Status__c bStatus5 = new  Business_Status__c(name='Complete',score__c=3);
        insert bStatus5;
        Business_Status__c bStatus6 = new  Business_Status__c(name='Confirmed Completed',score__c=4);
        insert bStatus6;
        
        Business_Market__c bm = new Business_Market__c(name='CT');
        insert bm;
        
        String recordTypeId1  = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account pAcc= new Account(
        RecordTypeID=recordTypeId1 ,
        FirstName='Test FName',
        LastName='Test LName',
        PersonMailingStreet='test@yahoo.com',
        PersonMailingPostalCode='12345',
        PersonMailingCity='SFO',
        PersonEmail='test@yahoo.com',
        PersonHomePhone='1234567',
        PersonMobilePhone='12345678' 
        );
        insert pAcc;
        
        Property__c prop = new Property__c();
        prop.State__c = 'CT';
        prop.Account__c = pAcc.id;
        prop.Address_Line_1__c = 'Address1 Test';
        insert prop;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
   
        User u = new User(); 
        u.Username =  'Hello'+ '@testPMToolV2' + '.org'; 
        u.ProfileId = p.Id; 
        u.LastName = 'test'; 
        u.Alias = 'test1'; 
        u.Email =  'name'+ '@test' + '.org'; 
        u.TimeZoneSidKey = 'America/Los_Angeles'; 
        u.localesidkey='en_US'; 
        u.emailencodingkey='UTF-8';
        u.languagelocalekey='en_US'; 
        insert u;
        
        Opportunity opp = new Opportunity();
        opp.name = 'Test1';
        opp.Project_Manager__c = u.id;
        opp.Property__c = prop.id;
        opp.StageName = 'Layout Approval';
        opp.CloseDate = system.today();
        opp.Accountid = pAcc.id;
        insert opp;
        
        PM_Tool_V2__c pm = new PM_Tool_V2__c();
        pm.Opportunity__c = opp.id;
        pm.Project_Status__c = 'Active';
        pm.Completion_Average__c = 0.0;
        pm.Lease_Type__c = '';
        insert pm;
        
        Business_Stage__c bs = new Business_Stage__c(Name='Feasibility', Business_Market__c = bm.id, Display_In_Tracker__c=true);
        insert bs;
        
        for(Integer i = 0; i < 5; i++) {
            Business_Installation_Step__c bis = new Business_Installation_Step__c();
            bis.name = 'Test '+i;
            bis.Business_Stage__c = bs.id;
            bisFilterList.add(bis);         
        }
        insert bisFilterList;
        
        PM_Steps__c pms = new PM_Steps__c();
        pms.Aging__c = 1;
        pms.Business_Installation_Step__c = new Business_Installation_Step__c(name='test1',Business_Stage__c=bs.id).id;
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
        pms.PM_Tool_V2__c = pm.id; 
        pms.Start_Date__c = null;
        insert pms;
        List<PM_Steps__c> pmStepsList = new List<PM_Steps__c>();
        pmStepsList.add(pms);
        
        PMToolV2Controller pmtool = new PMToolV2Controller();
        pmtool.filterConditions = ' <span id="dtext_0">(Intro Call = Not Started)</span><span id="dtext_1"> and (Final Utility Approval/PTO/NM = In Process)</span> ';
        pmtool.filterText = '{\"data\":[{\"id\":0,\"step\":\"Intro Call\",\"status\":\"Not Started\"},{\"id\":1,\"step\":\"Quality Control\",\"status\":\"Completed\"}]}';
        pmtool.selectedMarket = bm.id;
        pmtool.loaddata();
        pmtool.getBusinessMarkets();
        pmtool.populateProjectManagersList('CT');
        pmtool.populateFilterList(bisFilterList);
        pmtool.getEvalConditions();
        
        ApexPages.currentPage().getParameters().put('customerId', pm.id);
        pmtool.viewCustomerDetail();
        
        pmtool.loaddata();
    }
    
    public static testMethod void unitTest2() {
        PMToolV2Controller pmtool = new PMToolV2Controller();
        pmtool.filterConditions = '';
        pmtool.filterText = '';
        pmtool.loaddata();
        pmtool.getBusinessMarkets();
        pmtool.populateProjectManagersList('');
        pmtool.populateFilterList(null);
        pmtool.getEvalConditions();
        
        ApexPages.currentPage().getParameters().put('customerId', '#');
        pmtool.viewCustomerDetail();
        pmtool.loaddata();
    }
    
    public static testMethod void unitTest3() {
        List<Business_Installation_Step__c> bisFilterList = new List<Business_Installation_Step__c>();
        
        Business_Status__c bStatus1 = new  Business_Status__c(name='Not Applicable',score__c=-1);
        insert bStatus1;
        Business_Status__c bStatus2 = new  Business_Status__c(name='Not Started',score__c=0);
        insert bStatus2;
        Business_Status__c bStatus3 = new  Business_Status__c(name='PM Review',score__c=1);
        insert bStatus3;
        Business_Status__c bStatus4 = new  Business_Status__c(name='In Process',score__c=2);
        insert bStatus4;
        Business_Status__c bStatus5 = new  Business_Status__c(name='Complete',score__c=3);
        insert bStatus5;
        Business_Status__c bStatus6 = new  Business_Status__c(name='Confirmed Completed',score__c=4);
        insert bStatus6;
        
        Business_Market__c bm = new Business_Market__c(name='NY');
        insert bm;
        
        String recordTypeId1  = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account pAcc= new Account(
        RecordTypeID=recordTypeId1 ,
        FirstName='Test FName',
        LastName='Test LName',
        PersonMailingStreet='test@yahoo.com',
        PersonMailingPostalCode='12345',
        PersonMailingCity='SFO',
        PersonEmail='test@yahoo.com',
        PersonHomePhone='1234567',
        PersonMobilePhone='12345678' 
        );
        insert pAcc;
        
        Property__c prop = new Property__c();
        prop.State__c = 'NY';
        prop.Account__c = pAcc.id;
        prop.Address_Line_1__c = 'Address1 Test';
        insert prop;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
   
        User u = new User(); 
        u.Username =  'Hello'+ '@testPMToolV2' + '.org'; 
        u.ProfileId = p.Id; 
        u.LastName = 'test'; 
        u.Alias = 'test1'; 
        u.Email =  'name'+ '@test' + '.org'; 
        u.TimeZoneSidKey = 'America/Los_Angeles'; 
        u.localesidkey='en_US'; 
        u.emailencodingkey='UTF-8';
        u.languagelocalekey='en_US'; 
        insert u;
        
        Opportunity opp = new Opportunity();
        opp.name = 'Test1';
        opp.Project_Manager__c = u.id;
        opp.Property__c = prop.id;
        opp.StageName = 'Layout Approval';
        opp.CloseDate = system.today();
        opp.Accountid = pAcc.id;
        insert opp;
        
        PM_Tool_V2__c pm = new PM_Tool_V2__c();
        pm.Opportunity__c = opp.id;
        pm.Project_Status__c = 'Active';
        insert pm;
        
        Business_Stage__c bs = new Business_Stage__c(Name='Feasibility', Business_Market__c = bm.id);
        insert bs;
        
        for(Integer i = 0; i < 5; i++) {
            Business_Installation_Step__c bis = new Business_Installation_Step__c();
            bis.name = 'Test '+i;
            bis.Business_Stage__c = bs.id;
            bisFilterList.add(bis);         
        }
        insert bisFilterList;
        
        pm.Completion_Average__c = 0.0;
        pm.Lease_Type__c = ''; 
        update pm;
        
        PM_Steps__c pms = new PM_Steps__c();
        pms.Aging__c = 1;
        pms.Business_Installation_Step__c = new Business_Installation_Step__c(name='test1',Business_Stage__c=bs.id).id;
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
        pms.PM_Tool_V2__c = pm.id; 
        pms.Start_Date__c = null;
        insert pms;
        
        PMToolV2Controller pmtool = new PMToolV2Controller();
        pmtool.selectedProjectManager = 'Dev';
        pmtool.stateChanged = false;
        pmtool.selectedMarket = 'NY';
        pmtool.filterConditions = '';
        pmtool.loaddata();
        pmtool.getBusinessMarkets();
        pmtool.populateProjectManagersList('');
        pmtool.populateFilterList(bisFilterList);
        pmtool.getEvalConditions();
        
        ApexPages.currentPage().getParameters().put('customerId', pm.id);
        pmtool.viewCustomerDetail();
        pmtool.loaddata();
    }
    
    public static testMethod void unitTest4() {
        List<Business_Installation_Step__c> bisFilterList = new List<Business_Installation_Step__c>();
        
        Business_Status__c bStatus1 = new  Business_Status__c(name='Not Applicable',score__c=-1);
        insert bStatus1;
        Business_Status__c bStatus2 = new  Business_Status__c(name='Not Started',score__c=0);
        insert bStatus2;
        Business_Status__c bStatus3 = new  Business_Status__c(name='PM Review',score__c=1);
        insert bStatus3;
        Business_Status__c bStatus4 = new  Business_Status__c(name='In Process',score__c=2);
        insert bStatus4;
        Business_Status__c bStatus5 = new  Business_Status__c(name='Complete',score__c=3);
        insert bStatus5;
        Business_Status__c bStatus6 = new  Business_Status__c(name='Confirmed Completed',score__c=4);
        insert bStatus6;
        
        Business_Market__c bm = new Business_Market__c(name='LA');
        insert bm;
        
        String recordTypeId1  = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account pAcc= new Account(
        RecordTypeID=recordTypeId1 ,
        FirstName='Test FName',
        LastName='Test LName',
        PersonMailingStreet='test@yahoo.com',
        PersonMailingPostalCode='12345',
        PersonMailingCity='SFO',
        PersonEmail='test@yahoo.com',
        PersonHomePhone='1234567',
        PersonMobilePhone='12345678' 
        );
        insert pAcc;
        
        Property__c prop = new Property__c();
        prop.State__c = 'LA';
        prop.Account__c = pAcc.id;
        prop.Address_Line_1__c = 'Address1 Test';
        insert prop;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
   
        User u = new User(); 
        u.Username =  'Hello'+ '@testPMToolV2' + '.org'; 
        u.ProfileId = p.Id; 
        u.LastName = 'test'; 
        u.Alias = 'test1'; 
        u.Email =  'name'+ '@test' + '.org'; 
        u.TimeZoneSidKey = 'America/Los_Angeles'; 
        u.localesidkey='en_US'; 
        u.emailencodingkey='UTF-8';
        u.languagelocalekey='en_US'; 
        insert u;
        
        Opportunity opp = new Opportunity();
        opp.name = 'Test1';
        opp.Project_Manager__c = u.id;
        opp.Property__c = prop.id;
        opp.StageName = 'Layout Approval';
        opp.CloseDate = system.today();
        opp.Accountid = pAcc.id;
        insert opp;
        
        PM_Tool_V2__c pm = new PM_Tool_V2__c();
        pm.Opportunity__c = opp.id;
        pm.Project_Status__c = 'Active';
        insert pm;
        
        Business_Stage__c bs = new Business_Stage__c(Name='Feasibility', Business_Market__c = bm.id);
        insert bs;
        
        for(Integer i = 0; i < 5; i++) {
            Business_Installation_Step__c bis = new Business_Installation_Step__c();
            bis.name = 'Test '+i;
            bis.Business_Stage__c = bs.id;
            bisFilterList.add(bis);         
        }
        insert bisFilterList;
        
        pm.Completion_Average__c = 0.0;
        pm.Lease_Type__c = ''; 
        update pm;
        
        PM_Steps__c pms = new PM_Steps__c();
        pms.Aging__c = 1;
        pms.Business_Installation_Step__c = new Business_Installation_Step__c(name='test1',Business_Stage__c=bs.id).id;
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
        pms.PM_Tool_V2__c = pm.id; 
        pms.Start_Date__c = null;
        insert pms;
        
        PMToolV2Controller pmtool = new PMToolV2Controller();
        pmtool.selectedMarket = '';
        pmtool.selectedProjectManager = null;
        pmtool.stateChanged = true;
        pmtool.loaddata();
        
        pmtool.filterConditions = '';
        pmtool.getBusinessMarkets();
        pmtool.populateProjectManagersList('LA');
        pmtool.populateFilterList(bisFilterList);
        pmtool.getEvalConditions();
        
        ApexPages.currentPage().getParameters().put('customerId', pm.id);
        pmtool.viewCustomerDetail();
        pmtool.loaddata();
    }
}