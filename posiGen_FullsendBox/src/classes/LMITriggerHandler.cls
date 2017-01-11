public with sharing class LMITriggerHandler implements ITrigger{
    
    public static boolean firstRun = true;
    // Constructor
    public LMITriggerHandler(){
          
    }
    

    /**
     * bulkBefore
     *
     * This method is called prior to execution of a BEFORE trigger. Use this to cache
     * any data required into maps prior execution of the trigger.
     */
    public void bulkBefore()
    {
       
    }
    
    public void bulkAfter()
    {
    }
    
    
    public void beforeInsert()
    {

       
    }
    
    public void beforeUpdate()
    {
        // before update will only execute for Opportunity 
        Deal__c oppError;
        try{       

            Map<integer, decimal> muncipalityValues = new Map<integer, decimal>();
            
            for(Deal__c opp : [select id, Property__r.AHJ__r.Household_Size_01__c, Property__r.AHJ__r.Household_Size_02__c, 
                                    Property__c, Property__r.AHJ__r.Household_Size_03__c, Property__r.AHJ__r.Household_Size_04__c, 
                                    Property__r.AHJ__c, Property__r.AHJ__r.Household_Size_05__c, Property__r.AHJ__r.Household_Size_06__c, 
                                    Property__r.AHJ__r.Household_Size_07__c, Property__r.AHJ__r.Household_Size_08__c, People_In_Household__c,
                                    Annual_Household_Income__c from Deal__c where id in : Trigger.New]){
                                    
                oppError = (Deal__c)Trigger.NewMap.get(opp.id);
                 if(opp.Property__c != Null && opp.Property__r.AHJ__c != Null){
                     
                         muncipalityValues.put(1, opp.Property__r.AHJ__r.Household_Size_01__c);
                         muncipalityValues.put(2, opp.Property__r.AHJ__r.Household_Size_02__c);
                         muncipalityValues.put(3, opp.Property__r.AHJ__r.Household_Size_03__c);
                         muncipalityValues.put(4, opp.Property__r.AHJ__r.Household_Size_04__c);
                         muncipalityValues.put(5, opp.Property__r.AHJ__r.Household_Size_05__c);
                         muncipalityValues.put(6, opp.Property__r.AHJ__r.Household_Size_06__c);
                         muncipalityValues.put(7, opp.Property__r.AHJ__r.Household_Size_07__c);
                         muncipalityValues.put(8, opp.Property__r.AHJ__r.Household_Size_08__c);
                     
                 }            
            }
               
            
            for(Deal__c opp: (List<Deal__c>)Trigger.New){
                oppError = opp;
                
                if(opp.Annual_Household_Income__c != Null && opp.People_in_Household__c != Null){
                
                    if(muncipalityValues.containsKey(Integer.valueOf(opp.People_in_Household__c)) &&  muncipalityValues.get(Integer.valueOf(opp.People_in_Household__c)) != Null){
                        if(opp.Annual_Household_Income__c <= muncipalityValues.get(Integer.valueOf(opp.People_in_Household__c))){
                            opp.LMI_Eligible__c= 'Yes';
                        }
                        else if(opp.Annual_Household_Income__c > muncipalityValues.get(Integer.valueOf(opp.People_in_Household__c))){
                            opp.LMI_Eligible__c = 'No';
                        } 
                    }
                    else{
                        opp.LMI_Eligible__c = Null;
                    }
                }
                else{
                    opp.LMI_Eligible__c = Null;
                } 
                
            }
        }
        catch(Exception e){
           oppError.addError(e.getMessage()+': in class LMITriggerHandler at line number - '+e.getLineNumber());
        }
    }
    
    /**
     * beforeDelete
     *
     * This method is called for records to be deleted during a BEFORE
     * trigger.
     */
    public void beforeDelete()
    {   
        
    }
    
    public void afterInsert()
    {   
        // after insert will only execute for Opportunity 
        Deal__c oppError;
        try{
        
            Map<integer, decimal> muncipalityValues = new Map<integer, decimal>();
            
            for(Deal__c opp : [select id, Property__r.AHJ__r.Household_Size_01__c, Property__r.AHJ__r.Household_Size_02__c, 
                                    Property__c, Property__r.AHJ__r.Household_Size_03__c, Property__r.AHJ__r.Household_Size_04__c, 
                                    Property__r.AHJ__c, Property__r.AHJ__r.Household_Size_05__c, Property__r.AHJ__r.Household_Size_06__c, 
                                    Property__r.AHJ__r.Household_Size_07__c, Property__r.AHJ__r.Household_Size_08__c, People_In_Household__c,
                                    Annual_Household_Income__c from Deal__c where id in : Trigger.New]){
                 
                 oppError = (Deal__c)Trigger.NewMap.get(opp.id);
                
                     if(opp.Property__c != Null && opp.Property__r.AHJ__c != Null){
                         
                             muncipalityValues.put(1, opp.Property__r.AHJ__r.Household_Size_01__c);
                             muncipalityValues.put(2, opp.Property__r.AHJ__r.Household_Size_02__c);
                             muncipalityValues.put(3, opp.Property__r.AHJ__r.Household_Size_03__c);
                             muncipalityValues.put(4, opp.Property__r.AHJ__r.Household_Size_04__c);
                             muncipalityValues.put(5, opp.Property__r.AHJ__r.Household_Size_05__c);
                             muncipalityValues.put(6, opp.Property__r.AHJ__r.Household_Size_06__c);
                             muncipalityValues.put(7, opp.Property__r.AHJ__r.Household_Size_07__c);
                             muncipalityValues.put(8, opp.Property__r.AHJ__r.Household_Size_08__c);
                         
                    }
                
                                  
            }     
            
            List<Deal__c> oppList = new List<Deal__c>();
            for(Deal__c opp: [select id, Property__r.AHJ__r.Household_Size_01__c, Property__r.AHJ__r.Household_Size_02__c, 
                                    Property__c, Property__r.AHJ__r.Household_Size_03__c, Property__r.AHJ__r.Household_Size_04__c, 
                                    Property__r.AHJ__c, Property__r.AHJ__r.Household_Size_05__c, Property__r.AHJ__r.Household_Size_06__c, 
                                    Property__r.AHJ__r.Household_Size_07__c, Property__r.AHJ__r.Household_Size_08__c, People_In_Household__c,
                                    Annual_Household_Income__c from Deal__c where id in : Trigger.New]){
                                    
                oppError = (Deal__c)Trigger.NewMap.get(opp.id);
                
                if(opp.Annual_Household_Income__c != Null && opp.People_in_Household__c != Null){
                
                    if(muncipalityValues.containsKey(Integer.valueOf(opp.People_in_Household__c)) &&  muncipalityValues.get(Integer.valueOf(opp.People_in_Household__c)) != Null){
                        if(opp.Annual_Household_Income__c <= muncipalityValues.get(Integer.valueOf(opp.People_in_Household__c))){
                            opp.LMI_Eligible__c= 'Yes';
                        }
                        else if(opp.Annual_Household_Income__c > muncipalityValues.get(Integer.valueOf(opp.People_in_Household__c))){
                            opp.LMI_Eligible__c = 'No';
                        } 
                    }
                    else{
                        opp.LMI_Eligible__c = Null;
                    }
                }
                else{
                    opp.LMI_Eligible__c = Null;
                }
                
                oppList.add(opp); 
                
            }
            
            update oppList;   
        
        }
        catch(Exception e){
            
            oppError.addError(e.getMessage()+': in class LMITriggerHandler at line number - '+e.getLineNumber());
        }
        
        
    }
    
    public void afterUpdate()
    {
    
        // after update will only execute for property 
        
        Deal__c oppError;
        try{
        
            Set<id> oppIds = new Set<id>();
            for(Deal__c opp: [select id from Deal__c where property__c in : Trigger.New]){
                 oppIds.add(opp.id);
            }
        
            Map<integer, decimal> muncipalityValues = new Map<integer, decimal>();
            for(Deal__c opp : [select id, Property__r.AHJ__r.Household_Size_01__c, Property__r.AHJ__r.Household_Size_02__c, 
                                    Property__c, Property__r.AHJ__r.Household_Size_03__c, Property__r.AHJ__r.Household_Size_04__c, 
                                    Property__r.AHJ__c, Property__r.AHJ__r.Household_Size_05__c, Property__r.AHJ__r.Household_Size_06__c, 
                                    Property__r.AHJ__r.Household_Size_07__c, Property__r.AHJ__r.Household_Size_08__c, People_In_Household__c,
                                    Annual_Household_Income__c from Deal__c where id in : oppIds]){
                 
                 oppError = (Deal__c)Trigger.NewMap.get(opp.id);
                
                     if(opp.Property__c != Null && opp.Property__r.AHJ__c != Null){
                         
                             muncipalityValues.put(1, opp.Property__r.AHJ__r.Household_Size_01__c);
                             muncipalityValues.put(2, opp.Property__r.AHJ__r.Household_Size_02__c);
                             muncipalityValues.put(3, opp.Property__r.AHJ__r.Household_Size_03__c);
                             muncipalityValues.put(4, opp.Property__r.AHJ__r.Household_Size_04__c);
                             muncipalityValues.put(5, opp.Property__r.AHJ__r.Household_Size_05__c);
                             muncipalityValues.put(6, opp.Property__r.AHJ__r.Household_Size_06__c);
                             muncipalityValues.put(7, opp.Property__r.AHJ__r.Household_Size_07__c);
                             muncipalityValues.put(8, opp.Property__r.AHJ__r.Household_Size_08__c);
                         
                    }
                
                                  
            }     
            
            List<Deal__c> oppList = new List<Deal__c>();
            for(Deal__c opp: [select id, Property__r.AHJ__r.Household_Size_01__c, Property__r.AHJ__r.Household_Size_02__c, 
                                    Property__c, Property__r.AHJ__r.Household_Size_03__c, Property__r.AHJ__r.Household_Size_04__c, 
                                    Property__r.AHJ__c, Property__r.AHJ__r.Household_Size_05__c, Property__r.AHJ__r.Household_Size_06__c, 
                                    Property__r.AHJ__r.Household_Size_07__c, Property__r.AHJ__r.Household_Size_08__c, People_In_Household__c,
                                    Annual_Household_Income__c from Deal__c where id in : oppIds]){
                                    
                oppError = (Deal__c)Trigger.NewMap.get(opp.id);
                
                if(opp.Annual_Household_Income__c != Null && opp.People_in_Household__c != Null){
                
                    if(muncipalityValues.containsKey(Integer.valueOf(opp.People_in_Household__c)) &&  muncipalityValues.get(Integer.valueOf(opp.People_in_Household__c)) != Null){
                        if(opp.Annual_Household_Income__c <= muncipalityValues.get(Integer.valueOf(opp.People_in_Household__c))){
                            opp.LMI_Eligible__c= 'Yes';
                        }
                        else if(opp.Annual_Household_Income__c > muncipalityValues.get(Integer.valueOf(opp.People_in_Household__c))){
                            opp.LMI_Eligible__c = 'No';
                        } 
                    }
                    else{
                        opp.LMI_Eligible__c = Null;
                    }
                }
                else{
                    opp.LMI_Eligible__c = Null;
                }
                
                oppList.add(opp); 
                
            }
            
            update oppList;   
        
        }
        catch(Exception e){
            
            oppError.addError(e.getMessage()+': in class LMITriggerHandler at line number - '+e.getLineNumber());
        }
    }
    
    public void afterDelete()
    {
    }
    
    public void afterUnDelete()
    {
    }
    
    /**
     * andFinally
     *
     * This method is called once all records have been processed by the trigger. Use this 
     * method to accomplish any final operations such as creation or updates of other records.
     */
    public void andFinally()
    {
        
    }
}