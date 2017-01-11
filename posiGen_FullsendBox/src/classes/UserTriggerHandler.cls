public with sharing class UserTriggerHandler implements ITrigger{
 public  UserCollaboratiionController ucc;
      // Constructor
    public UserTriggerHandler(){
    
      ucc = new UserCollaboratiionController();
        
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
      List<User> us = Trigger.new;
      for(User use : us){ 
         ucc.createUserCollaboratoion(use); 
       }
    }
    
    public void afterUpdate()
    {  
       Set<Id> UserSet = new Set<Id>();
       List<User> userUpdateList = (List<User>)Trigger.New;
       for(User u: userUpdateList){
          
                user oldUsr = (user)Trigger.OldMap.get(u.id);
             if(u.isActive!=oldUsr.isActive){    
                if(u.isActive==false){
                   if(u.profile.Name!='Concierge'||u.profile.Name!='Document Controller'||u.profile.Name!='System Administrator')
                       ucc.DeleteUserCollaboratoion(u);     
                 }
                if(u.isActive==true){
                     ucc.createUserCollaboratoion(u);
                 }
              }    
       
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