@isTest
public class TestBoxCreateCollaborationsFromErrorLogs{
    public static testMethod void testschedule(){ 
        Test.StartTest();
        BoxCreateCollaborationsFromErrorLogs sh1 = new BoxCreateCollaborationsFromErrorLogs();
        String sch = '0 0 23 * * ?'; system.schedule('Test Territory Check', sch, sh1);
        Test.stopTest(); 
    }
}