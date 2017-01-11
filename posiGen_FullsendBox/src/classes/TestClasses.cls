@isTest (SeeAllData=true)
private class TestClasses{
    
	// testProjectUpdateTriggers moved to ProjectTestMethods Apex class 
    /*static testMethod void testProjectUpdateTriggers()  
    {
        
        //Initialize test data 
        final Date railsDate = date.newInstance(2014, 5, 27);
         final Date panelDate = date.newInstance(2014, 5, 27);

        final Date electricDate = date.newInstance(2014, 5, 27);
        final Date netMeterDate = date.newInstance(2014, 5, 27);
        final Date finalInspectionDate = date.newInstance(2014, 5, 27);
        final String assessmentResult = 'Feasible';
        final Date railsPanelsLeftWHDate = date.newInstance(2014, 6, 25);
        final Date electricLeftWHDate = date.newInstance(2014, 7, 1);
        final Date placedInServiceDate = date.newInstance(2014, 7, 1);
        final Date markedCompletedOnDate = date.newInstance(2014, 7, 1);
        final Date EACompletedDate = date.newInstance(2014, 7, 1);
        final Date EUCompletedDate = date.newInstance(2014, 7, 1);
        final double EUElecDollarSavings = 10000;
        final double EUEleckWhSavings = 5000;
        final double EUGasDollarSavings = 15000;
        final double EUGasThermsSavings = 7500;
        
        User u1 = [SELECT Id FROM User WHERE Alias='susco'];
        
        
        System.RunAs(u1){
            
            //Initialize test sObject and insert them into database
            Account testAcct = new Account(LastName = 'Test Account', FirstName = 'Trigger');
            insert testAcct;
            System.debug('Using Apex triggers to update fields from Projects to Opportunities');
            
            Opportunity testOpp = new Opportunity(Name = 'Test', Account = testAcct, StageName = 'Schedule Appointment', CloseDate = railsDate);
            insert testOpp;
            
            RecordType pvAssess = [select Id from RecordType where Name='PV Feasibility' and SobjectType='Project__c' limit 1]; // grab PV Feasibility RecordTypeId
            
            Project__c testProj = new Project__c();
            testProj.Name = 'Trigger Test Project';
            testProj.Opportunity__c = testOpp.Id;
            testProj.RecordTypeId = pvAssess.Id;
            
            RecordType eeAssessment = [select Id from RecordType where Name='EE Assessment' and SobjectType='Project__c' limit 1];
            RecordType eeUpgrade = [select Id from RecordType where Name='EE Upgrade' and SobjectType='Project__c' limit 1];
            
            Project__c eaProj = new Project__c();
            eaProj.Name = 'Trigger Test Project 2';
            eaProj.RecordTypeId = eeAssessment.Id;
            eaProj.Opportunity__c = testOpp.Id;
            
            Project__c euProj = new Project__c();
            euProj.Name = 'Trigger Test Project 3';
            euProj.RecordTypeId = eeUpgrade.Id;
            euProj.Opportunity__c = testOpp.Id;
            
            insert testProj;
            insert eaProj;
            insert euProj;
            
            //Set trigger-firing variables on project record
            testProj.PVI_Rails_Installed_Date__c = railsDate;
            testProj.PVI_Panels_Installed_Date__c = panelDate;
            testProj.PVI_Electrical_Installed_Date__c = electricDate;
            testProj.PV_Net_Meter_Install_Verified_Date__c = netMeterDate;
            testProj.Final_3rd_Party_Inspection_Compete_Date__c = finalInspectionDate;
            testProj.Result__c = assessmentResult;
            testProj.PVI_Rails_and_Panels_Left_Warehouse_Date__c = railsPanelsLeftWHDate;
            testProj.PVI_Electrical_Left_Warehouse_Date__c = electricLeftWHDate;
            testProj.PVI_Placed_In_Service_Date__c = placedInServiceDate;
            testProj.Marked_Completed_On_Date__c = markedCompletedOnDate;
            
            eaProj.EE_Completed_Date__c = EACompletedDate;
            
            euProj.EE_Completed_Date__c = EUCompletedDate;
            euProj.EU_Projected_Elec_kWh_perYear_Savings__c = EUEleckWhSavings;
            euProj.EU_Projected_Elec_Savings_DlrsPerYr__c = EUElecDollarSavings;
            euproj.EU_Projected_Nat_Gas_Savings_yr__c = EUGasDollarSavings;
            euproj.EU_Projected_NG_Therms_PerYear_Savings__c = EUGasThermsSavings;
            
            //Update project record
            update testProj;
            update eaProj;
            update euProj;
            
            //Pull the records (and updated fields) to variables
            testProj = [SELECT Id, Name, Opportunity__c, 
                        PVI_Rails_Installed_Date__c,
                        PVI_Panels_Installed_Date__c ,
                        PVI_Electrical_Installed_Date__c,
                        PV_Net_Meter_Install_Verified_Date__c,
                        Final_3rd_Party_Inspection_Compete_Date__c,
                        Result__c,
                        PVI_Rails_and_Panels_Left_Warehouse_Date__c,
                        PVI_Electrical_Left_Warehouse_Date__c,
                        PVI_Placed_In_Service_Date__c,
                        Marked_Completed_On_Date__c
                        FROM Project__c Where id = :testProj.id ];
            
            eaProj = [SELECT Id, Name, Opportunity__c,
                     EE_Completed_Date__c
                     FROM Project__c WHERE id = :eaProj.Id];
            
            euProj = [SELECT Id, Name, Opportunity__c,
                     EE_Completed_Date__c,
                     EU_Projected_Elec_kWh_perYear_Savings__c,
                     EU_Projected_Elec_Savings_DlrsPerYr__c,
                     EU_Projected_Nat_Gas_Savings_yr__c,
                     EU_Projected_NG_Therms_PerYear_Savings__c 
                     FROM Project__c WHERE id = :euProj.Id];
            
            
            testOpp = [SELECT Id, Name, 
                       PVI_Rails_Installed_Date__c,
                       PVI_Panels_Installed_Date__c ,
                       PVI_Electrical_Installed_Date__c,
                       Informed_Net_Meter_Installed_Date__c,
                       Final_3rd_Party_Inspection_Compete_Date__c,
                       Result__c,
                       PVI_Rails_and_Panels_Left_WH_Date__c,
                       PVI_Electric_Left_WH_Date__c,
                       PVI_Placed_In_Service_Date__c,
                       PVA_Assessment_Complete_Date__c,
                       EA_Completed_Date__c,
                       EU_Completed_Date__c,
                       EU_Projected_Elec_kWh_perYear_Savings__c,
                       EU_Projected_Elec_Savings_DlrsPerYr__c,
                       EU_Projected_Nat_Gas_Savings_yr__c,
                       EU_Projected_NG_Therms_PerYear_Savings__c
                       FROM Opportunity WHERE Id = :testOpp.Id ];
            
            //Assert that the trigger(s) made the expected changes
        	System.assertEquals(testOpp.PVI_Rails_Installed_Date__c, testProj.PVI_Rails_Installed_Date__c );
            System.assertEquals(testOpp.PVI_Panels_Installed_Date__c, testProj.PVI_Panels_Installed_Date__c);
            System.assertEquals(testOpp.PVI_Electrical_Installed_Date__c, testProj.PVI_Electrical_Installed_Date__c);
            System.assertEquals(testOpp.Informed_Net_Meter_Installed_Date__c, testProj.PV_Net_Meter_Install_Verified_Date__c);
            System.assertEquals(testOpp.Final_3rd_Party_Inspection_Compete_Date__c, testProj.Final_3rd_Party_Inspection_Compete_Date__c);
            System.assertEquals(testOpp.Result__c, testProj.Result__c);
            System.assertEquals(testOpp.PVI_Rails_and_Panels_Left_WH_Date__c, testProj.PVI_Rails_and_Panels_Left_Warehouse_Date__c);
            System.assertEquals(testOpp.PVI_Electric_Left_WH_Date__c, testProj.PVI_Electrical_Left_Warehouse_Date__c);
            System.assertEquals(testOpp.PVI_Placed_In_Service_Date__c, testProj.PVI_Placed_In_Service_Date__c);
            System.assertEquals(testOpp.PVA_Assessment_Complete_Date__c, testProj.Marked_Completed_On_Date__c.date());
            System.assertEquals(testOpp.EA_Completed_Date__c, eaProj.EE_Completed_Date__c);
            System.assertEquals(testOpp.EU_Completed_Date__c, euProj.EE_Completed_Date__c);
            System.assertEquals(testopp.EU_Projected_Elec_kWh_perYear_Savings__c,euProj.EU_Projected_Elec_kWh_perYear_Savings__c);
            System.assertEquals(testopp.EU_Projected_Elec_Savings_DlrsPerYr__c, euProj.EU_Projected_Elec_Savings_DlrsPerYr__c);
            System.assertEquals(testOpp.EU_Projected_Nat_Gas_Savings_yr__c, euProj.EU_Projected_Nat_Gas_Savings_yr__c);
            System.assertEquals(testOpp.EU_Projected_NG_Therms_PerYear_Savings__c, euProj.EU_Projected_NG_Therms_PerYear_Savings__c);
        }
        
        
    }*/
    
    static testMethod void testLeaseInsertTriggers() 
    {
        
        final String boardingStatus = 'Need to Board';
        final Date opportunityDate = date.newInstance(2014, 7, 14);
        
        User u1 = [SELECT Id FROM User WHERE Alias='susco'];
        
        System.RunAs(u1){
            
            Intacct_Entity__c testIntacctEntity = new Intacct_Entity__c(Name = 'PG of LA');
            insert testIntacctEntity;
            
            Intacct_Entity__c testIntacctEntity2 = new Intacct_Entity__c(Name = 'PG of CT');
            insert testIntacctEntity2;
            
            Intacct_Entity__c testIntacctEntity3 = new Intacct_Entity__c(Name = 'PG of NY');
            insert testIntacctEntity3;
            
            Account testAcct = new Account(LastName = 'Test Account', FirstName = 'Trigger');
            insert testAcct;
            System.debug('Using Apex Triggers to update fields from Leases to Opportunities');
            
            Opportunity testOpp = new Opportunity(Name = 'Test', Account = testAcct, StageName = 'Schedule Appointment', CloseDate = opportunityDate);
            insert testOpp;
            
            Lease__c testLease = new Lease__c();
            testLease.Account__c = testAcct.Id;
            testLease.Opportunity__c = testOpp.Id;
            testLease.LMS_Account_Number__c = '999999999';
            testLease.Name = '999999';
            testLease.Lease_Term__c = 1000;
            testLease.Boarding_Status__c = boardingStatus;
            insert testLease;
            
            testLease = [SELECT Id, Name, Account__c, Opportunity__c, LMS_Account_Number__c, Lease_Term__c,
                        Boarding_Status__c
                        FROM Lease__c WHERE id = :testLease.Id];
            
            testOpp = [SELECT Id, Name,
                      Lease_Boarding_Status__c
                      FROM Opportunity WHERE Id = :testOpp.Id];
            
            System.assertEquals(testOpp.Lease_Boarding_Status__c, testLease.Boarding_Status__c);
            
        }
    }
    
    static testMethod void testLeaseUpdateTriggers() 
    {
        
        final String boardingStatus = 'Need to Board';
        final String updateBoardingStatus = 'Research Before Boarding';
        final Date opportunityDate = date.newInstance(2014, 7, 14);
        
        User u1 = [SELECT Id FROM User WHERE Alias='susco'];
        
        System.RunAs(u1){
            
            
            Account testAcct = new Account(LastName = 'Test Account', FirstName = 'Trigger');
            insert testAcct;
            System.debug('Using Apex Triggers to update fields from Leases to Opportunities');
            
            Opportunity testOpp = new Opportunity(Name = 'Test', Account = testAcct, StageName = 'Schedule Appointment', CloseDate = opportunityDate);
            insert testOpp;
            
            Lease__c testLease = new Lease__c();
            testLease.Account__c = testAcct.Id;
            testLease.Opportunity__c = testOpp.Id;
            testLease.LMS_Account_Number__c = '999999999';
            testLease.Name = '999999';
            testLease.Lease_Term__c = 1000;
            testLease.Boarding_Status__c = boardingStatus;
            insert testLease;
            
            testLease.Boarding_Status__c = updateBoardingStatus;
            
            update testLease;
            
            testLease = [SELECT Id, Name, Account__c, Opportunity__c, LMS_Account_Number__c, Lease_Term__c,
                        Boarding_Status__c
                        FROM Lease__c WHERE id = :testLease.Id];
            
            testOpp = [SELECT Id, Name,
                      Lease_Boarding_Status__c
                      FROM Opportunity WHERE Id = :testOpp.Id];
            
            System.assertEquals(testOpp.Lease_Boarding_Status__c, testLease.Boarding_Status__c);
    }
}
    
  static testMethod void testCaseUpdateTriggers() 
    {
        final Date oppDate = date.newInstance(2014, 7, 22);
        final decimal theCount = 1;
        
        User u1 = [SELECT Id FROM User WHERE Alias='susco'];
        
        System.RunAs(u1) 
        {
            Intacct_Entity__c testIntacctEntity = new Intacct_Entity__c(Name = 'PG of LA');
            insert testIntacctEntity;
            
            Intacct_Entity__c testIntacctEntity2 = new Intacct_Entity__c(Name = 'PG of CT');
            insert testIntacctEntity2;
            
            Intacct_Entity__c testIntacctEntity3 = new Intacct_Entity__c(Name = 'PG of NY');
            insert testIntacctEntity3;
            
            Account testAcct = new Account(LastName = 'Test Account', FirstName = 'Trigger');
            insert testAcct;
            System.debug('Using Apex Triggers to update fields from Cases to Accounts');
            
            Opportunity testOpp = new Opportunity(Name = 'Test', AccountId = testAcct.Id, StageName = 'Schedule Appointment', CloseDate = oppDate );
            insert testOpp;
            
            RecordType pvAssess = [select Id from RecordType where Name='PV Feasibility' and SobjectType='Project__c' limit 1]; // grab PV Feasibility RecordTypeId
            
            Project__c testProj = new Project__c();
            testProj.Name = 'Trigger Test Project';
            testProj.Opportunity__c = testOpp.Id;
            testProj.RecordTypeId = pvAssess.Id;
            
            insert testProj;
            
            Case testCase = new Case(RecordTypeId = '012d0000000OywDAAS',AccountId = testAcct.Id,PG_Product__c = testProj.Id,Mobile_Number__c = '5045551234',Status = 'New',Reason = 'System Error',Origin = 'Phone',Service_Description__c = 'Electrical');
         
            insert testCase;
            
            
            
            testAcct = [SELECT Id,Num_of_Open_Cases__c FROM Account WHERE id = :testAcct.Id LIMIT 1];
            
            System.assertEquals(testAcct.Num_of_Open_Cases__c, theCount);
        }
    }
    
   /* static testMethod void testUpdateLDLeaseFromTask()
    {
        
        
        
        User u1 = [SELECT Id FROM User WHERE Alias='susco'];
        
        System.RunAs(u1) 
        {
            Intacct_Entity__c testIntacctEntity = new Intacct_Entity__c(Name = 'PG of LA');
            insert testIntacctEntity;
            
            Intacct_Entity__c testIntacctEntity2 = new Intacct_Entity__c(Name = 'PG of CT');
            insert testIntacctEntity2;
            
            Intacct_Entity__c testIntacctEntity3 = new Intacct_Entity__c(Name = 'PG of NY');
            insert testIntacctEntity3;
            
            Account testAcct = new Account(LastName = 'Test Account', FirstName = 'Trigger');
            insert testAcct;
            
            Task testTask = new Task();
            testTask.WhatId = testAcct.Id;
            testTask.Description = 'test comments';
            testTask.Type = 'Call';
            
            insert testTask;
            
            testAcct = [SELECT Id, Last_Call_Comment__c, Last_Call_Type__c FROM Account WHERE Id = : testAcct.Id];
            
            System.assertEquals('test comments', testAcct.Last_Call_Comment__c);
            System.assertEquals('Call', testAcct.Last_Call_Type__c);
        }
    }*/
}

    /* Not Complete Yet */
/*    static testMethod void testEventUpdateTriggers()
    {
        final Date oppDate = date.newInstance(2014, 7, 25);
        
        User u1 = [SELECT Id FROM User WHERE Alias='susco'];
        
        System.RunAs(u1)
        {
            Account testAcct = new Account(LastName = 'Test Account', FirstName = 'Trigger');
            insert testAcct;
            System.debug('Using Apex Triggers to test update fields from Events to Accounts');
            
            Opportunity testOpp = new Opportunity(Name = 'Test', AccountId = testAcct.Id, StageName = 'Schedule Appointment', CloseDate = oppDate);
            insert testOpp;
        }
    }*/