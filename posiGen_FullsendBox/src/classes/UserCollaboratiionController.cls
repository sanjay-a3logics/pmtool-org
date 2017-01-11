public with sharing class UserCollaboratiionController{

   public UserCollaboratiionController(){}
   
 
  
 public void createUserCollaboratoion(User userId){
       
    for(BoxAccessMatrix_subfolder__c Bas:[Select Subfolder_Name__c from BoxAccessMatrix_subfolder__c]){
    
         Database.executeBatch(new Batch_CreateUserCollaboration(userId,Bas.Subfolder_Name__c),1);     
      
     }
  
   } 
   
 public void DeleteUserCollaboratoion(User userId){
       
          Database.executeBatch(new  Batch_DeleteUserCollaboration(userId),1);
  
   }     
 
}