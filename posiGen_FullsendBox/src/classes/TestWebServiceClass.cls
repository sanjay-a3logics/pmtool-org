@isTest
private class TestWebServiceClass 
{
    static testMethod void myUnitTest() 
    {
    	/*
    	RecordType rectype = new RecordType();
		rectype = [select name, id from RecordType where sObjectType = 'Account' and name like '%Business Account%' and isActive=true limit 1];
    	
    	Account account = new Account(Name = 'efdfsdfsdf', ShippingState = 'NY', PBSI__Payment_Terms__c = 'Net 35',RecordTypeid=rectype.id);
    	insert account;
    	
        //WebServiceClass.ConvertAccountInSalesOrder(account.Id);
    
        PBSI__PBSI_Sales_Order__c so =new PBSI__PBSI_Sales_Order__c(PBSI__Customer__c = account.Id);
        insert so;
        
        PBSI__PBSI_Location__c loc = new PBSI__PBSI_Location__c(Name = 'aaaaaddd', PBSI__description__c = 'Shipping',PBSI__Account__c=account.Id,PBSI__Default_for_Account__c=false);
        insert loc;
        
        PBSI__PBSI_Item_Group__c group1 = new PBSI__PBSI_Item_Group__c(Name = 'dsdsd', PBSI__Description__c = 'PBS Tools', PBSI__Item_Group_Code__c = '876');
        insert group1;
        
        PBSI__PBSI_Item__c item = new PBSI__PBSI_Item__c(name='uniqueitem', 
        												  PBSI__purchaseprice__c = 2, 
        												  PBSI__salesprice__c = 88, 
        												  PBSI__description__c = 'Hammer test', 
        												  PBSI__defaultunitofmeasure__c = 'EA', 
        												  PBSI__Default_Location__c = loc.Id, 
        												  PBSI__Item_Group__c = group1.Id);
        insert item;
        
        PBSI__PBSI_Sales_Order_Line__c soLine = new PBSI__PBSI_Sales_Order_Line__c(PBSI__Sales_Order__c = so.Id, PBSI__Quantity_Needed__c = 4, PBSI__Item__c = item.Id);
        insert soLine;
        
        //WebServiceClass.closeorderAndLines(so.Id);
        
        PBSI__Quote__c quote = new  PBSI__Quote__c(PBSI__Status__c='Active');
     	insert quote;
     	
     	PBSI__Quote_Line__c quoteLine = new PBSI__Quote_Line__c(PBSI__Quote__c = quote.Id, PBSI__Item__c=item.Id);
    	insert quoteLine;
     	
     	//WebServiceClass.createSalesOrder(quote.Id);
     	
     	Opportunity opp = new Opportunity(Name='optest', StageName='Prospecting', AccountID=account.Id, CloseDate=(system.today()+5));
     	insert opp;
     	
     	PBSI__PBSI_Opportunity_Line__c oppLine = new PBSI__PBSI_Opportunity_Line__c(PBSI__Opportunity__c = opp.Id, PBSI__Item__c = item.id, PBSI__Quantity__c = 1);
        insert oppLine;
      
        try
        {  
           WebServiceClass.createSOfromOpp(opp.Id);
        
        }
        catch(Exception ex){}
        /*
        try
        {  
        
           WebServiceClass.createQuotefromOpp(opp.Id);
        
        }
        catch(Exception ex){}
        
        WebServiceClass.updateBOMSalesPrice(item.Id);
        
        Contact contact = new Contact(LastName = 'Lorincz', Email = 'andreealorincz@gmail.com', AccountId = account.Id, PBSI__Level__c = 'Shipping ATTN');
        insert contact;
        
        WebServiceClass.createSalesOrderFromContact(contact.Id);
        
        WebServiceClass.createRMAFromPO(null);
        */
    }
}