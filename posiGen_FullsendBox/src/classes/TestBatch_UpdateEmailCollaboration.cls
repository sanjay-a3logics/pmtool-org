@isTest
public class TestBatch_UpdateEmailCollaboration{ 
    static testMethod void myUnitTest() {
         // TO DO: implement unit test
        List<Sub_folder__c> subList = new List<Sub_folder__c>();
        
        Account acc =new Account();
        acc.name = 'irfan khan';
        upsert acc;
        
        Contact con = new Contact(FirstName='Test1',LastName='State1',email='test2@test.com',AccountId=acc.id);
        upsert con;
        
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed Won';
        upsert opp;
       
       Opportunity oppr =[Select id, Pipeline_stage__c from opportunity where stageName='Closed Won' and id=:opp.id];
        
      //  System.assert(false,[select id,stageName From opportunity where id=:opp.id]);             
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        upsert testBox;
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Application';
        sf.cf_opportunity__c = oppr.id;
        sf.cf_box_folder_id__c = '11446498';
        upsert sf;
        subList.add(sf);
        
        List<String> fldsubList = new List<String>();
        fldsubList.add(sf.cf_box_folder_id__c);
        //System.assert(false,[Select id,CF_Box_Folder_Id__c,cf_opportunity__r.stagename from Sub_Folder__c  where name=:'Funding-Vendor']);
        Profile prf= [select id,Name From Profile Where Name='System Administrator'];
        
        BoxAccessMatrix_SubFolder__c bams = new BoxAccessMatrix_SubFolder__c();
        bams.SubFolder_Name__c='Application';
        bams.Name='Application';
        upsert bams;
        
        BoxAccessMatrix_Profile__c bamp = new BoxAccessMatrix_Profile__c();
        bamp.BoxAccessMatrix_SubFolder__c=bams.id;
        bamp.Profile_Id__c=prf.id;
        bamp.Profile_Name__c='System Administrator';
        bamp.Lookup_Field_Name__c='Concierge__c';
        upsert bamp;
        
        List<BoxAccessMatrix_Stage__c> bst = new List<BoxAccessMatrix_Stage__c>();
        BoxAccessMatrix_Stage__c BAM = new BoxAccessMatrix_Stage__c();
        BAM.Box_Permission__c='Viewer';
        BAM.BoxAccessMatrix_Profile__c=bamp.id;
        BAM.Stage__c=oppr.Pipeline_stage__c;
        BAM.check__c=true;
        upsert BAM;
        bst.add(BAM);
        
       
        
        
       
        
        Box_Group__c bg = new Box_Group__c();
        bg.BoxGroup_Id__c='34087847';
        bg.BoxGroup_Name__c='test box grop';
        bg.SF_Profile_Id__c=prf.id;
        upsert bg;
        
        List<Box_error__c> OppList = new List<Box_error__c>();
        box_error__c bxerr = new box_error__c();
        bxerr.Opportunity__c = opp.id; 
        bxerr.name = '409'; 
        bxerr.Message__c = 'Attachment id-'; 
        bxerr.Body__c = '{"type":"error","status":409,"code":"item_name_in_use","context_info":{"conflicts":{"type":"folder","id":"5045260509","sequence_id":"0","etag":"0","name":"2796_9019apricotst_JamesTobias"}},"help_url":"http:developers.box.com","message":"Item with the same name already exists","request_id":"1145339348561cbaa279ec4"}';
        bxerr.Type__c = 'EE';
        bxerr.Status__c = 'Error';  
        OppList.add(bxerr); 
        
        List<Collaboration__c> lstclb = new List<Collaboration__c>();
        Collaboration__c clb = new Collaboration__c(BoxCollaboration_Id__c='123456',BoxFolder_Id__c='34567',BoxGroup_Id__c=bg.BoxGroup_Id__c,Role__c='Viewer');
        upsert clb;
        lstclb.add(clb);
        
        Map<String, String> mapCol = new Map<String, String>();
        for(Collaboration__c c : lstclb) {
            mapCol.put(c.BoxFolder_Id__c, c.Id);
        }
        
        List<String> listfldr = new List<String>();
        listfldr.add('34567');
        Profile profiles=[Select Id From Profile Where Name='System Administrator']; 
     
       
        
        Batch_UpdateEmailCollaboration bcb = new Batch_UpdateEmailCollaboration(bst,'Test@emai.com','editor');
        Database.BatchableContext BC;
        
        bcb.start(BC);
        Test.startTest();
        Batch_UpdateEmailCollaboration.updateCollaboration(clb,BAM.Box_Permission__c, testBox, OppList);
        Test.setMock(HttpCalloutMock.class, new TestFolderInfoMock());
        bcb.execute(BC,lstclb);
        bcb.finish(BC);
        
    }
}