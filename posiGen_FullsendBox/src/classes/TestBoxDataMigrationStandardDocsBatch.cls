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
private class TestBoxDataMigrationStandardDocsBatch {

    static testMethod void myUnitTest() {
        
        List<Opportunity> OppList = new List<Opportunity>();
                
        Account acc =new Account();
        acc.name = 'irfan khan';
        insert acc;
    
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed won';
        insert opp;
        
        OppList.add(opp);
        
        Box__c testBox = new Box__c (BoxAccess_Token__c='7sejJNKnLhC6NFQFcGTPqZk1a8T2JjLd',Boxrefresh_token__c ='uvXGWWKFyArawZRa4kJ2VdQP4qmBkMMwcoweMQRpiigpzJzxYkW9My3j6TlHBnnM',Boxclient_Id__c ='askknl10jr57z26sb649nqlh4ftb2xz4',Boxclient_Secret__c='iVmHlomxgyJOPIa7b55vZDzAdCV98833');
        insert testBox;
       
        Attachment att = new Attachment();
        att.name = 'test.pdf';
        att.body = Blob.valueOf('safdsf fdsf sdfsd fdsoyfdso fds fsdyf dsfy sdifidsfy sif');
        att.parentId = opp.id;
        insert att;
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Sales';
        sf.cf_opportunity__c = opp.id;
        sf.cf_box_folder_id__c = '11446498';
        insert sf;

        BoxDataMigrationStandardDocsBatch bfb = new BoxDataMigrationStandardDocsBatch(1);
        Database.BatchableContext BC;
        
        bfb.start(BC);
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
        bfb.execute(bc,OppList);
        Test.stopTest();               
        
    }
    
    static testMethod void myUnitTest1() {
        
        List<Opportunity> OppList = new List<Opportunity>();
                
        Account acc =new Account();
        acc.name = 'irfan khan';
        insert acc;
    
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed won';
        insert opp;
        
        OppList.add(opp);
        
         Box__c testBox = new Box__c (BoxAccess_Token__c='7sejJNKnLhC6NFQFcGTPqZk1a8T2JjLd',Boxrefresh_token__c ='uvXGWWKFyArawZRa4kJ2VdQP4qmBkMMwcoweMQRpiigpzJzxYkW9My3j6TlHBnnM',Boxclient_Id__c ='askknl10jr57z26sb649nqlh4ftb2xz4',Boxclient_Secret__c='iVmHlomxgyJOPIa7b55vZDzAdCV98833');
        insert testBox;
       
        Attachment att = new Attachment();
        att.name = 'test.pdf';
        att.body = Blob.valueOf('safdsf fdsf sdfsd fdsoyfdso fds fsdyf dsfy sdifidsfy sif');
        att.parentId = opp.id;
        insert att;
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Sales';
        sf.cf_opportunity__c = opp.id;
        sf.cf_box_folder_id__c = '34535345345';
        insert sf;

        BoxDataMigrationStandardDocsBatch bfb = new BoxDataMigrationStandardDocsBatch(1);
        Database.BatchableContext BC;
        
        bfb.start(BC);
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
        bfb.execute(bc,OppList);
        Test.stopTest();               
        
    }
    
    static testMethod void myUnitTest4() {
        
        List<Opportunity> OppList = new List<Opportunity>();
                
        Account acc =new Account();
        acc.name = 'irfan khan';
        insert acc;
    
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed won';
        insert opp;
        
        OppList.add(opp);
        
         Box__c testBox = new Box__c (BoxAccess_Token__c='7sejJNKnLhC6NFQFcGTPqZk1a8T2JjLd',Boxrefresh_token__c ='uvXGWWKFyArawZRa4kJ2VdQP4qmBkMMwcoweMQRpiigpzJzxYkW9My3j6TlHBnnM',Boxclient_Id__c ='askknl10jr57z26sb649nqlh4ftb2xz4',Boxclient_Secret__c='iVmHlomxgyJOPIa7b55vZDzAdCV98833');
        insert testBox;
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Sales';
        sf.cf_opportunity__c = opp.id;
        sf.cf_box_folder_id__c = '34535345345';
        insert sf;

        BoxDataMigrationStandardDocsBatch bfb = new BoxDataMigrationStandardDocsBatch(1);
        Database.BatchableContext BC;
        
        bfb.start(BC);
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
        bfb.execute(bc,OppList);
        Test.stopTest();               
        
    }

    static testMethod void myUnitTest5() {
        
        BoxDataMigrationStandardDocsBatch bfb = new BoxDataMigrationStandardDocsBatch(1);
        Database.BatchableContext BC;
        
        bfb.finish(BC);
    }
    
    static testMethod void myUnitTest3() {
        
        List<Opportunity> OppList = new List<Opportunity>();
                
        Account acc =new Account();
        acc.name = 'irfan khan';
        insert acc;
    
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed won';
        insert opp;
        
        OppList.add(opp);
        
        Box__c testBox = new Box__c (BoxAccess_Token__c='7sejJNKnLhC6NFQFcGTPqZk1a8T2JjLd',Boxrefresh_token__c ='uvXGWWKFyArawZRa4kJ2VdQP4qmBkMMwcoweMQRpiigpzJzxYkW9My3j6TlHBnnM',Boxclient_Id__c ='askknl10jr57z26sb649nqlh4ftb2xz4',Boxclient_Secret__c='iVmHlomxgyJOPIa7b55vZDzAdCV98833');
        insert testBox;
       
        Attachment att = new Attachment();
        att.name = 'test.pdf';
        att.body = Blob.valueOf('safdsf fdsf sdfsd fdsoyfdso fds fsdyf dsfy sdifidsfy sif');
        att.parentId = opp.id;
        insert att;
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.cf_opportunity__c = opp.id;
        sf.cf_box_folder_id__c = '34535345345';
        insert sf;

        BoxDataMigrationStandardDocsBatch bfb = new BoxDataMigrationStandardDocsBatch(1);
        Database.BatchableContext BC;
        
        bfb.start(BC);
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
        bfb.execute(bc,OppList);
        Test.stopTest();               
        
    }

    static testMethod void myUnitTest2() {
        
        List<Opportunity> OppList = new List<Opportunity>();
                
        Account acc =new Account();
        acc.name = 'irfan khan';
        insert acc;
    
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed won';
        insert opp;
        
        OppList.add(opp);
        
        Box__c testBox = new Box__c (BoxAccess_Token__c='7sejJNKnLhC6NFQFcGTPqZk1a8T2JjLd',Boxrefresh_token__c ='uvXGWWKFyArawZRa4kJ2VdQP4qmBkMMwcoweMQRpiigpzJzxYkW9My3j6TlHBnnM',Boxclient_Id__c ='askknl10jr57z26sb649nqlh4ftb2xz4',Boxclient_Secret__c='iVmHlomxgyJOPIa7b55vZDzAdCV98833');
        insert testBox;
       
        Attachment att = new Attachment();
        att.name = 'test.pdf';
        att.body = Blob.valueOf('safdsf fdsf sdfsd fdsoyfdso fds fsdyf dsfy sdifidsfy sif');
        att.parentId = opp.id;
        insert att;
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Sales';
        sf.cf_opportunity__c = opp.id;
        sf.cf_box_folder_id__c = '11446498';
        insert sf;

        BoxDataMigrationStandardDocsBatch bfb = new BoxDataMigrationStandardDocsBatch(1);
        Database.BatchableContext BC;
        
        bfb.start(BC);
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new BoxApiControllerRecover_mock_error());
        bfb.execute(bc,OppList);
        Test.stopTest();               
        
    }
}