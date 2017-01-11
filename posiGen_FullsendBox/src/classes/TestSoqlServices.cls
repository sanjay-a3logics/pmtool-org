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
private class TestSoqlServices {

    static testMethod void myUnitTest() {
        
        Set<Id> OppIds = new Set<Id>();
            for(Integer i=0; i<2; i++){
                
                Account acc =new Account();
                acc.name = 'irfan khan';
                insert acc;
            
                Deal__c opp = new Deal__c();
                //opp.name = 'Test opp'+i;
                opp.Account__c = acc.id;
                opp.CloseDate__c = date.today();
                opp.stageName__c = 'Closed won';
                insert opp;
                
                OppIds.add(opp.id);
            }
        List<String> acclst = New List<String>(); 
        Account acc1 =new Account();
        acc1.name = 'irfan khan';
        insert acc1;
        acclst.add(acc1.id);
        
        contact con =  new contact(Firstname = 'Test',LastName='New',email ='abc@test.com',AccountId = acc1.id);
        insert con;
    
        Deal__c opp1 = new Deal__c();
        //opp1.name = 'Test opp';  
        opp1.Account__c = acc1.id;
        opp1.CloseDate__c = date.today();
        opp1.stageName__c = 'Closed won';
        insert opp1;
        Sub_Folder__c sc= new Sub_Folder__c(Name='test',CF_Deal__c=opp1.id);
        insert sc;
        dsfs__DocuSign_Status__c ds1 = new dsfs__DocuSign_Status__c();
        ds1.Deal__c = opp1.id;
        ds1.dsfs__Subject__c ='dfdsvd';
        ds1.dsfs__Company__c =acc1.id;
        insert ds1;
        
       Set<Id> attSet = new Set<Id>();
        Attachment att = new Attachment();
        att.name = 'test.pdf';
        att.body = Blob.valueOf('safdsf fdsf sdfsd fdsoyfdso fds fsdyf dsfy sdifidsfy sif');
        att.parentId = ds1.id;
        insert att;
        attSet.add(att.id);
        
        SoqlServices.getOpportunityList(OppIds);
        SoqlServices.getOpportunityById(opp1.id);
        SoqlServices.getChildFolders(opp1.id);
        SoqlServices.getAttachment(opp1.id);
        SoqlServices.getDocusignStatusList(opp1.id);
        SoqlServices.getCustomAttachmentsList(opp1.id);
        SoqlServices.getCollobration('123456',opp1.id);
        SoqlServices.getsubfolder('656546','Opportunity');  
        SoqlServices.getsubfolder(opp1.id,'test');
        SoqlServices.getDocusignStatus(ds1.id);
        SoqlServices.getAttachmentListBySet(attSet);
        SoqlServices.getContactList(con.id);
        SoqlServices.getAccountContList(acclst);        


        //SoqlServices.getsubfolder('123456','Attachment__c');



        
                
    }
}