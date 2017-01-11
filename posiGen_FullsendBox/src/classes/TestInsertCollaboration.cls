@isTest
private class TestInsertCollaboration {

    static testMethod void executeTest1() {
    
        Account acc =new Account();
        acc.name = 'irfan khan';
        upsert acc;
    
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed Won';
        insert opp;
    
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'EE';
        sf.cf_opportunity__c = opp.id;
        sf.cf_box_folder_id__c = '11446498';
        insert sf;
        
        
        Opportunity_Collaboration_Recovery__c ocr = new Opportunity_Collaboration_Recovery__c();
        ocr.Sub_Folder__c = sf.id;
        ocr.BoxCollaboration_Id__c = '4545454';
        ocr.Profile_Id__c = 'feukfyskufhds';
        ocr.UserEmail__c = 'test@abc.com';
        insert ocr;
        
        List<Opportunity_Collaboration_Recovery__c> ocrList = new List<Opportunity_Collaboration_Recovery__c>();
        ocrList.add(ocr);
        
        Collaboration__c clb = new Collaboration__c();
        clb.BoxCollaboration_Id__c = '4523256';
        clb.BoxFolder_Id__c = sf.cf_box_folder_id__c;
        clb.BoxFolder_Id__c = sf.cf_box_folder_id__c;
        clb.Sub_Folder__c = sf.id;
        insert clb;
        
        Database.BatchableContext BC;
        InsertCollaboration icb = new InsertCollaboration('EE');
        
        Test.startTest();
        icb.start(bc);
        icb.execute(bc,ocrList);
        icb.finish(bc);
        Test.stopTest();
        

    }
}