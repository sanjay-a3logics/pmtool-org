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
private class TestBoxFolderBatch {

    static testMethod void executeTest() {
        
         List<Opportunity> OppList = new List<Opportunity>();
            for(Integer i=0; i<2; i++){
                
                Account acc =new Account();
                acc.name = 'irfan khan';
                insert acc;
            
                Opportunity opp = new Opportunity();
                opp.name = 'Test opp'+i;
                opp.accountId = acc.id;
                opp.CloseDate = date.today();
                opp.stageName = 'Closed won';
                insert opp;
                
                OppList.add(opp);
            }
            
            
                box_error__c bxerr = new box_error__c();
                bxerr.Opportunity__c = OppList[0].id; 
                bxerr.name = '409'; 
                bxerr.Message__c = 'Attachment id-'; 
                bxerr.Body__c = '{"type":"error","status":409,"code":"item_name_in_use","context_info":{"conflicts":{"type":"folder","id":"5045260509","sequence_id":"0","etag":"0","name":"2796_9019apricotst_JamesTobias"}},"help_url":"http:developers.box.com","message":"Item with the same name already exists","request_id":"1145339348561cbaa279ec4"}';
                bxerr.Type__c = 'EE';
                bxerr.Status__c = 'Error';
                insert bxerr;
            
            BoxFolderBatch bfb = new BoxFolderBatch(1);
            Database.BatchableContext BC;
            
             Box__c testBox = new Box__c (BoxAccess_Token__c='7sejJNKnLhC6NFQFcGTPqZk1a8T2JjLd',Boxrefresh_token__c ='uvXGWWKFyArawZRa4kJ2VdQP4qmBkMMwcoweMQRpiigpzJzxYkW9My3j6TlHBnnM',Boxclient_Id__c ='askknl10jr57z26sb649nqlh4ftb2xz4',Boxclient_Secret__c='iVmHlomxgyJOPIa7b55vZDzAdCV98833');
            insert testBox;
            
            bfb.start(bc);
            
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new BoxApiController_mock());
            bfb.execute(bc,OppList);
            Test.stopTest();
    }
    static testMethod void executeTest2() {
        
         List<Opportunity> OppList = new List<Opportunity>();
            for(Integer i=0; i<2; i++){
                
                Account acc =new Account();
                acc.name = 'irfan khan';
                insert acc;
            
                Opportunity opp = new Opportunity();
                opp.name = 'Test opp'+i;
                opp.accountId = acc.id;
                opp.CloseDate = date.today();
                opp.stageName = 'Closed won';
               
                insert opp;
                OppList.add(opp);
            }
            
            
                box_error__c bxerr = new box_error__c();
                bxerr.Opportunity__c = OppList[0].id; 
                bxerr.name = '401'; 
                bxerr.Message__c = 'Attachment id-'; 
                bxerr.Body__c = '';
                bxerr.Type__c = 'EE';
                bxerr.Status__c = 'Error';
                insert bxerr;
            
            BoxFolderBatch bfb = new BoxFolderBatch(0);
            Database.BatchableContext BC;
            
            Box__c testBox = new Box__c (BoxAccess_Token__c='7sejJNKnLhC6NFQFcGTPqZk1a8T2JjLd',Boxrefresh_token__c ='uvXGWWKFyArawZRa4kJ2VdQP4qmBkMMwcoweMQRpiigpzJzxYkW9My3j6TlHBnnM',Boxclient_Id__c ='askknl10jr57z26sb649nqlh4ftb2xz4',Boxclient_Secret__c='iVmHlomxgyJOPIa7b55vZDzAdCV98833');
            insert testBox;
            
            bfb.start(bc);
            
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new TestFileUploadMock4());
            bfb.execute(bc,OppList);
            Test.stopTest();
    } 
}