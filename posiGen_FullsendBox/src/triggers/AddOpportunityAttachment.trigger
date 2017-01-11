trigger AddOpportunityAttachment on Attachment (after insert) {
   Trigger_Setting__c ts = Trigger_Setting__c.getInstance(); 
   Id newParentId;
   
   Set<Id> attachmentsIdSet = new Set<Id>(); 
   for(Attachment att: trigger.new){
       newParentId = att.parentId ;
       attachmentsIdSet.add(att.id);
   }
  if(ts.Attachment_Trigger__c ==true){     
     if(newParentId!=null){
      
      Schema.SObjectType sobjectType = newParentId.getSObjectType();
      String sobjectName = sobjectType.getDescribe().getName();
      
      if(sobjectName == 'dsfs__DocuSign_Status__c'){
          BoxUploadAttachmentController.uploadDocusignDocs(newParentId, attachmentsIdSet);
      }
     else{
          BoxUploadAttachmentController.uploadAttachment(newParentId, sobjectName, attachmentsIdSet);
      }
   			
     }
   }  
 }