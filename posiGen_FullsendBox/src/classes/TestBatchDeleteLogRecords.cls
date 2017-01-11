@isTest
public class TestBatchDeleteLogRecords{ 
    static testMethod void myUnitTest() { 
       
       List<Collaboration__c> lstclb = new List<Collaboration__c>();
       Collaboration__c clb = new Collaboration__c(BoxCollaboration_Id__c='123456',BoxFolder_Id__c='11446498',BoxGroup_Id__c=null,Role__c='Viewer');
       insert clb;
       lstclb.add(clb);
       
       BatchDeleteLogRecords bcb = new BatchDeleteLogRecords('select id, createddate from Collaboration__c','Log');
       Database.BatchableContext BC;
       
       System.test.startTest();
       bcb.start(BC);
       bcb.execute(BC,lstclb); 
       bcb.finish(BC);
       System.test.stopTest();
       
    }
}