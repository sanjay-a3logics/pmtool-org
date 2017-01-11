@isTest (SeeAllData=true)
public class ProjectTestMethods 
{ 
    /*  Tests these Apex Triggers:
    UpdateOppFromEEUpgradeProjects*/
   /* static testMethod void testEEUpgradeProjectTriggers()
    {
        final Date euCompletedDate = date.newInstance(2014, 8, 11);
        final double EUElecDollarSavings = 10000;
        final double EUEleckWhSavings = 5000;
        final double EUGasDollarSavings = 15000;
        final double EUGasThermsSavings = 7500;
        test.startTest();
        User u1 = [SELECT Id FROM User WHERE Alias='susco'];
        
        System.runAs(u1) {
       
            Intacct_Entity__c testIntacctEntity = new Intacct_Entity__c(Name = 'PG of LA');
            insert testIntacctEntity;
            
            Intacct_Entity__c testIntacctEntity2 = new Intacct_Entity__c(Name = 'PG of CT');
            insert testIntacctEntity2;
            
            Intacct_Entity__c testIntacctEntity3 = new Intacct_Entity__c(Name = 'PG of NY');
            insert testIntacctEntity3; 
            
          Account testAcct = new Account(LastName = 'Test Account', FirstName = 'Trigger');
          insert testAcct;
        
          Opportunity testOpp = new Opportunity(Name = 'Test', Account = testAcct, StageName = 'Schedule Appointment', CloseDate = euCompletedDate);
          insert testOpp;
            
            RecordType eeUpgrade = [select Id from RecordType where Name='EE Upgrade' and SobjectType='Project__c' limit 1];
            RecordType eeAssessment = [select Id from RecordType where Name='EE Assessment' and SobjectType='Project__c' limit 1];
            
            Project__c eaProj = new Project__c();
            eaProj.Name = 'Pre-Req for EE Upgrade';
            eaProj.RecordTypeId = eeAssessment.Id;
            eaProj.Opportunity__c = testOpp.Id;
            
            insert eaProj;
            
            Project__c euProj = new Project__c();
            euProj.Name = 'Trigger Test Project 3';
            euProj.RecordTypeId = eeUpgrade.Id;
            euProj.Opportunity__c = testOpp.Id;
            euProj.EE_Assessment__c = eaProj.Id;
            
            insert euProj;
            
            
            
            euProj.EU_Projected_Elec_kWh_perYear_Savings__c = EUEleckWhSavings;
            euProj.EU_Projected_Elec_Savings_DlrsPerYr__c = EUElecDollarSavings;
            euProj.EU_Projected_Nat_Gas_Savings_yr__c = EUGasDollarSavings;
            euProj.EU_Projected_NG_Therms_PerYear_Savings__c = EUGasThermsSavings;
            euProj.EE_Completed_Date__c = euCompletedDate;
            euProj.Status__c = 'On Hold';
            
            update euProj;
            
            
            
            testOpp = [SELECT EU_Projected_Elec_kWh_perYear_Savings__c,
                      EU_Projected_Elec_Savings_DlrsPerYr__c,
                      EU_Projected_Nat_Gas_Savings_yr__c,
                      EU_Projected_NG_Therms_PerYear_Savings__c,
                      EU_Completed_Date__c,
                      EU_Status__c
                      FROM Opportunity WHERE Id = :testOpp.Id];
            
            euProj = [SELECT EU_Projected_Elec_kWh_perYear_Savings__c,
                      EU_Projected_Elec_Savings_DlrsPerYr__c,
                      EU_Projected_Nat_Gas_Savings_yr__c,
                      EU_Projected_NG_Therms_PerYear_Savings__c,
                      EE_Completed_Date__c,
                      Status__c
                      FROM Project__c WHERE Id = :euProj.Id];
            
            
            
            //system.assertEquals(testOpp.EU_Projected_Elec_kWh_perYear_Savings__c, euProj.EU_Projected_Elec_kWh_perYear_Savings__c);
            //system.assertEquals(testOpp.EU_Projected_Elec_Savings_DlrsPerYr__c, euProj.EU_Projected_Elec_Savings_DlrsPerYr__c);
            //system.assertEquals(testOpp.EU_Projected_Nat_Gas_Savings_yr__c, euProj.EU_Projected_Nat_Gas_Savings_yr__c);
            //system.assertEquals(testOpp.EU_Projected_NG_Therms_PerYear_Savings__c, euProj.EU_Projected_NG_Therms_PerYear_Savings__c);
            //system.assertEquals(testOpp.EU_Completed_Date__c, euProj.EE_Completed_Date__c);
            //system.assertEquals(testOpp.EU_Status__c,euProj.Status__c);

        }
        Test.stopTest();
    }*/
   
    /*  Tests these Apex Triggers:
    UpdateEACompletedDate*/
    static testMethod void testEEAssessmentProjectTriggers()
    {
        final Date eaCompletedDate = date.newInstance(2014, 8, 11);
        
        User u1 = [SELECT Id FROM User WHERE Alias='susco'];
        
        System.runAs(u1) {
          
            Test.startTest();
            
            Intacct_Entity__c testIntacctEntity = new Intacct_Entity__c(Name = 'PG of LA');
            insert testIntacctEntity;
            
            Intacct_Entity__c testIntacctEntity2 = new Intacct_Entity__c(Name = 'PG of CT');
            insert testIntacctEntity2;
            
            Intacct_Entity__c testIntacctEntity3 = new Intacct_Entity__c(Name = 'PG of NY');
            insert testIntacctEntity3;
            
          Account testAcct = new Account(LastName = 'Test Account', FirstName = 'Trigger');
          insert testAcct;
        
          Opportunity testOpp = new Opportunity(Name = 'Test', Account = testAcct, StageName = 'Schedule Appointment', CloseDate = eaCompletedDate);
          insert testOpp;
            
            RecordType eeAssessment = [select Id from RecordType where Name='EE Assessment' and SobjectType='Project__c' limit 1];
            
            Project__c eaProj = new Project__c();
            eaProj.Name = 'Pre-Req for EE Upgrade';
            eaProj.RecordTypeId = eeAssessment.Id;
            eaProj.Opportunity__c = testOpp.Id;
            
            insert eaProj;
            
            
            
            eaProj.EE_Completed_Date__c = eaCompletedDate;
            eaProj.Stage__c = 'Schedule';
            
            update eaProj;
            
            
            
            eaProj = [SELECT EE_Completed_Date__c,
                      Status__c
                     FROM Project__c WHERE Id = :eaProj.Id];
            
            testOpp = [SELECT EA_Completed_Date__c,
                       EA_Status__c
                      FROM Opportunity WHERE Id = :testOpp.Id];
            
            Test.stopTest();
            
            //system.assertEquals(testOpp.EA_Completed_Date__c, eaProj.EE_Completed_Date__c);
            //system.assertEquals(testOpp.EA_Status__c, eaProj.Status__c);
        }
    }
    
    /*  Tests these Apex Triggers:
      UpdateRailsInstalledDate
        updatePVIRailsPanelsLeftWHDate
        UpdatePVIPlacedInServiceDate
      UpdatePanelInstallDate
    UpdateInformedNetMeterInstalledDate
    UpdateFinalThirdPartyInspectionDate
    UpdateElectricLeftWH
    UpdateElectricalInstallDate
       */
   /* static testMethod void testPVInstallProjectTriggers()
        
    {
        final Date railsAndPanelsLeftWHDate = date.newInstance(2014, 8, 11);
        final Date placedInServiceDate = date.newInstance(2014,8,12);
        final Date electricLeftWHDate = date.newInstance(2014,8,13);
        final Date informedNetMeterInstalledDate = date.newInstance(2014,8,14);
        final Date final3rdPartyInspectionDate = date.newInstance(2014, 8, 15);
        final Date electricalInstallDate = date.newInstance(2014,8,16);
        final Date railsInstalledDate = date.newInstance(2014,8,17);
        final Date panelsInstalledDate = date.newInstance(2014,8,18);
        final Date billingPacketApprovedDate = date.newInstance(2014, 12, 19);
        final Decimal grossSystemCost = 22000;
        
        User u1 = [SELECT Id FROM User WHERE Alias='susco'];
        
        System.runAs(u1) 
        {
            
            Test.startTest();
            
          Intacct_Entity__c testIntacctEntity = new Intacct_Entity__c(Name = 'PG of LA');
            insert testIntacctEntity;
            
            Intacct_Entity__c testIntacctEntity2 = new Intacct_Entity__c(Name = 'PG of CT');
            insert testIntacctEntity2;
            
            Intacct_Entity__c testIntacctEntity3 = new Intacct_Entity__c(Name = 'PG of NY');
            insert testIntacctEntity3;
            
            Account testAcct = new Account(LastName = 'Test Account', FirstName = 'Trigger');
            insert testAcct;
            
            Opportunity testOpp = new Opportunity(Name = 'Test', Account = testAcct, StageName = 'Schedule Appointment', CloseDate = railsAndPanelsLeftWHDate);
            insert testOpp;
            
            RecordType pvInstall = [select Id from RecordType where Name='PV Install' and SobjectType='Project__c' limit 1];
            
            Project__c pviProj = new Project__c();
            pviProj.Name = 'Test PV Install Project';
            pviProj.Opportunity__c = testOpp.Id;
            pviProj.RecordTypeId = pvInstall.Id;
            
            insert pviProj;
            
            
            
            pviProj.PVI_Placed_In_Service_Date__c = placedInServiceDate;
            pviProj.PVI_Electrical_Left_Warehouse_Date__c = electricLeftWHDate;
            pviProj.PV_Net_Meter_Install_Verified_Date__c = informedNetMeterInstalledDate;
            pviProj.Final_3rd_Party_Inspection_Compete_Date__c = final3rdPartyInspectionDate;
            pviProj.PVI_Electrical_Installed_Date__c = electricalInstallDate;
            pviProj.PVI_Rails_and_Panels_Left_Warehouse_Date__c = railsAndPanelsLeftWHDate;
            pviProj.PVI_Rails_Installed_Date__c = railsInstalledDate;
            pviProj.PVI_Panels_Installed_Date__c = panelsInstalledDate;
            pviProj.Gross_System_Cost_in_Dollars__c = grossSystemCost;
            pviProj.Billing_Packet_Approved_Date__c = billingPacketApprovedDate;
            
            update pviProj;
            
            
            
            testOpp = [SELECT PVI_Placed_In_Service_Date__c,PVI_Rails_and_Panels_Left_WH_Date__c, PVI_Electrical_Installed_Date__c, PVI_Electric_Left_WH_Date__c,
                      PVI_Net_Meter_Install_Date__c,Final_3rd_Party_Inspection_Compete_Date__c,PVI_Rails_Installed_Date__c,PVI_Panels_Installed_Date__c, Gross_System_Cost_In_Dollars__c, Billing_Packet_Approved_Date__c
                      FROM Opportunity WHERE Id = :testOpp.Id];
            
            pviProj = [SELECT PVI_Placed_In_Service_Date__c,PVI_Rails_and_Panels_Left_Warehouse_Date__c, PVI_Electrical_Installed_Date__c, PVI_Electrical_Left_Warehouse_Date__c,
                      PV_Net_Meter_Install_Verified_Date__c,Final_3rd_Party_Inspection_Compete_Date__c,PVI_Rails_Installed_Date__c,PVI_Panels_Installed_Date__c, Gross_System_Cost_In_Dollars__c, Billing_Packet_Approved_Date__c
                      FROM Project__c WHERE Id = :pviProj.Id];
            
            Test.stopTest();
            
            //system.assertEquals(pviProj.PVI_Placed_In_Service_Date__c, testOpp.PVI_Placed_In_Service_Date__c);
            //system.assertEquals(pviProj.PVI_Electrical_Left_Warehouse_Date__c, testOpp.PVI_Electric_Left_WH_Date__c);
            //system.assertEquals(pviProj.PV_Net_Meter_Install_Verified_Date__c, testOpp.PVI_Net_Meter_Install_Date__c);
            //system.assertEquals(pviProj.Final_3rd_Party_Inspection_Compete_Date__c, testOpp.Final_3rd_Party_Inspection_Compete_Date__c);
            //system.assertEquals(pviProj.PVI_Electrical_Installed_Date__c, testOpp.PVI_Electrical_Installed_Date__c);
            //system.assertEquals(pviProj.PVI_Rails_and_Panels_Left_Warehouse_Date__c, testOpp.PVI_Rails_and_Panels_Left_WH_Date__c);
            //system.assertEquals(pviProj.PVI_Rails_Installed_Date__c, testOpp.PVI_Rails_Installed_Date__c);  
            //system.assertEquals(pviProj.PVI_Panels_Installed_Date__c, testOpp.PVI_Panels_Installed_Date__c);
            //system.assertEquals(pviProj.Gross_System_Cost_in_Dollars__c, testOpp.Gross_System_Cost_in_Dollars__c);
            //system.assertEquals(pviProj.Billing_Packet_Approved_Date__c, testOpp.Billing_Packet_Approved_Date__c);
            
        }
    }*/

    
    /*  Tests these Apex Triggers: 
      UpdatePVAAssessmentCompleteDate
    UpdateFeasibilityResult*/
    /*static testMethod void testPVFeasibilityProjectTriggers()
    {
        final String assessmentResult = 'Feasible';
        final Date markedCompletedOnDate = date.newInstance(2014, 8, 12);
        
        User u1 = [SELECT Id FROM User WHERE Alias='susco'];
        
        System.runAs(u1) 
        {
        Intacct_Entity__c testIntacctEntity = new Intacct_Entity__c(Name = 'PG of LA');
            insert testIntacctEntity;
            
            Intacct_Entity__c testIntacctEntity2 = new Intacct_Entity__c(Name = 'PG of CT');
            insert testIntacctEntity2;
            
            Intacct_Entity__c testIntacctEntity3 = new Intacct_Entity__c(Name = 'PG of NY');
            insert testIntacctEntity3;

            Account testAcct = new Account(LastName = 'Test Account', FirstName = 'Trigger');
            insert testAcct;
            
            Opportunity testOpp = new Opportunity(Name = 'Test', Account = testAcct, StageName = 'Schedule Appointment', CloseDate = markedCompletedOnDate);
            insert testOpp;
            
            RecordType pvFeas = [select Id from RecordType where Name='PV Feasibility' and SobjectType='Project__c' limit 1];
            
            Project__c pvaProj = new Project__c();
            pvaProj.Name = 'Test PV Feasibility Project';
            pvaProj.Opportunity__c = testOpp.Id;
            pvaProj.RecordTypeId = pvFeas.Id;
            
            insert pvaProj;
            
            pvaProj.Result__c = assessmentResult;
            pvaProj.Marked_Completed_On_Date__c = markedCompletedOnDate;
            
            update pvaProj;
            
            testOpp = [SELECT Result__c,
                      PVA_Assessment_Complete_Date__c
                      FROM Opportunity WHERE Id = :testOpp.Id];
            
            pvaProj = [SELECT Result__c,
                      Marked_Completed_On_Date__c
                      FROM Project__c WHERE Id = :pvaProj.Id];
        }
    }*/
    
    static testMethod void testPVRemovalProjectTriggers()
    {
        final Date removalDate = date.newInstance(2015, 2, 4);
        
        User u1 = [SELECT Id FROM User WHERE Alias='susco'];
        
        System.runAs(u1) {
       
            Test.startTest();
            
            Intacct_Entity__c testIntacctEntity = new Intacct_Entity__c(Name = 'PG of LA');
            insert testIntacctEntity;
            
            Intacct_Entity__c testIntacctEntity2 = new Intacct_Entity__c(Name = 'PG of CT');
            insert testIntacctEntity2;
            
            Intacct_Entity__c testIntacctEntity3 = new Intacct_Entity__c(Name = 'PG of NY');
            insert testIntacctEntity3; 
            
          Account testAcct = new Account(LastName = 'Test Account', FirstName = 'Trigger');
          insert testAcct;
        
          Opportunity testOpp = new Opportunity(Name = 'Test', Account = testAcct, StageName = 'Schedule Appointment', CloseDate = removalDate);
          insert testOpp;
            
            RecordType removalProj = [select Id from RecordType where Name='PV Removal' and SobjectType='Project__c' limit 1];
            
            Project__c remProj = new Project__c();
            remProj.Name = 'Test PV Install Project';
            remProj.Opportunity__c = testOpp.Id;
            remProj.RecordTypeId = removalProj.Id;
            
            insert remProj;
            
            
            
            remProj.R_P_Removal_Date__c = removalDate;
            remProj.Permanent_Removal__c = TRUE;
            
            update remProj;
            
            
            
            testOpp = [SELECT R_P_Removal_Date__c, Permanent_Removal__c FROM Opportunity WHERE Id = : testOpp.Id];
            
            remProj = [SELECT R_P_Removal_Date__c, Permanent_Removal__c FROM Project__c WHERE Id = : remProj.Id];
            
            Test.stopTest();
            
            //system.assertEquals(remProj.R_P_Removal_Date__c, testOpp.R_P_Removal_Date__c);
            //system.assertEquals(remProj.Permanent_Removal__c, testOpp.Permanent_Removal__c);
            
            
            remProj.Permanent_Removal__c = FALSE;
            
            update remProj;
            
            testOpp = [SELECT R_P_Removal_Date__c, Permanent_Removal__c FROM Opportunity WHERE Id = : testOpp.Id];
            
            remProj = [SELECT R_P_Removal_Date__c, Permanent_Removal__c FROM Project__c WHERE Id = : remProj.Id];            
            
            //system.assertEquals(remProj.Permanent_Removal__c, testOpp.Permanent_Removal__c);
            
            
        }
    }
    
  /*  static testMethod void testLockoutProjectTriggers()
    {
        
        final Date oppCloseDate = date.newInstance(2015, 02, 12);
        
        User u1 = [SELECT Id FROM User WHERE Alias = 'susco'];
        
        System.runAs(u1) 
        {
            Intacct_Entity__c testIntacctEntity = new Intacct_Entity__c(Name = 'PG of LA');
            insert testIntacctEntity;
            
            Intacct_Entity__c testIntacctEntity2 = new Intacct_Entity__c(Name = 'PG of CT');
            insert testIntacctEntity2;
            
            Intacct_Entity__c testIntacctEntity3 = new Intacct_Entity__c(Name = 'PG of NY');
            insert testIntacctEntity3; 
            
            Account testAcct = new Account(LastName = 'Test Account', FirstName = 'Trigger');
          insert testAcct;
          
            Opportunity testOpp = new Opportunity(Name = 'Test', Account = testAcct, StageName = 'Schedule Appointment', CloseDate = oppCloseDate);
          insert testOpp;        
            
            RecordType lockoutRT = [SELECT Id FROM RecordType WHERE Name = 'Lockout' AND SobjectType = 'Project__c' LIMIT 1];
            
            Project__c lockProj = new Project__c();
            lockProj.Name = 'Test Lockout';
            lockProj.RecordTypeId = lockoutRT.Id;
            lockProj.Opportunity__c = testOpp.id;
            
            insert lockProj;
            
            lockProj.Request_Type__c = 'Disconnect';
            lockProj.Status__c = 'Completed';
            
            update lockProj;
            
            testOpp = [SELECT Disconnect_Status__c FROM Opportunity WHERE Id = : testOpp.Id];
            
            //system.assertEquals('Disconnected', testOpp.Disconnect_Status__c);
            
            lockProj.Request_Type__c = 'Reconnect';
            
            update lockProj;
            
            testOpp = [SELECT Disconnect_Status__c FROM Opportunity WHERE Id = : testOpp.Id];
            
            //system.assertEquals('Reconnected', testOpp.Disconnect_Status__c);
            
        }
    }*/
}   

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
        //    euProj.EU_Projected_Elec_Savings_DlrsPerYr__c = EUElecDollarSavings;
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
                  //   EU_Projected_Elec_kWh_perYear_Savings__c,
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
                     //  EU_Projected_Elec_Savings_DlrsPerYr__c,
                       EU_Projected_Nat_Gas_Savings_yr__c,
                       EU_Projected_NG_Therms_PerYear_Savings__c
                       FROM Opportunity WHERE Id = :testOpp.Id ];
            
            //Assert that the trigger(s) made the expected changes
          //system.assertEquals(testOpp.PVI_Rails_Installed_Date__c, testProj.PVI_Rails_Installed_Date__c );
            //system.assertEquals(testOpp.PVI_Panels_Installed_Date__c, testProj.PVI_Panels_Installed_Date__c);
            //system.assertEquals(testOpp.PVI_Electrical_Installed_Date__c, testProj.PVI_Electrical_Installed_Date__c);
            //system.assertEquals(testOpp.Informed_Net_Meter_Installed_Date__c, testProj.PV_Net_Meter_Install_Verified_Date__c);
            //system.assertEquals(testOpp.Final_3rd_Party_Inspection_Compete_Date__c, testProj.Final_3rd_Party_Inspection_Compete_Date__c);
            //system.assertEquals(testOpp.Result__c, testProj.Result__c);
            //system.assertEquals(testOpp.PVI_Rails_and_Panels_Left_WH_Date__c, testProj.PVI_Rails_and_Panels_Left_Warehouse_Date__c);
            //system.assertEquals(testOpp.PVI_Electric_Left_WH_Date__c, testProj.PVI_Electrical_Left_Warehouse_Date__c);
            //system.assertEquals(testOpp.PVI_Placed_In_Service_Date__c, testProj.PVI_Placed_In_Service_Date__c);
            //system.assertEquals(testOpp.PVA_Assessment_Complete_Date__c, testProj.Marked_Completed_On_Date__c.date());
            //system.assertEquals(testOpp.EA_Completed_Date__c, eaProj.EE_Completed_Date__c);
            //system.assertEquals(testOpp.EU_Completed_Date__c, euProj.EE_Completed_Date__c);
            //system.assertEquals(testopp.EU_Projected_Elec_kWh_perYear_Savings__c,euProj.EU_Projected_Elec_kWh_perYear_Savings__c);
          //  //system.assertEquals(testopp.EU_Projected_Elec_Savings_DlrsPerYr__c, euProj.EU_Projected_Elec_Savings_DlrsPerYr__c);
            //system.assertEquals(testOpp.EU_Projected_Nat_Gas_Savings_yr__c, euProj.EU_Projected_Nat_Gas_Savings_yr__c);
            //system.assertEquals(testOpp.EU_Projected_NG_Therms_PerYear_Savings__c, euProj.EU_Projected_NG_Therms_PerYear_Savings__c);
        }
}
}*/