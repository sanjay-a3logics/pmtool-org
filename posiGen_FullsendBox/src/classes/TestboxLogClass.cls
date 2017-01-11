@isTest
public class TestboxLogClass{
  public static testMethod void test1(){
        List<Box_error__c>bxerlst = new List<Box_error__c>();
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
         								
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Funding-Vendor';
        sf.cf_Deal__c = opp.id;
        sf.cf_box_folder_id__c = '11446498';
        upsert sf;
     
        Box_error__c be = new Box_error__c(Name='401',Useremail__c='test@appcino.com',Sub_folder__c=sf.id,Type__c='Check');
        insert be; 
        
        BoxAccessMatrix_subfolder__c bsub = new BoxAccessMatrix_subfolder__c(Subfolder_Name__c ='Sales');
        insert bsub;
        
        bxerlst.add(be);
        boxLogClass blc= new boxLogClass();
        blc.createUserCollaboratoion(bxerlst);
  
  
   }

}