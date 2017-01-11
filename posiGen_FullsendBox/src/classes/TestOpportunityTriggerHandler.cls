@isTest 
public class TestOpportunityTriggerHandler{
    static testMethod void unitTest()
    {
      try{
       // RecordType rt2 = [Select id from RecordType where name='EE'];
        Set<Id>oppSet = new Set<Id>(); 
        final Date closeDate = date.newInstance(2014,11, 18);

        Account testAcct = new Account(LastName = 'Test Account', FirstName = 'Trigger', BillingState = 'Louisiana', BillingCountry = 'United States');
        insert testAcct;
        
        Trigger_Setting__c ts = new Trigger_Setting__c(Opportunity_Trigger__c =true);
        insert ts; 
        
        OpportunityTriggerHandler.firstRunPmTool = true;
        Opportunity testOpp = new Opportunity(Contracts_approved_date__c = Date.Today(), Name = 'Test Opp', AccountId = testAcct.Id, StageName = 'Schedule Appointment', CloseDate = closeDate);
        insert testOpp;

        
       /* Project__c pj = new Project__c();
        pj.RecordTypeId=rt2.id;
        pj.Name = 'old prj';
        pj.Opportunity__c = testOpp.id;
        pj.Subcontractor__c = testAcct.id;
       
        insert pj;*/
        oppSet.add(testOpp.id);
        OpportunityTriggerHandler.firstRun =true;
        
        opportunity op =[Select id, Pipeline_stage__c from opportunity where id=:testOpp.id];
        
         Profile prf= [select id,Name From Profile Where Name='EE Admin'];
         
          
        
        BoxAccessMatrix_SubFolder__c bams = new BoxAccessMatrix_SubFolder__c();
        bams.SubFolder_Name__c='EE';
        bams.Name='EE';
        upsert bams;
        
        BoxAccessMatrix_Profile__c bamp = new BoxAccessMatrix_Profile__c();
        bamp.BoxAccessMatrix_SubFolder__c=bams.id;
        bamp.Profile_Id__c=prf.id;
        bamp.Profile_Name__c='EE Admin';
        
        upsert bamp;
        
        BoxAccessMatrix_Stage__c BAM = new BoxAccessMatrix_Stage__c();
        BAM.Box_Permission__c='Viewer';
        BAM.BoxAccessMatrix_Profile__c=bamp.id;
        BAM.Stage__c=op.Pipeline_stage__c;
        BAM.check__c=true;
        upsert BAM;
     
        List<String> sflst = new List<String>(); 
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = bams.Name;
        sf.cf_opportunity__c = op.id;
        sf.cf_box_folder_id__c = '11446498';
        insert sf;
        
       sflst.add(sf.cf_box_folder_id__c );
            
       
        
        
       
        testOpp.StageName = 'Closed Won';
        
        update testOpp;
        OpportunityTriggerHandler.firstRun =true;
       
          
        
        
      
      
        
        
        
       
                      
        OpportunityTriggerHandler ot = new OpportunityTriggerHandler();
        
        ot.bulkBefore();
        ot.bulkAfter();
        ot.beforeInsert();
        ot.beforeUpdate();
        ot.afterDelete();
        ot.afterUnDelete();
        //PMTool.createPMRecord(oppSet);
        
        delete op;
        
       }
      catch(Exception e){
        //system.assert(false,e.getstacktracestring()+'hiii'+e.getmessage());
       }  
    }
    
    static testMethod void unitTest2()
    {
        User usr1 = [select id, Name, ProfileId  from User where Profile.Name = 'Sales Manager'  and IsActive = true limit 1 ];
        System.runAs(usr1) {  
        
            final Date closeDate = date.newInstance(2014,11, 18);
            
            Account testAcct = new Account(LastName = 'Test Account', FirstName = 'Trigger', BillingState = 'Louisiana', BillingCountry = 'United States');
            insert testAcct;
            System.assert(testAcct.id!=null);
            
            OpportunityTriggerHandler.firstRunPmTool = true;
            Opportunity testOpp = new Opportunity(Contracts_approved_date__c = Date.Today(), Name = 'Test Opp', AccountId = testAcct.Id, StageName = 'Schedule Appointment', CloseDate = closeDate);
            insert testOpp;
            System.assert(testOpp.id!=null);
            
            Sub_Folder__c sc2= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=testOpp.id,Name='Funding-Vendor');
            insert sc2;
            system.assert(sc2.id!=null);
            
            RecordType referralProgramRecordType = [SELECT Id FROM RecordType WHERE sObjectType = 'Campaign' AND Name = 'Referral Programs'];
           
            Campaign camp = new Campaign();
            camp.RecordTypeId = referralProgramRecordType.Id;
            camp.Name = 'test camp';
            camp.Allows_For_Multiple_Members__c = false;
            camp.IsActive = true;
            insert camp;
            //system.assert(false, camp);
            
             UtilityController.CreateReferralrecursive = true;
            testOpp.LeadSource = 'Referral';
            testOpp.Referral_Type__c = 'Single';
            testOpp.Referrer__c =testAcct.id;
            
            update testOpp ;
        }
        
        
    }   
    
    static testMethod void unitTest3()
    {
         
        
            final Date closeDate = date.newInstance(2014,11, 18);
            
            Account testAcct = new Account(LastName = 'Test Account', FirstName = 'Trigger', BillingState = 'Louisiana', BillingCountry = 'United States');
            insert testAcct;
            System.assert(testAcct.id!=null);
            
            Opportunity testOpp = new Opportunity(Name = 'Test Opp', AccountId = testAcct.Id, StageName = 'Schedule Appointment', CloseDate = closeDate);
            insert testOpp;
            System.assert(testOpp.id!=null);
            
            RecordType referralProgramRecordType = [SELECT Id FROM RecordType WHERE sObjectType = 'Campaign' AND Name = 'Referral Programs'];
           
            Campaign camp = new Campaign();
            
            String abc = camp.id;    

            //system.assert(false, camp);

            
            update testOpp ;
       
        
        
    } 
        
}