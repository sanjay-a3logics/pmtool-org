@isTest
public class TestBatch_CreateEmailUserCollaboration{ 

    static testMethod void myUnitTest() {
    
        // TO DO: implement unit test
        List<Sub_folder__c> subList = new List<Sub_folder__c>();
        
        Account acc =new Account();
        acc.name = 'irfan khan';
        insert acc;
        
      
        
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Release to Installer';
        insert opp;
       
       Opportunity oppr =[Select id, Pipeline_stage__c from opportunity where id=:opp.id];
        
      //  System.assert(false,[select id,stageName From opportunity where id=:opp.id]);             
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        insert testBox;
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Funding-Vendor';
        sf.cf_opportunity__c = oppr.id;
        sf.cf_box_folder_id__c = '11446498';
        insert sf;
        subList.add(sf);
        Set<String> fldsubList = new Set<String>();
        fldsubList.add(sf.cf_box_folder_id__c);
        //System.assert(false,[Select id,CF_Box_Folder_Id__c,cf_opportunity__r.stagename from Sub_Folder__c  where name=:'Funding-Vendor']);
        Profile prf= [select id,Name From Profile Where Name='Concierge'];
        
        List<Box_error__c> OppList = new List<Box_error__c>();
        box_error__c bxerr = new box_error__c();
        bxerr.Opportunity__c = opp.id; 
        bxerr.name = '409'; 
        bxerr.Message__c = 'Attachment id-'; 
        bxerr.Body__c = '{"type":"error","status":409,"code":"item_name_in_use","context_info":{"conflicts":{"type":"folder","id":"5045260509","sequence_id":"0","etag":"0","name":"2796_9019apricotst_JamesTobias"}},"help_url":"http:developers.box.com","message":"Item with the same name already exists","request_id":"1145339348561cbaa279ec4"}';
        bxerr.Type__c = 'Funding';
        bxerr.Status__c = 'Error';  
        OppList.add(bxerr); 
       
       List<Collaboration__c> lstclb = new List<Collaboration__c>();
        Collaboration__c clb = new Collaboration__c(BoxCollaboration_Id__c='123456',BoxFolder_Id__c='34567',BoxGroup_Id__c='',Role__c='Uploader');
        insert clb;
        lstclb.add(clb);
        
       
        Batch_CreateEmailUserCollaboration bcb = new Batch_CreateEmailUserCollaboration('test@email.com','Uploader',fldsubList);
        Database.BatchableContext BC;
        bcb.accountdata();
        bcb.start(BC);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
        bcb.execute(bc,subList);
        Test.stopTest();         
    }
  
  
}