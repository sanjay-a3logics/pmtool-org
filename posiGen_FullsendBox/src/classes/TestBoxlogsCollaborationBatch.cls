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
public class TestBoxlogsCollaborationBatch { 

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        List<Sub_folder__c> subList = new List<Sub_folder__c>();
        
        Account acc =new Account();
        acc.name = 'irfan khan';
        upsert acc;
        
        Contact con = new Contact(FirstName='Test1',LastName='State1',email='test2@test.com',AccountId=acc.id);
        upsert con;
        
        
         Profile profiles=[Select Id From Profile Where Name='System Administrator']; 
     
        String orgId = UserInfo.getOrganizationId(); 
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-',''); 
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000)); 
        String uniqueName = orgId + dateString + randomInt; 
        
        Trigger_Setting__c ts = new Trigger_Setting__c(User_Trigger__c =true);
        insert ts; 
         
        User u = new User(); 
        u.Username =  uniqueName + '@test' + orgId + '.org'; 
        u.ProfileId = profiles.Id; 
        u.LastName = 'test'; 
        u.Alias = 'test1'; 
        u.Email =  uniqueName + '@test' + orgId + '.org'; 
        u.TimeZoneSidKey = 'America/Los_Angeles'; 
        u.localesidkey='en_US'; 
        u.emailencodingkey='UTF-8'; 
        u.languagelocalekey='en_US'; 
        insert u; 
        
        List<String>lstemail= new List<String>();
        lstemail.add(u.email);
        Map<String,String>Usmap = new Map<String,String>();
        Usmap.put(u.email,u.profileId);
        
        
       
       Set<String> opset = new Set<String>();  
        Deal__c opp = new Deal__c();
        //opp.name = 'Test opp';
        opp.Account__c = acc.id;
        opp.CloseDate__c = date.today();
        opp.stageName__c = 'Closed Won';
        upsert opp;
        opset.add(opp.id);				
        
        Deal__c op =[Select id, Opp_Pipeline_Stage__c from Deal__c where stageName__c='Closed Won' and id=:opp.id];
        
        
      //  System.assert(false,[select id,stageName From Deal__c where id=:opp.id]);             
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        upsert testBox;
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Funding-Vendor';
        sf.cf_Deal__c = op.id;
        sf.cf_box_folder_id__c = '11446498';   			
        upsert sf;
       
        Sub_folder__c sflst =[Select id,cf_box_folder_id__c,cf_Deal__c,name, cf_Deal__r.Opp_Pipeline_Stage__c from Sub_folder__c where id=:sf.id];
        
        subList.add(sflst);
        Set<String> fldsubList = new Set<String>();
        fldsubList.add(sf.cf_box_folder_id__c);
       
        Profile prf= [select id,Name From Profile Where Name='EE Partner User'];
        
        BoxAccessMatrix_SubFolder__c bams = new BoxAccessMatrix_SubFolder__c();
        bams.SubFolder_Name__c='Funding-Vendor';
        bams.Name='Funding-Vendor';
        upsert bams;
        
        BoxAccessMatrix_Profile__c bamp = new BoxAccessMatrix_Profile__c();
        bamp.BoxAccessMatrix_SubFolder__c=bams.id;
        bamp.Profile_Id__c=prf.id;
        bamp.Profile_Name__c='EE Partner User';
        bamp.Lookup_field_Name__c='Subcontractor__c';
        upsert bamp;
        
        BoxAccessMatrix_Stage__c BAM = new BoxAccessMatrix_Stage__c();
        BAM.Box_Permission__c='Viewer';
        BAM.BoxAccessMatrix_Profile__c=bamp.id;
        BAM.Stage__c=op.Opp_Pipeline_Stage__c;			
        BAM.check__c=true;
        upsert BAM;
        
        BoxAccessMatrix_Stage__c BAMl = [Select BoxAccessMatrix_Profile__r.Profile_Id__c ,Box_Permission__c from BoxAccessMatrix_Stage__c  where id=:BAM.id];
        Map<String,String>promap = new Map<String,String>();
        promap.put(BAMl.BoxAccessMatrix_Profile__r.Profile_Id__c,BAMl.Box_Permission__c);
        
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
        Collaboration__c clb = new Collaboration__c(BoxCollaboration_Id__c='123456',BoxFolder_Id__c='34567',BoxGroup_Id__c=bg.BoxGroup_Id__c,Role__c='Viewer');
        upsert clb;
        
        BoxlogsCollaborationBatch bcb = new BoxlogsCollaborationBatch('Sales',lstemail,fldsubList);
        Database.BatchableContext BC;
        
        bcb.start(BC);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
        bcb.execute(bc,subList);
        BoxlogsCollaborationBatch.CreateLookupUserCollaboration(lstemail,sf,Usmap,promap,lstclb,OppList);
        Test.stopTest();         
  }
 }