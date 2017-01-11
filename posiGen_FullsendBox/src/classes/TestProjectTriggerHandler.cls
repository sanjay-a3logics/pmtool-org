@isTest
public class TestProjectTriggerHandler {
    Static testmethod void method2(){
      UtilityController.recursive = true;
            List<Sub_folder__c> subList = new List<Sub_folder__c>();
            RecordType rt2 = [Select id from RecordType where name='EE Upgrade'];
            RecordType rt = [Select id from RecordType where name='Subcontractor'];
            UtilityController.recursive =true;
            
            
            Account acc =new Account();
            acc.name = 'irfan khan';
            acc.RecordTypeId = rt.Id;
            insert acc;
            system.assert(acc.id!=null);
            
            
            
            Trigger_Setting__c ts = new Trigger_Setting__c(Project_Trigger__c =true);
            insert ts; 
            
            Opportunity opp = new Opportunity();
            opp.name = 'Test opp';
            opp.accountId = acc.id;
            opp.CloseDate = date.today();
            opp.stageName = 'Release to Installer';
            OpportunityTriggerHandler.firstRun =false; 
            insert opp;
            
            Opportunity oppr =[Select id, Pipeline_stage__c from opportunity where id=:opp.id];
            
            Sub_folder__c sf = new Sub_folder__c();
            sf.name = 'EE';
            sf.cf_opportunity__c = oppr.id;
            sf.cf_box_folder_id__c = '11446498';
            insert sf;
            
            subList.add(sf);
            List<String> fldsubList = new List<String>();
            fldsubList.add(sf.cf_box_folder_id__c);
           
            Profile prf= [select id,Name From Profile Where Name='EE partner user'];
            
            BoxAccessMatrix_SubFolder__c bams = new BoxAccessMatrix_SubFolder__c();
            bams.SubFolder_Name__c='EE';
            bams.Name='EE';
            insert bams;
            
            BoxAccessMatrix_Profile__c bamp = new BoxAccessMatrix_Profile__c();
            bamp.BoxAccessMatrix_SubFolder__c=bams.id;
            bamp.Profile_Id__c=prf.id;
            bamp.Profile_Name__c='EE partner user';
            bamp.Lookup_Field_Name__c='Subcontractor__c';
            insert bamp;
            
            BoxAccessMatrix_Stage__c BAM = new BoxAccessMatrix_Stage__c();
            BAM.Box_Permission__c='Viewer';
            BAM.BoxAccessMatrix_Profile__c=bamp.id;
            BAM.Stage__c=oppr.Pipeline_stage__c;
            BAM.check__c=true;
            insert BAM;
            
            Box_Group__c bg = new Box_Group__c();
            bg.BoxGroup_Id__c='34087847';
            bg.BoxGroup_Name__c='test box grop';
            bg.SF_Profile_Id__c=prf.id;
            insert bg;
            
            
            
            List<String> cnLst = new List<String>(); 
            Contact con = new Contact(FirstName='Test1',LastName='State1',email='newCon@abc.com',AccountId=acc.id);
            insert con;
            
            cnlst.add(con.email);
            Set<String> cnSet = new Set<String>(cnLst);
            
            Project__c pj = new Project__c();
            pj.RecordTypeId=rt2.id;
            pj.Name = 'old prj';
            pj.Opportunity__c = opp.id;
            pj.Subcontractor__c = acc.id;
            insert pj;
            
            
            Account acc2 =new Account();
            acc2.name = 'Anki khan';
            acc2.RecordTypeId = rt.id;
            insert acc2;
            
            Set<String> cnSet2 = new Set<String>();
            Contact con2 = new Contact(FirstName='Test1',LastName='State1',email='crewCon@abc.com',AccountId=acc2.id);
            insert con2;
            cnSet.add(con2.email);
            
            
            pj.Subcontractor__c =acc2.id;
            UtilityController.recursive =true;
            OpportunityTriggerHandler.firstRun =false; 
            pj.EE_Completed_Date__c = system.today();
            pj.PVI_Rails_and_Panels_Left_Warehouse_Date__c = system.today();
            pj.PVI_Rails_Installed_Date__c = system.today();
            update pj;
            
            ProjectTriggerHandler pt = new ProjectTriggerHandler();
            pt.bulkBefore();
            pt.bulkAfter();
            pt.beforeInsert();
            pt.beforeUpdate();
            pt.beforeDelete();
            pt.afterDelete();
            pt.afterUnDelete();
            
            
    }
    
    Static testmethod void method22(){
      UtilityController.recursive = true;
        List<Sub_folder__c> subList = new List<Sub_folder__c>();
        RecordType rt2 = [Select id from RecordType where name='PV Install'];
        RecordType rt = [Select id from RecordType where name='Subcontractor'];
        UtilityController.recursive =true;
        
        
        Account acc =new Account();
        acc.name = 'irfan khan';
        acc.RecordTypeId = rt.Id;
        insert acc;
        
        
        Trigger_Setting__c ts = new Trigger_Setting__c(Attachment_Trigger__c=true,BoxAccessMatrixStage_Trigger__c=true,FeedItem_Trigger__c=true,LD_Lease_trigger__c=true,LogsTrigger__c=true,Opportunity_Trigger__c=true,PM_Trigger__c=true,Project_Trigger__c=true,Task_Trigger__c=true,User_Trigger__c=true);
        insert ts; 
        
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Release to Installer';
        OpportunityTriggerHandler.firstRun =false; 
        insert opp;
        
        Opportunity oppr =[Select id, Pipeline_stage__c from opportunity where id=:opp.id];
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Sales';
        sf.cf_opportunity__c = oppr.id;
        sf.cf_box_folder_id__c = '11446498';
        insert sf;
        
        subList.add(sf);
        List<String> fldsubList = new List<String>();
        fldsubList.add(sf.cf_box_folder_id__c);
       
        Profile prf= [select id,Name From Profile Where Name='EE partner user'];
        
        BoxAccessMatrix_SubFolder__c bams = new BoxAccessMatrix_SubFolder__c();
        bams.SubFolder_Name__c='Sales';
        bams.Name='Sales';
        insert bams;
        
        BoxAccessMatrix_Profile__c bamp = new BoxAccessMatrix_Profile__c();
        bamp.BoxAccessMatrix_SubFolder__c=bams.id;
        bamp.Profile_Id__c=prf.id;
        bamp.Profile_Name__c='EE partner user';
        bamp.Lookup_Field_Name__c='Subcontractor__c';
        insert bamp;
        
        BoxAccessMatrix_Stage__c BAM = new BoxAccessMatrix_Stage__c();
        BAM.Box_Permission__c='Viewer';
        BAM.BoxAccessMatrix_Profile__c=bamp.id;
        BAM.Stage__c=oppr.Pipeline_stage__c;
        BAM.check__c=true;
        insert BAM;
        
        Box_Group__c bg = new Box_Group__c();
        bg.BoxGroup_Id__c='34087847';
        bg.BoxGroup_Name__c='test box grop';
        bg.SF_Profile_Id__c=prf.id;
        insert bg;
        
        
        
        List<String> cnLst = new List<String>(); 
        Contact con = new Contact(FirstName='Test1',LastName='State1',email='newCon@abc.com',AccountId=acc.id);
        insert con;
        
        cnlst.add(con.email);
        Set<String> cnSet = new Set<String>(cnLst);
        
        Project__c pj = new Project__c();
        pj.RecordTypeId=rt2.id;
        pj.Name = 'old prj';
        pj.Opportunity__c = opp.id;
        pj.Subcontractor__c = acc.id;
       
        insert pj;
        
        Account acc2 =new Account();
        acc2.name = 'Anki khan';
        acc2.RecordTypeId = rt.id;
        insert acc2;
        
        Project__c pj2 = new Project__c();
        pj2.RecordTypeId=rt2.id;
        pj2.Name = 'old prj aa';
        pj2.Opportunity__c = opp.id;
        pj2.Subcontractor__c = acc2.id;
        
        Set<String> cnSet2 = new Set<String>();
        Contact con2 = new Contact(FirstName='Test1',LastName='State1',email='crewCon@abc.com',AccountId=acc2.id);
        insert con2;
        cnSet.add(con2.email);
        
        
        pj.Subcontractor__c =acc2.id;
        UtilityController.recursive =true;
        OpportunityTriggerHandler.firstRun =false; 
        update pj;
       
       
       
        ProjectTriggerHandler pt = new ProjectTriggerHandler();
        pt.bulkBefore();
        pt.bulkAfter();
        pt.beforeInsert();
        pt.beforeUpdate();
        pt.beforeDelete();
        pt.afterDelete();
        pt.afterUnDelete();
        
    }
  
    
    Static testmethod void method23(){
      
        List<Sub_folder__c> subList = new List<Sub_folder__c>();
        RecordType rt2 = [Select id from RecordType where name='PV Install'];
        RecordType rt = [Select id from RecordType where name='Subcontractor'];
        UtilityController.recursive =true;
        
        
        Account acc =new Account();
        acc.name = 'irfan khan';
        acc.RecordTypeId = rt.Id;
        insert acc;
        
        
        
        
        Trigger_Setting__c ts = new Trigger_Setting__c(Project_Trigger__c =true);
        insert ts; 
        
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Release to Installer';
        OpportunityTriggerHandler.firstRun =false; 
        insert opp;
        
        Opportunity oppr =[Select id, Pipeline_stage__c from opportunity where id=:opp.id];
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Funding-Vendor';
        sf.cf_opportunity__c = oppr.id;
        sf.cf_box_folder_id__c = '11446498';
        insert sf;
        
        subList.add(sf);
        List<String> fldsubList = new List<String>();
        fldsubList.add(sf.cf_box_folder_id__c);
       
        Profile prf= [select id,Name From Profile Where Name='EE partner user'];
        
        BoxAccessMatrix_SubFolder__c bams = new BoxAccessMatrix_SubFolder__c();
        bams.SubFolder_Name__c='Funding-Vendor';
        bams.Name='Funding-Vendor';
        insert bams;
        
        BoxAccessMatrix_Profile__c bamp = new BoxAccessMatrix_Profile__c();
        bamp.BoxAccessMatrix_SubFolder__c=bams.id;
        bamp.Profile_Id__c=prf.id;
        bamp.Profile_Name__c='EE partner user';
        bamp.Lookup_Field_Name__c='Subcontractor__c';
        insert bamp;
        
        BoxAccessMatrix_Stage__c BAM = new BoxAccessMatrix_Stage__c();
        BAM.Box_Permission__c='Viewer';
        BAM.BoxAccessMatrix_Profile__c=bamp.id;
        BAM.Stage__c=oppr.Pipeline_stage__c;
        BAM.check__c=true;
        insert BAM;
        
        Box_Group__c bg = new Box_Group__c();
        bg.BoxGroup_Id__c='34087847';
        bg.BoxGroup_Name__c='test box grop';
        bg.SF_Profile_Id__c=prf.id;
        insert bg;
        
        
        
        List<String> cnLst = new List<String>(); 
        Contact con = new Contact(FirstName='Test1',LastName='State1',email='newCon@abc.com',AccountId=acc.id);
        insert con;
        
        cnlst.add(con.email);
        Set<String> cnSet = new Set<String>(cnLst);
        
        Project__c pj = new Project__c();
        pj.RecordTypeId=rt2.id;
        pj.Name = 'old prj';
        pj.Opportunity__c = opp.id;
        pj.Subcontractor__c = acc.id;
        insert pj;
        
        Account acc2 =new Account();
        acc2.name = 'Anki khan';
        acc2.RecordTypeId = rt.id;
        insert acc2;
        
        Set<String> cnSet2 = new Set<String>();
        Contact con2 = new Contact(FirstName='Test1',LastName='State1',email='crewCon@abc.com',AccountId=acc2.id);
        insert con2;
        cnSet.add(con2.email);
        
        
        //pj.Subcontractor__c =acc2.id;
        //update pj;
      
      
        ProjectTriggerHandler pt = new ProjectTriggerHandler();
        pt.bulkBefore();
        pt.bulkAfter();
        pt.beforeInsert();
        pt.beforeUpdate();
        pt.beforeDelete();
        pt.afterDelete();
        pt.afterUnDelete();
        
    }
   
    Static testmethod void method24(){
        
        UtilityController.recursive = true;
        List<Sub_folder__c> subList = new List<Sub_folder__c>();
        RecordType rt2 = [Select id from RecordType where name='PV Install'];
        RecordType rt = [Select id from RecordType where name='Subcontractor'];
        UtilityController.recursive =true;
        
        
        Account acc =new Account();
        acc.name = 'irfan khan';
        acc.RecordTypeId = rt.Id;
        insert acc;
        
        
        Trigger_Setting__c ts = new Trigger_Setting__c(Project_Trigger__c =true);
        insert ts; 
        
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Release to Installer';
        OpportunityTriggerHandler.firstRun =false; 
        insert opp;
        
        Opportunity oppr =[Select id, Pipeline_stage__c from opportunity where id=:opp.id];
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Application';
        sf.cf_opportunity__c = oppr.id;
        sf.cf_box_folder_id__c = '11446498';
        insert sf;
        
        subList.add(sf);
        List<String> fldsubList = new List<String>();
        fldsubList.add(sf.cf_box_folder_id__c);
       
        Profile prf= [select id,Name From Profile Where Name='EE partner user'];
        
        BoxAccessMatrix_SubFolder__c bams = new BoxAccessMatrix_SubFolder__c();
        bams.SubFolder_Name__c='Application';
        bams.Name='Application';
        insert bams;
        
        BoxAccessMatrix_Profile__c bamp = new BoxAccessMatrix_Profile__c();
        bamp.BoxAccessMatrix_SubFolder__c=bams.id;
        bamp.Profile_Id__c=prf.id;
        bamp.Profile_Name__c='EE partner user';
        bamp.Lookup_Field_Name__c='Subcontractor__c';
        insert bamp;
        
        BoxAccessMatrix_Stage__c BAM = new BoxAccessMatrix_Stage__c();
        BAM.Box_Permission__c='Viewer';
        BAM.BoxAccessMatrix_Profile__c=bamp.id;
        BAM.Stage__c=oppr.Pipeline_stage__c;
        BAM.check__c=true;
        insert BAM;
        
        Box_Group__c bg = new Box_Group__c();
        bg.BoxGroup_Id__c='34087847';
        bg.BoxGroup_Name__c='test box grop';
        bg.SF_Profile_Id__c=prf.id;
        insert bg;
        
        
        
        List<String> cnLst = new List<String>(); 
        Contact con = new Contact(FirstName='Test1',LastName='State1',email='newCon@abc.com',AccountId=acc.id);
        insert con;
        
        cnlst.add(con.email);
        Set<String> cnSet = new Set<String>(cnLst);
        
        Project__c pj = new Project__c();
        pj.RecordTypeId=rt2.id;
        pj.Name = 'old prj';
        pj.Opportunity__c = opp.id;
        pj.Subcontractor__c = acc.id;
       
        insert pj;
        
        Account acc2 =new Account();
        acc2.name = 'Anki khan';
        acc2.RecordTypeId = rt.id;
        insert acc2;
        
        Set<String> cnSet2 = new Set<String>();
        Contact con2 = new Contact(FirstName='Test1',LastName='State1',email='crewCon@abc.com',AccountId=acc2.id);
        insert con2;
        cnSet.add(con2.email);
        
        
        pj.Subcontractor__c =acc2.id;
        UtilityController.recursive =true;
        
        OpportunityTriggerHandler.firstRun =false; 
        update pj;
        
        
        ProjectTriggerHandler pt = new ProjectTriggerHandler();
        pt.bulkBefore();
        pt.bulkAfter();
        pt.beforeInsert();
        pt.beforeUpdate();
        pt.beforeDelete();
        pt.afterDelete();
        pt.afterUnDelete();
        
        ts.Project_Trigger__c =false;
        update ts; 
        
        UtilityController.recursive =true;
        OpportunityTriggerHandler.firstRun =false; 
        RecordType rt3 = [Select id from RecordType where name='EE Assessment'];
        pj.RecordTypeId=rt3.id;
        pj.EE_Completed_Date__c  = system.today();
        update pj;

    } 
    
    Static testmethod void method25(){
        
        UtilityController.recursive = true;
        RecordType rt2 = [Select id from RecordType where name='EE Upgrade'];
        RecordType rt = [Select id from RecordType where name='Subcontractor'];
        UtilityController.recursive =true;

        Account acc =new Account();
        acc.name = 'irfan khan';
        acc.RecordTypeId = rt.Id;
        insert acc;
        
        
        Trigger_Setting__c ts = new Trigger_Setting__c(Project_Trigger__c =false);
        insert ts; 
        
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Release to Installer';
        OpportunityTriggerHandler.firstRun =false; 
        insert opp;
        
       
    
        Project__c pj = new Project__c();
        pj.RecordTypeId=rt2.id;
        pj.Name = 'old prj';
        pj.Opportunity__c = opp.id;
        pj.Subcontractor__c = acc.id;
       
        insert pj;
        
        UtilityController.recursive =true;
        OpportunityTriggerHandler.firstRun =false; 

        pj.EE_Completed_Date__c = system.today();
        update pj;
        
      

    } 
    
    
    Static testmethod void method26(){
        
        UtilityController.recursive = true;
        RecordType rt2 = [Select id from RecordType where name='PV Feasibility'];
        RecordType rt = [Select id from RecordType where name='Subcontractor'];
        UtilityController.recursive =true;

        Account acc =new Account();
        acc.name = 'irfan khan';
        acc.RecordTypeId = rt.Id;
        insert acc;
        
        
        Trigger_Setting__c ts = new Trigger_Setting__c(Project_Trigger__c =false);
        insert ts; 
        
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Release to Installer';
        OpportunityTriggerHandler.firstRun =false; 
        insert opp;
        
       
    
        Project__c pj = new Project__c();
        pj.RecordTypeId=rt2.id;
        pj.Name = 'old prj';
        pj.Opportunity__c = opp.id;
        pj.Subcontractor__c = acc.id;
        insert pj;

    } 
    
    Static testmethod void method27(){
        
        UtilityController.recursive = true;
        RecordType rt2 = [Select id from RecordType where name='PV Removal'];
        RecordType rt = [Select id from RecordType where name='Subcontractor'];
        UtilityController.recursive =true;

        Account acc =new Account();
        acc.name = 'irfan khan';
        acc.RecordTypeId = rt.Id;
        insert acc;
        
        
        Trigger_Setting__c ts = new Trigger_Setting__c(Project_Trigger__c =false);
        insert ts; 
        
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Release to Installer';
        OpportunityTriggerHandler.firstRun =false; 
        insert opp;
        
       
    
        Project__c pj = new Project__c();
        pj.RecordTypeId=rt2.id;
        pj.Name = 'old prj';
        pj.Opportunity__c = opp.id;
        pj.Subcontractor__c = acc.id;
       
        insert pj;

    } 
    
   
}