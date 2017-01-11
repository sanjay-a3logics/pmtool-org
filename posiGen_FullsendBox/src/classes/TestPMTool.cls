@isTest
public class TestPMTool{
  
  public Static testmethod void PMTest1(){
        
        Boolean result = false;
        
        Profile profiles=[Select Id From Profile Where Name='System Administrator']; 
        
        String orgId = UserInfo.getOrganizationId(); 
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-',''); 
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000)); 
        String uniqueName = orgId + dateString + randomInt; 
        
        User u = new User(); 
        u.Username =  uniqueName + '@testPMTool' + orgId + '.org'; 
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
        OpportunityTriggerHandler.firstRun =false;
        Deal__c opp = new Deal__c();
        ////opp.name = 'Test opp';
        opp.property__c=pr.id;
        opp.accountId__c = acc.id;          
        opp.CloseDate__c = date.today();
        opp.stageName__c = 'Closed Won';
        insert opp;
        opSet.add(opp.id);
        
        Sales_Order__c so= new Sales_Order__c(Account__c = acc.id,Deal__c = opp.id);
        insert so;
        
        UtilityController.recursive =true;
        UtilityController.pmtool_flag =true;
        
        RecordType rt1 = [Select id,Name  from RecordType where name='PV Install'];
        Project__c pjI = new Project__c(Name='PV Install Project',Deal__c = opp.id,RecordTypeId = rt1.id);
        insert pjI;
        
        //pjI.Name='PV Install Project1';
        //update pjI;
        
        Set<Id> prjset = new Set<Id>();
        Project__c ProjI = [Select id, Name ,Deal__c,RecordType.Name  from Project__c where id=:pjI.id];
        prjset.add(ProjI.id);
        
        Business_Market__c bm = new Business_Market__c(name = 'CT');
        insert bm;
               
        
        Installation_Step__c ist = new Installation_Step__c(name='Initial_Utility_Approval/Net_Metering');
        insert ist;
        
        Market_Installation_Step__c mis = new Market_Installation_Step__c(Business_Market__c = bm.id,Installation_Step__c = ist.id,Display_In_Tracker__c = true,Sequence__c = 1);
        insert mis;
       
        PM_Tool__c pmt = new PM_Tool__c(Deal__c = opp.id,Project_Manager__c=u.id,
                                        Project__c=ProjI.id,Property__c=pr.id,Sales_Order__c=so.id);
        insert pmt;
        
        PM_Tool__c pmtQ = [Select id ,Name ,State__c, Project_Manager__c from PM_Tool__c where id=:pmt.id];
        
      
        PMTool pmTol = new PMTool();
        pmTol.customerId = pmtQ.id;
        pmTol.selectedMarket = bm.id;
        pmTol.selectedProjectManager = pmt.Project_Manager__c;
        test.startTest();
        pmTol.getBusinessMarkets();
        PMTool.updatePMRecord(prjset,'hello');
        PMTool.createPMRecord(opset);
        PMTool.updatePMRecordFromOpportunity(opset);
        pmTol.loadData();
        pmTol.viewCustomerDetail();
        test.stopTest();
     }
    public Static testmethod void PMTest2(){
        /*test.startTest();
        Boolean result = false;
        
        Profile profiles=[Select Id From Profile Where Name='System Administrator']; 
        
        String orgId = UserInfo.getOrganizationId(); 
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-',''); 
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000)); 
        String uniqueName = orgId + dateString + randomInt; 
        
        User u = new User(); 
        u.Username =  uniqueName + '@testPMTool' + orgId + '.org'; 
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
        OpportunityTriggerHandler.firstRun =false;
        Opportunity opp = new Opportunity();
        ////opp.name = 'Test opp';
        opp.property__c=pr.id;
        opp.accountId__c = acc.id;
        opp.CloseDate__c = date.today();
        opp.stageName__c = 'Closed Won';
        insert opp;
        opSet.add(opp.id);
        
        Sales_Order__c so= new Sales_Order__c(Account__c = acc.id,Deal__c = opp.id);
        insert so;
        
        UtilityController.recursive =true;
        UtilityController.pmtool_flag =true;
        
        RecordType rt2 = [Select id,Name from RecordType where name='PV Feasibility'];
        Project__c pjF = new Project__c(Name='PV Feasibility Project',Deal__c = opp.id,RecordTypeId = rt2.id);
        insert pjF;
        
        Set<Id> prjset = new Set<Id>();
        Project__c ProjF = [Select id, Name ,Deal__c,RecordType.Name  from Project__c where id=:pjF.id];
        prjset.add(ProjF.id);
                
        Business_Market__c bm = new Business_Market__c(name = 'CT');
        insert bm;
        
        Installation_Step__c ist = new Installation_Step__c(name='State_Initial_Submission');
        insert ist;
        
        Market_Installation_Step__c mis = new Market_Installation_Step__c(Business_Market__c = bm.id,Installation_Step__c = ist.id,Display_In_Tracker__c = true,Sequence__c = 1);
        insert mis;
          
               
        Set<Id> pmset = new Set<Id>();
        PM_Tool__c pmt = new PM_Tool__c(Deal__c = opp.id,Project_Manager__c=u.id,
                                        Project_PV_Feasibility__c=ProjF.id,Property__c=pr.id,Sales_Order__c=so.id);
        insert pmt;
        
        PM_Tool__c pmtQ = [Select id ,Name ,State__c, Project_Manager__c from PM_Tool__c where id=:pmt.id];
       
        
        PMTool pmTol = new PMTool();
        pmTol.customerId = pmtQ.id;
        pmTol.selectedMarket = bm.id;
        pmTol.selectedProjectManager = pmt.Project_Manager__c;
        
        pmTol.getBusinessMarkets();
        PMTool.updatePMRecord(prjset,'hello');
        PMTool.createPMRecord(opset);
        PMTool.updatePMRecordFromOpportunity(opset);
        pmTol.loadData();
        test.stopTest();*/
       
     } 
    public Static testmethod void PMTest3(){
        
        Boolean result = false;
        
        Profile profiles=[Select Id From Profile Where Name='System Administrator']; 
        
        String orgId = UserInfo.getOrganizationId(); 
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-',''); 
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000)); 
        String uniqueName = orgId + dateString + randomInt; 
        
        User u = new User(); 
        u.Username =  uniqueName + '@testPMTool' + orgId + '.org'; 
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
        OpportunityTriggerHandler.firstRun =false;
        Deal__c opp = new Deal__c();
        ////opp.name = 'Test opp';
        opp.property__c=pr.id;
        opp.accountId__c = acc.id;
        opp.CloseDate__c = date.today();
        opp.stageName__c = 'Closed Won';
        insert opp;
        opSet.add(opp.id);
        
        
        Sales_Order__c so= new Sales_Order__c(Account__c = acc.id,Deal__c = opp.id);
        insert so;
        
        UtilityController.recursive =true;
        UtilityController.pmtool_flag =true;
        
        RecordType rt3 = [Select id,Name  from RecordType where name='EE Assessment'];
        Project__c pjA = new Project__c(Name='EE Assessment Project',Deal__c = opp.id,RecordTypeId = rt3.id);
        insert pjA;
        
        Set<Id> prjset = new Set<Id>();
        Project__c ProjA = [Select id, Name ,Deal__c,RecordType.Name  from Project__c where id=:pjA.id];
        prjset.add(ProjA.id);
                
        Business_Market__c bm = new Business_Market__c(name = 'CT');
        insert bm;
        
        Installation_Step__c ist = new Installation_Step__c(name='PTO/Final_Utility_Approval');
        insert ist;
        
        Market_Installation_Step__c mis = new Market_Installation_Step__c(Business_Market__c = bm.id,Installation_Step__c = ist.id,Display_In_Tracker__c = true,Sequence__c = 1);
        insert mis;
          
               
        
        PM_Tool__c pmt = new PM_Tool__c(Deal__c = opp.id,Project_Manager__c=u.id,
                                        Project_EE_Assessment__c=ProjA.id,Property__c=pr.id,Sales_Order__c=so.id);
        insert pmt;
        
        PM_Tool__c pmtQ = [Select id ,Name ,State__c, Project_Manager__c from PM_Tool__c where id=:pmt.id];
       
        PMTool pmTol = new PMTool();
        pmTol.customerId = pmtQ.id;
        pmTol.selectedMarket = bm.id;
        pmTol.selectedProjectManager = pmt.Project_Manager__c;
        pmTol.getBusinessMarkets();
        test.startTest();
        PMTool.updatePMRecord(prjset,'hello');
        PMTool.createPMRecord(opset);
        PMTool.updatePMRecordFromOpportunity(opset);
        pmTol.loadData();
        pmTol.viewCustomerDetail();
        test.stopTest();
     }
     
   public Static testmethod void PMTest4(){
        
        Boolean result = false;
        
        Profile profiles=[Select Id From Profile Where Name='System Administrator']; 
        
        String orgId = UserInfo.getOrganizationId(); 
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-',''); 
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000)); 
        String uniqueName = orgId + dateString + randomInt; 
        
        User u = new User(); 
        u.Username =  uniqueName + '@testPMTool' + orgId + '.org'; 
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
        OpportunityTriggerHandler.firstRun =false;
        Deal__c opp = new Deal__c();
        ////opp.name = 'Test opp';
        opp.property__c=pr.id;
        opp.accountId__c = acc.id;
        opp.CloseDate__c = date.today();
        opp.stageName__c = 'Closed Won';
        insert opp;
        opSet.add(opp.id);
       
          
        
       // Opportunity oppQ = [Select id,name,Property_State__c from Opportunity where id=:opp.id];
        Sales_Order__c so= new Sales_Order__c(Account__c = acc.id,Deal__c = opp.id);
        insert so;
        
        UtilityController.recursive =true;
        UtilityController.pmtool_flag =true;
        
        RecordType rt4 = [Select id,Name  from RecordType where name='EE Upgrade'];
        Project__c pjU = new Project__c(Name='EE Upgrade Project',Deal__c = opp.id,RecordTypeId = rt4.id);
        insert pjU;
        
        Set<Id> prjset = new Set<Id>();
        Project__c ProjU = [Select id, Name ,Deal__c,RecordType.Name  from Project__c where id=:pjU.id];
        prjset.add(ProjU.id);        
                
        Business_Market__c bm = new Business_Market__c(name = 'CT');
        insert bm;
        
        Installation_Step__c ist = new Installation_Step__c(name='Intro_Call');
        insert ist;
        
        Market_Installation_Step__c mis = new Market_Installation_Step__c(Business_Market__c = bm.id,Installation_Step__c = ist.id,Display_In_Tracker__c = true,Sequence__c = 1);
        insert mis;
          
               
      
        PM_Tool__c pmt = new PM_Tool__c(Deal__c = opp.id,Project_Manager__c=u.id,
                                        Project_EE_Upgrade__c=ProjU.id,Property__c=pr.id,Sales_Order__c=so.id);
        insert pmt;
        
        PM_Tool__c pmtQ = [Select id ,Name ,State__c, Project_Manager__c from PM_Tool__c where id=:pmt.id];
       
        PMTool pmTol = new PMTool();
        pmTol.customerId = pmtQ.id;
        pmTol.selectedMarket = bm.id;
        pmTol.selectedProjectManager = pmt.Project_Manager__c;
        pmTol.getBusinessMarkets();
        test.startTest();
        PMTool.updatePMRecord(prjset,'hello');
        PMTool.createPMRecord(opset);
        PMTool.updatePMRecordFromOpportunity(opset);
        pmTol.loadData();
        pmTol.viewCustomerDetail();
        test.stopTest();
     } 
    public Static testmethod void PMTest5(){
        
        Boolean result = false;
        
        Profile profiles=[Select Id From Profile Where Name='System Administrator']; 
        
        String orgId = UserInfo.getOrganizationId(); 
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-',''); 
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000)); 
        String uniqueName = orgId + dateString + randomInt; 
        
        User u = new User(); 
        u.Username =  uniqueName + '@testPMTool' + orgId + '.org'; 
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
        OpportunityTriggerHandler.firstRun =false;
        Deal__c opp = new Deal__c();
        ////opp.name = 'Test opp';
        opp.property__c=pr.id;
        opp.accountId__c = acc.id;
        opp.CloseDate__c = date.today();
        opp.stageName__c = 'Closed Won';
        insert opp;
        opSet.add(opp.id);
       
          
        
       // Opportunity oppQ = [Select id,name,Property_State__c from Deal__c where id=:opp.id];
        Sales_Order__c so= new Sales_Order__c(Account__c = acc.id,Deal__c = opp.id);
        insert so;
        
        UtilityController.recursive =true;
        UtilityController.pmtool_flag =true;
        
        RecordType rt4 = [Select id,Name  from RecordType where name='EE Upgrade'];
        Project__c pjU = new Project__c(Name='EE Upgrade Project',Deal__c = opp.id,RecordTypeId = rt4.id);
        insert pjU;
        
        Set<Id> prjset = new Set<Id>();
        Project__c ProjU = [Select id, Name ,Deal__c,RecordType.Name  from Project__c where id=:pjU.id];
        prjset.add(ProjU.id);        
                
        Business_Market__c bm = new Business_Market__c(name = 'CT');
        insert bm;
        
        Installation_Step__c ist = new Installation_Step__c(name='Sales_Order');
        insert ist;
        
        Market_Installation_Step__c mis = new Market_Installation_Step__c(Business_Market__c = bm.id,Installation_Step__c = ist.id,Display_In_Tracker__c = true,Sequence__c = 1);
        insert mis;
          
               
      
        PM_Tool__c pmt = new PM_Tool__c(Deal__c = opp.id,Project_Manager__c=u.id,
                                        Project_EE_Upgrade__c=ProjU.id,Property__c=pr.id,Sales_Order__c=so.id);
        insert pmt;
        
        PM_Tool__c pmtQ = [Select id ,Name ,State__c, Project_Manager__c from PM_Tool__c where id=:pmt.id];
       
        PMTool pmTol = new PMTool();
        pmTol.customerId = pmtQ.id;
        pmTol.selectedMarket = bm.id;
        pmTol.selectedProjectManager = pmt.Project_Manager__c;
        pmTol.getBusinessMarkets();
        test.startTest();
        PMTool.updatePMRecord(prjset,'hello');
        PMTool.createPMRecord(opset);
        PMTool.updatePMRecordFromOpportunity(opset);
        pmTol.loadData();
        pmTol.viewCustomerDetail();
        test.stopTest();
     } 
   public Static testmethod void PMTest6(){
    
    Boolean result = false;
        
        Profile profiles=[Select Id From Profile Where Name='System Administrator']; 
        
        String orgId = UserInfo.getOrganizationId(); 
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-',''); 
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000)); 
        String uniqueName = orgId + dateString + randomInt; 
        
        User u = new User(); 
        u.Username =  uniqueName + '@testPMTool' + orgId + '.org'; 
        u.ProfileId = profiles.Id; 
        u.LastName = 'test Rec1'; 
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
        OpportunityTriggerHandler.firstRun =false;
        Deal__c opp = new Deal__c();
        ////opp.name = 'Test opp';
        opp.property__c=pr.id;
        opp.accountId__c = acc.id;
        opp.CloseDate__c = date.today();
        opp.stageName__c = 'Closed Won';
        insert opp;
        opSet.add(opp.id);
        
        Sales_Order__c so= new Sales_Order__c(Account__c = acc.id,Deal__c = opp.id);
        insert so;
        
        UtilityController.recursive =true;
        UtilityController.pmtool_flag =true;
        
        RecordType rt1 = [Select id,Name  from RecordType where name='PV Install'];
        Project__c pjI = new Project__c(Name='PV Install Project',Deal__c = opp.id,RecordTypeId = rt1.id);
        insert pjI;
        
        Set<Id> prjset = new Set<Id>();
        Project__c ProjI = [Select id, Name ,Deal__c,RecordType.Name  from Project__c where id=:pjI.id];
        prjset.add(ProjI.id);
        
        Business_Market__c bm = new Business_Market__c(name = 'CT');
        insert bm;
        
       
        
        Installation_Step__c ist = new Installation_Step__c(name='Initial_Utility_Approval/Net_Metering');
        insert ist;
        
        Market_Installation_Step__c mis = new Market_Installation_Step__c(Business_Market__c = bm.id,Installation_Step__c = ist.id,Display_In_Tracker__c = true,Sequence__c = 1);
        insert mis;
       
        PM_Tool__c pmt = new PM_Tool__c(Deal__c = opp.id,Project_Manager__c=u.id,
                                        Project__c=ProjI.id,Property__c=pr.id,Sales_Order__c=so.id);
        insert pmt;
        
        test.startTest();
        OpportunityTriggerHandler.firstRun =false;
        Deal__c opp1 = new Deal__c();
        //opp1.name = 'Test opp new ';
        opp1.property__c=pr.id;
        opp1.accountId__c = acc.id;
        opp1.CloseDate__c = date.today();
        opp1.stageName__c = 'Closed Won';
        insert opp1;
        
        so.Deal__c = opp1.id;
        update so;
        
        pmt.Name ='NewPM';
        UtilityController.recursive = true;
        UtilityController.pmtool_flag =true;
        update pmt;
        test.stopTest();
   
   
   
   }  
   public Static testmethod void PMTest7(){
        
        Boolean result = false;
        
        Profile profiles=[Select Id From Profile Where Name='System Administrator']; 
        
        String orgId = UserInfo.getOrganizationId(); 
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-',''); 
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000)); 
        String uniqueName = orgId + dateString + randomInt; 
        
        User u = new User(); 
        u.Username =  uniqueName + '@testPMTool' + orgId + '.org'; 
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
        OpportunityTriggerHandler.firstRun =false;
        Deal__c opp = new Deal__c();
        ////opp.name = 'Test opp';
        opp.property__c=pr.id;
        opp.accountId__c = acc.id;
        opp.CloseDate__c = date.today();
        opp.stageName__c = 'Closed Won';
        insert opp;
        opSet.add(opp.id);
       
          
        
       // Opportunity oppQ = [Select id,name,Property_State__c from Opportunity where id=:opp.id];
        Sales_Order__c so= new Sales_Order__c(Account__c = acc.id,Deal__c = opp.id);
        insert so;
        
        UtilityController.recursive =true;
        UtilityController.pmtool_flag =true;
        
        RecordType rt4 = [Select id,Name  from RecordType where name='EE Upgrade'];
        Project__c pjU = new Project__c(Name='EE Upgrade Project',Deal__c = opp.id,RecordTypeId = rt4.id);
        insert pjU;
        
        Set<Id> prjset = new Set<Id>();
        Project__c ProjU = [Select id, Name ,Deal__c,RecordType.Name  from Project__c where id=:pjU.id];
        prjset.add(ProjU.id);        
                
        Business_Market__c bm = new Business_Market__c(name = 'CT');
        insert bm;
        
        Installation_Step__c ist = new Installation_Step__c(name='State_Initial_Submission');
        insert ist;
        
        Market_Installation_Step__c mis = new Market_Installation_Step__c(Business_Market__c = bm.id,Installation_Step__c = ist.id,Display_In_Tracker__c = true,Sequence__c = 1);
        insert mis;
          
               
      
        PM_Tool__c pmt = new PM_Tool__c(Deal__c = opp.id,Project_Manager__c=u.id,
                                        Project_EE_Upgrade__c=ProjU.id,Property__c=pr.id,Sales_Order__c=so.id);
        insert pmt;
        
        PM_Tool__c pmtQ = [Select id ,Name ,State__c, Project_Manager__c from PM_Tool__c where id=:pmt.id];
       
        PMTool pmTol = new PMTool();
        pmTol.customerId = pmtQ.id;
        pmTol.selectedProjectManager = pmt.Project_Manager__c;
        pmTol.getBusinessMarkets();
        test.startTest();
        PMTool.updatePMRecord(prjset,'hello');
        PMTool.createPMRecord(opset);
        PMTool.updatePMRecordFromOpportunity(opset);
        pmTol.loadData();
        pmTol.viewCustomerDetail();
        test.stopTest();
     }
    public Static testmethod void PMTest8(){
    
    Boolean result = false;
        Trigger_Setting__c ts = new Trigger_Setting__c(PM_Trigger__c =true);
        insert ts; 
        Profile profiles=[Select Id From Profile Where Name='System Administrator']; 
        
        String orgId = UserInfo.getOrganizationId(); 
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-',''); 
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000)); 
        String uniqueName = orgId + dateString + randomInt; 
        
        User u = new User(); 
        u.Username =  uniqueName + '@testPMTool' + orgId + '.org'; 
        u.ProfileId = profiles.Id; 
        u.LastName = 'test Rec1'; 
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
        OpportunityTriggerHandler.firstRun =false;
        Deal__c opp = new Deal__c();
        ////opp.name = 'Test opp';            
        opp.property__c=pr.id;
        opp.accountId__c = acc.id;
        opp.CloseDate__c = date.today();
        opp.stageName__c = 'Closed Won';
        opp.Solar_Product__c  = 'Energy Efficiency';
        insert opp;
        opSet.add(opp.id);
        
        Sales_Order__c so= new Sales_Order__c(Account__c = acc.id,Deal__c = opp.id);
        insert so;
        
        UtilityController.recursive =true;
        UtilityController.pmtool_flag =true;
        
        RecordType rt1 = [Select id,Name  from RecordType where name='PV Install'];
        Project__c pjI = new Project__c(Name='PV Install Project',Deal__c = opp.id,RecordTypeId = rt1.id);
        insert pjI;
        
        Set<Id> prjset = new Set<Id>();
        Project__c ProjI = [Select id, Name ,Deal__c,RecordType.Name  from Project__c where id=:pjI.id];
        prjset.add(ProjI.id);
        
        Business_Market__c bm = new Business_Market__c(name = 'CT');
        insert bm;
        
       
        
        Installation_Step__c ist = new Installation_Step__c(name='Initial_Utility_Approval/Net_Metering');
        insert ist;
        
        Market_Installation_Step__c mis = new Market_Installation_Step__c(Business_Market__c = bm.id,Installation_Step__c = ist.id,Display_In_Tracker__c = true,Sequence__c = 1);
        insert mis;
       
        PM_Tool__c pmt = new PM_Tool__c();
        pmt.Deal__c = opp.id;
        pmt.Project_Manager__c=u.id;
        pmt.Project__c=ProjI.id;
        pmt.Property__c=pr.id;
        pmt.Sales_Order__c=so.id;
        pmt.PM_Assignment_NA_Override__c = false;
        pmt.Intro_Call_NA_Override__c = false;
        pmt.Feasibility_NA_Override__c = false;
        pmt.Initial_Utility_Approval_Net_Metering_NA__c = false;
        pmt.State_Initial_Submission_NA_Override__c = false;
        pmt.Permitting_NA_Override__c = false;
        pmt.Sales_Order_NA_Override__c = false;
        pmt.R_P_Install_NA_Override__c = false;
        pmt.Electrical_Install_NA_Override__c = false;
        pmt.Quality_Control_NA_Override__c = false;
        pmt.M1_ITC_Funding_NA_Override__c = false;
        pmt.Municipal_Inspection_NA_Override__c = false;
        pmt.PTO_Final_Utility_Approval_NA_Override__c = false;
        pmt.M2_NA_Override__c = false;
        pmt.M3_NA_Override__c = false;
        pmt.Activation_NA_Override__c = false;
        pmt.State_Final_Submission_NA_Override__c = false;
        pmt.M2_NA_Override__c = false;
        insert pmt;
        
        
        
        
        test.startTest();
          
        OpportunityTriggerHandler.firstRun =false;
        Deal__c opp1 = new Deal__c();
        //opp1.name = 'Test opp new ';
        opp1.property__c=pr.id;
        opp1.accountId__c = acc.id;
        opp1.CloseDate__c = date.today();           
        opp1.stageName__c = 'Closed Won';
       
        insert opp1;
        
        so.Deal__c = opp1.id;
        update so;
        
        
       
        pmt.Name ='NewPM';
        pmt.PM_Assignment_NA_Override__c = true;
        pmt.Intro_Call_NA_Override__c = true;
        pmt.Feasibility_NA_Override__c = true;
        pmt.Initial_Utility_Approval_Net_Metering_NA__c = true;
        pmt.State_Initial_Submission_NA_Override__c = true;
        pmt.Permitting_NA_Override__c = true;
        pmt.Sales_Order_NA_Override__c = true;
        pmt.R_P_Install_NA_Override__c = true;
        pmt.Electrical_Install_NA_Override__c = true;
        pmt.Quality_Control_NA_Override__c = true;
        pmt.M1_ITC_Funding_NA_Override__c = true;
        pmt.Municipal_Inspection_NA_Override__c = true;
        pmt.PTO_Final_Utility_Approval_NA_Override__c = true;
        pmt.M2_NA_Override__c = true;
        pmt.M3_NA_Override__c = true;
        pmt.Activation_NA_Override__c = true;
        pmt.State_Final_Submission_NA_Override__c = true;
        pmt.M2_NA_Override__c = true;
        UtilityController.recursive = true;
        UtilityController.pmtool_flag =true;
        update pmt;
        
        test.stopTest();
   
   
   } 
 
}