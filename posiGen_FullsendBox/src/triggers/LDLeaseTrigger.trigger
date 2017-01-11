trigger LDLeaseTrigger on LD_Lease__c (before insert) {

    Trigger_Setting__c ts = Trigger_Setting__c.getInstance();
    if(ts.LD_Lease_trigger__c){
 
        Set<String> ldLeaseCustomerNos = new Set<String>();
        for(LD_Lease__c ldLease: Trigger.New){
            if(ldLease.Customer_No__c != null && ldLease.Customer_No__c != ''){
                String customerNo = ldLease.Customer_No__c.substring(ldLease.Customer_No__c.length()-5);
                ldLeaseCustomerNos.add(customerNo);
            }
        }
        
        Map<String,Id> oppMap = new Map<String,Id>();
        Map<String,Id> accMap = new Map<String,Id>();
        for(Opportunity opp : [select id, Numeric_ID__c, accountId from opportunity where Numeric_ID__c in: ldLeaseCustomerNos]){
            oppMap.put(opp.Numeric_ID__c, opp.Id);if(opp.accountId != null){accMap.put(opp.Numeric_ID__c, opp.accountId);
            }
        }
        
        for(LD_Lease__c ldLease: Trigger.New){
        
            if(ldLease.Customer_No__c != null && ldLease.Customer_No__c != ''){
                String cno = ldLease.Customer_No__c.substring(ldLease.Customer_No__c.length()-5);
            
                if(oppMap.containsKey(cno)){
                    ldLease.Opportunity__c = oppMap.get(cno);
                }
                
                if(accMap.containsKey(cno)){
                    ldLease.Account__c = accMap.get(cno);
                }
            }
        }
    
    }
}