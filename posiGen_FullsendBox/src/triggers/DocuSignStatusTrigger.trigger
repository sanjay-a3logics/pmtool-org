trigger DocuSignStatusTrigger on dsfs__DocuSign_Status__c (before insert,before update) {
    public Set<Id> oppSetId = new Set<Id>();
    public Map<id,id> accMap = new Map<id,id>();
    
    for(dsfs__DocuSign_Status__c dsfs : Trigger.New) {
        if(dsfs.dsfs__Opportunity__c != null) {
            oppSetId.add(dsfs.dsfs__Opportunity__c);
        }
    }
    for(Opportunity op : [select id, accountId from opportunity where id in: oppSetId and accountId != null]) {
        accMap.put(op.id, op.accountId);
    }
    for(dsfs__DocuSign_Status__c dsfs : Trigger.New) {
        if(accMap.containsKey(dsfs.dsfs__Opportunity__c)) {
            dsfs.dsfs__Company__c = accMap.get(dsfs.dsfs__Opportunity__c);
        }
    }
}