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
private class Test_Lead {

    static testMethod void leadTest() {
        test.startTest();
          StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('mockDocumentResponse');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'text/xml');
        
        // Set the mock callout mode
        Test.setMock(HttpCalloutMock.class, mock);
        
        
        Lead l = new Lead();
        l.Status = 'Open';
        l.Company = 'Test Company';
        l.Firstname = 'first';
        l.LastName = 'Tester';
        l.Street = '1245 A Street';
        l.City = 'San Francisco';
        l.State = 'California';
        l.PostalCode = '94123';
        l.Country = 'United States';
        
        l.SNSolutionID__c = '5254';
        l.SNProjectID__c = '19151';
        l.SolarNexus_Proposal_Fetched__c = false;
        insert l;
        
        l.SolarNexus_Proposal_Fetched__c = true;
        update l;
       test.stopTest();
    }
    
        static testMethod void leadTestError() {
      test.startTest();
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('mockDocumentResponse');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'text/xml');
        
        // Set the mock callout mode
        Test.setMock(HttpCalloutMock.class, mock);
        
        
        Lead l = new Lead();
        l.Status = 'Open';
        l.Company = 'Test Company';
        l.Firstname = 'first';
        l.LastName = 'Tester';
        l.Street = '1245 A Street';
        l.City = 'San Francisco';
        l.State = 'California';
        l.PostalCode = '94123';
        l.Country = 'United States';
        
        l.SNSolutionID__c = '';
        l.SNProjectID__c = '19151';
        l.SolarNexus_Proposal_Fetched__c = false;
        insert l;
       
        l.SolarNexus_Proposal_Fetched__c = true;
        update l;
       test.stopTest();
    }
    
       static testMethod void additionalCoverage() {
        test.startTest();
           List<String> aList = new List<String>();
          aList.add('one');
          aList.add('two');
          aList.add('three');
          
          TriggerUtil.containsList(aList, 'one');
          TriggerUtil.containsList(aList, 'a');
          TriggerUtil.containsList(null, null);
          
          TriggerUtil.getListIndex(aList, 'one');
          TriggerUtil.getListIndex(aList, 'a');
          TriggerUtil.getListIndex(null, null);
          
          TriggerUtil.coverageMethod();
           test.stopTest();
       }
}