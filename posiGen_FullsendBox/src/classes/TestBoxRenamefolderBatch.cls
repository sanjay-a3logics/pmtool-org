@isTest
Public class TestBoxRenamefolderBatch {

    static testMethod void myUnitTest() {
      
      List<Box_error__c> OppList = new List<Box_error__c>();
                
        Account acc =new Account();
        acc.name = 'irfan khanNew';
        insert acc;
    
       
        Opportunity opp = new Opportunity();
        opp.name = 'TestoppDocu    fghf " fj \\ fhg / fm';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed won';
        insert opp;
        
        List<Sub_folder__c>fldlst = new List<Sub_folder__c>();
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Application';
        sf.cf_opportunity__c = opp.id;
        sf.cf_box_folder_id__c = '11446498';
        
        insert sf;
        
        Sub_folder__c sfd = [Select id,Name,cf_box_folder_id__c,cf_opportunity__c, cf_opportunity__r.name from Sub_folder__c where id=:sf.id];
        fldlst.add(sfd);
       

        BoxRenamefolderBatch customDpb = new BoxRenamefolderBatch('Application',1);
        Database.BatchableContext BC;
        
        customDpb.start(BC);
       
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestFileUploadMockGet());
        customDpb.execute(bc,fldlst);
        
        Test.stopTest();  
               
      
    }
   
   
}