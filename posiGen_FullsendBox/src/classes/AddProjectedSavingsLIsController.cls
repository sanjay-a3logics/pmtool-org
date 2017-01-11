public class AddProjectedSavingsLIsController {

    public String newPSLIs { get; set; }

    public PageReference createmonths()
    {
       Id psId = ApexPages.currentPage().getParameters().get('id');
       //Id psId = 'a4S7A0000000ElH';
       Decimal myCount = [SELECT Count_Of_Projected_Months__c FROM Projected_Savings__c WHERE Id = :psId].Count_Of_Projected_Months__c;
       Integer psliCount = myCount.intValue();
       added = false;
       if (psliCount < 12)
       {
           List<Projected_Savings_Line_Item__c> newPSLIs = new List<Projected_Savings_Line_Item__c>(); 
           String[] months = new String[]{'January','February','March','April','May','June','July','August','September','October','November','December'};
           for (String month : months)
           {
              Projected_Savings_Line_Item__c psli = new Projected_Savings_Line_Item__c(Name=month+' Projected Savings', 
                 Month_Projected__c=month, Projected_Savings__c=psId);
              newPSLIs.add(psli);
           }
           insert newPSLIs;
           added = true;
       }
       return null;
    }
    
    public Boolean added { get; set; }
    
    Id psId;
    public List<Projected_Savings_Line_Item__c> psliList {get;set;}
    
    public AddProjectedSavingsLIsController(){
        psId = ApexPages.currentPage().getParameters().get('id');
        //psId = 'a4S7A0000000ElH';
        psliList = [SELECT Projected_Savings__c, Name, Month_Projected__c, Month_Bill_Dollars__c, Month_Bill_Usage_kWh__c
                    FROM Projected_Savings_Line_Item__c WHERE Projected_Savings__c = :psId
                    ORDER BY Numeric_Month_Projected__c]; 
    }
    
    public void save(){
        update psliList;
    }
    
    public PageReference saveAndReturn() {
        update psliList;
        PageReference parentPage = new PageReference('/' + ApexPages.currentPage().getParameters().get('id'));
        //parentPage.setRedirect(true);
        return parentPage;
    }
    
    public void insertPSLIs(){
        insert psliList;
    }

}