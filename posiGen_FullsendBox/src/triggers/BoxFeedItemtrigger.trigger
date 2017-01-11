trigger BoxFeedItemtrigger on FeedItem (after insert) {
   Id newParentId;
   Trigger_Setting__c ts= Trigger_Setting__c.getInstance();
   Set<Id> FeedItemsIdSet = new Set<Id>(); 
   for(FeedItem fd: trigger.new){
       newParentId = fd.parentId ;
       FeedItemsIdSet.add(fd.id);
   }
  if(ts.FeedItem_Trigger__c ==true){   
       if(newParentId!=null){
              BoxUploadAttachmentController.uploadFeedItems(newParentId, FeedItemsIdSet);
         }
    }
}