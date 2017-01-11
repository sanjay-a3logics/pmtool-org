@isTest
public class TestBoxUploadFeedItems{
    
     static testmethod void myTest() {
     
        Account acc =new Account();
        acc.name = 'irfan khan';
        insert acc;
        //System.assert(acc.id!=null); 
                   
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed won';
        insert opp;
        //System.assert(opp.id!=null); 
        
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        insert testBox;
       // System.assert(testBox.id!=null);                   
        
        Sub_Folder__c sc1= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='sales');
        insert sc1;
       // system.assert(sc1.id!=null);           

        FeedItem  fdi = new FeedItem(ContentFileName='Test.pdf', ContentData=Blob.valueOf('Test Data'), parentid=opp.id);
        insert fdi;
       // system.assert(fdi.id!=null);
        
        FeedItem  fdi1 = new FeedItem(ContentFileName='Test1.pdf', ContentData=Blob.valueOf('Test1 Data'), parentid=opp.id);
        insert fdi1;
       // system.assert(fdi1.id!=null);
        
        Box_error__c bx = new Box_error__c();
        bx.name = '201';
        bx.message__c = 'Attachment id-'+fdi1.id;
        bx.type__c = 'Feed Item Standard';
        insert bx;
       
       // system.assert(bx.id!=null);
           BoxUploadFeedItems bfd = new BoxUploadFeedItems();
           BoxUploadFeedItems.uploadFeedItem();

     }
}