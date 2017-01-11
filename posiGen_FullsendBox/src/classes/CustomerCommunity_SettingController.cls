public class CustomerCommunity_SettingController {

    public Customer_Portal_Global_Setting__c globalSetting { get; set; }
    public String howToSaveMore { get; set; }
    public Boolean standardUser { get; set; }

    public pageReference redirectToMySavings() {
        return new PageReference((standardUser?'/apex':'') + '/CustomerCommunity_MySavings');
    }
    
    public CustomerCommunity_SettingController() {
        standardUser = (UserInfo.getUserType() == 'Standard');
        globalSetting = [SELECT How_To_Save_More__c FROM Customer_Portal_Global_Setting__c LIMIT 1];
        howToSaveMore = globalSetting.How_To_Save_More__c;
    }
    
}