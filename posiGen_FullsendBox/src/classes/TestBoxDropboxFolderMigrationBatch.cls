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
private class TestBoxDropboxFolderMigrationBatch  {

    static testMethod void executeTest() {
        
        
                
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

            Dropbox_Files_in_Box__c  dfb= new Dropbox_Files_in_Box__c(Box_Folder_Id__c='890384',Directory_Path__c='c/user/demo',done__c=false,Folder_Name__c='demo',Opportunity_Id__c=opp.id,Type__c='dumy');
            insert dfb;
            system.assert(dfb.id!=null);
            
            List<Dropbox_Files_in_Box__c > dfiles= new List<Dropbox_Files_in_Box__c >();
            dfiles.add(dfb);
            
            Sub_Folder__c sc2= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=Opp.id,Name='Funding-Vendor');
            insert sc2;
            system.assert(sc2.id!=null);
            
            
            BoxDropboxFolderMigrationBatch bfb = new BoxDropboxFolderMigrationBatch(1);
            Database.BatchableContext BC;
            
            Box__c testBox = new Box__c (BoxAccess_Token__c='7sejJNKnLhC6NFQFcGTPqZk1a8T2JjLd',Boxrefresh_token__c ='uvXGWWKFyArawZRa4kJ2VdQP4qmBkMMwcoweMQRpiigpzJzxYkW9My3j6TlHBnnM',Boxclient_Id__c ='askknl10jr57z26sb649nqlh4ftb2xz4',Boxclient_Secret__c='iVmHlomxgyJOPIa7b55vZDzAdCV98833');
            insert testBox;
            
            bfb.start(bc);
            
            Test.startTest();
          Test.setMock(HttpCalloutMock.class, new BoxApiController_mock());
            bfb.execute(bc,dfiles);
            bfb.finish(bc);
          Test.stopTest();
    }
    static testMethod void executeTest2() {
        
        
                
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

            Dropbox_Files_in_Box__c  dfb= new Dropbox_Files_in_Box__c(Box_Folder_Id__c='890384',Directory_Path__c='c/user/demo',done__c=false,Folder_Name__c='demo',Opportunity_Id__c=opp.id,Type__c='dumy');
            insert dfb;
            system.assert(dfb.id!=null);
            
            List<Dropbox_Files_in_Box__c > dfiles= new List<Dropbox_Files_in_Box__c >();
            dfiles.add(dfb);
            
            Sub_Folder__c sc2= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=Opp.id,Name='Funding-Vendor');
            insert sc2;
            system.assert(sc2.id!=null);
            
            
            BoxDropboxFolderMigrationBatch bfb = new BoxDropboxFolderMigrationBatch(1);
            Database.BatchableContext BC;
            
            Box__c testBox = new Box__c (BoxAccess_Token__c='7sejJNKnLhC6NFQFcGTPqZk1a8T2JjLd',Boxrefresh_token__c ='uvXGWWKFyArawZRa4kJ2VdQP4qmBkMMwcoweMQRpiigpzJzxYkW9My3j6TlHBnnM',Boxclient_Id__c ='askknl10jr57z26sb649nqlh4ftb2xz4',Boxclient_Secret__c='iVmHlomxgyJOPIa7b55vZDzAdCV98833');
            insert testBox;
            
            bfb.start(bc);
            
            Test.startTest();
          Test.setMock(HttpCalloutMock.class, new BoxApiControllerRecover_mock_error());
            bfb.execute(bc,dfiles);
            bfb.finish(bc);
          Test.stopTest();
    }
   /* static testMethod void executeTest1() {
        
        
            List<Account> con = new List<Account >();
            Account acc =new Account();
            acc.name = 'irfan khan';
            insert acc;
            System.assert(acc.id!=null);
            con.add(acc);
               
            BoxDropboxFolderMigrationBatch bfb = new BoxDropboxFolderMigrationBatch();
            Database.BatchableContext BC;
            
            Box__c testBox = new Box__c (BoxAccess_Token__c='7sejJNKnLhC6NFQFcGTPqZk1a8T2JjLd',Boxrefresh_token__c ='uvXGWWKFyArawZRa4kJ2VdQP4qmBkMMwcoweMQRpiigpzJzxYkW9My3j6TlHBnnM',Boxclient_Id__c ='askknl10jr57z26sb649nqlh4ftb2xz4',Boxclient_Secret__c='iVmHlomxgyJOPIa7b55vZDzAdCV98833');
            insert testBox;
            
            bfb.start(bc);
            
            Test.startTest();
            bfb.execute(bc,con);
            bfb.finish(bc);
          Test.stopTest();
    }*/
}