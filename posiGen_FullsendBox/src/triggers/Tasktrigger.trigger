trigger Tasktrigger on Task (after insert, after update) {
    
    Set<String> leadIds = new Set<String>();
    for (Task t : trigger.new) {
        // only in case of leads.
        if (t.whoId != null && string.valueOf(t.whoId).startswith('00Q')) {
            String subject = t.subject.tolowercase();
            if (t.Status == 'Completed' && t.subject != null && subject.contains('call')) {
                leadIds.add(t.whoId);
            }
        }
    }
    Map<id,Integer> leadtoTaskCount = new Map<Id,integer>();
    
    for( Task task : [select id,whoId,subject from task where whoId in: leadIds and whoid != null and Status = 'Completed']){
            
            if(leadtoTaskCount.ContainsKey(task.whoId)){
                Integer count = leadtoTaskCount.get(task.whoId);
                count = count +1;
                leadtoTaskCount.put(task.whoId,count);
            }else{
                leadtoTaskCount.put(task.whoId,1);
            }
        
    }
    
    
    List<Lead> leadstoUpdate = new List<Lead>();
    for (Task t : trigger.new) {
        // only in case of leads.
        if (t.whoId != null && string.valueOf(t.whoId).startswith('00Q')) {
            String subject = t.subject.tolowercase();
            
            if (t.Status == 'Completed' && t.subject != null && subject.contains('call')) {
                if(leadtoTaskCount.ContainsKey(t.whoId) && leadtoTaskCount.get(t.whoId) == 1){
                    // only in case when it is first task.
                    Lead lead = new Lead();
                    lead.id = t.whoId;
                    if(t.CallDurationInSeconds != null){
                        lead.First_Activity_date_time__c  = t.CreatedDate.addSeconds(-t.CallDurationInSeconds);
                    }else{
                        lead.First_Activity_date_time__c  = t.CreatedDate;                        
                    }
                    leadstoUpdate.add(lead);
                }
                
            }
        }
    }
    
    if(leadstoUpdate.size() > 0){
       update leadstoUpdate; 
    }
    
}