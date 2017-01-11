@isTest
public with sharing class TestAddCollaborationController{
  public static testMethod void myUnitTest1(){
    
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
        opp.Account__r.Id = acc.id;
        opp.CloseDate__c = date.today();
        opp.stageName__c = 'Closed Won';
        upsert opp;
       
        Deal__c oppr =[Select id, Opp_Pipeline_Stage__c from Deal__c where stageName__c='Closed Won' and id=:opp.id];
        
          
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
        
        Profile prf= [select id,Name From Profile Where Name='System Administrator - Vendor'];
        
        BoxAccessMatrix_SubFolder__c bams = new BoxAccessMatrix_SubFolder__c();
        bams.SubFolder_Name__c='Application';
        bams.Name='Application';
        upsert bams;
        
        BoxAccessMatrix_Profile__c bamp = new BoxAccessMatrix_Profile__c();
        bamp.BoxAccessMatrix_SubFolder__c=bams.id;
        bamp.Profile_Id__c=prf.id;
        bamp.Profile_Name__c='System Administrator - Vendor';
        upsert bamp;
        
        BoxAccessMatrix_Stage__c BAM = new BoxAccessMatrix_Stage__c();
        BAM.Box_Permission__c='Viewer';
        BAM.BoxAccessMatrix_Profile__c=bamp.id;
        BAM.Stage__c=oppr.Opp_Pipeline_Stage__c;
        BAM.check__c=true;
        upsert BAM;
        
        BoxAccessMatrix_Stage__c bm = [Select BoxAccessMatrix_Profile__r.Profile_Id__c from BoxAccessMatrix_Stage__c  where id=:BAM.id];
        
        List<Collaboration__c> lstclb = new List<Collaboration__c>();
        Collaboration__c clb = new Collaboration__c(BoxCollaboration_Id__c='123456',BoxFolder_Id__c=sf.cf_box_folder_id__c,BoxGroup_Id__c='12345',Sub_folder__c = sf.id,Role__c='Uploader',SFUser_Email__c =UserInfo.getUserEmail());
        insert clb;
        lstclb.add(clb);
        
        List<box_log__c> OppList = new List<box_log__c>();
        box_log__c bxerr = new box_log__c(Deal__c = opp.id,Status__c = 'Success',Sub_Folder__c = sf.id,Type__c ='Create Collaboration', email__c = userInfo.getUserEmail());
        insert  bxerr ; 
        OppList.add(bxerr); 
       
       
       
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new BoxApiController_mock());
        ApexPages.StandardController cont = new ApexPages.StandardController(opp);
        AddCollaborationController acl= new AddCollaborationController(cont);
        acl.createCollaboration();
        acl.createColl();
        acl.collaborationlogist();
        acl.backtoOpportunity();
        Test.stoptest();
        
        
  
  
  }
 public static testMethod void myUnitTest2(){
    
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
        opp.Account__r.Id = acc.id;
        opp.CloseDate__c = date.today();
        opp.stageName__c = 'Closed Won';
        upsert opp;
       
        Deal__c oppr =[Select id, Opp_Pipeline_Stage__c from Deal__c where stageName__c='Closed Won' and id=:opp.id];
        
             
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
        
        Profile prf= [select id,Name From Profile Where Name='System Administrator - Vendor'];
        
        BoxAccessMatrix_SubFolder__c bams = new BoxAccessMatrix_SubFolder__c();
        bams.SubFolder_Name__c='Application';
        bams.Name='Application';
        upsert bams;
        
        BoxAccessMatrix_Profile__c bamp = new BoxAccessMatrix_Profile__c();
        bamp.BoxAccessMatrix_SubFolder__c=bams.id;
        bamp.Profile_Id__c=prf.id;
        bamp.Profile_Name__c='System Administrator - Vendor';
        upsert bamp;
        
        BoxAccessMatrix_Stage__c BAM = new BoxAccessMatrix_Stage__c();
        BAM.Box_Permission__c='Viewer';
        BAM.BoxAccessMatrix_Profile__c=bamp.id;
        BAM.Stage__c=oppr.Opp_Pipeline_Stage__c;
        BAM.check__c=true;		
        upsert BAM;
        
        BoxAccessMatrix_Stage__c bm = [Select BoxAccessMatrix_Profile__r.Profile_Id__c from BoxAccessMatrix_Stage__c  where id=:BAM.id];
        
        List<Collaboration__c> lstclb = new List<Collaboration__c>();
        Collaboration__c clb = new Collaboration__c(BoxCollaboration_Id__c='123456',BoxFolder_Id__c=sf.cf_box_folder_id__c,BoxGroup_Id__c='12345',Sub_folder__c = sf.id,Role__c='Uploader',SFUser_Email__c =UserInfo.getUserEmail());
        insert clb;
        lstclb.add(clb);
        
        List<box_log__c> OppList = new List<box_log__c>();
        box_log__c bxerr = new box_log__c(Deal__c = opp.id,Status__c = 'Success',Sub_Folder__c = sf.id,Type__c ='Create Collaboration', email__c = userInfo.getUserEmail());
        insert  bxerr ; 
        OppList.add(bxerr); 
       
       
       
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestFileUploadMock3());
        ApexPages.StandardController cont = new ApexPages.StandardController(opp);
        AddCollaborationController acl= new AddCollaborationController(cont);
        acl.createCollaboration();
        acl.createColl();
        acl.collaborationlogist();
        acl.backtoOpportunity();
        Test.stoptest();
        
        
  
  
  }    


}