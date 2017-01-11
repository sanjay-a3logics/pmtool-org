@isTest
public class TestUserTriggerHandler {
    static testMethod void myUnitTest() {
        Profile profiles=[Select Id From Profile Where Name='System Administrator']; 
     
        String orgId = UserInfo.getOrganizationId(); 
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-',''); 
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000)); 
        String uniqueName = orgId + dateString + randomInt; 
        
        Trigger_Setting__c ts = new Trigger_Setting__c(User_Trigger__c =true);
        insert ts; 
         
        User u = new User(); 
        u.Username =  uniqueName + '@test' + orgId + '.org'; 
        u.ProfileId = profiles.Id; 
        u.LastName = 'test'; 
        u.Alias = 'test1'; 
        u.Email =  uniqueName + '@test' + orgId + '.org'; 
        u.TimeZoneSidKey = 'America/Los_Angeles'; 
        u.localesidkey='en_US'; 
        u.emailencodingkey='UTF-8'; 
        u.languagelocalekey='en_US'; 
        insert u; 
        
        u.LastName = 'testingLastName';
        update u;
        
        UserTriggerHandler ut = new UserTriggerHandler();
        ut.bulkBefore();
        ut.beforeInsert();
        ut.beforeUpdate();
        ut.beforeDelete();
        ut.afterDelete();
        ut.afterUnDelete();
        
    }
}