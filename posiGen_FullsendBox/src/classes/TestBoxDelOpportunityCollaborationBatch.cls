@isTest
public class TestBoxDelOpportunityCollaborationBatch{ 
    static testMethod void myUnitTest() {
        List<Sub_folder__c> subList = new List<Sub_folder__c>();
        List<Deal__c> opList = new List<Deal__c>();
        Account acc =new Account();     
        acc.name = 'irfan khan';
        upsert acc;
        
        Contact con = new Contact(FirstName='Test1',LastName='State1',email='test2@test.com',AccountId=acc.id);
        upsert con;
        
        Deal__c opp = new Deal__c();
        //opp.name = 'Test opp';
        opp.Account__c = acc.id;
        opp.CloseDate__c = date.today();
        opp.stageName__c = 'Closed Won';
        upsert opp;
        opList.add(opp);
       
       Deal__c oppr =[Select id, Opp_Pipeline_Stage__c from Deal__c where stageName__c='Closed Won' and id=:opp.id];
        
      //  System.assert(false,[select id,stageName From Deal__c where id=:opp.id]);             
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        upsert testBox;
        
        profile prf=[Select id from profile where name ='System Administrator'];
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Application';
        sf.cf_Deal__c = oppr.id;
        sf.cf_box_folder_id__c = '11446498';
        upsert sf;
        subList.add(sf);			
        
       
        
        Box_Group__c bg = new Box_Group__c();
        bg.BoxGroup_Id__c='34087847';
        bg.BoxGroup_Name__c='test box grop';
        bg.SF_Profile_Id__c=prf.id;
        upsert bg;
        
        List<Box_error__c> OppList = new List<Box_error__c>();
        box_error__c bxerr = new box_error__c();
        bxerr.Deal__c = opp.id; 
        bxerr.name = '409'; 
        bxerr.Message__c = 'Attachment id-'; 
        bxerr.Body__c = '{"type":"error","status":409,"code":"item_name_in_use","context_info":{"conflicts":{"type":"folder","id":"5045260509","sequence_id":"0","etag":"0","name":"2796_9019apricotst_JamesTobias"}},"help_url":"http:developers.box.com","message":"Item with the same name already exists","request_id":"1145339348561cbaa279ec4"}';
        bxerr.Type__c = 'EE';
        bxerr.Status__c = 'Error';  
        OppList.add(bxerr); 
       
       List<Collaboration__c> lstclb = new List<Collaboration__c>();
       Collaboration__c clb = new Collaboration__c(BoxCollaboration_Id__c='123456',BoxFolder_Id__c='11446498',BoxGroup_Id__c=bg.BoxGroup_Id__c,Role__c='Viewer');
       upsert clb;
       lstclb.add(clb);
       
       Set<String> setProfileId = new Set<String>();
       setProfileId.add(prf.Id);
          
       BoxDeleteOpportunityCollaborationBatch bcb = new BoxDeleteOpportunityCollaborationBatch(opList,subList);
       Database.BatchableContext BC;  	   		
        
       bcb.start(BC);
       Test.startTest();
       Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
       bcb.execute(BC,opList); 
       Test.stopTest();
       
    }
}