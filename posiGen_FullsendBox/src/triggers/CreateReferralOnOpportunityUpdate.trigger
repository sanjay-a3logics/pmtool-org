trigger CreateReferralOnOpportunityUpdate on Opportunity (before update) {
    /* Create referral */   
    
    if(UtilityController.CreateReferralrecursive){
        UtilityController.CreateReferralrecursive = false;
        List<Opportunity> opportunityNeedingReferral = [SELECT Id, Referrer__c, Referrer__r.FirstName, AccountId, Name, LeadSource, Account.Name,
                                                        Referrer__r.LastName, Referral__c, Referral_Type__c, Referree_Contact_Id__c, Account.Referring_Customer__c
                                                        FROM Opportunity WHERE Id IN : Trigger.new];
        
        System.debug(opportunityNeedingReferral);
        
        RecordType referralRecordType = [SELECT Id FROM RecordType WHERE sObjectType = 'Campaign' AND Name = 'Referral'];
        RecordType referralProgramRecordType = [SELECT Id FROM RecordType WHERE sObjectType = 'Campaign' AND Name = 'Referral Programs'];
        List<Campaign> lTemp = [SELECT Id, RecordTypeId FROM Campaign WHERE RecordTypeId = :referralProgramRecordType.Id AND Allows_For_Multiple_Members__c = FALSE AND IsActive = TRUE];
        if(lTemp.size()==0)
            return;
        Campaign SingleReferralProgramToUse = lTemp[0];
        
        List<Campaign> newReferrals = new List<Campaign>();
        
        List<Opportunity> updateOppList = new List<Opportunity>();
        
        for (Opportunity o : Trigger.new) 
        {
            if (o.Referrer__c != null && o.Referral__c == null && o.LeadSource == 'Referral' && SingleReferralProgramToUse != null && o.Referral_Type__c == 'Single')
            {
                Campaign referral = new Campaign();
                //String name = o.Name + ' from ' + o.Referrer__r.FirstName + ' ' + o.Referrer__r.LastName;
                referral.Name = 'Temporary Name';
                referral.ParentId = SingleReferralProgramToUse.Id;
                referral.RecordTypeId = referralRecordType.Id;
                referral.IsActive = TRUE;
                referral.Referrer__c = o.Referrer__c;
                referral.Opportunity_for_Single_Referral__c = o.Id;
                referral.Type = 'Referral';
                referral.SRT_Referee__c = o.AccountId;
                newReferrals.add(referral);
               // o.Referral__c = referral.Id;
               // System.debug(o.Referral__c);
                
            }
            
        }
        //Campaign referral = newReferrals[0];  
        if (newReferrals.size() != 0) {
            insert newReferrals;
            System.debug(newReferrals);
        }
            
         if (newReferrals.size() != 0) {
        for (Opportunity o : Trigger.new) 
        {
            Campaign referral = newReferrals[0];
            o.Referral__c = referral.Id;
            o.CampaignId = referral.Id;
        }
         }
    }
        
        //newReferrals = [SELECT Id FROM Campaign WHERE Referrer__c IN (SELECT Referrer__c FROM Opportunity)];
        
   
        /*opportunityNeedingReferral = [SELECT Id, Referrer__c, Referrer__r.FirstName, Referrer__r.LastName, ReferralProgramToCreateReferralUnder__c, Referral__c, 
         * Referree_Contact_Id__c FROM Opportunity WHERE Id IN : Trigger.newMap.keySet()];
        Opportunity thisOpp = opportunityNeedingReferral[0];
        thisOpp.Referral__c = referral.Id;
        System.debug(thisOpp.Referral__c); */
        //update thisOpp;
        
    

        /*Campaign referralToUse = newReferrals[0];
        
        for (Opportunity o : opportunityNeedingReferral) 
        {
            o.Referral__c = referralToUse.Id;
        }
        
    */
    
        
        
        /* Update opportunity */
        
        /* Create Campaign Member */
    /*
        for (Opportunity o : opportunityNeedingReferral)
        {
            if (o.Referrer__c != null && o.ReferralProgramToCreateReferralUnder__c != null && o.Referral__c == null)
            {
                o.Referral__c = referralToUse.Id;
                CampaignMember cm = new CampaignMember();
                cm.ContactId = o.Referree_Contact_Id__c;
                cm.Opportunity__c = o.Id;
                cm.CampaignId = referralToUse.Id;
             
                cmToInsert.add(cm);
                
                
            }
        }
        insert cmToInsert;

*/

}