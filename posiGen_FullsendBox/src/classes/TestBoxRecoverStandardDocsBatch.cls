@isTest
private class TestBoxRecoverStandardDocsBatch {

    static testMethod void executeTest() {
        
         List<Attachment> attList = new List<Attachment>();
            
                
                Account acc =new Account();
                acc.name = 'irfan khan';
                insert acc;
                System.assert(acc.id!=null);
                
                Opportunity opp = new Opportunity();
                opp.name = 'Test opp';
                opp.accountId = acc.id;
                opp.CloseDate = date.today();
                opp.stageName = 'Closed won';
                insert opp;
                System.assert(opp.id!=null);

                
            
             Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='Sales');
            insert sc;
            system.assert(sc.id!=null); 
            
            Attachment att = new Attachment();
            att.name = 'Test111.pdf';
            att.body = Blob.valueOf('Test data');
            att.parentId = opp.id;
            insert att;
            attList.add(att);
            
            BoxRecoverStandardDocsBatch bfb = new BoxRecoverStandardDocsBatch(10);
            Database.BatchableContext BC;
            
            Box__c testBox = new Box__c (BoxAccess_Token__c='7sejJNKnLhC6NFQFcGTPqZk1a8T2JjLd',Boxrefresh_token__c ='uvXGWWKFyArawZRa4kJ2VdQP4qmBkMMwcoweMQRpiigpzJzxYkW9My3j6TlHBnnM',Boxclient_Id__c ='askknl10jr57z26sb649nqlh4ftb2xz4',Boxclient_Secret__c='iVmHlomxgyJOPIa7b55vZDzAdCV98833');
            insert testBox;
            
            bfb.start(bc);
            
            Test.startTest();
          Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
            bfb.execute(bc,attList);
            bfb.finish(bc);
          Test.stopTest();
    }
    
    static testMethod void executeTest1() {
        
         List<Attachment> attList = new List<Attachment>();
            
                
                Account acc =new Account();
                acc.name = 'irfan khan';
                insert acc;
                System.assert(acc.id!=null);
                
                Opportunity opp = new Opportunity();
                opp.name = 'Test opp';
                opp.accountId = acc.id;
                opp.CloseDate = date.today();
                opp.stageName = 'Closed won';
                insert opp;
                System.assert(opp.id!=null);

                
            
             Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='Sales');
            insert sc;
            system.assert(sc.id!=null); 
            
            Attachment att = new Attachment();
            att.name = 'Test111zzzz.pdf';
            att.body = Blob.valueOf('Test data');
            att.parentId = opp.id;
            att.contenttype = 'application/pdf';
            insert att;
            attList.add(att);
            
            BoxRecoverStandardDocsBatch bfb = new BoxRecoverStandardDocsBatch(10);
            Database.BatchableContext BC;
            
             Box__c testBox = new Box__c (BoxAccess_Token__c='7sejJNKnLhC6NFQFcGTPqZk1a8T2JjLd',Boxrefresh_token__c ='uvXGWWKFyArawZRa4kJ2VdQP4qmBkMMwcoweMQRpiigpzJzxYkW9My3j6TlHBnnM',Boxclient_Id__c ='askknl10jr57z26sb649nqlh4ftb2xz4',Boxclient_Secret__c='iVmHlomxgyJOPIa7b55vZDzAdCV98833');
            insert testBox;
            
            bfb.start(bc);
            
            Test.startTest();
          Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
            bfb.execute(bc,attList);
            bfb.finish(bc);
          Test.stopTest();
    }
    
    
     static testMethod void executeTest2() {
        
         List<Attachment> attList = new List<Attachment>();
            
                
                Account acc =new Account();
                acc.name = 'irfan khan';
                insert acc;
                System.assert(acc.id!=null);
                
                Opportunity opp = new Opportunity();
                opp.name = 'Test opp';
                opp.accountId = acc.id;
                opp.CloseDate = date.today();
                opp.stageName = 'Closed won';
                insert opp;
                System.assert(opp.id!=null);

                
            
             Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='Sales');
            insert sc;
            system.assert(sc.id!=null); 
            
            Attachment att = new Attachment();
            att.name = 'Test111wewe.pdf';
            att.body = Blob.valueOf('Test data');
            att.parentId = opp.id;
            att.contenttype = 'application/pdf';
            insert att;
            attList.add(att);
            
            BoxRecoverStandardDocsBatch bfb = new BoxRecoverStandardDocsBatch(10);
            Database.BatchableContext BC;
            
            Box__c testBox = new Box__c (BoxAccess_Token__c='7sejJNKnLhC6NFQFcGTPqZk1a8T2JjLd',Boxrefresh_token__c ='uvXGWWKFyArawZRa4kJ2VdQP4qmBkMMwcoweMQRpiigpzJzxYkW9My3j6TlHBnnM',Boxclient_Id__c ='askknl10jr57z26sb649nqlh4ftb2xz4',Boxclient_Secret__c='iVmHlomxgyJOPIa7b55vZDzAdCV98833');
            insert testBox;
            
            bfb.start(bc);
            
            Test.startTest();
          Test.setMock(HttpCalloutMock.class, new TestFileUploadMock4());
            bfb.execute(bc,attList);
            bfb.finish(bc);
          Test.stopTest();
    }
    
     static testMethod void executeTest3() {
        
         List<Attachment> attList = new List<Attachment>();
            
                
                Account acc =new Account();
                acc.name = 'irfan khan';
                insert acc;
                System.assert(acc.id!=null);
                
                Opportunity opp = new Opportunity();
                opp.name = 'Test opp';
                opp.accountId = acc.id;
                opp.CloseDate = date.today();
                opp.stageName = 'Closed won';
                insert opp;
                System.assert(opp.id!=null);

                
            
             Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='11446498',CF_Opportunity__c=opp.id,Name='Sales');
            insert sc;
            system.assert(sc.id!=null); 
            
            Attachment att = new Attachment();
            att.name = 'Test111wdffooo.pdf';
            att.body = Blob.valueOf('Test data');
            att.parentId = opp.id;
            att.contenttype = 'application/pdf';
            insert att;
            attList.add(att);
            
            BoxRecoverStandardDocsBatch bfb = new BoxRecoverStandardDocsBatch(10);
            Database.BatchableContext BC;
            
            Box__c testBox = new Box__c (BoxAccess_Token__c='7sejJNKnLhC6NFQFcGTPqZk1a8T2JjLd',Boxrefresh_token__c ='uvXGWWKFyArawZRa4kJ2VdQP4qmBkMMwcoweMQRpiigpzJzxYkW9My3j6TlHBnnM',Boxclient_Id__c ='askknl10jr57z26sb649nqlh4ftb2xz4',Boxclient_Secret__c='iVmHlomxgyJOPIa7b55vZDzAdCV98833');
            insert testBox;
            
            bfb.start(bc);
            
            Test.startTest();
          Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
            bfb.execute(bc,attList);
            bfb.finish(bc);
          Test.stopTest();
    }
    
    static testMethod void executeTest4() {
        
         List<Attachment> attList = new List<Attachment>();
            
                
                Account acc =new Account();
                acc.name = 'irfan khan';
                insert acc;
                System.assert(acc.id!=null);
                
                Opportunity opp = new Opportunity();
                opp.name = 'Test opp';
                opp.accountId = acc.id;
                opp.CloseDate = date.today();
                opp.stageName = 'Closed won';
                insert opp;
                System.assert(opp.id!=null);

                
            
             Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='11446498',CF_Opportunity__c=opp.id,Name='Sales');
            insert sc;
            system.assert(sc.id!=null); 
            
            Attachment att = new Attachment();
            att.name = 'Test111wdffoooaaa';
            att.body = Blob.valueOf('Test data');
            att.parentId = opp.id;
            att.contenttype = 'plain/txt';
            insert att;
            attList.add(att);
            
            BoxRecoverStandardDocsBatch bfb = new BoxRecoverStandardDocsBatch(10);
            Database.BatchableContext BC;
            
             Box__c testBox = new Box__c (BoxAccess_Token__c='7sejJNKnLhC6NFQFcGTPqZk1a8T2JjLd',Boxrefresh_token__c ='uvXGWWKFyArawZRa4kJ2VdQP4qmBkMMwcoweMQRpiigpzJzxYkW9My3j6TlHBnnM',Boxclient_Id__c ='askknl10jr57z26sb649nqlh4ftb2xz4',Boxclient_Secret__c='iVmHlomxgyJOPIa7b55vZDzAdCV98833');
            insert testBox;
            
            bfb.start(bc);
            
            Test.startTest();
          Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
            bfb.execute(bc,attList);
            bfb.finish(bc);
          Test.stopTest();
    }
    
    
    static testMethod void executeTest5() {
        
         List<Attachment> attList = new List<Attachment>();
            
                
                Account acc =new Account();
                acc.name = 'irfan khan';
                insert acc;
                System.assert(acc.id!=null);
                
                Opportunity opp = new Opportunity();
                opp.name = 'Test opp';
                opp.accountId = acc.id;
                opp.CloseDate = date.today();
                opp.stageName = 'Closed won';
                insert opp;
                System.assert(opp.id!=null);

                
            
             Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='11446498',CF_Opportunity__c=opp.id,Name='Sales');
            insert sc;
            system.assert(sc.id!=null); 
            
            Attachment att = new Attachment();
            att.name = 'Test111wdffoooddd';
            att.body = Blob.valueOf('Test data');
            att.parentId = opp.id;
            att.contenttype = 'image/jpeg';
            insert att;
            attList.add(att);
            
            BoxRecoverStandardDocsBatch bfb = new BoxRecoverStandardDocsBatch(10);
            Database.BatchableContext BC;
            
            Box__c testBox = new Box__c (BoxAccess_Token__c='7sejJNKnLhC6NFQFcGTPqZk1a8T2JjLd',Boxrefresh_token__c ='uvXGWWKFyArawZRa4kJ2VdQP4qmBkMMwcoweMQRpiigpzJzxYkW9My3j6TlHBnnM',Boxclient_Id__c ='askknl10jr57z26sb649nqlh4ftb2xz4',Boxclient_Secret__c='iVmHlomxgyJOPIa7b55vZDzAdCV98833');
            insert testBox;
            
            bfb.start(bc);
            
            Test.startTest();
          Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
            bfb.execute(bc,attList);
            bfb.finish(bc);
          Test.stopTest();
    }
    
}