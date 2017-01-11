public with sharing class SoqlServices{

   /* Author: Irfan Khan (Appcino Technologies Pvt. Ltd.)
    * Function for getting opportunity object list.
    * Params:
    *     1. Name: OppIds, Type: Set of Id, Description: Opportunity record ids Set 
    * 
    * Return value:
    *     It will return opportunity list 'OppList', each record contains Id, Name, Owner-Id and Owner-email   
    */
    public static List<Opportunity> getOpportunityList(Set<Id> OppIds){
        List<Opportunity> OppList = new List<Opportunity>();
        if(OppIds.size() > 0){
            OppList = [select Id, Name,Pipeline_Stage__c, owner.email, ownerId from Opportunity where Id in: OppIds];
        }
        return OppList;
    }
      
    //***************New Method*********************** This Method for Deal Attachment to Box***************************************************    
     public static List<Deal__c> getDealList(Set<Id> OppIds){                       
        List<Deal__c> OppList = new List<Deal__c>();
        if(OppIds.size() > 0){
            OppList = [select Id, Name,Opp_Pipeline_Stage__c, owner.email, ownerId from Deal__c where Id in: OppIds];
        }           
        return OppList;          
    }
    //********************************************************************************************************************************************
    
   /* Author: Irfan Khan (Appcino Technologies Pvt. Ltd.)
    * Function for getting opportunity object record.
    * Params:
    *     1. Name: opportunityId, Type: Id, Description: Opportunity record id. 
    * 
    * Return value:
    *     It will return opportunity single record 'opp', this record contains Name, Box folder id and stage of opportunity.   
    */
    public static Opportunity getOpportunityById(Id opportunityId){
        Opportunity opp = [select name, O_Box_Folder_Id__c, Pipeline_Stage__c from Opportunity where id =: opportunityId];
        return opp;
    } 		
    
    public static List<Sub_Folder__c> getChildFolders(String OppId){
        List<Sub_Folder__c> ChList = new List<Sub_Folder__c>();
        if(OppId!=null && OppId!='')
        {
            for(Sub_Folder__c CF : [select Id, Name, CF_Box_Folder_Id__c from Sub_Folder__c where CF_Deal__c =: OppId order by createdDate asc]){
                ChList.add(CF);
            }
        }
        return ChList;
    }
    
    
    public static List<Collaboration__c> getCollobration(String OppBoxUserId, string FolderId){
      List<Collaboration__c>CollList = new List<Collaboration__c>();
      for(Collaboration__c col:[Select id,BoxCollaboration_Id__c from Collaboration__c where BoxUser_Id__c =:OppBoxUserId and BoxFolder_Id__c =:FolderId]){
           CollList.add(col); 
        }
      return CollList; 
     }
                
    //************************************** This Method for Deal Attachment to Box***************************************************
    public static List<Sub_Folder__c > getsubfolder(String folderIds, String objectName){
      List<Sub_Folder__c>foldList = new List<Sub_Folder__c >();
      if(objectName == 'Deal__c' && folderIds!=null){           // Opportunity
        system.debug('soql controller-----61 Line------------'+objectName) ;
         for(Sub_Folder__c fol:[Select id,Name,CF_Box_Folder_Id__c,CF_Deal__c from Sub_Folder__c where CF_Deal__c =:folderIds and name=:'Sales']){
           foldList.add(fol);                   
        }
      }
      else if(objectName == 'Attachment__c' && folderIds!=null){
         Attachment__c cAttach = [select project__r.Deal__c from Attachment__c where id =: folderIds];
         for(Sub_Folder__c fol:[Select id,Name,CF_Box_Folder_Id__c,CF_Deal__c from Sub_Folder__c where CF_Deal__c =:cAttach.project__r.Deal__c and name=:'Funding-Vendor']){
           foldList.add(fol); 
        }
      }
      return foldList; 
     }      
     
     
    public static List<Attachment> getAttachment(String parId){
      List<Attachment>AttList = new List<Attachment>();
      for(Attachment fol:[Select id, Name, Body, parentId from Attachment where parentId =:parId]){
           AttList.add(fol); 
        }
      return AttList; 
     }     
     
    public static Sub_Folder__c getSubFolder(Id opportunityId, String subFolderName){
        Sub_Folder__c childFolder = [select id, CF_Box_Folder_Id__c from Sub_Folder__c where CF_Opportunity__c =: opportunityId and name =: subFolderName];
        return childFolder;
    } 

    public static List<dsfs__DocuSign_Status__c> getDocusignStatusList(Id opportunityId){
        List<dsfs__DocuSign_Status__c> docuSignStatusList = new List<dsfs__DocuSign_Status__c>();
        for(dsfs__DocuSign_Status__c docuSignStatus : [select id, dsfs__Subject__c from dsfs__DocuSign_Status__c where dsfs__Opportunity__c =: opportunityId]){
            docuSignStatusList.add(docuSignStatus);
        }
        return docuSignStatusList;
    } 

    public static dsfs__DocuSign_Status__c getDocusignStatus(Id docusignId){
        return [select id, dsfs__Subject__c, dsfs__Opportunity__c from dsfs__DocuSign_Status__c where id =: docusignId];
    } 

    public static List<Attachment__c> getCustomAttachmentsList(Id opportunityId){
        List<Attachment__c> customAttachmentList = new List<Attachment__c>();
        for(Attachment__c att : [select id, project__r.opportunity__c from attachment__c where project__r.opportunity__c =: opportunityId]){
            customAttachmentList.add(att);
        }
        return customAttachmentList;
    } 
    
    public static List<Attachment> getAttachmentListBySet(Set<Id> attIds){
        List<Attachment> attList = new List<Attachment>();
        if(attIds.size() > 0){
            attList = [Select id, Name, Body, parentId from Attachment where Id in: attIds];
        }
        return attList;
    }
   public static List<String> getContactList(Id contId){
     List<String> conList = new List<String>();
     if(contId!=null){
      for(Contact con:[Select id from Contact where AccountId=:contId]){
          conList.add(con.id);
        }
      } 
     return conList;
   
   }
  public static List<String>getAccountContList(List<String> aacIdlst){
    List<String> contList = new  List<String>();
    for(Contact cont:[Select id from Contact where AccountId in:aacIdlst]){
        contList.add(cont.id);
     }
    return contList;
  } 
 public static List<String> getUserList(List<String> ownIdlst){
   List<String> usList = new  List<String>();
    for(Box_User__c bxusr: [select BoxUser_Id__c from Box_User__c where SF_User_Id__c in:ownIdlst]){
        usList.add(bxusr.BoxUser_Id__c);
     }
    return usList;
 
  }  

}