@isTest
public class TestBoxUploadFeedItemsBatch{
    
     static testMethod void myTest() {
        Set<String> oppList = new Set<String>();
        List<String> feedList = new List<String>();
        List<Box_error__c> errList = new List<Box_error__c>();
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
        
        box_error__c bxerr = new box_error__c();
        bxerr.Opportunity__c = opp.id; 
        bxerr.name = '409'; 
        bxerr.Message__c = 'Attachment id-'; 
        bxerr.Body__c = '';
        bxerr.Type__c = 'Feed Item';
        bxerr.Status__c = 'Error';
        errList.add(bxerr);
        
        oppList.add(opp.id);
        System.assert(opp.id!=null); 
                           
        
        Sub_Folder__c sc1= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='sales');
        insert sc1;
        system.assert(sc1.id!=null);           
        
        List<FeedItem> feedItemsList = new List<FeedItem>();
        FeedItem  fdi = new FeedItem(ContentFileName='Test.pdf', ContentData=Blob.valueOf('Test Data'), parentid=opp.id);
        insert fdi;
        system.assert(fdi.id!=null);
        feedItemsList.add(fdi);
        feedList.add(fdi.id);  
        
    
        Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='Application');
        insert sc;
        system.assert(sc.id!=null);
       
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        insert testBox;
        System.assert(testBox.id!=null);
        
         Database.BatchableContext BC;
     
         BoxUploadFeedItemsBatch bfb = new BoxUploadFeedItemsBatch(feedList,oppList,10);
          bfb.start(BC);      
         bfb.accData();
         Test.startTest();
          Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
          bfb.execute(bc,feedItemsList);
          BoxUploadFeedItemsBatch.uploadDocument(2,fdi,sc.CF_Box_Folder_Id__c,errList);
          bfb.finish(bc);
          Test.stopTest();
         
             
     }
   static testMethod void myTest1() {
        Set<String> oppList = new Set<String>();
        List<String> feedList = new List<String>();
        List<Box_error__c> errList = new List<Box_error__c>();
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
        
        box_error__c bxerr = new box_error__c();
        bxerr.Opportunity__c = opp.id; 
        bxerr.name = '409'; 
        bxerr.Message__c = 'Attachment id-'; 
        bxerr.Body__c = '';
        bxerr.Type__c = 'Feed Item';
        bxerr.Status__c = 'Error';
        errList.add(bxerr);
        
        oppList.add(opp.id);
        System.assert(opp.id!=null); 
                           
        
        Sub_Folder__c sc1= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='sales');
        insert sc1;
        system.assert(sc1.id!=null);           
        
        List<FeedItem> feedItemsList = new List<FeedItem>();
        FeedItem  fdi = new FeedItem(ContentFileName='Test.pdf', ContentData=Blob.valueOf('Test Data'), parentid=opp.id);
        insert fdi;
        system.assert(fdi.id!=null);
        
        FeedItem  fdi1 = new FeedItem(ContentFileName='Test.pdf', ContentData=Blob.valueOf('Test Data'), parentid=opp.id);
        insert fdi1;
        system.assert(fdi1.id!=null);
        
        feedItemsList.add(fdi);
        feedList.add(fdi.id);  
        feedItemsList.add(fdi1);
        feedList.add(fdi1.id);  
    
        Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='Application');
        insert sc;
        system.assert(sc.id!=null);
       
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        insert testBox;
        System.assert(testBox.id!=null);
        
         Database.BatchableContext BC;
     
         BoxUploadFeedItemsBatch bfb = new BoxUploadFeedItemsBatch(feedList,oppList,10);
          bfb.start(BC);      
         
         Test.startTest();
          Test.setMock(HttpCalloutMock.class, new TestFileUploadMock4());
          bfb.execute(bc,feedItemsList);
          BoxUploadFeedItemsBatch.uploadDocument(1,fdi,sc.CF_Box_Folder_Id__c,errList);
          bfb.finish(bc);
          Test.stopTest();
         
             
     }  
     static testMethod void myTest2() {
        Set<String> oppList = new Set<String>();
        List<String> feedList = new List<String>();
        List<Box_error__c> errList = new List<Box_error__c>();
        Account acc =new Account();
        acc.name = 'irfan khan';
        insert acc;
        System.assert(acc.id!=null); 
                   
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed won';
        //insert opp;
        
        box_error__c bxerr = new box_error__c();
        bxerr.Opportunity__c = opp.id; 
        bxerr.name = '409'; 
        bxerr.Message__c = 'Attachment id-'; 
        bxerr.Body__c = '';
        bxerr.Type__c = 'Feed Item';
        bxerr.Status__c = 'Error';
        errList.add(bxerr);
        
        oppList.add(opp.id);
       // System.assert(opp.id!=null); 
                           
        List<FeedItem> feedItemsList = new List<FeedItem>();
        FeedItem  fdi = new FeedItem(ContentFileName='Test.pdf', ContentData=Blob.valueOf('Test Data'), parentid=opp.id);
      /*  Sub_Folder__c sc1= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='sales');
        insert sc1;*/
                  
        
    
        Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='Application');
       // insert sc;
       
       
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        //insert testBox;
        
        
         Database.BatchableContext BC;
     
         BoxUploadFeedItemsBatch bfb = new BoxUploadFeedItemsBatch(feedList,oppList,10);
          bfb.start(BC);      
         
         Test.startTest();
          Test.setMock(HttpCalloutMock.class, new TestFileUploadMock4());
          bfb.execute(bc,feedItemsList);
          BoxUploadFeedItemsBatch.uploadDocument(1,fdi,sc.CF_Box_Folder_Id__c,errList);
          bfb.finish(bc);
          Test.stopTest();
         
             
     }  
     
     static testMethod void myTest11() {
        Set<String> oppList = new Set<String>();
        List<String> feedList = new List<String>();
        List<Box_error__c> errList = new List<Box_error__c>();
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
        
        box_error__c bxerr = new box_error__c();
        bxerr.Opportunity__c = opp.id; 
        bxerr.name = '409'; 
        bxerr.Message__c = 'Attachment id-'; 
        bxerr.Body__c = '';
        bxerr.Type__c = 'Feed Item';
        bxerr.Status__c = 'Error';
        errList.add(bxerr);
        
        oppList.add(opp.id);
        System.assert(opp.id!=null); 
                           
        
        Sub_Folder__c sc1= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='sales');
        insert sc1;
        system.assert(sc1.id!=null);           
        
        List<FeedItem> feedItemsList = new List<FeedItem>();
        FeedItem  fdi = new FeedItem(ContentFileName='Test.txt', ContentData=Blob.valueOf('Test Data'), parentid=opp.id);
        insert fdi;
        system.assert(fdi.id!=null);
        feedItemsList.add(fdi);
        feedList.add(fdi.id);  
        
    
        Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='Application');
        insert sc;
        system.assert(sc.id!=null);
       
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        insert testBox;
        System.assert(testBox.id!=null);
        
         Database.BatchableContext BC;
     
         BoxUploadFeedItemsBatch bfb = new BoxUploadFeedItemsBatch(feedList,oppList,10);
          bfb.start(BC);      
         
         Test.startTest();
          Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
          bfb.execute(bc,feedItemsList);
          BoxUploadFeedItemsBatch.uploadDocument(2,fdi,sc.CF_Box_Folder_Id__c,errList);
          bfb.finish(bc);
          Test.stopTest();
         
             
     }
     
    static testMethod void myTest12() {
        Set<String> oppList = new Set<String>();
        List<String> feedList = new List<String>();
        List<Box_error__c> errList = new List<Box_error__c>();
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
        
        box_error__c bxerr = new box_error__c();
        bxerr.Opportunity__c = opp.id; 
        bxerr.name = '409'; 
        bxerr.Message__c = 'Attachment id-'; 
        bxerr.Body__c = '';
        bxerr.Type__c = 'Feed Item';
        bxerr.Status__c = 'Error';
        errList.add(bxerr);
        
        oppList.add(opp.id);
        System.assert(opp.id!=null); 
                           
        
        Sub_Folder__c sc1= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='sales');
        insert sc1;
        system.assert(sc1.id!=null);           
        
        List<FeedItem> feedItemsList = new List<FeedItem>();
        FeedItem  fdi = new FeedItem(ContentFileName='Test.html', ContentData=Blob.valueOf('Test Data'), parentid=opp.id);
        insert fdi;
        system.assert(fdi.id!=null);
        feedItemsList.add(fdi);
        feedList.add(fdi.id);  
        
    
        Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='Application');
        insert sc;
        system.assert(sc.id!=null);
       
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        insert testBox;
        System.assert(testBox.id!=null);
        
         Database.BatchableContext BC;
     
         BoxUploadFeedItemsBatch bfb = new BoxUploadFeedItemsBatch(feedList,oppList,10);
          bfb.start(BC);      
         
         Test.startTest();
          Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
          bfb.execute(bc,feedItemsList);
          BoxUploadFeedItemsBatch.uploadDocument(2,fdi,sc.CF_Box_Folder_Id__c,errList);
          bfb.finish(bc);
          Test.stopTest();
         
             
     }
     
     static testMethod void myTest13() {
        Set<String> oppList = new Set<String>();
        List<String> feedList = new List<String>();
        List<Box_error__c> errList = new List<Box_error__c>();
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
        
        box_error__c bxerr = new box_error__c();
        bxerr.Opportunity__c = opp.id; 
        bxerr.name = '409'; 
        bxerr.Message__c = 'Attachment id-'; 
        bxerr.Body__c = '';
        bxerr.Type__c = 'Feed Item';
        bxerr.Status__c = 'Error';
        errList.add(bxerr);
        
        oppList.add(opp.id);
        System.assert(opp.id!=null); 
                           
        
        Sub_Folder__c sc1= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='sales');
        insert sc1;
        system.assert(sc1.id!=null);           
        
        List<FeedItem> feedItemsList = new List<FeedItem>();
        FeedItem  fdi = new FeedItem(ContentFileName='Test.doc', ContentData=Blob.valueOf('Test Data'), parentid=opp.id);
        insert fdi;
        system.assert(fdi.id!=null);
        feedItemsList.add(fdi);
        feedList.add(fdi.id);  
        
    
        Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='Application');
        insert sc;
        system.assert(sc.id!=null);
       
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        insert testBox;
        System.assert(testBox.id!=null);
        
         Database.BatchableContext BC;
     
         BoxUploadFeedItemsBatch bfb = new BoxUploadFeedItemsBatch(feedList,oppList,10);
          bfb.start(BC);      
         
         Test.startTest();
          Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
          bfb.execute(bc,feedItemsList);
          BoxUploadFeedItemsBatch.uploadDocument(2,fdi,sc.CF_Box_Folder_Id__c,errList);
          bfb.finish(bc);
          Test.stopTest();
         
             
     }
     
     static testMethod void myTest14() {
        Set<String> oppList = new Set<String>();
        List<String> feedList = new List<String>();
        List<Box_error__c> errList = new List<Box_error__c>();
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
        
        box_error__c bxerr = new box_error__c();
        bxerr.Opportunity__c = opp.id; 
        bxerr.name = '409'; 
        bxerr.Message__c = 'Attachment id-'; 
        bxerr.Body__c = '';
        bxerr.Type__c = 'Feed Item';
        bxerr.Status__c = 'Error';
        errList.add(bxerr);
        
        oppList.add(opp.id);
        System.assert(opp.id!=null); 
                           
        
        Sub_Folder__c sc1= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='sales');
        insert sc1;
        system.assert(sc1.id!=null);           
        
        List<FeedItem> feedItemsList = new List<FeedItem>();
        FeedItem  fdi = new FeedItem(ContentFileName='Test.jpg', ContentData=Blob.valueOf('Test Data'), parentid=opp.id);
        insert fdi;
        system.assert(fdi.id!=null);
        feedItemsList.add(fdi);
        feedList.add(fdi.id);  
        
    
        Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='Application');
        insert sc;
        system.assert(sc.id!=null);
       
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        insert testBox;
        System.assert(testBox.id!=null);
        
         Database.BatchableContext BC;
     
         BoxUploadFeedItemsBatch bfb = new BoxUploadFeedItemsBatch(feedList,oppList,10);
          bfb.start(BC);      
         
         Test.startTest();
          Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
          bfb.execute(bc,feedItemsList);
          BoxUploadFeedItemsBatch.uploadDocument(2,fdi,sc.CF_Box_Folder_Id__c,errList);
          bfb.finish(bc);
          Test.stopTest();
         
             
     }
      
}