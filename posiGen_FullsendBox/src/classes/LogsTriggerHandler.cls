public with sharing class LogsTriggerHandler implements ITrigger{
 
      // Constructor
    public LogsTriggerHandler(){
    
     
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
        //write code here
    }
    
    public void beforeUpdate()
    {
        //write code here
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
       boxLogClass blc = new boxLogClass();
         
       List<Box_Error__c>Loglist = (List<Box_error__c>)Trigger.New;
       List<Box_Error__c> ErrList = new List<Box_Error__c>();  
       for(Box_Error__c bx:Loglist){
         if(Bx.Name=='401'&& bx.Useremail__c!=null){
               ErrList.add(bx); 
          }
         } 
      if(ErrList.size()>0){    
         blc.createUserCollaboratoion(ErrList);
        }
    }
    
    public void afterUpdate()
    {  
       
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