@isTest
public class TestCreateCollaborationStageChangeBatch { 
    static testMethod void myUnitTest() {
         List<Sub_folder__c> subList = new List<Sub_folder__c>();
         
        RecordType rt = [Select id from RecordType where name='Subcontractor'];
        Account acc =new Account();
        acc.name = 'irfan khan';
        acc.RecordTypeId = rt.Id;
        upsert acc;
        
        Contact con = new Contact(FirstName='Test1',LastName='State1',email='test2@test.com',AccountId=acc.id);
        upsert con;
        Set<String> emailSet = new Set<String>();
        emailSet.add(con.email);
        
        Deal__c opp = new Deal__c();
        //opp.name = 'Test opp';
        opp.Account__c = acc.id;
        opp.CloseDate__c = date.today();
        opp.stageName__c = 'Closed Won';
        upsert opp;
       
       Deal__c oppr =[Select id, Opp_Pipeline_Stage__c from Deal__c where stageName__c='Closed Won' and id=:opp.id];
        
      //  System.assert(false,[select id,stageName From Deal__c where id=:opp.id]);             
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        upsert testBox;
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Application';
        sf.cf_Deal__c = oppr.id;
        sf.cf_box_folder_id__c = '11446498';
        upsert sf;
        subList.add(sf);
        List<String> fldsubList = new List<String>();
        fldsubList.add(sf.cf_box_folder_id__c);
        //System.assert(false,[Select id,CF_Box_Folder_Id__c,cf_Deal__r.stagename from Sub_Folder__c  where name=:'Funding-Vendor']);
        Profile prf= [select id,Name From Profile Where Name='System Administrator'];
        
        BoxAccessMatrix_SubFolder__c bams = new BoxAccessMatrix_SubFolder__c();
        bams.SubFolder_Name__c='Application';
        bams.Name='Application';
        upsert bams;
        
        BoxAccessMatrix_Profile__c bamp = new BoxAccessMatrix_Profile__c();
        bamp.BoxAccessMatrix_SubFolder__c=bams.id;
        bamp.Profile_Id__c=prf.id;
        bamp.Profile_Name__c='System Administrator';
       // bamp.Lookup_Field_Name__c='Concierge__c';
        upsert bamp;
        
        BoxAccessMatrix_Stage__c BAM = new BoxAccessMatrix_Stage__c();
        BAM.Box_Permission__c='Viewer';
        BAM.BoxAccessMatrix_Profile__c=bamp.id;
        BAM.Stage__c=oppr.Opp_Pipeline_Stage__c;
        BAM.check__c=true;
        upsert BAM;
        
       
        
        Box_Group__c bg = new Box_Group__c();
        bg.BoxGroup_Id__c='34087847';
        bg.BoxGroup_Name__c='test box grop';
        bg.SF_Profile_Id__c=prf.id;
        upsert bg;
        
        
        Project__c pj = new Project__c();
        pj.Name = 'old prj';
        pj.Deal__c = oppr.id;
        pj.Subcontractor__c = acc.id;
        insert pj;
        
        List<box_log__c> OppList = new List<box_log__c>();
        box_log__c bxerr = new box_log__c(Deal__c = opp.id,Status__c = 'Success',Sub_Folder__c = sf.id,Type__c ='Create Collaboration');
        insert  bxerr ; 
        OppList.add(bxerr); 
       
        List<Collaboration__c> lstclb = new List<Collaboration__c>();
        Collaboration__c clb = new Collaboration__c(BoxCollaboration_Id__c='123456',BoxFolder_Id__c=sf.cf_box_folder_id__c,BoxGroup_Id__c=bg.BoxGroup_Id__c,Sub_folder__c = sf.id,Role__c='Uploader');
        insert clb;
        lstclb.add(clb);
        
        CreateCollaborationOnStageChangeBatch bcb = new CreateCollaborationOnStageChangeBatch('Application','Closed Won','11446498');
        Database.BatchableContext BC;
        
        bcb.start(BC);
        Test.startTest();
        bcb.CreateUserGroupCollaboration(subList,bg.BoxGroup_Id__c,'Uploader',prf.Id,lstclb,OppList);
        bcb.CreateLookupUserCollaboration(subList,prf.Id,emailSet,'Uploader',OppList,lstclb);
        bcb.CreatePrfLookupUserCollaboration(subList,emailSet,'Uploader',prf.Id,OppList,lstclb);
        Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
        bcb.execute(BC,subList);
        bcb.finish(BC);
        
        bcb.CreateUserGroupCollaboration(subList,bg.BoxGroup_Id__c,'Uploader',prf.Id,lstclb,OppList);
        bcb.CreateLookupUserCollaboration(subList,prf.Id,emailSet,'Uploader',OppList,lstclb);
        bcb.CreatePrfLookupUserCollaboration(subList,emailSet,'Uploader',prf.Id,OppList,lstclb);
        
        
        
    }
   static testMethod void myUnitTestNew() {
         List<Sub_folder__c> subList = new List<Sub_folder__c>();
        RecordType rt = [Select id from RecordType where name='Subcontractor'];
        Account acc =new Account();
        acc.name = 'irfan khan';
        acc.RecordTypeId = rt.Id;
        upsert acc;
        
        Contact con = new Contact(FirstName='Test1',LastName='State1',email='test2@test.com',AccountId=acc.id);
        upsert con;
         Set<String> emailSet = new Set<String>();
        emailSet.add(con.email);
        
        Deal__c opp = new Deal__c();
        //opp.name = 'Test opp';
        opp.Account__c = acc.id;
        opp.CloseDate__c = date.today();
        opp.stageName__c = 'Closed Won';
        upsert opp;
       
       Deal__c oppr =[Select id, Opp_Pipeline_Stage__c from Deal__c where stageName__c='Closed Won' and id=:opp.id];
        
      //  System.assert(false,[select id,stageName From Deal__c where id=:opp.id]);             
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        upsert testBox;
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Sales';
        sf.cf_Deal__c = oppr.id;
        sf.cf_box_folder_id__c = '11446498';
        upsert sf;
        subList.add(sf);
        List<String> fldsubList = new List<String>();
        fldsubList.add(sf.cf_box_folder_id__c);
        //System.assert(false,[Select id,CF_Box_Folder_Id__c,cf_Deal__r.stagename from Sub_Folder__c  where name=:'Funding-Vendor']);
        Profile prf= [select id,Name From Profile Where Name='Project Manager'];
        
        BoxAccessMatrix_SubFolder__c bams = new BoxAccessMatrix_SubFolder__c();
        bams.SubFolder_Name__c='Sales';
        bams.Name='Sales';
        upsert bams;
        
        BoxAccessMatrix_Profile__c bamp = new BoxAccessMatrix_Profile__c();
        bamp.BoxAccessMatrix_SubFolder__c=bams.id;
        bamp.Profile_Id__c=prf.id;
        bamp.Profile_Name__c=prf.name;
       // bamp.Lookup_Field_Name__c='Concierge__c';
        upsert bamp;
        
        BoxAccessMatrix_Stage__c BAM = new BoxAccessMatrix_Stage__c();
        BAM.Box_Permission__c='Viewer';
        BAM.BoxAccessMatrix_Profile__c=bamp.id;
        BAM.Stage__c=oppr.Opp_Pipeline_Stage__c;
        BAM.check__c=true;
        upsert BAM;
        
       
        
        
       
        
        Box_Group__c bg = new Box_Group__c();
        bg.BoxGroup_Id__c='34087847';
        bg.BoxGroup_Name__c='test box grop';
        bg.SF_Profile_Id__c=prf.id;
        upsert bg;
        
        
        Project__c pj = new Project__c();
        pj.Name = 'old prj';
        pj.Deal__c = oppr.id;
        pj.Subcontractor__c = acc.id;
        insert pj;
        
       List<box_log__c> OppList = new List<box_log__c>();
        box_log__c bxerr = new box_log__c(Deal__c = opp.id,Status__c = 'Success',Sub_Folder__c = sf.id,Type__c ='Create Collaboration');
        insert  bxerr ; 
        OppList.add(bxerr); 
       
        List<Collaboration__c> lstclb = new List<Collaboration__c>();
        Collaboration__c clb = new Collaboration__c(BoxCollaboration_Id__c='123456',BoxFolder_Id__c='34567',BoxGroup_Id__c=bg.BoxGroup_Id__c,Role__c='Viewer');
        upsert clb;
        lstclb.add(clb);
        
        CreateCollaborationOnStageChangeBatch bcb = new CreateCollaborationOnStageChangeBatch('Sales','Closed Won','11446498');
        Database.BatchableContext BC;
        
        bcb.start(BC);
        Test.startTest();
        bcb.CreateUserGroupCollaboration(subList,bg.BoxGroup_Id__c,'Uploader',prf.Id,lstclb,OppList);
        bcb.CreateLookupUserCollaboration(subList,prf.Id,emailSet,'Uploader',OppList,lstclb);
        bcb.CreatePrfLookupUserCollaboration(subList,emailSet,'Uploader',prf.Id,OppList,lstclb);
        Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
        bcb.execute(BC,subList);
        bcb.finish(BC);
        
        bcb.CreateUserGroupCollaboration(subList,bg.BoxGroup_Id__c,'Uploader',prf.Id,lstclb,OppList);
        bcb.CreateLookupUserCollaboration(subList,prf.Id,emailSet,'Uploader',OppList,lstclb);
        bcb.CreatePrfLookupUserCollaboration(subList,emailSet,'Uploader',prf.Id,OppList,lstclb);
        
        
        
    }  
    
   static testMethod void myUnitTest1() {
         List<Sub_folder__c> subList = new List<Sub_folder__c>();
        RecordType rt = [Select id from RecordType where name='Subcontractor'];
        Account acc =new Account();
        acc.name = 'irfan khan';
        acc.RecordTypeId = rt.Id;
        upsert acc;
        
        Contact con = new Contact(FirstName='Test1',LastName='State1',email='test2@test.com',AccountId=acc.id);
        upsert con;
        
         Set<String> emailSet = new Set<String>();
        emailSet.add(con.email);
        
        Deal__c opp = new Deal__c();   
        //opp.name = 'Test opp';
        opp.Account__c = acc.id;
        opp.CloseDate__c = date.today();
        opp.stageName__c = 'Closed Won';
        upsert opp;
       	
       Deal__c oppr =[Select id, Opp_Pipeline_Stage__c from Deal__c where stageName__c='Closed Won' and id=:opp.id];
        
      //  System.assert(false,[select id,stageName From Deal__c where id=:opp.id]);             
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        upsert testBox;
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Application';
        sf.cf_Deal__c = oppr.id;
        sf.cf_box_folder_id__c = '11446498';
        upsert sf;
        subList.add(sf);
        List<String> fldsubList = new List<String>();
        fldsubList.add(sf.cf_box_folder_id__c);
        //System.assert(false,[Select id,CF_Box_Folder_Id__c,cf_Deal__r.stagename from Sub_Folder__c  where name=:'Funding-Vendor']);
        Profile prf= [select id,Name From Profile Where Name='EE Partner User'];
        
        BoxAccessMatrix_SubFolder__c bams = new BoxAccessMatrix_SubFolder__c();
        bams.SubFolder_Name__c='Application';
        bams.Name='Application';
        upsert bams;
        
        BoxAccessMatrix_Profile__c bamp = new BoxAccessMatrix_Profile__c();
        bamp.BoxAccessMatrix_SubFolder__c=bams.id;
        bamp.Profile_Id__c=prf.id;
        bamp.Profile_Name__c='EE Partner User';
        bamp.Lookup_Field_Name__c='Subcontractor__c';
        upsert bamp;
        
        BoxAccessMatrix_Stage__c BAM = new BoxAccessMatrix_Stage__c();
        BAM.Box_Permission__c='Viewer';
        BAM.BoxAccessMatrix_Profile__c=bamp.id;
        BAM.Stage__c=oppr.Opp_Pipeline_Stage__c;
        BAM.check__c=true;
        upsert BAM;
        
       
        
        
       
        
        Box_Group__c bg = new Box_Group__c();
        bg.BoxGroup_Id__c='34087847';
        bg.BoxGroup_Name__c='test box grop';
        bg.SF_Profile_Id__c=prf.id;
        upsert bg;
        
        
        Project__c pj = new Project__c();
        pj.Name = 'old prj';
        pj.Deal__c = oppr.id;
        pj.Subcontractor__c = acc.id;
        insert pj;
        
        List<box_log__c> OppList = new List<box_log__c>();
        box_log__c bxerr = new box_log__c(Deal__c = opp.id,Status__c = 'Success',Sub_Folder__c = sf.id,Type__c ='Create Collaboration');
        insert  bxerr ; 
        OppList.add(bxerr);  
       
        List<Collaboration__c> lstclb = new List<Collaboration__c>();
        Collaboration__c clb = new Collaboration__c(BoxCollaboration_Id__c='123456',BoxFolder_Id__c='34567',BoxGroup_Id__c=bg.BoxGroup_Id__c,Role__c='Viewer');
        upsert clb;
        lstclb.add(clb);
        
        CreateCollaborationOnStageChangeBatch bcb = new CreateCollaborationOnStageChangeBatch('Application','Closed Won','11446498');
        Database.BatchableContext BC;
        
        bcb.start(BC);
        Test.startTest();
        bcb.CreateUserGroupCollaboration(subList,bg.BoxGroup_Id__c,'Uploader',prf.Id,lstclb,OppList);
        bcb.CreateLookupUserCollaboration(subList,prf.Id,emailSet,'Uploader',OppList,lstclb);
        bcb.CreatePrfLookupUserCollaboration(subList,emailSet,'Uploader',prf.Id,OppList,lstclb);
        Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
        bcb.execute(BC,subList);
        bcb.finish(BC);
        bcb.CreateUserGroupCollaboration(subList,bg.BoxGroup_Id__c,'Uploader',prf.Id,lstclb,OppList);
        bcb.CreateLookupUserCollaboration(subList,prf.Id,emailSet,'Uploader',OppList,lstclb);
        bcb.CreatePrfLookupUserCollaboration(subList,emailSet,'Uploader',prf.Id,OppList,lstclb);
        
        
        
    }
    
    static testMethod void myUnitTest2() {
         List<Sub_folder__c> subList = new List<Sub_folder__c>();
        
        RecordType rt = [Select id from RecordType where name='Subcontractor'];
        Account acc =new Account();
        acc.name = 'irfan khan';
        acc.RecordTypeId = rt.Id;
        upsert acc;
        
        Contact con = new Contact(FirstName='Test1',LastName='State1',email='test2@test.com',AccountId=acc.id);
        upsert con;
         Set<String> emailSet = new Set<String>();
        emailSet.add(con.email);
        
        Deal__c opp = new Deal__c();
        ///opp.name = 'Test opp';
        opp.Account__c = acc.id;
        opp.CloseDate__c = date.today();
        opp.stageName__c = 'Closed Won';
        upsert opp;
       
       Deal__c oppr =[Select id, Opp_Pipeline_Stage__c from Deal__c where stageName__c='Closed Won' and id=:opp.id];
        
      //  System.assert(false,[select id,stageName From Deal__c where id=:opp.id]);             
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        upsert testBox;   						
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Application';
        sf.cf_Deal__c = oppr.id;
        sf.cf_box_folder_id__c = '11446498';
        upsert sf;
        subList.add(sf);
        List<String> fldsubList = new List<String>();
        fldsubList.add(sf.cf_box_folder_id__c);
        //System.assert(false,[Select id,CF_Box_Folder_Id__c,cf_Deal__r.stagename from Sub_Folder__c  where name=:'Funding-Vendor']);
        Profile prf= [select id,Name From Profile Where Name='EE Assessor'];
        
        BoxAccessMatrix_SubFolder__c bams = new BoxAccessMatrix_SubFolder__c();
        bams.SubFolder_Name__c='Application';
        bams.Name='Application';
        upsert bams;
        
        BoxAccessMatrix_Profile__c bamp = new BoxAccessMatrix_Profile__c();
        bamp.BoxAccessMatrix_SubFolder__c=bams.id;
        bamp.Profile_Id__c=prf.id;
        bamp.Profile_Name__c='EE Assessor';
        bamp.Lookup_Field_Name__c='EE_Assessor__c';
        upsert bamp;
        
        BoxAccessMatrix_Stage__c BAM = new BoxAccessMatrix_Stage__c();
        BAM.Box_Permission__c='Viewer';
        BAM.BoxAccessMatrix_Profile__c=bamp.id;
        BAM.Stage__c=oppr.Opp_Pipeline_Stage__c;	
        BAM.check__c=true;
        upsert BAM;
        
       
        
        
       
        
        Box_Group__c bg = new Box_Group__c();
        bg.BoxGroup_Id__c='34087847';
        bg.BoxGroup_Name__c='test box grop';
        bg.SF_Profile_Id__c=prf.id;
        upsert bg;
        
        
        String orgId = UserInfo.getOrganizationId(); 
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-',''); 
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000)); 
        String uniqueName = orgId + dateString + randomInt; 
         
        User u = new User(); 
        u.Username =  uniqueName + '@test' + orgId + '.org'; 
        u.ProfileId = prf.Id; 
        u.LastName = 'test'; 
        u.Alias = 'test1'; 
        u.Email =  uniqueName + '@test' + orgId + '.org'; 
        u.TimeZoneSidKey = 'America/Los_Angeles'; 
        u.localesidkey='en_US'; 
        u.emailencodingkey='UTF-8'; 
        u.languagelocalekey='en_US'; 
        insert u; 

        
        Project__c pj = new Project__c();
        pj.Name = 'old prj';
        pj.Deal__c = oppr.id;
        pj.EE_Assessor__c = u.id;
        insert pj;
        
        List<box_log__c> OppList = new List<box_log__c>();
        box_log__c bxerr = new box_log__c(Deal__c = opp.id,Status__c = 'Success',Sub_Folder__c = sf.id,Type__c ='Create Collaboration');
        insert  bxerr ; 
        OppList.add(bxerr);  
       
        List<Collaboration__c> lstclb = new List<Collaboration__c>();
        Collaboration__c clb = new Collaboration__c(BoxCollaboration_Id__c='123456',BoxFolder_Id__c='34567',BoxGroup_Id__c=bg.BoxGroup_Id__c,Role__c='Viewer');
        upsert clb;
        lstclb.add(clb);
        
        CreateCollaborationOnStageChangeBatch bcb = new CreateCollaborationOnStageChangeBatch('Application','Closed Won','11446498');
        Database.BatchableContext BC;
        
        bcb.start(BC);
        Test.startTest();
        bcb.CreateUserGroupCollaboration(subList,bg.BoxGroup_Id__c,'Uploader',prf.Id,lstclb,OppList);
        bcb.CreateLookupUserCollaboration(subList,prf.Id,emailSet,'Uploader',OppList,lstclb);
        bcb.CreatePrfLookupUserCollaboration(subList,emailSet,'Uploader',prf.Id,OppList,lstclb);
        Test.setMock(HttpCalloutMock.class, new TestFileUploadMock4());
        bcb.execute(BC,subList);
        bcb.finish(BC);
        bcb.CreateUserGroupCollaboration(subList,bg.BoxGroup_Id__c,'Uploader',prf.Id,lstclb,OppList);
        bcb.CreateLookupUserCollaboration(subList,prf.Id,emailSet,'Uploader',OppList,lstclb);
        bcb.CreatePrfLookupUserCollaboration(subList,emailSet,'Uploader',prf.Id,OppList,lstclb);
        
        
        
    }
}