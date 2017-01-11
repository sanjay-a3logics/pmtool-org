trigger UpdateIntacctEntityFromAcctState on Opportunity (before update) {
  
    /*
     * Create List for updating Opportunities.
     */ 
    List<Opportunity> oppToUpdate = new List<Opportunity>();
    
    /*
     * Grab each of the Intacct Entities.
     */ 
    
    List<Intacct_Entity__c> lEntityLouisiana = [SELECT Id, Name FROM Intacct_Entity__c WHERE Name = 'PG of LA' LIMIT 1];
    List<Intacct_Entity__c> lEntityConnecticut = [SELECT Id, Name FROM Intacct_Entity__c WHERE Name = 'PG of CT' LIMIT 1];
    List<Intacct_Entity__c> lEntityNewYork = [SELECT Id, Name FROM Intacct_Entity__c WHERE Name = 'PG of NY' LIMIT 1];
    List<Intacct_Entity__c> lEntityPGSupport = [SELECT Id, Name FROM Intacct_Entity__c WHERE Name = 'PG Support' LIMIT 1];
        
    Id oLouisianaId = (lEntityLouisiana.size() > 0) ? lEntityLouisiana[0].Id : null;
    Id oConnecticutId = (lEntityConnecticut.size() > 0) ? lEntityConnecticut[0].Id : null;
    Id oNewYorkId = (lEntityNewYork.size() > 0) ? lEntityNewYork[0].Id : null;
    Id oPGSupportId = (lEntityPGSupport.size() > 0) ? lEntityPGSupport[0].Id : null;
	
    /*
     *  Grab the RecordTypeId of the Sunrise Opportunity Record Type.
     */ 
    
    List<RecordType> lOppSunriseRecordType = [SELECT Id, Name FROM RecordType WHERE Name = 'Sunrise' AND SobjectType = 'Opportunity' LIMIT 1];
    
    Id oSunriseRTId = (lOppSunriseRecordType.size() > 0) ? lOppSunriseRecordType[0].Id : null;
    
    /*
     *  Loop through the Opps in Trigger.new, checking to see if Account State exists, passing the Opportunity if it does not.
     */ 
   
    for (Opportunity o : Trigger.new)
    {	
        if(o.Account_State__c != null)
        {
            if(o.Account_State__c == 'Louisiana')
            {
                o.Intacct_Entity__c = oLouisianaId;
                oppToUpdate.add(o);
            }
            else if (o.Account_State__c == 'Connecticut')
            {
                o.Intacct_Entity__c = oConnecticutId;
                oppToUpdate.add(o);
            }
            else if (o.Account_State__c == 'New York' && o.RecordTypeId == oSunriseRTId)
            {
                o.Intacct_Entity__c = oPGSupportId;
                oppToUpdate.add(o);
            }
            else if (o.Account_State__c == 'New York') 
            {
                o.Intacct_Entity__c = oNewYorkId;
                oppToUpdate.add(o);
            }
        }
    }
}