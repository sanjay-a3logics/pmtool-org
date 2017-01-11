public with sharing class Batch_DeleteUserCollaboration implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful{
 
  public String base_url = 'https://app.box.com/files/0/f/';
  public User u;
  Box__c box ;
  List<Box_Error__c> bxErrList ;
   
  public Batch_DeleteUserCollaboration(User u){
    
    this.u= u;
  } 
  
  public Database.QueryLocator start(Database.BatchableContext BC){
        box = Box__c.getInstance();
        String UserEmail = u.email;
        return Database.getQueryLocator('select BoxUser_Id__c,BoxFolder_Id__c  , BoxCollaboration_Id__c from Collaboration__c  where BoxCollaboration_Id__c!= null and BoxGroup_Id__c=null and SFUser_Email__c=:UserEmail');
  }
  
  public void execute(Database.BatchableContext BC, List<Collaboration__c> collaborations){
     bxErrList = new List<Box_Error__c>();
         
     for(Collaboration__c clb :collaborations){
        Batch_DeleteUserCollaboration.deleteCollaboration(clb, box, bxErrList ); 
      } 
   
     insert bxErrList; 
          
  } 
  
  public void finish(Database.BatchableContext BC){
   
    List<Messaging.SingleEmailMessage> msgList = new List<Messaging.SingleEmailMessage>(); 
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    mail.setTargetObjectId(UserInfo.getUserId());  
    mail.setToAddresses(new String[]{UserInfo.getUserEmail()});
    mail.setSaveasactivity(false);
    mail.setSubject('Delete Collabration Batch Status');
    mail.setPlainTextBody('Delete User Collabration batch Completed successfully Collaboration are deleted for '+u.email+' user');
    msgList.add(mail);
    Messaging.sendEmail(msgList);
  
  }
  
  
  
   
   public static void deleteCollaboration(Collaboration__c coll,Box__c box,List<Box_Error__c> bxErrList){
     try{
        
            

            
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://api.box.com/2.0/collaborations/'+coll.BoxCollaboration_Id__c);
            req.setMethod('DELETE');
            req.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
            HTTPResponse res = new Http().send(req);
            
            if(res.getStatuscode()==204){
                 Box_Error__c bxerr = new Box_Error__c();
                 bxerr.name = String.valueOf(res.getStatusCode()); 
                 bxerr.Message__c = coll.BoxCollaboration_Id__c; 
                 bxerr.Body__c = res.getBody();
                 bxerr.Type__c = 'Delete User Collaboration';
                 bxerr.Status__c = 'Success';
                 bxErrList.add(bxerr);
                 delete coll;
             }
            else if(res.getStatusCode() == 401){
                BoxREFRESHAccessTokenScheduler.getToken();
                
            } 
           else{
                 Box_Error__c bxerr = new Box_Error__c();
                 bxerr.name = String.valueOf(res.getStatusCode()); 
                 bxerr.Message__c = coll.BoxCollaboration_Id__c; 
                 bxerr.Body__c = res.getBody();
                 bxerr.Type__c = 'Not Deleted User Collaboration';
                 bxerr.Status__c = 'Error';
                 bxErrList.add(bxerr);
              } 
              
           
        }
        catch(Exception e){
            Box_Error__c bxerr = new Box_Error__c();
             bxerr.name = 'Col Exception';
             bxerr.Message__c ='' ; 
             bxerr.Body__c = '';
             bxerr.Type__c = 'Collaboration';
             bxerr.Status__c = 'Error';
             bxErrList.add(bxerr); 
        }
        finally{
         
         
         }
   }  
  
      
   
 }