@isTest
public class TestBoxApiServicesController{
    
      public static testmethod void Testmethod3(){
        Set<Id> OppIds = new Set<Id>();
        List<Sub_folder__c> sflist = new List<Sub_folder__c>();
        List<Box_Log__c> bxList = new List<Box_Log__c>();
        Profile profiles=[Select Id From Profile Where Name='System Administrator']; 
       
        Account acc =new Account(name = 'Ankit Gupta');
        insert acc;
        
        Deal__c opp = new Deal__c(Account__c = acc.id,CloseDate__c = date.today(),stageName__c = 'Closed won',O_box_folder_id__c='2345678');
        insert opp;
        			
        OppIds.add(opp.id); 
        Deal__c op =[Select id, Opp_Pipeline_Stage__c,ownerId from Deal__c where stageName__c='Closed Won' and id=:opp.id]; 
          
        String orgId = UserInfo.getOrganizationId(); 
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-',''); 
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000)); 
        String uniqueName = orgId + dateString + randomInt; 
        
         
         
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
        
        
        Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Deal__c=opp.id,Name='sales');
        insert sc;
        
        box_log__c bxerr = new box_log__c(Deal__c = opp.id,Status__c = 'Success',Sub_Folder__c = sc.id,Type__c ='Create Collaboration');
        insert  bxerr ;
        
        
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        insert testBox;
        
        BoxAPIServicesController boxapi = new BoxAPIServicesController();
        boxapi.accData();
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new BoxApiController_mock());		
        BoxAPIServicesController.changeOpportunityOwner(opp.id,u.id,op.Opp_Pipeline_Stage__c,op.ownerId);
        
        Test.stopTest();
            
               
      } 
       public static testmethod void Testmethod4(){
        Set<Id> OppIds = new Set<Id>();
        List<Sub_folder__c> sflist = new List<Sub_folder__c>();
        List<Box_Log__c> brlst = new List<Box_Log__c>();
       
        Account acc =new Account(name = 'Ankit Gupta');
        insert acc;
        
        Profile pf =[Select id from profile where Name ='System administrator'];
        
        Deal__c opp = new Deal__c(Account__c = acc.id,CloseDate__c = date.today(),stageName__c = 'Closed won',O_box_folder_id__c='2345678');
        insert opp;
        									
        OppIds.add(opp.id); 
        
        Deal__c op =[Select id,Name, Opp_Pipeline_Stage__c from Deal__c where stageName__c='Closed Won' and id=:opp.id];
        
        Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Deal__c=opp.id,Name='Sales');
        insert sc;
        
        Sub_Folder__c sc1= new Sub_Folder__c(CF_Box_Folder_Id__c='890386',CF_Deal__c=opp.id,Name='Application');
        insert sc1;
        
        Sub_Folder__c sc2= new Sub_Folder__c(CF_Box_Folder_Id__c='890387',CF_Deal__c=opp.id,Name='Funding-Vendor');
        insert sc2;
        
        Sub_Folder__c sc3= new Sub_Folder__c(CF_Box_Folder_Id__c='890388',CF_Deal__c=opp.id,Name='EE');
        insert sc3;
        
        box_log__c bxerr = new box_log__c(Deal__c = opp.id,Status__c = 'Success',Sub_Folder__c = sc.id,Type__c ='Create Collaboration');
        insert  bxerr ;
        
        brlst.add(bxerr);
        
        
        BoxAccessMatrix_SubFolder__c bams = new BoxAccessMatrix_SubFolder__c();
        bams.SubFolder_Name__c='Sales';
        bams.Name='Sales';
        upsert bams;
        
        BoxAccessMatrix_Profile__c bamp = new BoxAccessMatrix_Profile__c();
        bamp.BoxAccessMatrix_SubFolder__c=bams.id;
        bamp.Profile_Id__c=pf.id;
        bamp.Profile_Name__c='System Administrator';
        //bamp.Lookup_field_Name__c='Concierge__c';
        upsert bamp;
        
        BoxAccessMatrix_Stage__c BAM = new BoxAccessMatrix_Stage__c();
        BAM.Box_Permission__c='Viewer';
        BAM.BoxAccessMatrix_Profile__c=bamp.id;
        BAM.Stage__c=op.Opp_Pipeline_Stage__c;
        BAM.check__c=true;
        upsert BAM;
        
       
        
        Box_Group__c bg = new Box_Group__c();
        bg.BoxGroup_Id__c='34087847';
        bg.BoxGroup_Name__c='test box grop';
        bg.SF_Profile_Id__c=pf.id;
        insert bg;
        
        List<Collaboration__c> lstclb = new List<Collaboration__c>();
        Collaboration__c clb = new Collaboration__c(BoxCollaboration_Id__c='123456',BoxFolder_Id__c='34567',BoxGroup_Id__c=bg.BoxGroup_Id__c,Role__c='Editor');
        upsert clb;
       
        List<String> cnLst = new List<String>(); 
        Contact con = new Contact(FirstName='Test1',LastName='State1',email='test2@test.com',AccountId=acc.id);
        insert con;
        
        cnlst.add(con.email);
        Set<String> cnSet = new Set<String>(cnLst);
        
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        insert testBox;
        
        BoxAPIServicesController boxapi = new BoxAPIServicesController();
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestFileUploadMock4());
        BoxAPIServicesController.CreateFolder(OppIds);
       // BoxAPIServicesController.createSubFolder('EE',sc.CF_Box_Folder_Id__c,op.Name,op.id,testBox,sflist,brlst);
        BoxAPIServicesController.deleteContactCollaborationOnStageChange(pf.id,sc.CF_Box_Folder_Id__c,opp.id,sc.id); 
        BoxAPIServicesController.createcollaborationOnFolder(String.valueOf(pf.id),'Editor',sc.CF_Box_Folder_Id__c,cnSet,String.valueOf(opp.id),String.valueOf(sc.id));
        BoxAPIServicesController.createOpportunityFolder(opp.name, testBox);
        Test.stopTest();
        
               
      }   
          
}