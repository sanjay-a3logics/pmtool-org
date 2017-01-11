@isTest
public class TestFormulaExecuter { 
    static testMethod void myUnitTest1() { 
        FormulaExecuter fe = new FormulaExecuter();
        String toEval = 'if((2/2)==1){return 1;}else{return 2;}';
        FormulaExecuterMock fexMock = new FormulaExecuterMock();
        Test.StartTest(); 
        Test.setMock(HttpCalloutMock.class, fexMock);
        FormulaExecuter.evalInteger(toEval,UserInfo.getSessionId());
        Test.stopTest();
    }
}