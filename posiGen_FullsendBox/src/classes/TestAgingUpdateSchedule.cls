@isTest
public with sharing class TestAgingUpdateSchedule {
  public static testMethod void myUnitTest1() {   
      SchedulableContext SC;
      AgingUpdateSchedule obj = new AgingUpdateSchedule();
      obj.execute(SC);
      
  }
}