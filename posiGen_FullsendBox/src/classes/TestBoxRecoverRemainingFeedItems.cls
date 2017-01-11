@isTest
public class TestBoxRecoverRemainingFeedItems{
    
     static testmethod void myTest() {
     
        Account acc =new Account();
        acc.name = 'irfan khan';
        insert acc;
        
                   
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed won';
        insert opp;
                    
        
        Sub_Folder__c sc1= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='sales');
        insert sc1;
                
        
        FeedItem  fdi = new FeedItem(ContentFileName='Testa.pdf', ContentData=Blob.valueOf('Test Data'), parentid=opp.id);
        insert fdi;
       
        
        FeedItem  fdi1 = new FeedItem(ContentFileName='Test1.pdf', ContentData=Blob.valueOf('Test1 Data'), parentid=opp.id);
        insert fdi1;
        
        List<FeedItem> feedItemList = new List<FeedItem>();
        feedItemList.add(fdi);
       
        
        Box_error__c bx = new Box_error__c();
        bx.name = '201';
        bx.message__c = 'Attachment id-'+fdi1.id;
        bx.type__c = 'Feed Item Standard';
        insert bx;
        
       Database.BatchableContext bc;
       BoxRecoverRemainingFeedItems bfb = new BoxRecoverRemainingFeedItems();
       
        bfb.start(bc);
       
       Test.startTest();
       bfb.execute(bc,feedItemList);
       bfb.finish(bc);
       Test.stopTest();
          

     }
}