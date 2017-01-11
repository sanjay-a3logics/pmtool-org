trigger SalesOrderTrigger on Sales_Order__c (after insert, after update) {
    
    List<Sales_Order__c> salesOrderList = (List<Sales_Order__c>)Trigger.New;
    Set<Id> oppIdSet = new Set<Id>();
    Map<Id,Id> salesOrderMap = new Map<Id,Id>();
    
    for(Sales_Order__c salesOrder: salesOrderList){
        if(salesOrder.Opportunity__c != null){
            if(Trigger.isInsert){
                oppIdSet.add(salesOrder.Opportunity__c);
                salesOrderMap.put(salesOrder.Opportunity__c, salesOrder.Id);
            }
            else if(Trigger.isUpdate){
                Sales_Order__c oldSalesOrder = (Sales_Order__c)Trigger.OldMap.get(salesOrder.Id);
                if(oldSalesOrder.Opportunity__c != salesOrder.Opportunity__c){
                    oppIdSet.add(salesOrder.Opportunity__c);
                    salesOrderMap.put(salesOrder.Opportunity__c, salesOrder.Id);
                }
            }
        }
    }
    
     if(oppIdSet.size() > 0){
        List<PM_Tool__c> pmToolList = new List<PM_Tool__c>();
        for(PM_Tool__c pmTool: [select id, Sales_order__c, Opportunity__c, Sales_Order_EDT__c from PM_Tool__c where Opportunity__c in: oppIdSet]){
            pmTool.Sales_order__c = salesOrderMap.get(pmTool.Opportunity__c);
            pmTool.Sales_Order_EDT__c = (pmTool.Sales_Order_EDT__c == null) ?  Date.today() : pmTool.Sales_Order_EDT__c;
            pmToolList.add(pmTool);
        }
        
        update pmToolList;
    }
    
    if(oppIdSet.size() > 0){
       PMToolV2.updatePMRecordFromSalesOrder(oppIdSet, salesOrderMap);
    }
        
}