public with sharing class UploadUnlogAttachemntsCalculateCust implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful{
    public  String base_url = 'https://app.box.com/files/0/f/';
    public  Integer record_count = 0; 
    public  Integer record_count_stop = 0;
    public String attName;
   
   
   public  UploadUnlogAttachemntsCalculateCust (Integer record_count_stop,String attName){
      this.record_count_stop = record_count_stop;
      this.attName = attName;
      
    } 
   
    public Database.QueryLocator start(Database.BatchableContext BC){
      if(attName == 'Docusign'){
          system.debug('#########'+attName);
         return Database.getQueryLocator('select id, name, body,bodylength , parentId from Attachment where bodylength < 10000000 and parent.name like \'DSX%\'');
        }
     else if(attName == 'Custom'){
        system.debug('#########'+attName);
        return Database.getQueryLocator('select id, name, body,bodylength , parentId from Attachment where bodylength < 10000000 and parent.name like \'ATT%\'');
       }
     else{
       system.debug('#########'+attName);
       return Database.getQueryLocator('select id, name, body,bodylength , parentId from Attachment where bodylength < 10000000 and parentid in (Select id from opportunity)');
       }     
     } 
    public void execute(Database.BatchableContext BC, List<Attachment> attachmentList){
      List<Box_Error__c> bxErrList = new List<Box_Error__c>();  
       try{
       
         Set<Id> OppIds = new Set<Id>();
         Set<Id> docuSignSet = new Set<Id>(); 
          Set<Id> AttSet = new Set<Id>();   
            for(Opportunity Opp :[Select id from Opportunity where id!=null]){
                OppIds.add(Opp.Id);
            }
         if(attName == 'Docusign'){   
            for(dsfs__DocuSign_Status__c docSign: [select id, dsfs__Subject__c, dsfs__Opportunity__c from dsfs__DocuSign_Status__c where dsfs__Opportunity__c in: oppIds]){
                docuSignSet.add(docSign.id);
            }
           system.debug('#########Docu'+docuSignSet.size()); 
           } 
        else if(attName == 'Custom'){   
           for(Attachment__c  att:[Select id from Attachment__c where  project__r.Opportunity__c in:OppIds]){
                 docuSignSet.add(att.id);
              } 
             system.debug('#########Cust'+docuSignSet.size());  
             } 
       
         
           Set<String> lstatt = new Set<String>(); 
          
          if(attName == 'Docusign'){ 
              for(box_error__c bx :[Select id,Message__c,opportunity__c from box_error__c where  type__c = 'Docusign Doc' and Name='201' limit 45000]){
               
                   if(bx.Message__c.contains('Attachment id-')){
                     List<String> msglst = bx.Message__c.split('-');
                      lstatt.add(msglst[1]);
     
                   }
               
                }
               system.debug('#########Docu'+lstatt.size());  
             }  
          
         else if(attName == 'Custom'){ 
              for(box_error__c bx :[Select id,Message__c,opportunity__c from box_error__c where  type__c = 'Custom Doc' and Name='201' limit 45000]){
               
                   if(bx.Message__c.contains('Attachment id-')){
                     List<String> msglst = bx.Message__c.split('-');
                      lstatt.add(msglst[1]);
     
                   }
               
                }
                system.debug('#########Cust'+lstatt.size());  
             } 
          
         else{ 
              for(box_error__c bx :[Select id,Message__c,opportunity__c from box_error__c where  type__c = 'Standard Doc' and Name='201']){
               
                   if(bx.Message__c.contains('Attachment id-')){
                     List<String> msglst = bx.Message__c.split('-');
                      lstatt.add(msglst[1]);
     
                   }
               
                }
               system.debug('#########Stand'+lstatt.size());  
             } 
          
                    
            for(Attachment attachmentObj : attachmentList){
                     if(attachmentObj.body.size()<=4000000){
                            if(!lstatt.contains(attachmentObj.id) && docuSignSet.contains(attachmentObj.parentId)){  
                               system.debug('#########'+attName+'**'+attachmentObj);  
                                 Box_Error__c bxerr = new Box_Error__c();
                                 bxerr.name =attachmentObj.id; 
                                 bxerr.Message__c = 'Attachment-'+attachmentObj.id; 
                                 bxerr.Body__c = '';
                                if(attName == 'Docusign')
                                   bxerr.Type__c = 'Docusign Doc count';
                                else if(attName == 'Custom')
                                   bxerr.Type__c = 'Custom Doc count';
                                   bxerr.Status__c = 'Error';
                           
                                 bxErrList.add(bxerr);
                               
                             } 
                         else{
                         
                               if(!lstatt.contains(attachmentObj.id)){
                                 box_Error__c bxerr = new Box_Error__c();
                                 bxerr.name =attachmentObj.id; 
                                 bxerr.Message__c = 'Attachment-'+attachmentObj.id; 
                                 bxerr.Body__c = '';
                                 bxerr.Type__c = 'Standard Doc count';   
                                 bxerr.Status__c = 'Error';
                                 bxErrList.add(bxerr);
                                }
                            
                              }    
                                 
                      }
                
               }
             record_count += attachmentList.size();
            if(record_count == record_count_stop){
               system.debug('######################################## job aborted record_count is'+ record_count);
               System.abortJob(BC.getJobId()); 
             } 
           
          }
       catch(Exception e){
                system.debug('###############################'+e.getMessage()); 
                Box_Error__c bxerr = new Box_Error__c();
                bxerr.name = 'Exception'; 
                bxerr.Message__c = e.getMessage(); 
                bxerr.Body__c = e.getStackTraceString();
                bxerr.Type__c = '';
                bxerr.Status__c = 'Error';
                bxErrList.add(bxerr);
         
       }
       
       finally{
         insert bxErrList;
       }
    }
    
    public void finish(Database.BatchableContext BC){}
 
}