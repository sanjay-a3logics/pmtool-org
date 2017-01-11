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
private class TestBoxFolderBatchRecover {

    static testMethod void myUnitTest() {
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
            
            BoxFolderBatchRecover bfb = new BoxFolderBatchRecover();
            Database.BatchableContext BC;
            
            Box__c testBox = new Box__c (BoxAccess_Token__c='7sejJNKnLhC6NFQFcGTPqZk1a8T2JjLd',Boxrefresh_token__c ='uvXGWWKFyArawZRa4kJ2VdQP4qmBkMMwcoweMQRpiigpzJzxYkW9My3j6TlHBnnM',Boxclient_Id__c ='askknl10jr57z26sb649nqlh4ftb2xz4',Boxclient_Secret__c='iVmHlomxgyJOPIa7b55vZDzAdCV98833');
            insert testBox;
            
            bfb.start(bc);
            
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new BoxApiController_mock());
            bfb.execute(bc,OppList);
            Test.stopTest();
    }

    static testMethod void myUnitTest1() {
       List<Opportunity> OppList = new List<Opportunity>();
            for(Integer i=0; i<1; i++){
                
                Account acc =new Account();
                acc.name = 'irfan khan';
                insert acc;
            
                Opportunity opp = new Opportunity();
                opp.name = 'Pictures';
                opp.accountId = acc.id;
                opp.CloseDate = date.today();
                opp.stageName = 'Closed won';
                insert opp;
                
                OppList.add(opp);
            }
            
            BoxFolderBatchRecover bfb = new BoxFolderBatchRecover();
            Database.BatchableContext BC;
            
            Box__c testBox = new Box__c (BoxAccess_Token__c='7sejJNKnLhC6NFQFcGTPqZk1a8T2JjLd',Boxrefresh_token__c ='uvXGWWKFyArawZRa4kJ2VdQP4qmBkMMwcoweMQRpiigpzJzxYkW9My3j6TlHBnnM',Boxclient_Id__c ='askknl10jr57z26sb649nqlh4ftb2xz4',Boxclient_Secret__c='iVmHlomxgyJOPIa7b55vZDzAdCV98833');
            insert testBox;
            
            bfb.start(bc);
            
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new BoxApiControllerRecover_mock());
            bfb.execute(bc,OppList);
            Test.stopTest();
    }
}