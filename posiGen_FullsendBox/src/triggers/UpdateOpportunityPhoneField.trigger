trigger UpdateOpportunityPhoneField on Account (after insert, after update) {
  // Loop through all account updates in this trigger (there will generally be one)
  /*for(Account acct: Trigger.new) {
    List<Opportunity> oppList = [SELECT id, NVM_Phone__c FROM Opportunity WHERE Accountid = :acct.id AND NVM_Phone__c != :acct.Phone]; // Find all the opportunities for this account.
    for(integer i = 0 ; i < oppList.size(); i++){
      oppList[i].NVM_Phone__c = acct.Phone; // Update all opportunities with the new phone number.
    }
    update oppList;
  }*/
  
  Map<String,String> mapAccountPhone = new Map<String,String>();
  for(Account acc: Trigger.new) {
      mapAccountPhone.put(acc.id, acc.Phone);
  }
  
   // Find all the opportunities for this account.
  List<Opportunity> opps = [SELECT id, AccountId, NVM_Phone__c FROM Opportunity WHERE Accountid in: mapAccountPhone.keyset()];
  
  for(Opportunity opp : opps) {
      if (mapAccountPhone.containskey(opp.accountId)) {
          opp.NVM_Phone__c = mapAccountPhone.get(opp.AccountId);
      }
  }
  
  // 
  update opps;
    
}