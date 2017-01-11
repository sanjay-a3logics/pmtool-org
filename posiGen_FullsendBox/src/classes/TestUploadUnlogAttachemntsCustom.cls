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
public class TestUploadUnlogAttachemntsCustom{

    static testMethod void myUnitTest() {
      
      List<Box_error__c> OppList = new List<Box_error__c>();
                
        Account acc =new Account();
        acc.name = 'irfan khanNew';
        insert acc;
        Set<String> Oppset = new Set<String>(); 
        Opportunity opp = new Opportunity();
        opp.name = 'Test oppDocu';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed won';
        insert opp;
        Oppset.add(opp.id);
        
       
       
        box_error__c bxerr = new box_error__c();
        bxerr.Opportunity__c = opp.id; 
        bxerr.name = '409'; 
        bxerr.Message__c = 'Attachment id-'; 
        bxerr.Body__c = '';
        bxerr.Type__c = 'Custom Doc';
        bxerr.Status__c = 'Error';
        
        OppList.add(bxerr);
        
        insert OppList;   
        
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        insert testBox;
        
        
       Project__c project = new Project__c(Opportunity__c=opp.id);
        insert project;
        system.assert(project.id!=null);
        Set<String> ptlst = new Set<String>();
         Attachment__c ca= new Attachment__c();
         ca.Project__c=project.id;
         insert ca;
         ptlst.add(ca.id);
         System.assert(ca.id!=null);
         
       
       
    List<String> stlst = new List<String> (); 
    List<Attachment> attlst = new List<Attachment> ();
    for(Integer i=0; i<=3;i++){ 
        Attachment att = new Attachment();
        att.name = 'test.pdf';
        att.body = Blob.valueOf('safdsf fdsf sdfsd fdsoyfdso fds fsdyf dsfy sdifidsfy sif');
        att.parentId = ca.id;
        attlst.add(att); 
        stlst.add(att.id); 
        }
        
       insert attlst; 
    
         
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Funding-Vendor';
        sf.cf_opportunity__c = opp.id;
        sf.cf_box_folder_id__c = '11446498';
        insert sf;
        
       

        UploadUnlogAttachemntsCustom customDpb = new UploadUnlogAttachemntsCustom(stlst,ptlst,oppset,1);
        Database.BatchableContext BC;
        
        customDpb.start(BC);
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
        customDpb.execute(bc,attlst);
        Test.stopTest();         
      
    }
    
    static testMethod void myUnitTest1() {
      
      List<Box_error__c> OppList = new List<Box_error__c>();
                
        Account acc =new Account();
        acc.name = 'irfan khanTest';
        insert acc;
    
        Set<String> Oppset = new Set<String>();
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed won';
        insert opp;
        oppset.add(opp.id);
        
        Box_Error__c bxerr = new Box_Error__c();
        bxerr.Opportunity__c = opp.id; 
        bxerr.name = '409'; 
        bxerr.Message__c = 'Attachment id-'; 
        bxerr.Body__c = '';
        bxerr.Type__c = 'Custom Doc';
        bxerr.Status__c = 'Error';
        
       
        
        OppList.add(bxerr);
         insert OppList;
        
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        insert testBox;
        
        Project__c project = new Project__c(Opportunity__c=opp.id);
        insert project;
        system.assert(project.id!=null);
        
        Set<String> ptlst = new Set<String>();
         Attachment__c ca= new Attachment__c();
         ca.Project__c=project.id;
         insert ca;
         ptlst.add(ca.id);
         System.assert(ca.id!=null);
         
       
       
     
   List<String> stlst = new List<String> (); 
    List<Attachment> attlst = new List<Attachment> ();
    for(Integer i=0; i<=3;i++){ 
        Attachment att = new Attachment();
        att.name = 'test.pdf';
        att.body = Blob.valueOf('safdsf fdsf sdfsd fdsoyfdso fds fsdyf dsfy sdifidsfy sif');
        att.parentId = ca.id;
        attlst.add(att); 
        stlst.add(att.id); 
        }
        
       insert attlst; 
    
         
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Funding-Vendor';
        sf.cf_opportunity__c = opp.id;
        sf.cf_box_folder_id__c = '11446498';
        insert sf;
        
         Sub_folder__c sf1 = new Sub_folder__c();
        sf1.name = 'Funding-Vendor';
        sf1.cf_opportunity__c = opp.id;
        sf1.cf_box_folder_id__c = '11446478';
        insert sf1;

        UploadUnlogAttachemntsCustom customDpb = new UploadUnlogAttachemntsCustom(stlst,ptlst,oppset,1);
        Database.BatchableContext BC;
        
        customDpb.start(BC);
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
        customDpb.execute(bc,attlst);
        Test.stopTest();         
      
    }
    static testMethod void myUnitTest2() {
      
      List<Box_error__c> OppList = new List<Box_error__c>();
                
        Account acc =new Account();
        acc.name = 'irfan khanTest';
        insert acc;
    
        Set<String> Oppset = new Set<String>();
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed won';
        insert opp;
        oppset.add(opp.id);
        
        Box_Error__c bxerr = new Box_Error__c();
        bxerr.Opportunity__c = opp.id; 
        bxerr.name = '409'; 
        bxerr.Message__c = 'Attachment id-'; 
        bxerr.Body__c = '';
        bxerr.Type__c = 'Custom Doc';
        bxerr.Status__c = 'Error';
        
       
        
        OppList.add(bxerr);
         insert OppList;
        
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        insert testBox;
        
        Project__c project = new Project__c(Opportunity__c=opp.id);
        insert project;
        system.assert(project.id!=null);
        
        Set<String> ptlst = new Set<String>();
         Attachment__c ca= new Attachment__c();
         ca.Project__c=project.id;
         insert ca;
         ptlst.add(ca.id);
         System.assert(ca.id!=null);
         
       
       
     
   List<String> stlst = new List<String> (); 
    List<Attachment> attlst = new List<Attachment> ();
    for(Integer i=0; i<=3;i++){ 
        Attachment att = new Attachment();
        att.name = 'test.pdf';
        att.body = Blob.valueOf('safdsf fdsf sdfsd fdsoyfdso fds fsdyf dsfy sdifidsfy sif');
        att.parentId = ca.id;
        attlst.add(att); 
        stlst.add(att.id); 
        }
        
       insert attlst; 
    
         
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Funding-Vendor';
        sf.cf_opportunity__c = opp.id;
        sf.cf_box_folder_id__c = '11446498';
        insert sf;

        UploadUnlogAttachemntsCustom customDpb = new UploadUnlogAttachemntsCustom(stlst,ptlst,Oppset,1);
        Database.BatchableContext BC;
        
        customDpb.start(BC);
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestFileUploadMock3());
        customDpb.execute(bc,attlst);
        Test.stopTest();         
      
    } 
     static testMethod void myUnitTest5() {
        List<String> sttlst = new List<String> ();  
        Set<String> ptlst = new Set<String>();
        Set<String> Oppset = new Set<String>();
        UploadUnlogAttachemntsCustom customDpb = new UploadUnlogAttachemntsCustom (sttlst,ptlst,Oppset,100);
        Database.BatchableContext BC;
        
        customDpb.finish(BC);
    }
    
    static testMethod void myUnitTest3() {
      
      List<Box_error__c> OppList = new List<Box_error__c>();
                
        Account acc =new Account();
        acc.name = 'irfan khan';
        insert acc;
        
        Set<String> Oppset = new Set<String>();
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed won';
        insert opp;
         oppset.add(opp.id); 
       
        
        Box_Error__c bxerr = new Box_Error__c();
        bxerr.Opportunity__c = opp.id; 
        bxerr.name = '409'; 
        bxerr.Message__c = 'Attachment id-'; 
        bxerr.Body__c = '';
        bxerr.Type__c = 'Custom Doc';
        bxerr.Status__c = 'Error';
        
         OppList.add(bxerr);
         insert OppList;
        
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        insert testBox;
        
        
        Project__c project = new Project__c(Opportunity__c=opp.id);
        insert project;
        system.assert(project.id!=null);
        
         Set<String> ptlst = new Set<String>();
         Attachment__c ca= new Attachment__c();
         ca.Project__c=project.id;
         insert ca;
         ptlst.add(ca.id);
         System.assert(ca.id!=null);
         
       
       
   List<String> sttlst = new List<String> ();  
    List<Attachment> attlst = new List<Attachment> ();
    
        Attachment att = new Attachment();
        att.name = 'test.pdf1';
        att.body = Blob.valueOf('safdsf fdsf sdfsd fdsoyfdso fds fsdyf dsfy sdifidsfy sif');
        att.parentId = ca.id;
        attlst.add(att); 
        
        Attachment att1 = new Attachment();
        att1.name = 'test.pdf1';
        att1.body = Blob.valueOf('safdsf fdsf sdfsd fdsoyfdso fds fsdyf dsfy sdifidsfy sif');
        att1.parentId = project.id;
        attlst.add(att1);
       insert attlst; 
    
         
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = '';
        sf.cf_opportunity__c = opp.id;
        sf.cf_box_folder_id__c = '11446498';
        insert sf;
  
        UploadUnlogAttachemntsCustom customDpb = new UploadUnlogAttachemntsCustom(sttlst,ptlst,oppset,100);
        Database.BatchableContext BC;
        
        customDpb.start(BC);
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
        customDpb.execute(bc,attlst);
        Test.stopTest();         
      
    }

   
   
}