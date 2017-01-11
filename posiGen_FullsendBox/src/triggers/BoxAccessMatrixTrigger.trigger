trigger BoxAccessMatrixTrigger on BoxAccessMatrix_Stage__c (after update) {
     Trigger_Setting__c ts=  Trigger_Setting__c.getInstance();  
       Map<String,String> foldermap = New  Map<String,String>();
       for(BoxAccessMatrix_Profile__c bp:[Select id,BoxAccessMatrix_SubFolder__r.SubFolder_Name__c from BoxAccessMatrix_Profile__c]){
            foldermap.put(bp.id,bp.BoxAccessMatrix_SubFolder__r.SubFolder_Name__c);
          }
  
  if(ts.BoxAccessMatrixStage_Trigger__c == true){
    if(compareStageData(trigger.oldmap).size()>0){
          List<BoxAccessMatrix_Stage__c> Bamlst = new List<BoxAccessMatrix_Stage__c>(); 
        
         for(BoxAccessMatrix_Stage__c bstge:[select id, Box_Permission__c,BoxAccessMatrix_Profile__r.Lookup_field_Name__c,BoxAccessMatrix_Profile__r.Profile_Name__c, BoxAccessMatrix_Profile__r.Profile_Id__c, Stage__c,check__c from BoxAccessMatrix_Stage__c where id in:compareStageData(trigger.oldmap)]){
              Bamlst.add(bstge);
            }
          
          for(BoxAccessMatrix_Stage__c  bs: Bamlst){
                    
              if(foldermap.get(bs.BoxAccessMatrix_Profile__c) =='Sales'){
                 Database.executeBatch(New BoxUpdateCollaborationBatch('Sales',50000,bs),1);
                }
           else if(foldermap.get(bs.BoxAccessMatrix_Profile__c) =='Application'){
                 Database.executeBatch(New BoxUpdateCollaborationBatch('Application',50000,bs),1);
                }
           else if(foldermap.get(bs.BoxAccessMatrix_Profile__c) =='Funding-Vendor'){
                 Database.executeBatch(New BoxUpdateCollaborationBatch('Funding-Vendor',50000,bs),1);
                }
          else if(foldermap.get(bs.BoxAccessMatrix_Profile__c) =='EE'){
                 Database.executeBatch(New BoxUpdateCollaborationBatch('EE',50000,bs),1);
                }               
          }
       }
   if(comparePermissionData(trigger.oldmap).size()>0){
      
        Database.executeBatch(new Batch_UpdateCollaboration(comparePermissionData(trigger.oldmap)),1);
     }
   }       
    
   public List<BoxAccessMatrix_Stage__c> compareStageData(Map<Id,BoxAccessMatrix_Stage__c> OldStageMap){
       List<BoxAccessMatrix_Stage__c> retList=new List<BoxAccessMatrix_Stage__c>();
     
       for(BoxAccessMatrix_Stage__c b:trigger.new){
           
           if(b.check__c!=OldStageMap.get(b.id).Check__c){
              retList.add(b); 
            }
            
        }
      
       return retList;
    } 
   public List<BoxAccessMatrix_Stage__c> comparePermissionData(Map<Id,BoxAccessMatrix_Stage__c> OldStageMap){
       List<BoxAccessMatrix_Stage__c> retList=new List<BoxAccessMatrix_Stage__c>();
      
       for(BoxAccessMatrix_Stage__c b:trigger.new){
                   
          if(b.box_permission__c!=OldStageMap.get(b.id).box_permission__c){
             if(b.check__c==true && b.box_permission__c!=null)
                 retList.add(b);
             }
         }
      
       return retList;
    }  

}