trigger LeadTrigger on Lead (before insert) {

    for(Lead l: Trigger.New){
        // logic to update created date time field based on lead source. 
        // web to lead requirement.
        if (l.Leadsource == 'Web' || l.Leadsource == 'Ambassador' || l.Leadsource == 'CT PPC' || l.Leadsource == 'NY PPC'  || l.Leadsource == 'LA PPC'  ) {
        //Web, Ambassador, CT PPC, NY PPC, and LA PPC
            l.created_date_time__c = System.now();
        }
    }
    
}