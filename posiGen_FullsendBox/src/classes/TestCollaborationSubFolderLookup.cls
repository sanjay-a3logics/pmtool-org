@isTest
public class TestCollaborationSubFolderLookup{ 
    static testMethod void myTest1() {
    
        Account acc =new Account();
        acc.name = 'irfan khan';
        insert acc;
        
        Contact con = new Contact(FirstName='Test1',LastName='State1',email='test2@test.com',AccountId=acc.id);
        insert con;
        
        Deal__c opp = new Deal__c();       
        //opp.name = 'Test opp';
        opp.Account__c = acc.id;
        opp.CloseDate__c = date.today();
        opp.stageName__c = 'Closed Won';
        insert opp;   								
        
        List<Sub_Folder__c> lstclb = new List<Sub_Folder__c>();
        Sub_Folder__c sf = new Sub_Folder__c();
        sf.CF_Box_Folder_Id__c = '654321';
        sf.CF_Deal__c = opp.id;
        insert sf;
        lstclb.add(sf); 
        
        
        Collaboration__c collaboration = new Collaboration__c();
        collaboration.BoxCollaboration_Id__c = '123456';
        collaboration.BoxFolder_Id__c= '654321';
        collaboration.BoxGroup_Id__c = '11111';
        collaboration.BoxUser_Id__c= '22222';
        collaboration.Role__c= 'Uploader';
        collaboration.SFProfile_Id__c = '33333';
        collaboration.SFUser_Email__c = 'test2@test.com';
        collaboration.Sub_Folder__c = null;
        insert collaboration;
       
        
        CollaborationSubFolderLookup bcb = new CollaborationSubFolderLookup();
        Database.BatchableContext BC;
        
        bcb.start(BC);
        Test.startTest();
        bcb.start(BC);
        bcb.execute(BC,lstclb);
        bcb.finish(BC);
        
        
    }
}