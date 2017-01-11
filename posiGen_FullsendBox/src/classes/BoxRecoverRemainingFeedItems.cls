public with sharing class BoxRecoverRemainingFeedItems implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful{

  public Database.QueryLocator start(Database.BatchableContext BC){
     
     Set<String> attchmentIdSet = new Set<String>();
     for(Box_Error__c bxer:[Select Message__c from Box_Error__c where type__c like 'Feed%' and name = '201']){
                       
            List<String> a1 = bxer.Message__c.split('-');
            attchmentIdSet.add(a1[1]);
     }
     return Database.getQueryLocator('SELECT id, parentid FROM FeedItem WHERE id not in:attchmentIdSet');
  }
  
  public void execute(Database.BatchableContext BC, List<FeedItem> feedItemList){
          try{
               List<Box_Error__c> bxErrList = new List<Box_Error__c>(); 
               for(FeedItem att: feedItemList){
               
                   Schema.SObjectType sobjectType = att.ParentId.getSObjectType();
                     String sobjectName = sobjectType.getDescribe().getName();
               
                     if(sobjectName == 'Opportunity'){  
                         Box_Error__c bxerr = new Box_Error__c();
                         bxerr.Opportunity__c = att.parentId;
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
           system.debug('==============================='+e.getMessage()+'--'+e.getStackTraceString());
       }

  }
  
  public void finish(Database.BatchableContext BC){}
}