public with sharing  class  boxLogClass {
   
   public boxLogClass(){}
   
   public void createUserCollaboratoion(List<Box_error__c> BoxLogList){
      List<String>emailList = new List<String>(); 
      Set<String>folderIdSet = new Set<String>();
      for(Box_error__c be:BoxLogList){
          emailList.add(be.Useremail__c);
          folderIdSet.add(be.Sub_folder__c);
      }
 
     
      for(BoxAccessMatrix_subfolder__c Bas:[Select Subfolder_Name__c from BoxAccessMatrix_subfolder__c]){
    
                  Database.executeBatch(new BoxlogsCollaborationBatch(Bas.Subfolder_Name__c,emailList,folderIdSet),1);
            }
                   
      
        }
   


}