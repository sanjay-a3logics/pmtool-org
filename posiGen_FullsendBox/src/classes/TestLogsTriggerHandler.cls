@isTest
public class TestLogsTriggerHandler {
    static testMethod void myUnitTest() {
      
        Account acc =new Account();
        acc.name = 'irfan khan';
        upsert acc;
        
        Contact con = new Contact(FirstName='Test1',LastName='State1',email='test2@test.com',AccountId=acc.id);
        upsert con;
        
        Trigger_Setting__c ts = new Trigger_Setting__c(LogsTrigger__c =true);
        insert ts; 
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed Won';
        upsert opp;
      
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Funding-Vendor';
        sf.cf_opportunity__c = opp.id;
        sf.cf_box_folder_id__c = '11446498';
        upsert sf;
     
        Box_error__c be = new Box_error__c(Name='401',Useremail__c='test@appcino.com',Sub_folder__c=sf.id,Type__c='Check');
        insert be; 
        
        
        LogsTriggerHandler ut = new LogsTriggerHandler();
        ut.bulkBefore();
        ut.beforeInsert();
        ut.beforeUpdate();
        ut.beforeDelete();
        ut.afterDelete();
        ut.afterUnDelete();
        
    }
}