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
private class TestBoxStandardDocsDuplicateBatch{

    static testMethod void myUnitTest() {
      
      List<Box_error__c> OppList = new List<Box_error__c>();
                
        Account acc =new Account();
        acc.name = 'irfan khan';
        insert acc;
    
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed won';
        insert opp;
        
       
        
        box_error__c bxerr = new box_error__c();
        bxerr.Opportunity__c = opp.id; 
        bxerr.name = '409'; 
        bxerr.Message__c = 'Attachment id-'; 
        bxerr.Body__c = '';
        bxerr.Type__c = 'Standard Doc';
        bxerr.Status__c = 'Error';
        
        insert bxerr;
        
        OppList.add(bxerr);
        
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        insert testBox;
     
    List<Attachment> attlst = new List<Attachment> ();
    for(Integer i=0; i<=3;i++){ 
        Attachment att = new Attachment();
        att.name = 'test.pdf';
        att.body = Blob.valueOf('safdsf fdsf sdfsd fdsoyfdso fds fsdyf dsfy sdifidsfy sif');
        att.parentId = opp.id;
        attlst.add(att); 
        }
       insert attlst; 
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Sales';
        sf.cf_opportunity__c = opp.id;
        sf.cf_box_folder_id__c = '11446498';
        insert sf;

        BoxStandardDocsDuplicateBatch  bfb = new BoxStandardDocsDuplicateBatch (1);
        Database.BatchableContext BC;
        
        bfb.start(BC);
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
        bfb.execute(bc,OppList);
        Test.stopTest();         
      
    }
    
    static testMethod void myUnitTest1() {
      
      List<Box_error__c> OppList = new List<Box_error__c>();
                
        Account acc =new Account();
        acc.name = 'irfan khan';
        insert acc;
    
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed won';
        insert opp;
        
        Box_Error__c bxerr = new Box_Error__c();
        bxerr.Opportunity__c = opp.id; 
        bxerr.name = '409'; 
        bxerr.Message__c = 'Attachment id-'; 
        bxerr.Body__c = '';
        bxerr.Type__c = 'Standard Doc';
        bxerr.Status__c = 'Error';
        
        insert bxerr;
        
        OppList.add(bxerr);
        
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        insert testBox;
     
    List<Attachment> attlst = new List<Attachment> ();
    for(Integer i=0; i<=3;i++){ 
        Attachment att = new Attachment();
        att.name = 'test.pdf';
        att.body = Blob.valueOf('safdsf fdsf sdfsd fdsoyfdso fds fsdyf dsfy sdifidsfy sif');
        att.parentId = opp.id;
        attlst.add(att); 
        }
       insert attlst; 
    
    Sub_folder__c sf = new Sub_folder__c();
    sf.name = 'Sales';
    sf.cf_opportunity__c = opp.id;
    sf.cf_box_folder_id__c = '34535345345';
    insert sf;

        BoxStandardDocsDuplicateBatch bfb = new BoxStandardDocsDuplicateBatch(1);
        Database.BatchableContext BC;
        
        bfb.start(BC);
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
        bfb.execute(bc,OppList);
        Test.stopTest();         
      
    }
    
    static testMethod void myUnitTest4() {
      
      List<Box_error__c> OppList = new List<Box_error__c>();
                
        Account acc =new Account();
        acc.name = 'irfan khan';
        insert acc;
    
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed won';
        insert opp;
        
        Box_Error__c bxerr = new Box_Error__c();
        bxerr.Opportunity__c = opp.id; 
        bxerr.name = '409'; 
        bxerr.Message__c = 'Attachment id-'; 
        bxerr.Body__c = '';
        bxerr.Type__c = 'Standard Doc';
        bxerr.Status__c = 'Error';
        
        insert bxerr;
        
        OppList.add(bxerr);
        
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        insert testBox;
    
    Sub_folder__c sf = new Sub_folder__c();
    sf.name = 'Sales';
    sf.cf_opportunity__c = opp.id;
    sf.cf_box_folder_id__c = '34535345345';
    insert sf;

    BoxStandardDocsDuplicateBatch bfb = new BoxStandardDocsDuplicateBatch(1);
        Database.BatchableContext BC;
        
        bfb.start(BC);
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
        bfb.execute(bc,OppList);
        Test.stopTest();         
      
    }

    static testMethod void myUnitTest5() {
      
    BoxStandardDocsDuplicateBatch bfb = new BoxStandardDocsDuplicateBatch(1);
        Database.BatchableContext BC;
        
        bfb.finish(BC);
    }
    
    static testMethod void myUnitTest3() {
      
      List<Box_error__c> OppList = new List<Box_error__c>();
                
        Account acc =new Account();
        acc.name = 'irfan khan';
        insert acc;
    
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed won';
        insert opp;
        
        Box_Error__c bxerr = new Box_Error__c();
        bxerr.Opportunity__c = opp.id; 
        bxerr.name = '409'; 
        bxerr.Message__c = 'Attachment id-'; 
        bxerr.Body__c = '';
        bxerr.Type__c = 'Standard Doc';
        bxerr.Status__c = 'Error';
        
        insert bxerr;
        
        OppList.add(bxerr);
        
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        insert testBox;
     
    List<Attachment> attlst = new List<Attachment> ();
    for(Integer i=0; i<=3;i++){ 
        Attachment att = new Attachment();
        att.name = 'test.pdf';
        att.body = Blob.valueOf('safdsf fdsf sdfsd fdsoyfdso fds fsdyf dsfy sdifidsfy sif');
        att.parentId = opp.id;
        attlst.add(att); 
        }
       insert attlst; 
       
    Sub_folder__c sf = new Sub_folder__c();
    sf.cf_opportunity__c = opp.id;
    sf.cf_box_folder_id__c = '34535345345';
    insert sf;

    BoxStandardDocsDuplicateBatch bfb = new BoxStandardDocsDuplicateBatch (1);
        Database.BatchableContext BC;
        
        bfb.start(BC);
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
        bfb.execute(bc,OppList);
        Test.stopTest();         
      
    }

    static testMethod void myUnitTest2() {
      
      List<Box_error__c> OppList = new List<Box_error__c>();
                
        Account acc =new Account();
        acc.name = 'irfan khan';
        insert acc;
    
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed won';
        insert opp;
        
        Box_Error__c bxerr = new Box_Error__c();
        bxerr.Opportunity__c = opp.id; 
        bxerr.name = '409'; 
        bxerr.Message__c = 'Attachment id-'; 
        bxerr.Body__c = '';
        bxerr.Type__c = 'Standard Doc';
        bxerr.Status__c = 'Error';
        
        insert bxerr;
        
        OppList.add(bxerr);
        
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        insert testBox;
     
    List<Attachment> attlst = new List<Attachment> ();
    for(Integer i=0; i<=3;i++){ 
        Attachment att = new Attachment();
        att.name = 'test.pdf';
        att.body = Blob.valueOf('safdsf fdsf sdfsd fdsoyfdso fds fsdyf dsfy sdifidsfy sif');
        att.parentId = opp.id;
        attlst.add(att); 
        }
       insert attlst; 
    
    Sub_folder__c sf = new Sub_folder__c();
    sf.name = 'Sales';
    sf.cf_opportunity__c = opp.id;
    sf.cf_box_folder_id__c = '11446498';
    insert sf;

    BoxStandardDocsDuplicateBatch bfb = new BoxStandardDocsDuplicateBatch (1);
        Database.BatchableContext BC;
        
        bfb.start(BC);
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new BoxApiControllerRecover_mock_error());
        bfb.execute(bc,OppList);
        Test.stopTest();         
      
    }
}