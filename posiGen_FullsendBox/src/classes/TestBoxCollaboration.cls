@isTest(seeAllData=False)
public class TestBoxCollaboration{ 
    static testMethod void myUnitTest() {
         // TO DO: implement unit test
         List<Sub_folder__c> subList = new List<Sub_folder__c>();
         Set<String> emailSet = new Set<String>();
        
        
        Account acc =new Account();
        acc.name = 'irfan khan';
        insert acc;
        
        Contact con = new Contact(FirstName='Test1',LastName='State1',email='clone@abc.com',AccountId=acc.id);
        insert con;
       
        emailSet.add(con.email);
        
        Deal__c opp = new Deal__c();
        //opp.name = 'Test opp';							
        opp.Account__c = acc.id;
        opp.CloseDate__c = date.today();
        opp.stageName__c = 'Closed Won';
        insert opp;  			
       
       Deal__c oppr =[Select id, Opp_Pipeline_Stage__c from Deal__c where stageName__c='Closed Won' and id=:opp.id];
        
                 
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        insert testBox;
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Application';
        sf.cf_Deal__c = oppr.id;
        sf.cf_box_folder_id__c = '1144649867';
        insert sf;
        subList.add(sf);
        
        List<String> fldsubList = new List<String>();
        fldsubList.add(sf.cf_box_folder_id__c);
       
        Profile prf= [select id,Name From Profile Where Name='Project Manager'];
        
       
        
        List<box_log__c > OppList = new List<box_log__c >();
        box_log__c bxerr = new box_log__c(Deal__c = opp.id,Reference__c='abcd',Status__c = 'Success',Sub_Folder__c = sf.id,Type__c ='Create Collaboration');
        insert  bxerr ;
        OppList.add(bxerr); 
        
        List<Collaboration__c> lstclb = new List<Collaboration__c>();
        Set<Collaboration__c> Setclb = new Set<Collaboration__c>();
        Collaboration__c clb = new Collaboration__c(BoxCollaboration_Id__c='123456',BoxFolder_Id__c=sf.cf_box_folder_id__c,BoxGroup_Id__c='',Sub_folder__c = sf.id,Role__c='Uploader');
        insert clb;
        Setclb.add(clb);
        
       
       
        
        BoxCollaboration bcb = new BoxCollaboration();
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestFileUploadMock4());
        BoxCollaboration.createCollaboration('abcd',prf.id,'Uploader',sf.cf_box_folder_id__c,emailSet,sf.id,opp.id,OppList,lstclb);
        BoxCollaboration.deleteCollaboration('abcd',opp.id,sf.id,Setclb, OppList,lstclb);
        
        Test.StopTest();
        
       
        
       
        
        
    }
    static testMethod void myUnitTest2() {
         // TO DO: implement unit test
         List<Sub_folder__c> subList = new List<Sub_folder__c>();
         Set<String> emailSet = new Set<String>();
        
        
        Account acc =new Account();
        acc.name = 'irfan khan';
        insert acc;
        
        Contact con = new Contact(FirstName='Test1',LastName='State1',email='clone@abc.com',AccountId=acc.id);
        insert con;
       
        emailSet.add(con.email);
        
        Deal__c opp = new Deal__c();
        //opp.name = 'Test opp';
        opp.Account__c = acc.id;
        opp.CloseDate__c = date.today();  
        opp.stageName__c = 'Closed Won';
        insert opp;
       
       Deal__c oppr =[Select id, Opp_Pipeline_Stage__c from Deal__c where stageName__c='Closed Won' and id=:opp.id];
        
                 
        Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
        insert testBox;
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Application';
        sf.cf_Deal__c = oppr.id;
        sf.cf_box_folder_id__c = '1144649867';
        insert sf;
        subList.add(sf);
        
        List<String> fldsubList = new List<String>();
        fldsubList.add(sf.cf_box_folder_id__c);
       
        Profile prf= [select id,Name From Profile Where Name='Project Manager'];
        
       
        
        List<box_log__c > OppList = new List<box_log__c >();
        box_log__c bxerr = new box_log__c(Deal__c = opp.id,Reference__c='abcd',Status__c = 'Success',Sub_Folder__c = sf.id,Type__c ='Create Collaboration');
        insert  bxerr ;
        OppList.add(bxerr); 
        
        List<Collaboration__c> lstclb = new List<Collaboration__c>();
        Set<Collaboration__c> Setclb = new Set<Collaboration__c>();
        Collaboration__c clb = new Collaboration__c(BoxCollaboration_Id__c='123456',BoxFolder_Id__c=sf.cf_box_folder_id__c,BoxGroup_Id__c='',Sub_folder__c = sf.id,Role__c='Uploader');
        insert clb;
        Setclb.add(clb);
        
       
       
        
        BoxCollaboration bcb = new BoxCollaboration();
        
        Test.startTest();
        
        BoxCollaboration.createCollaboration('abcd',prf.id,'Uploader',sf.cf_box_folder_id__c,emailSet,sf.id,opp.id,OppList,lstclb);
        BoxCollaboration.deleteCollaboration('abcd',opp.id,sf.id,Setclb, OppList,lstclb);
        Test.setMock(HttpCalloutMock.class, new TestFileUploadMock4());
        Test.StopTest();
        
       
         
    }
   
   
  }