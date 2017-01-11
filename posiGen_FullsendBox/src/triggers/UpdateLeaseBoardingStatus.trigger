trigger UpdateLeaseBoardingStatus on Lease__c (before update, after insert) {
	for( Lease__c lease : trigger.new)
    {
        if(trigger.isInsert) 
        {
        	Opportunity relatedOpp = [SELECT Id,Lease_Boarding_Status__c FROM Opportunity WHERE Id = :lease.Opportunity__c LIMIT 1];
            relatedOpp.Lease_Boarding_Status__c = lease.Boarding_Status__c;
            
            try
            {
                update relatedOpp;
            }
            catch(DmlException e)
            {
                System.Debug(e.getCause());
            }
        }
        if (trigger.isUpdate) {
        //Lease__c oldLease = trigger.oldMap.get(lease.Id);
        //if (lease.Boarding_Status__c != null && oldLease.Boarding_Status__c == null) {
        
            Opportunity relatedOpp = [SELECT Id, Lease_Boarding_Status__c FROM Opportunity WHERE Id = :lease.Opportunity__c LIMIT 1];
            relatedOpp.Lease_Boarding_Status__c = lease.Boarding_Status__c;
            
            try
            {
            	update relatedOpp;    
            }
            catch(DmlException e)
            {
                System.Debug(e.getCause());
            }
       // }
        }
	}
}