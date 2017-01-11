@isTest
public class TestExplicitLogin { 
    static testMethod void myUnitTest1() { 
        Login_access__c mts = new Login_access__c();
        mts.EndPointUrl__c = 'test';
        mts.Password__c = 'test';
        mts.security_token__c = 'test';
        mts.Username__c = 'test';
        insert mts;
        
        ExplicitLogin fe = new ExplicitLogin();
        ExplicitLoginMock exMock = new ExplicitLoginMock();
        Test.StartTest(); 
        Test.setMock(HttpCalloutMock.class, exMock);
        ExplicitLogin.login();
        Test.stopTest();
    }
}