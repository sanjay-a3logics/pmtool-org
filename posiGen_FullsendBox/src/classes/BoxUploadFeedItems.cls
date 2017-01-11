public class BoxUploadFeedItems{

    public BoxUploadFeedItems(){
    
        
    }
    
    
    @future(callout=true)  
    public static void uploadFeedItem(){
          
         try{  
            Set<String> attchmentIdSet = new Set<String>();
            Set<String> attchmentIdList1 = new Set<String>();
            for(Box_Error__c bxer:[Select Deal__c ,name ,Type__c ,Status__c , Message__c from Box_Error__c where type__c like 'Feed%' and name = '201']){
                       
                    List<String> a1 = bxer.Message__c.split('-');
                    attchmentIdSet.add(a1[1]);
             }
             
               
               List<Box_Error__c> bxErrList = new List<Box_Error__c>(); 
               for(FeedItem att: [SELECT id, parentid FROM FeedItem WHERE id not in: attchmentIdSet]){
               
                   Schema.SObjectType sobjectType = att.ParentId.getSObjectType();
                     String sobjectName = sobjectType.getDescribe().getName();
               
                     if(sobjectName == 'Opportunity'){  
                         Box_Error__c bxerr = new Box_Error__c();
                         bxerr.Deal__c = att.parentId;
                         bxerr.name = '401';
                         bxerr.Message__c = 'Attachment id-'+att.id; 
                         bxerr.Body__c = '';
                         bxerr.Type__c = 'Feed Item Standard';
                         bxerr.Status__c = 'Error';
                   
                         bxErrList.add(bxerr);
                     }    
               }
               insert bxErrList;
     }

       catch(Exception e){
           system.assert(false,e.getMessage()+'--'+e.getStackTraceString());
       }
       
      
  }
}