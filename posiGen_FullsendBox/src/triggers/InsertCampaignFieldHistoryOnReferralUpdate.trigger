trigger InsertCampaignFieldHistoryOnReferralUpdate on Campaign (before update) {

	public static boolean firstRun = true;
    /* On update of a Referral or Referral Program Record Type Campaign, insert a Campaign Field History Record that copies the old version of the field and who made the change.
     */
    
    /* Map Id and Campaign, grabbing the old fields from the Campaign with the Trigger.oldMap.keySet() IN clause*/
    Map<Id,Campaign> oldCampaignFields = new Map<Id,Campaign>([SELECT Id, Name, SRT_Referee__c, Referrer__c, Opportunity_for_Single_Referral__c, Referrer__r.FirstName, Referrer__r.LastName 
                                                               FROM Campaign WHERE Id IN : Trigger.oldMap.keySet() AND RecordType.Name = 'Referral']);
    
    /* Holder of Campaign Field History records to be inserted. */
    List<Campaign_Field_History__c> cfhToInsert = new List<Campaign_Field_History__c>();
    
    RecordType referralRecordType = [SELECT Id, Name, sObjectType FROM RecordType WHERE Name = 'Referral' AND sObjectType = 'Campaign'];
    
    /* Loop that goes through each referral in Trigger.new */
    for (Campaign referral : Trigger.new) 
    {
		
        //System.debug(referral.Referrer__c);
        //System.debug(Trigger.oldMap.get(referral.Id).Referrer__c);
        //System.debug(referral.RecordTypeId);
		
        /* If the Referrer lookup field is not equal to the OldMap, then the field has changed. Go through rest of loop if the prior is true and RecordType is Referral (fields only apply to Referral) and the
		ReferralHelperMethod static variable firstRun is True (to prevent second firings due to Workflow Rules)*/
        if (referral.Referrer__c != Trigger.oldMap.get(referral.Id).Referrer__c && referral.RecordTypeId == referralRecordType.Id && firstRun) 
        {
            /* Create a new Campaign Field History record to hold the data about the change */
            Campaign_Field_History__c cfh = new Campaign_Field_History__c();
            System.debug(Trigger.oldMap.get(referral.Id).Referrer__c);
            System.debug(Trigger.oldMap.get(referral.Id).Referrer__r.FirstName);
            System.debug(oldCampaignFields.get(referral.Id).Referrer__r.FirstName);
            /* Add the values to the holder record */
            cfh.Field_Name__c = 'Referrer';
            cfh.Field_Value__c = oldCampaignFields.get(referral.Id).Referrer__r.FirstName + ' ' + oldCampaignFields.get(referral.Id).Referrer__r.LastName;
            cfh.Lookup_ID__c = Trigger.oldMap.get(referral.Id).Referrer__c;
            cfh.Campaign_Field_Modified_By__c = UserInfo.getUserId();
            cfh.Campaign__c = referral.Id;
            cfh.Name = 'Referrer changed';
            /* Add the record to the List created earlier to hold these records. */
            cfhToInsert.add(cfh);
            //System.debug(cfhToInsert);
        }
        if (referral.SRT_Referral_Amount__c != Trigger.oldMap.get(referral.Id).SRT_Referral_Amount__c && referral.RecordTypeId == referralRecordType.Id && ReferralHelperMethods.firstRun) 
        {
            /* Create a new Campaign Field History record to hold the data about the change */
            Campaign_Field_History__c cfh = new Campaign_Field_History__c();
            /* Add the values to the holder record */
            cfh.Field_Name__c = 'SRT Referral Amount';
            Decimal srtAmount = Trigger.oldMap.get(referral.Id).SRT_Referral_Amount__c; // Format Decimal value to String 
            cfh.Field_Value__c = srtAmount.format();
            cfh.Campaign_Field_Modified_By__c = UserInfo.getUserId();
            cfh.Campaign__c = referral.Id;
            cfh.Name = 'SRT Referral Amount changed';
            cfhToInsert.add(cfh);
        }
        ReferralHelperMethods.firstRun = false;
    }
    //System.debug(cfhToInsert);
    /* Check if the holder list of Campaign Field History Records has a size of greater than zero. If true, execute code below. */
    if (cfhToInsert.size() > 0) 
    {
        /* Insert the list of Campaign Field History records. */
        insert cfhToInsert;
    }

}