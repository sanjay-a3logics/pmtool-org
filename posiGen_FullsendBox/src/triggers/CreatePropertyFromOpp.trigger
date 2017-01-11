trigger CreatePropertyFromOpp on Opportunity (after insert) 
{
    for(Opportunity opp: trigger.new )
    {
        if(opp.Lead_Numeric_ID_Text__c != null)
        {
            CallSuscoWebService.createPropertyFromOpportunity(opp.Id);
        }
        else
        {
            throw new InvalidFieldValueException('Lead Numeric Id: ' + opp.Lead_Numeric_ID__c);
        }
    }
}