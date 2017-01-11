@isTest
public class TestrefreshTokenScheduler{

   public static String CRON_EXP = '0 45 0 15 3 ? 2022';

 
  public static testmethod void TestrefreshTokenScheduler() {
       
       
       Box__c testBox = new Box__c ();
           testBox.name = 'BoxANGBVNn';
           testBox.BoxAccess_Token__c='sdgagfsgdgs2351254';
           testBox.Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324';
           testBox.Boxclient_Id__c ='12334asd';
           testBox.Boxclient_Secret__c='dsgzdfagadfh';
        insert testBox;
        
         refreshTokenScheduler  rf = new refreshTokenScheduler();
         SchedulableContext SC;
        
         Test.startTest(); 
         
         Test.setMock(HttpCalloutMock.class, new BoxApiController_mock()); 
         rf.execute(SC);
        Test.stopTest();
 
  
   }
}