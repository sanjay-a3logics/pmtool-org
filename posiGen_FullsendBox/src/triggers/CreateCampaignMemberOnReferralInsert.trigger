trigger CreateCampaignMemberOnReferralInsert on Campaign (after insert) {
	List<Campaign> newReferral = [SELECT Id, Referrer__c, RecordTypeId, Opportunity_for_Single_Referral__r.Id, Opportunity_for_Single_Referral__r.Referree_Contact_Id__c FROM Campaign WHERE Id IN : Trigger.newMap.keySet()];
    Campaign referralHolder = newReferral[0];
    List<Opportunity> oppToUpdate = [SELECT Id, Referree_Contact_Id__c, Referrer__c, Referral__c
                                     FROM Opportunity WHERE Referral__c = null AND Id = : referralHolder.Opportunity_for_Single_Referral__c];
    //Map<Id, Opportunity> entries = new Map<Id, Opportunity>(
    //	[SELECT Id, Referree_Contact_Id__c, Referrer__c, Referral__c FROM Opportunity WHERE Referral__c = null AND Id = : newReferral]);
    //System.debug(oppToUpdate);
    System.debug(newReferral);
    List<CampaignMember> cmUpdateList = new List<CampaignMember>();

	RecordType referralRecordType = [SELECT Id FROM RecordType WHERE sObjectType = 'Campaign' AND Name = 'Referral'];    
    
    /*for (Opportunity o : oppToUpdate) 
    	{
			Campaign referralToUse = newReferral[0];
            o.Referral__c = referralToUse.Id;
            updateOppList.add(o);
    	}
	update updateOppList;*/
    
    for (Campaign referral : newReferral) 
    	{
            Integer oppCounter = 0;
            if (referral.RecordTypeId == referralRecordType.Id) {
                CampaignMember cm = new CampaignMember();
                //Opportunity o = oppToUpdate[oppCounter];
                cm.CampaignId = referral.Id;
                cm.Opportunity__c = referral.Opportunity_for_Single_Referral__r.Id;
                cm.ContactId = referral.Opportunity_for_Single_Referral__r.Referree_Contact_Id__c;
                System.debug(cm);
                cmUpdateList.add(cm);
            }
            oppCounter++;
    	}
    if (cmUpdateList.size() != 0){
    	insert cmUpdateList;
    }
}