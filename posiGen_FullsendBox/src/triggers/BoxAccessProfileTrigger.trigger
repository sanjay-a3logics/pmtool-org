trigger BoxAccessProfileTrigger on BoxAccessMatrix_Profile__c (after update) {
    Map<String,String> foldermap = New  Map<String,String>();
       for(BoxAccessMatrix_Profile__c bp:[Select id,BoxAccessMatrix_SubFolder__r.SubFolder_Name__c from BoxAccessMatrix_Profile__c]){
            foldermap.put(bp.id,bp.BoxAccessMatrix_SubFolder__r.SubFolder_Name__c);
          }
       
      List<BoxAccessMatrix_Stage__c> Bamlst = new List<BoxAccessMatrix_Stage__c>(); 
             
               
           for(BoxAccessMatrix_Stage__c bstge:[select id, Box_Permission__c,BoxAccessMatrix_Profile__r.Lookup_field_Name__c,BoxAccessMatrix_Profile__r.Profile_Name__c, BoxAccessMatrix_Profile__r.Profile_Id__c, Stage__c,check__c from BoxAccessMatrix_Stage__c where check__c=true and BoxAccessMatrix_Profile__c in:compareData(trigger.oldmap)]){
              Bamlst.add(bstge);
            }
    
      for(BoxAccessMatrix_Stage__c  bs: Bamlst){
          
         if(foldermap.get(bs.BoxAccessMatrix_Profile__c) =='Sales'){
              Database.executeBatch(New BoxUpdateCollaborationBatch('Sales',35000,bs),1);
            }
         else if(foldermap.get(bs.BoxAccessMatrix_Profile__c) =='Application'){
              Database.executeBatch(New BoxUpdateCollaborationBatch('Application',35000,bs),1);
            }
         else if(foldermap.get(bs.BoxAccessMatrix_Profile__c) =='Funding-Vendor'){
              Database.executeBatch(New BoxUpdateCollaborationBatch('Funding-Vendor',35000,bs),1);
              }
         else if(foldermap.get(bs.BoxAccessMatrix_Profile__c) =='EE'){
              Database.executeBatch(New BoxUpdateCollaborationBatch('EE',35000,bs),1);
            }               
      }
      
   public List<BoxAccessMatrix_Profile__c> compareData(Map<Id,BoxAccessMatrix_Profile__c> OldStageMap){
       List<BoxAccessMatrix_Profile__c> retList=new List<BoxAccessMatrix_Profile__c>();
     
       for(BoxAccessMatrix_Profile__c b:trigger.new){
       
          if(b.Lookup_Field_Name__c!=OldStageMap.get(b.id).Lookup_Field_Name__c){
              retList.add(b); 
            }
        
           
       }
       
       return retList;
    } 

}