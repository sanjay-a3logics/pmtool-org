@isTest
private class TestBoxRenameattachmentsBatch {

    static testMethod void myUnitTest() {
    
        Account acc =new Account();
        acc.name = 'irfan khan';
        insert acc;
    
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed won';
        insert opp;
        
         Box__c testBox = new Box__c (BoxAccess_Token__c='7sejJNKnLhC6NFQFcGTPqZk1a8T2JjLd',Boxrefresh_token__c ='uvXGWWKFyArawZRa4kJ2VdQP4qmBkMMwcoweMQRpiigpzJzxYkW9My3j6TlHBnnM',Boxclient_Id__c ='askknl10jr57z26sb649nqlh4ftb2xz4',Boxclient_Secret__c='iVmHlomxgyJOPIa7b55vZDzAdCV98833');
        insert testBox;
     
        Attachment att = new Attachment();
        att.name = 'Panel Photo';
        att.body = Blob.valueOf('safdsf fdsf sdfsd fdsoyfdso fds fsdyf dsfy sdifidsfy sif');
        att.parentId = opp.id;
        att.contentType = 'image/jpeg';
        insert att;
        
        Attachment att1 = new Attachment();
        att1.name = 'House Photo';
        att1.body = Blob.valueOf('safdsf fdsf sdfsd fdsoyfdso fds fsdyf dsfy sdifidsfy sif');
        att1.parentId = opp.id;
        att1.contentType = 'image/jpeg';
        insert att1;
        
        List<Attachment> attList = new List<Attachment>();
        attList.add(att);
        attList.add(att1);
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Sales';
        sf.cf_opportunity__c = opp.id;
        sf.cf_box_folder_id__c = '11446498';
        insert sf;
        
        BoxRenameattachmentsBatch bfb = new BoxRenameattachmentsBatch(10);
        Database.BatchableContext BC;
        
        bfb.start(BC);
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new BoxRenameattachmentsBatch_mock());
        bfb.execute(bc,attList);
        Test.stopTest();         
        
    }
    
    static testMethod void myUnitTest1() {
    
        Account acc =new Account();
        acc.name = 'irfan khan';
        insert acc;
    
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed won';
        insert opp;
        
        Box__c testBox = new Box__c (BoxAccess_Token__c='7sejJNKnLhC6NFQFcGTPqZk1a8T2JjLd',Boxrefresh_token__c ='uvXGWWKFyArawZRa4kJ2VdQP4qmBkMMwcoweMQRpiigpzJzxYkW9My3j6TlHBnnM',Boxclient_Id__c ='askknl10jr57z26sb649nqlh4ftb2xz4',Boxclient_Secret__c='iVmHlomxgyJOPIa7b55vZDzAdCV98833');
        insert testBox;
        
        Attachment att = new Attachment();
        att.name = 'Panel Photo';
        att.body = Blob.valueOf('safdsf fdsf sdfsd fdsoyfdso fds fsdyf dsfy sdifidsfy sif');
        att.parentId = opp.id;
        att.contentType = 'image/jpeg';
        insert att;
        
        Attachment att1 = new Attachment();
        att1.name = 'House Photo';
        att1.body = Blob.valueOf('safdsf fdsf sdfsd fdsoyfdso fds fsdyf dsfy sdifidsfy sif');
        att1.parentId = opp.id;
        att1.contentType = 'image/jpeg';
        insert att1;
        
        List<Attachment> attList = new List<Attachment>();
        attList.add(att);
        attList.add(att1);
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Sales';
        sf.cf_opportunity__c = opp.id;
        sf.cf_box_folder_id__c = '11446498';
        insert sf;
        
        BoxRenameattachmentsBatch bfb = new BoxRenameattachmentsBatch(10);
        Database.BatchableContext BC;
        
        bfb.start(BC);
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new BoxApiControllerRecover_mock_error());
        bfb.execute(bc,attList);
        Test.stopTest();         
        
    }
    
    static testMethod void myUnitTest2() {
    
        Account acc =new Account();
        acc.name = 'irfan khan';
        insert acc;
    
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed won';
        insert opp;
        
         Box__c testBox = new Box__c (BoxAccess_Token__c='7sejJNKnLhC6NFQFcGTPqZk1a8T2JjLd',Boxrefresh_token__c ='uvXGWWKFyArawZRa4kJ2VdQP4qmBkMMwcoweMQRpiigpzJzxYkW9My3j6TlHBnnM',Boxclient_Id__c ='askknl10jr57z26sb649nqlh4ftb2xz4',Boxclient_Secret__c='iVmHlomxgyJOPIa7b55vZDzAdCV98833');
        insert testBox;
     
        Attachment att = new Attachment();
        att.name = 'Panel Photo';
        att.body = Blob.valueOf('safdsf fdsf sdfsd fdsoyfdso fds fsdyf dsfy sdifidsfy sif');
        att.parentId = opp.id;
        att.contentType = 'image/jpeg';
        insert att;
        
        Attachment att1 = new Attachment();
        att1.name = 'House Photo';
        att1.body = Blob.valueOf('safdsf fdsf sdfsd fdsoyfdso fds fsdyf dsfy sdifidsfy sif');
        att1.parentId = opp.id;
        att1.contentType = 'image/jpeg';
        insert att1;
        
        List<Attachment> attList = new List<Attachment>();
        attList.add(att);
        attList.add(att1);
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Sales';
        sf.cf_opportunity__c = opp.id;
        sf.cf_box_folder_id__c = '11446498';
        insert sf;
        
        BoxRenameattachmentsBatch bfb = new BoxRenameattachmentsBatch(10);
        Database.BatchableContext BC;
        
        bfb.start(BC);
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
        bfb.execute(bc,attList);
        Test.stopTest();         
        
    }
}