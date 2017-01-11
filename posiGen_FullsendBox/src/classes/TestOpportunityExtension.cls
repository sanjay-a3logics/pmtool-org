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
private class TestOpportunityExtension {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        
        Account acc =new Account();
        acc.name = 'irfan khan';
        insert acc;
        
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed won';
        insert opp;
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Sales';
        sf.CF_Box_Folder_Id__c = '234873284632';
        sf.CF_Opportunity__c = opp.id;
        
        ApexPages.StandardController controller = new ApexPages.StandardController(opp);
        
        OpportunityExtension oe = new OpportunityExtension(controller);
        oe.ShareWithUser();
        oe.getDetails();
        
    }
}