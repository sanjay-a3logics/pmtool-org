@isTest
public class TestScheduler_class1{
    public static testMethod void testschedule(){ 
        Test.StartTest();
        Scheduler_class1 sh1 = new Scheduler_class1('EE','Closed Won','23456');
        String sch = '0 0 23 * * ?'; system.schedule('Test Territory Check', sch, sh1);
        Test.stopTest(); 
    }
}