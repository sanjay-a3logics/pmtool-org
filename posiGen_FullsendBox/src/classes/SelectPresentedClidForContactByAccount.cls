global class SelectPresentedClidForContactByAccount implements NVMContactWorld.ISelectPresentedClid{
     
    // The clickToDialResult parameter contains the response string from the Salesforce ClickToDial event.
    // Salesforce passes the clickToDialResult parameter to us:
    // for example '{number: "07890123456", objectId: "0032000001FTGSo", object: "Contact"}'
    // Find more information at: https://www.salesforce.com/us/developer/docs/api_cti/Content/sforce_api_cti_onclicktodial.htm
  
    global String GetPresentedClid(String clickToDialResult){
          
        Map<String,Object> clickToDialResultMap = (Map<String,Object>)JSON.deserializeUntyped(clickToDialResult);
        String contactId = (String)clickToDialResultMap.get('objectId');
          
        Contact c = [SELECT Id, AccountId FROM Contact WHERE Id = :contactId];
        Account a = [SELECT Id, ClickToDialPresentedClid__c FROM Account WHERE Id = :c.AccountId];
          
        String presentedClid = a.ClickToDialPresentedClid__c;
          
        return presentedClid;      
    }
}