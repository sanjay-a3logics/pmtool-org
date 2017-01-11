@isTest
public class TestBoxaddCollaborationBatch { 

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        List<Sub_folder__c> subList = new List<Sub_folder__c>();
        
         Account acc =new Account();
        acc.name = 'irfan khan';
        upsert acc;
        
        Contact con = new Contact(FirstName='Test1',LastName='State1',email='test2@test.com',AccountId=acc.id);
        upsert con;
        
     
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed Won';
        upsert opp;
        
        opportunity op =[Select id, Pipeline_stage__c from opportunity where stageName='Closed Won' and id=:opp.id];
        
        
      //  System.assert(false,[select id,stageName From opportunity where id=:opp.id]);             
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        upsert testBox;
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Funding-Vendor';
        sf.cf_opportunity__c = op.id;
        sf.cf_box_folder_id__c = '11446498';
        upsert sf;
       
        Sub_folder__c sflst =[Select id,cf_box_folder_id__c,cf_opportunity__c,name, cf_opportunity__r.Pipeline_stage__c from Sub_folder__c where id=:sf.id];
        
        subList.add(sflst);
        List<String> fldsubList = new List<String>();
        fldsubList.add(sf.cf_box_folder_id__c);
       
        Profile prf= [select id,Name From Profile Where Name='EE Partner User'];
        
        BoxAccessMatrix_SubFolder__c bams = new BoxAccessMatrix_SubFolder__c();
        bams.SubFolder_Name__c='Funding-Vendor';
        bams.Name='Funding-Vendor';
        upsert bams;
        
        BoxAccessMatrix_Profile__c bamp = new BoxAccessMatrix_Profile__c();
        bamp.BoxAccessMatrix_SubFolder__c=bams.id;
        bamp.Profile_Id__c=prf.id;
        bamp.Profile_Name__c='EE Partner User';
        bamp.Lookup_field_Name__c='Subcontractor__c';
        insert bamp;
        
        
        
               
        RecordType rt = [Select id,Name from recordType where name='Pv Install'];
        
        Project__c pj = new Project__c();
        pj.Opportunity__c = op.id;
        //pj.Subcontractor__c=acc.id;
        pj.RecordTypeId = rt.id;       
        insert pj; 
        
        BoxAccessMatrix_Stage__c BAM = new BoxAccessMatrix_Stage__c();
        BAM.Box_Permission__c='Viewer';
        BAM.BoxAccessMatrix_Profile__c=bamp.id;
        BAM.Stage__c=op.Pipeline_stage__c;
        BAM.check__c=true;
        insert BAM;
        
        
        
        BoxAccessMatrix_Stage__c BAMT = [Select id,Stage__c,check__c,Box_Permission__c,BoxAccessMatrix_Profile__r.Profile_Id__c,BoxAccessMatrix_Profile__r.Lookup_field_Name__c,BoxAccessMatrix_Profile__r.Profile_Name__c from BoxAccessMatrix_Stage__c where id=:BAM.id];
        
        Box_Group__c bg = new Box_Group__c();
        bg.BoxGroup_Id__c='34087847';
        bg.BoxGroup_Name__c='test box grop';
        bg.SF_Profile_Id__c=prf.id;
        upsert bg;
        
        List<Box_error__c> OppList = new List<Box_error__c>();
        box_error__c bxerr = new box_error__c();
        bxerr.Opportunity__c = opp.id; 
        bxerr.name = '409'; 
        bxerr.Message__c = 'Attachment id-'; 
        bxerr.Body__c = '{"type":"error","status":409,"code":"item_name_in_use","context_info":{"conflicts":{"type":"folder","id":"5045260509","sequence_id":"0","etag":"0","name":"2796_9019apricotst_JamesTobias"}},"help_url":"http:developers.box.com","message":"Item with the same name already exists","request_id":"1145339348561cbaa279ec4"}';
        bxerr.Type__c = 'EE';
        bxerr.Status__c = 'Error';  
        OppList.add(bxerr); 
       
        List<Collaboration__c> lstclb = new List<Collaboration__c>();
        Collaboration__c clb = new Collaboration__c(BoxCollaboration_Id__c='123456',BoxFolder_Id__c='34567',BoxGroup_Id__c=bg.BoxGroup_Id__c,Role__c='Viewer');
        upsert clb;
        lstclb.add(clb);
        
        BoxaddCollaborationBatch bcb = new BoxaddCollaborationBatch('EE',10,prf.id,'test@emai.com');
        Database.BatchableContext BC;
        
        bcb.start(BC);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestFolderInfoMock());
        bcb.execute(BC,subList);
        bcb.accountdata();
        Test.stopTest();         
    }
  static testMethod void myUnitTest2() {
        // TO DO: implement unit test
        List<Sub_folder__c> subList = new List<Sub_folder__c>();
        
         Account acc =new Account();
        acc.name = 'irfan khan';
        upsert acc;
        
        Contact con = new Contact(FirstName='Test1',LastName='State1',email='test2@test.com',AccountId=acc.id);
        upsert con;
        
     
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed Won';
        upsert opp;
        
        opportunity op =[Select id, Pipeline_stage__c from opportunity where stageName='Closed Won' and id=:opp.id];
        
        
      //  System.assert(false,[select id,stageName From opportunity where id=:opp.id]);             
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        upsert testBox;
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Funding-Vendor';
        sf.cf_opportunity__c = op.id;
        sf.cf_box_folder_id__c = '11446498';
        upsert sf;
       
        Sub_folder__c sflst =[Select id,cf_box_folder_id__c,cf_opportunity__c,name, cf_opportunity__r.Pipeline_stage__c from Sub_folder__c where id=:sf.id];
        
        subList.add(sflst);
        List<String> fldsubList = new List<String>();
        fldsubList.add(sf.cf_box_folder_id__c);
       
        Profile prf= [select id,Name From Profile Where Name='EE Partner User'];
        
        BoxAccessMatrix_SubFolder__c bams = new BoxAccessMatrix_SubFolder__c();
        bams.SubFolder_Name__c='Funding-Vendor';
        bams.Name='Funding-Vendor';
        upsert bams;
        
        BoxAccessMatrix_Profile__c bamp = new BoxAccessMatrix_Profile__c();
        bamp.BoxAccessMatrix_SubFolder__c=bams.id;
        bamp.Profile_Id__c=prf.id;
        bamp.Profile_Name__c='EE Partner User';
        bamp.Lookup_field_Name__c='Subcontractor__c';
        insert bamp;
        
        
        
               
        RecordType rt = [Select id,Name from recordType where name='Pv Install'];
        
        Project__c pj = new Project__c();
        pj.Opportunity__c = op.id;
        //pj.Subcontractor__c=acc.id;
        pj.RecordTypeId = rt.id;       
        insert pj; 
        
        BoxAccessMatrix_Stage__c BAM = new BoxAccessMatrix_Stage__c();
        BAM.Box_Permission__c='Viewer';
        BAM.BoxAccessMatrix_Profile__c=bamp.id;
        BAM.Stage__c=op.Pipeline_stage__c;
        BAM.check__c=true;
        insert BAM;
        
      
        
        BoxAccessMatrix_Stage__c BAMT = [Select id,Stage__c,check__c,Box_Permission__c,BoxAccessMatrix_Profile__r.Profile_Id__c,BoxAccessMatrix_Profile__r.Lookup_field_Name__c,BoxAccessMatrix_Profile__r.Profile_Name__c from BoxAccessMatrix_Stage__c where id=:BAM.id];
        
        Box_Group__c bg = new Box_Group__c();
        bg.BoxGroup_Id__c='34087847';
        bg.BoxGroup_Name__c='test box grop';
        bg.SF_Profile_Id__c=prf.id;
        upsert bg;
        
        List<Box_error__c> OppList = new List<Box_error__c>();
        box_error__c bxerr = new box_error__c();
        bxerr.Opportunity__c = opp.id; 
        bxerr.name = '409'; 
        bxerr.Message__c = 'Attachment id-'; 
        bxerr.Body__c = '{"type":"error","status":409,"code":"item_name_in_use","context_info":{"conflicts":{"type":"folder","id":"5045260509","sequence_id":"0","etag":"0","name":"2796_9019apricotst_JamesTobias"}},"help_url":"http:developers.box.com","message":"Item with the same name already exists","request_id":"1145339348561cbaa279ec4"}';
        bxerr.Type__c = 'EE';
        bxerr.Status__c = 'Error';  
        OppList.add(bxerr); 
       
        List<Collaboration__c> lstclb = new List<Collaboration__c>();
        Collaboration__c clb = new Collaboration__c(BoxCollaboration_Id__c='123456',BoxFolder_Id__c='34567',BoxGroup_Id__c=bg.BoxGroup_Id__c,Role__c='Viewer');
        upsert clb;
        lstclb.add(clb);
        
        BoxaddCollaborationBatch bcb = new BoxaddCollaborationBatch('EE',10,prf.id,'test@emai.com');
        Database.BatchableContext BC;
        
        bcb.start(BC);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
        bcb.execute(BC,subList);
        bcb.accountdata();
        Test.stopTest();         
    }  
    
   
        
}