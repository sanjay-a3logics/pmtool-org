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
private class TestBoxDataMigrationCustomDocsBatch  {

    static testMethod void myUnitTest() {
      
      List<Attachment> AttList = new List<Attachment>();
                
        Account acc =new Account();
        acc.name = 'irfan khan';
        insert acc;
    
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed won';
        insert opp;
                     
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        insert testBox;
        
        Project__c project = new Project__c(Opportunity__c=opp.id);
        insert project;
        system.assert(project.id!=null);
        
         Attachment__c ca= new Attachment__c();
         ca.Project__c=project.id;
         insert ca;
         System.assert(ca.id!=null);
         
        Attachment att = new Attachment();
        att.name = 'test.pdf';
        att.body = Blob.valueOf('safdsf');
        att.parentId = ca.id;
        insert att;
        
        AttList.add(att);
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Funding-Vendor';
        sf.cf_opportunity__c = opp.id;
        sf.cf_box_folder_id__c = '11446498';
        insert sf;

        BoxDataMigrationCustomDocsBatch bfb = new BoxDataMigrationCustomDocsBatch(1);
        Database.BatchableContext BC;
        
        bfb.start(BC);
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
        bfb.execute(bc,AttList);
        Test.stopTest();         
      
    }
   static testMethod void myUnitTest1() {
      
      List<Attachment> AttList = new List<Attachment>();
                
        Account acc =new Account();
        acc.name = 'irfan khan';
        insert acc;
    
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed won';
        insert opp;
                     
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        insert testBox;
        
        Project__c project = new Project__c(Opportunity__c=opp.id);
        insert project;
        system.assert(project.id!=null);
        
         Attachment__c ca= new Attachment__c();
         ca.Project__c=project.id;
         insert ca;
         System.assert(ca.id!=null);
         
        Attachment att = new Attachment();
        att.name = 'test.pdf';
        att.body = Blob.valueOf('safdsf');
        att.parentId = ca.id;
        insert att;
        
        AttList.add(att);
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Funding-Vendor';
        sf.cf_opportunity__c = opp.id;
        sf.cf_box_folder_id__c = '11446498';
        insert sf;

        BoxDataMigrationCustomDocsBatch bfb = new BoxDataMigrationCustomDocsBatch(1);
        Database.BatchableContext BC;
        
        bfb.start(BC);
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new BoxApiControllerRecover_mock_error());
        bfb.execute(bc,AttList);
        Test.stopTest();         
      
    }

    static testMethod void myUnitTest5() {
      
        BoxDataMigrationCustomDocsBatch bfb = new BoxDataMigrationCustomDocsBatch(1);
        Database.BatchableContext BC;
        
        bfb.finish(BC);
    }
    
    /*static testMethod void myUnitTest3() {
      
      List<Attachment> AttList = new List<Attachment>();
                
        Account acc =new Account();
        acc.name = 'irfan khan';
        insert acc;
    
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed won';
        insert opp;
        
        
        dsfs__DocuSign_Status__c ds3 = new dsfs__DocuSign_Status__c();
        ds3.dsfs__Opportunity__c = opp.id;
        ds3.dsfs__Subject__c ='Application';
        ds3.dsfs__Company__c =acc.id;
        
        insert ds3;
        
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        insert testBox;
     
        Attachment att = new Attachment();
        att.name = 'test.pdf';
        att.body = Blob.valueOf('safdsf fdsf sdfsd fdsoyfdso fds fsdyf dsfy sdifidsfy sif');
        att.parentId = ds3.id;
        insert att;
        
        AttList.add(att);

        Sub_folder__c sf = new Sub_folder__c();
        sf.cf_opportunity__c = opp.id;
        sf.cf_box_folder_id__c = '34535345345';
        insert sf;
    
        BoxDataMigrationCustomDocsBatch bfb = new BoxDataMigrationCustomDocsBatch(1);
        Database.BatchableContext BC;
        
        bfb.start(BC);
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
        bfb.execute(bc,AttList);
        Test.stopTest();         
      
    }

    static testMethod void myUnitTest2() {
      
      List<Attachment> AttList = new List<Attachment>();
                
        Account acc =new Account();
        acc.name = 'irfan khan';
        insert acc;
    
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed won';
        insert opp;
        
        
        dsfs__DocuSign_Status__c ds4 = new dsfs__DocuSign_Status__c();
        ds4.dsfs__Opportunity__c = opp.id;
        ds4.dsfs__Subject__c ='safsdafsd';
        ds4.dsfs__Company__c =acc.id;
        
        insert ds4;
        
        
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        insert testBox;
     
        Attachment att = new Attachment();
        att.name = 'test.pdf';
        att.body = Blob.valueOf('safdsf fdsf sdfsd fdsoyfdso fds fsdyf dsfy sdifidsfy sif');
        att.parentId = ds4.id;
        insert att;
        AttList.add(att);

        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Sales';
        sf.cf_opportunity__c = opp.id;
        sf.cf_box_folder_id__c = '114464984';
        insert sf;
    
        BoxDataMigrationCustomDocsBatch bfb = new BoxDataMigrationCustomDocsBatch(1);
        Database.BatchableContext BC;
        
        bfb.start(BC);
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new BoxApiControllerRecover_mock_error());
        bfb.execute(bc,AttList);
        Test.stopTest();         
      
    }*/
}