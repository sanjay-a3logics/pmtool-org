/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
public class TestBoxInitialCollaborationBatch { 

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        List<Sub_folder__c> subList = new List<Sub_folder__c>();
        
        Account acc =new Account();
        acc.name = 'irfan khan';
        upsert acc;
        
        Contact con = new Contact(FirstName='Test1',LastName='State1',email='test2@test.com',AccountId=acc.id);
        upsert con;
        
        
        
       
       Set<String> opset = new Set<String>();  
        Deal__c opp = new Deal__c();
        //opp.name = 'Test opp';
        opp.Account__c = acc.id;
        opp.CloseDate__c = date.today();
        opp.stageName__c = 'Closed Won';
        upsert opp;
        opset.add(opp.id);
        
        Deal__c op =[Select id, Opp_Pipeline_Stage__c from Deal__c where stageName__c='Closed Won' and id=:opp.id];
        
        
      //  System.assert(false,[select id,stageName From Deal__c where id=:opp.id]);             
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        upsert testBox;
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Funding-Vendor';
        sf.cf_Deal__c = op.id;
        sf.cf_box_folder_id__c = '11446498';
        upsert sf;
       
        Sub_folder__c sflst =[Select id,cf_box_folder_id__c,cf_Deal__c,name, cf_Deal__r.Opp_Pipeline_Stage__c from Sub_folder__c where id=:sf.id];
        
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
        upsert bamp;
        
        BoxAccessMatrix_Stage__c BAM = new BoxAccessMatrix_Stage__c();
        BAM.Box_Permission__c='Viewer';
        BAM.BoxAccessMatrix_Profile__c=bamp.id;
        BAM.Stage__c=op.Opp_Pipeline_Stage__c;
        BAM.check__c=true;
        upsert BAM;
        
        Box_Group__c bg = new Box_Group__c();
        bg.BoxGroup_Id__c='34087847';
        bg.BoxGroup_Name__c='test box grop';
        bg.SF_Profile_Id__c=prf.id;
        upsert bg;
        
        List<box_log__c > OppList = new List<box_log__c >();
        box_log__c bxerr = new box_log__c(Deal__c = opp.id,Reference__c='abcd',Status__c = 'Success',Sub_Folder__c = sf.id,Type__c ='Create Collaboration');
        //insert  bxerr ;
        OppList.add(bxerr);  
       
       List<Collaboration__c> lstclb = new List<Collaboration__c>();
        Collaboration__c clb = new Collaboration__c(BoxCollaboration_Id__c='123456',BoxFolder_Id__c='34567',BoxGroup_Id__c=bg.BoxGroup_Id__c,Role__c='Viewer');
        upsert clb;
        
        BoxInitialCollaborationBatch bcb = new BoxInitialCollaborationBatch('Funding-Vendor',10,opset);
        Database.BatchableContext BC;
        
        bcb.start(BC);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
        bcb.execute(bc,subList);
        BoxInitialCollaborationBatch.CreateUserGroupCollaboration(op.id,sflst.id,fldsubList,string.valueof(bg.id),'Viewer',bamp.Profile_Id__c,lstclb,OppList);
        BoxInitialCollaborationBatch.CreateLookupUserCollaboration(op.id,sflst.id,fldsubList,'test@appcino.com','Viewer',bamp.Profile_Id__c,lstclb,OppList);
        BoxInitialCollaborationBatch.CreatePrfLookupUserCollaboration(op.id,sflst.id,sf.cf_box_folder_id__c,'test1@appcino.com','Viewer',bamp.Profile_Id__c,lstclb,OppList);
        Test.stopTest();         
    }
    static testMethod void myUnitTest1() {
        // TO DO: implement unit test
        List<Sub_folder__c> subList = new List<Sub_folder__c>();
        Account acc =new Account();
        acc.name = 'irfan khan';
        upsert acc;
        
        Contact con = new Contact(FirstName='Test2',LastName='State1',email='test1@test.com',AccountId=acc.id);
        upsert con;
        
       
        Set<String> opset = new Set<String>(); 
        Deal__c opp = new Deal__c();
        //opp.name = 'Test opp';
        opp.Account__c = acc.id;
        opp.CloseDate__c = date.today();
        opp.stageName__c = 'Closed Won';
        upsert opp;
        opset.add(opp.id);
       
        Deal__c op =[Select id, Opp_Pipeline_Stage__c from Deal__c where stageName__c='Closed Won' and id=:opp.id];
        
      //  System.assert(false,[select id,stageName From Deal__c where id=:opp.id]);             
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        upsert testBox;
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Funding-Vendor';
        sf.cf_Deal__c = op.id;
        sf.cf_box_folder_id__c = '11446498';
        upsert sf;   
        Sub_folder__c sflst =[Select id,cf_box_folder_id__c,cf_Deal__c,name, cf_Deal__r.Opp_Pipeline_Stage__c from Sub_folder__c where id=:sf.id];
        
        subList.add(sflst);
        List<String> fldsubList = new List<String>();
        fldsubList.add(sf.cf_box_folder_id__c);
        //System.assert(false,[Select id,CF_Box_Folder_Id__c,cf_Deal__r.stagename from Sub_Folder__c  where name=:'Funding-Vendor']);
        Profile prf= [select id,Name From Profile Where Name='System Administrator'];
        
        BoxAccessMatrix_SubFolder__c bams = new BoxAccessMatrix_SubFolder__c();
        bams.SubFolder_Name__c='Funding-Vendor';
        bams.Name='Funding-Vendor';
        upsert bams;
        
        BoxAccessMatrix_Profile__c bamp = new BoxAccessMatrix_Profile__c();
        bamp.BoxAccessMatrix_SubFolder__c=bams.id;
        bamp.Profile_Id__c=prf.id;
        bamp.Profile_Name__c='System Administrator';
        //bamp.Lookup_field_Name__c='Concierge__c';
        upsert bamp;
        
        BoxAccessMatrix_Stage__c BAM = new BoxAccessMatrix_Stage__c();
        BAM.Box_Permission__c='Viewer';
        BAM.BoxAccessMatrix_Profile__c=bamp.id;
        BAM.Stage__c=op.Opp_Pipeline_Stage__c;
        BAM.check__c=true;
        upsert BAM;
        
        Box_Group__c bg = new Box_Group__c();
        bg.BoxGroup_Id__c='34087847';      
        bg.BoxGroup_Name__c='test box grop';
        bg.SF_Profile_Id__c=prf.id;
        upsert bg;
        
        List<Collaboration__c> lstclb = new List<Collaboration__c>();
        Collaboration__c clb = new Collaboration__c(BoxCollaboration_Id__c='123456',BoxFolder_Id__c='34567',BoxGroup_Id__c=bg.BoxGroup_Id__c,Role__c='Viewer');
        upsert clb;
        
         List<box_log__c > OppList = new List<box_log__c >();
        box_log__c bxerr = new box_log__c(Deal__c = opp.id,Reference__c='abcd',Status__c = 'Success',Sub_Folder__c = sf.id,Type__c ='Create Collaboration');
        //insert  bxerr ;
        OppList.add(bxerr);  
        
        
        
        BoxInitialCollaborationBatch bcb = new BoxInitialCollaborationBatch('Funding-Vendor',10,opset);
        Database.BatchableContext BC;
        
        bcb.start(BC);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestFileUploadMock3());
        bcb.execute(bc,subList);
        BoxInitialCollaborationBatch.CreateUserGroupCollaboration(op.id,sflst.id,fldsubList,string.valueof(bg.id),'Viewer',bamp.Profile_Id__c,lstclb,OppList);
        BoxInitialCollaborationBatch.CreateLookupUserCollaboration(op.id,sflst.id,fldsubList,'test1@appcino.com','Viewer',bamp.Profile_Id__c,lstclb,OppList);
        BoxInitialCollaborationBatch.CreatePrfLookupUserCollaboration(op.id,sflst.id,sf.cf_box_folder_id__c,'test1@appcino.com','Viewer',bamp.Profile_Id__c,lstclb,OppList);
        Test.stopTest();         
    }
  static testMethod void myUnitTest2() {
        // TO DO: implement unit test
        List<Sub_folder__c> subList = new List<Sub_folder__c>();
        Account acc =new Account();
        acc.name = 'irfan khan';
        upsert acc;
        
        Contact con = new Contact(FirstName='Test2',LastName='State1',email='test1@test.com',AccountId=acc.id);
        upsert con;
        
       
        
        Set<String> opset = new Set<String>(); 
        Deal__c opp = new Deal__c();
        //opp.name = 'Test opp';
        opp.Account__c = acc.id;
        opp.CloseDate__c = date.today();
        opp.stageName__c = 'Closed Won';
        upsert opp;
        opset.add(opp.id);
       
        Deal__c op =[Select id, Opp_Pipeline_Stage__c from Deal__c where stageName__c='Closed Won' and id=:opp.id];
        
      //  System.assert(false,[select id,stageName From Deal__c where id=:opp.id]);             
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        upsert testBox;
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Funding-Vendor';
        sf.cf_Deal__c = op.id;
        sf.cf_box_folder_id__c = '11446498';
        upsert sf;
        Sub_folder__c sflst =[Select id,cf_box_folder_id__c,cf_Deal__c,name, cf_Deal__r.Opp_Pipeline_Stage__c from Sub_folder__c where id=:sf.id];
        
        subList.add(sflst);
        List<String> fldsubList = new List<String>();
        fldsubList.add(sf.cf_box_folder_id__c);
        //System.assert(false,[Select id,CF_Box_Folder_Id__c,cf_Deal__r.stagename from Sub_Folder__c  where name=:'Funding-Vendor']);
        Profile prf= [select id,Name From Profile Where Name='EE Assessor'];
        
        BoxAccessMatrix_SubFolder__c bams = new BoxAccessMatrix_SubFolder__c();
        bams.SubFolder_Name__c='Funding-Vendor';
        bams.Name='Funding-Vendor';
        upsert bams;
        
        BoxAccessMatrix_Profile__c bamp = new BoxAccessMatrix_Profile__c();
        bamp.BoxAccessMatrix_SubFolder__c=bams.id;
        bamp.Profile_Id__c=prf.id;
        bamp.Profile_Name__c='EE Assessor';
        bamp.Lookup_field_Name__c='EE_Assessor__c';
        upsert bamp;
        
        BoxAccessMatrix_Stage__c BAM = new BoxAccessMatrix_Stage__c();
        BAM.Box_Permission__c='Viewer';
        BAM.BoxAccessMatrix_Profile__c=bamp.id;
        BAM.Stage__c=op.Opp_Pipeline_Stage__c;
        BAM.check__c=true;
        upsert BAM;
        
        Box_Group__c bg = new Box_Group__c();
        bg.BoxGroup_Id__c='34087847';      
        bg.BoxGroup_Name__c='test box grop';
        bg.SF_Profile_Id__c=prf.id;
        upsert bg;
        
        List<Collaboration__c> lstclb = new List<Collaboration__c>();
        Collaboration__c clb = new Collaboration__c(BoxCollaboration_Id__c='123456',BoxFolder_Id__c='34567',BoxGroup_Id__c=bg.BoxGroup_Id__c,Role__c='Viewer');
        upsert clb;
        
        List<box_log__c > OppList = new List<box_log__c >();
        box_log__c bxerr = new box_log__c(Deal__c = opp.id,Reference__c='abcd',Status__c = 'Success',Sub_Folder__c = sf.id,Type__c ='Create Collaboration');
       // insert  bxerr ;
        OppList.add(bxerr);  
        
        
        
        BoxInitialCollaborationBatch bcb = new BoxInitialCollaborationBatch('Funding-Vendor',10,opset);
        Database.BatchableContext BC;
        
        bcb.start(BC);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestFileUploadMock3());
        bcb.execute(bc,subList);
        BoxInitialCollaborationBatch.CreateUserGroupCollaboration(op.id,sflst.id,fldsubList,string.valueof(bg.id),'Viewer',bamp.Profile_Id__c,lstclb,OppList);
        BoxInitialCollaborationBatch.CreateLookupUserCollaboration(op.id,sflst.id,fldsubList,'test1@appcino.com','Viewer',bamp.Profile_Id__c,lstclb,OppList);
        BoxInitialCollaborationBatch.CreatePrfLookupUserCollaboration(op.id,sflst.id,sf.cf_box_folder_id__c,'test1@appcino.com','Viewer',bamp.Profile_Id__c,lstclb,OppList);
        Test.stopTest();         
    } 
   static testMethod void myUnitTest3() {
        // TO DO: implement unit test
        List<Sub_folder__c> subList = new List<Sub_folder__c>();
        Account acc =new Account();
        acc.name = 'irfan khan';
        upsert acc;
        
        Contact con = new Contact(FirstName='Test2',LastName='State1',email='test1@test.com',AccountId=acc.id);
        upsert con;
        
       
        
        Set<String> opset = new Set<String>(); 
        Deal__c opp = new Deal__c();
        ///opp.name = 'Test opp';    					
        opp.Account__c = acc.id;				
        opp.CloseDate__c = date.today();
        opp.stageName__c = 'Closed Won';
        upsert opp;
        opset.add(opp.id);
       
        Deal__c op =[Select id, Opp_Pipeline_Stage__c from Deal__c where stageName__c='Closed Won' and id=:opp.id];
        
      //  System.assert(false,[select id,stageName From Deal__c where id=:opp.id]);             
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        upsert testBox;
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Funding-Vendor';
        sf.cf_Deal__c = op.id;
        sf.cf_box_folder_id__c = '11446498';
        upsert sf;
        Sub_folder__c sflst =[Select id,cf_box_folder_id__c,cf_Deal__c,name, cf_Deal__r.Opp_Pipeline_Stage__c from Sub_folder__c where id=:sf.id];
        
        subList.add(sflst);
        List<String> fldsubList = new List<String>();
        fldsubList.add(sf.cf_box_folder_id__c);
        //System.assert(false,[Select id,CF_Box_Folder_Id__c,cf_Deal__r.stagename from Sub_Folder__c  where name=:'Funding-Vendor']);
        Profile prf= [select id,Name From Profile Where Name='Sales Manager'];
        
        BoxAccessMatrix_SubFolder__c bams = new BoxAccessMatrix_SubFolder__c();
        bams.SubFolder_Name__c='Funding-Vendor';
        bams.Name='Funding-Vendor';
        upsert bams;
        
        BoxAccessMatrix_Profile__c bamp = new BoxAccessMatrix_Profile__c();
        bamp.BoxAccessMatrix_SubFolder__c=bams.id;
        bamp.Profile_Id__c=prf.id;
        bamp.Profile_Name__c='Sales Manager';
       // bamp.Lookup_field_Name__c='EE_Assessor__c';
        upsert bamp;
        
        BoxAccessMatrix_Stage__c BAM = new BoxAccessMatrix_Stage__c();
        BAM.Box_Permission__c='Viewer';
        BAM.BoxAccessMatrix_Profile__c=bamp.id;
        BAM.Stage__c=op.Opp_Pipeline_Stage__c;	
        BAM.check__c=true;
        upsert BAM;
        
        Box_Group__c bg = new Box_Group__c();
        bg.BoxGroup_Id__c='34087847';      
        bg.BoxGroup_Name__c='test box grop';
        bg.SF_Profile_Id__c=prf.id;
        upsert bg;
        
        List<Collaboration__c> lstclb = new List<Collaboration__c>();
        Collaboration__c clb = new Collaboration__c(BoxCollaboration_Id__c='123456',BoxFolder_Id__c='34567',BoxGroup_Id__c=bg.BoxGroup_Id__c,Role__c='Viewer');
        upsert clb;
        
        List<box_log__c > OppList = new List<box_log__c >();
        box_log__c bxerr = new box_log__c(Deal__c = opp.id,Reference__c='abcd',Status__c = 'Success',Sub_Folder__c = sf.id,Type__c ='Create Collaboration');
        //insert  bxerr ;
        OppList.add(bxerr);  
        
        
        
        BoxInitialCollaborationBatch bcb = new BoxInitialCollaborationBatch('Funding-Vendor',10,opset);
        Database.BatchableContext BC;
        
        bcb.start(BC);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestFileUploadMock3());
        bcb.execute(bc,subList);
        BoxInitialCollaborationBatch.CreateUserGroupCollaboration(op.id,sflst.id,fldsubList,string.valueof(bg.id),'Viewer',bamp.Profile_Id__c,lstclb,OppList);
        BoxInitialCollaborationBatch.CreateLookupUserCollaboration(op.id,sflst.id,fldsubList,'test1@appcino.com','Viewer',bamp.Profile_Id__c,lstclb,OppList);
        BoxInitialCollaborationBatch.CreatePrfLookupUserCollaboration(op.id,sflst.id,sf.cf_box_folder_id__c,'test1@appcino.com','Viewer',bamp.Profile_Id__c,lstclb,OppList);
        Test.stopTest();         
    }    
}