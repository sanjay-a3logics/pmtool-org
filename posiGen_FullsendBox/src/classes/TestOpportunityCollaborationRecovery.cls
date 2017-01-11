@isTest
public class TestOpportunityCollaborationRecovery{ 

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        List<Sub_folder__c> subList = new List<Sub_folder__c>();
        Map<String,String> profileMap = new Map<String,String>(); 
        Account acc =new Account();
        acc.name = 'irfan khan';
        upsert acc;
        
      
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed Won';
        upsert opp;
        
        opportunity op =[Select id, Pipeline_stage__c from opportunity where stageName='Closed Won' and id=:opp.id];
        
        
      //  System.assert(false,[select id,stageName From opportunity where id=:opp.id]);             
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        upsert testBox;
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Funding-Vendor';
        sf.cf_opportunity__c = op.id;
        sf.cf_box_folder_id__c = '11446498';
        upsert sf;
       
        Sub_folder__c sflst =[Select id,cf_box_folder_id__c,cf_opportunity__c,name, cf_opportunity__r.Pipeline_stage__c from Sub_folder__c where id=:sf.id];
        
        subList.add(sflst);
        List<String> fldsubList = new List<String>();
        fldsubList.add(sf.cf_box_folder_id__c);
       
        Profile prf= [select id,Name From Profile Where Name='EE Partner User'];
        profileMap.put(prf.Name,prf.id);
        
        
        List<Box_error__c> OppList = new List<Box_error__c>();
        box_error__c bxerr = new box_error__c();
        bxerr.Opportunity__c = opp.id; 
        bxerr.name = '409'; 
        bxerr.Message__c = 'Attachment id-'; 
        bxerr.Body__c = '{"type":"error","status":409,"code":"item_name_in_use","context_info":{"conflicts":{"type":"folder","id":"5045260509","sequence_id":"0","etag":"0","name":"2796_9019apricotst_JamesTobias"}},"help_url":"http:developers.box.com","message":"Item with the same name already exists","request_id":"1145339348561cbaa279ec4"}';
        bxerr.Type__c = 'EE';
        bxerr.Status__c = 'Error';  
        OppList.add(bxerr); 
       
        List<Opportunity_Collaboration_Recovery__c> lstclb = new List<Opportunity_Collaboration_Recovery__c>();
        Opportunity_Collaboration_Recovery__c clb = new Opportunity_Collaboration_Recovery__c(BoxCollaboration_Id__c='123456',Sub_Folder__c =sf.id,UserEmail__c='anki@abc.com',Profile_Id__c=prf.id);
        upsert clb;
        lstclb.add(clb);
        
        Batch_OpportunityCollaborationRecovery bcb = new Batch_OpportunityCollaborationRecovery('EE');
        Database.BatchableContext BC;
        
        bcb.start(BC);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestFolderInfoMock());
        bcb.execute(BC,subList);
        Test.stopTest();         
    }
  static testMethod void myUnitTest2() {
        // TO DO: implement unit test
        List<Sub_folder__c> subList = new List<Sub_folder__c>();
        Map<String,String> profileMap = new Map<String,String>(); 
        Account acc =new Account();
        acc.name = 'irfan khan';
        upsert acc;
        
      
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed Won';
        upsert opp;
        
        opportunity op =[Select id, Pipeline_stage__c from opportunity where stageName='Closed Won' and id=:opp.id];
        
        
      //  System.assert(false,[select id,stageName From opportunity where id=:opp.id]);             
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        upsert testBox;
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Funding-Vendor';
        sf.cf_opportunity__c = op.id;
        sf.cf_box_folder_id__c = '11446498';
        upsert sf;
       
        Sub_folder__c sflst =[Select id,cf_box_folder_id__c,cf_opportunity__c,name, cf_opportunity__r.Pipeline_stage__c from Sub_folder__c where id=:sf.id];
        
        subList.add(sflst);
        List<String> fldsubList = new List<String>();
        fldsubList.add(sf.cf_box_folder_id__c);
       
        Profile prf= [select id,Name From Profile Where Name='EE Partner User'];
        profileMap.put(prf.Name,prf.id);
        
        
        List<Box_error__c> OppList = new List<Box_error__c>();
        box_error__c bxerr = new box_error__c();
        bxerr.Opportunity__c = opp.id; 
        bxerr.name = '409'; 
        bxerr.Message__c = 'Attachment id-'; 
        bxerr.Body__c = '{"type":"error","status":409,"code":"item_name_in_use","context_info":{"conflicts":{"type":"folder","id":"5045260509","sequence_id":"0","etag":"0","name":"2796_9019apricotst_JamesTobias"}},"help_url":"http:developers.box.com","message":"Item with the same name already exists","request_id":"1145339348561cbaa279ec4"}';
        bxerr.Type__c = 'EE';
        bxerr.Status__c = 'Error';  
        OppList.add(bxerr); 
       
        List<Opportunity_Collaboration_Recovery__c> lstclb = new List<Opportunity_Collaboration_Recovery__c>();
        Opportunity_Collaboration_Recovery__c clb = new Opportunity_Collaboration_Recovery__c(BoxCollaboration_Id__c='123456',Sub_Folder__c =sf.id,UserEmail__c='anki@abc.com',Profile_Id__c=prf.id);
        upsert clb;
        lstclb.add(clb);
        
        Batch_OpportunityCollaborationRecovery bcb = new Batch_OpportunityCollaborationRecovery('EE');
        Database.BatchableContext BC;
        
        bcb.start(BC);
        Test.startTest();
        bcb.execute(BC,subList);
        Test.setMock(HttpCalloutMock.class, new TestFolderInfoMock());
        Test.stopTest();         
    }  
   
        
}