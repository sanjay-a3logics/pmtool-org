trigger UpdateLeadCountInMunicipality on Lead (after update ) 
{
    
    integer leadCountOnMunicipality = [SELECT COUNT() FROM Lead WHERE Municipality__r.Id IN :Trigger.newMap.keySet()];
    List<Account> municipalitiesToUpdate = new List<Account>{};   
    
        
    
}

/*
 * for(Lead leadObj : Trigger.new )
    {
        //get Record ID of related Object
        if(leadObj.Municipality__c != null)
        {
            string relatedMunicipalityID = IdConversionHelper.ID15to18(leadObj.Municipality__c);
            
            //query for count of all(Perhaps not? Unaware of any enforced limits to size of query result) records that meet the necessary criteria
            integer leadCount = [SELECT COUNT() FROM Lead WHERE Municipality__r.id = :relatedMunicipalityID];
            
            //Query for record that contains the field that will store the rollup value and assign querry result to relevant sObject type (Account in this case) 
            Account municipalityAccount = [SELECT Name, Leads_In_County__c From Account Where id = :relatedMunicipalityId ];
            
            //Perform operation and assign to field
            municipalityAccount.Leads_In_County__c = leadCount;
            
            //Use dml statement to update record
            try
            {
                update municipalityAccount;
            }
            catch(DmlException e)
            {
                System.debug(e);
            }
        }
        
    }*/