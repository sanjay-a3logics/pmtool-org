public with sharing class DeleteUserInitialCollaborationBatch implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful{
 
  public String base_url = 'https://app.box.com/files/0/f/';
  public Integer record_count = 0; 
  public Integer record_count_stop = 0;
  public string  foldername ='';
  public Id  usr;
   
  public DeleteUserInitialCollaborationBatch(String folderName,Id usr,Integer record_count_stop){
    this.record_count_stop = record_count_stop;
    this.foldername =foldername; 
    this.usr = usr;
  } 
  
  public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('Select id,CF_Box_Folder_Id__c,cf_opportunity__r.Pipeline_Stage__c from Sub_Folder__c where name=:folderName ');
  }
  
  public void execute(Database.BatchableContext BC, List<Sub_Folder__c> fldList){
  
    List<Collaboration__c> lstcollab = new List<Collaboration__c>();
    List<Box_Error__c> bxErrList = new List<Box_Error__c>();
    Set<String>stagesSet  = new Set<String>(); 
    Set<String>profileSet = new Set<String>();      
    
    Map<String,String> profileGroupMap = new Map<String,String>();
    
    User Uspf = [Select Name,email, profileId from User where id=:usr];
    
    for(Sub_Folder__c sbFolder: fldList){
        stagesSet.add(sbFolder.cf_opportunity__r.Pipeline_Stage__c);
    }
    
     Map<String, String> folderUserMap = new Map<String,String>();  
     for(Collaboration__c clb :[select BoxUser_Id__c,BoxFolder_Id__c  , BoxCollaboration_Id__c from Collaboration__c  where BoxCollaboration_Id__c!= null and BoxGroup_Id__c=null and SFUser_Email__c=:Uspf.email]){
            folderUserMap.put(clb.BoxFolder_Id__c,clb.BoxCollaboration_Id__c);
         } 
    
    Map<String,String> profilePermissionMap = new Map<String,String>();
    Map<String,String> profileNameMap = new Map<String,String>();
    List<BoxAccessMatrix_Stage__c> bxStagePermissionList = new List<BoxAccessMatrix_Stage__c>();
    
    
    for(BoxAccessMatrix_Stage__c bxStg:[select Box_Permission__c,BoxAccessMatrix_Profile__r.Profile_Name__c, BoxAccessMatrix_Profile__r.Profile_Id__c, Stage__c from BoxAccessMatrix_Stage__c where BoxAccessMatrix_Profile__r.BoxAccessMatrix_SubFolder__r.SubFolder_Name__c =: folderName and check__c =true and Stage__c in: stagesSet and BoxAccessMatrix_Profile__r.Profile_Id__c=:Uspf.profileId]){       
        profileSet.add(bxStg.BoxAccessMatrix_Profile__r.Profile_Id__c);
        profilePermissionMap.put(bxStg.BoxAccessMatrix_Profile__r.Profile_Id__c,bxStg.Box_Permission__c);
        profileNameMap.put(bxStg.BoxAccessMatrix_Profile__r.Profile_Id__c,bxStg.BoxAccessMatrix_Profile__r.Profile_Name__c);
     }
    
    

    List<String> foldIdlst = new List<String>();     
    for(Sub_Folder__c sb:fldList){
       if(stagesSet.contains(sb.cf_opportunity__r.Pipeline_Stage__c) || Test.isRunningTest()) 
            foldIdlst.add(sb.CF_Box_Folder_Id__c);
    
    }
   
      
    
     system.debug('foldIdlst size='+foldIdlst.size());
     if(foldIdlst.size() > 0){
     
         for(Box_Group__c  bg : [Select SF_Profile_Id__c, BoxGroup_Id__c,BoxGroup_Name__c from Box_Group__c]){
             profileGroupMap.put(bg.SF_Profile_Id__c, bg.BoxGroup_Id__c);
         }
     
         for(String prf: profileSet){
            
             system.debug('======'+profileNameMap.get(prf));
               if(profileNameMap.get(prf)!='Concierge'||profileNameMap.get(prf)=='Document Controller'||profileNameMap.get(prf)!='System Administrator')
                  DeleteUserInitialCollaborationBatch.DeleteLookupUserCollaboration(foldIdlst,folderUserMap,bxErrList); 
             else {
                        
                  }                 
            }
         insert lstcollab;
         insert bxErrList; 
        
        }
       record_count += fldList.size();
      if(record_count == record_count_stop){
       system.debug('######################################## job aborted record_count is'+ record_count);
       System.abortJob(BC.getJobId());
       }     
    
          
  } 
  
  public void finish(Database.BatchableContext BC){
  
    List<Messaging.SingleEmailMessage> msgList = new List<Messaging.SingleEmailMessage>(); 
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    mail.setTargetObjectId(UserInfo.getUserId());  
    mail.setToAddresses(new String[]{UserInfo.getUserEmail()});
    mail.setSaveasactivity(false);
    mail.setSubject('Delete Collabration Batch Status');
    mail.setPlainTextBody('Delete User Collabration batch Completed successfully Collaboration are deleted for this user');
    msgList.add(mail);
    Messaging.sendEmail(msgList);
  
  
  }
  
  
  /*public static void DeleteUserGroupCollaboration(User usr,String groupId,List<Box_Error__c> bxErrList){
           
        try{
        
           if(usr!= null && groupId!= null){
                Box__c box = Box__c.getInstance();
                HttpRequest req = new HttpRequest();
                req.setEndpoint('https://api.box.com/2.0/users');
                req.setMethod('POST');
                req.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
                req.setBody('{"login": "'+usr.email+'", "name": "'+usr.Name+'"}');
                HTTPResponse res = new Http().send(req);
                Userwrapper uw = new Userwrapper();
                system.debug(res.getStatusCode()+'hiiiii'+res.getbody());
                if(res.getStatusCode() == 201){
                    uw = (Userwrapper)JSON.deserialize(res.getBody(),Userwrapper.class);
                    HttpRequest reqMem = new HttpRequest();
                    reqMem.setEndpoint('https://api.box.com/2.0/group_memberships');
                    reqMem.setMethod('POST');
                    reqMem.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
                    reqMem.setBody('{ "user": { "id": "'+uw.id+'"}, "group": { "id": "'+groupId+'" } }');
                    HTTPResponse resMem = new Http().send(reqMem);
                    
                   system.debug('*******'+resMem.getstatuscode()+'-----'+resMem.getbody());
                   if(resMem.getStatusCode() == 201){
                   
                     Box_Error__c bxerr = new Box_Error__c();
                     bxerr.name = String.valueOf(res.getStatusCode()); 
                     bxerr.Message__c =''; 
                     bxerr.Body__c = res.getBody();
                     bxerr.Type__c = 'Membership';
                     bxerr.Status__c = 'Success';
                     bxErrList.add(bxerr); 
                     }
                  else{
                     Box_Error__c bxerr = new Box_Error__c();
                     bxerr.name = String.valueOf(res.getStatusCode()); 
                     bxerr.Message__c =''; 
                     bxerr.Body__c = res.getBody();
                     bxerr.Type__c = 'Membership';
                     bxerr.Status__c = 'Error';
                     bxErrList.add(bxerr);
                    
                    
                       } 
                }
                else{
                     Box_Error__c bxerr = new Box_Error__c();
                     bxerr.name = String.valueOf(res.getStatusCode()); 
                     bxerr.Message__c =''; 
                     bxerr.Body__c = res.getBody();
                     bxerr.Type__c = 'Create User';
                     bxerr.Status__c = 'Error';
                     bxErrList.add(bxerr); 
                    
                }
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
   }*/ 
   
   public static void DeleteLookupUserCollaboration(List<String>fIdlst,Map<String,String>collMap,List<Box_Error__c> bxErrList){
     try{
        
        boolean isCallSuccess = true;
        Integer lastIndex = -1;
        String collfld;
        
         for(integer i=0; i<fIdlst.size(); i++){
               if(!isCallSuccess)
                   i = lastIndex; 
            lastIndex = i;
            collfld = fIdlst[i];
            if(fIdlst.size()>0 && collMap!=null){
                Box__c box = Box__c.getInstance();
                HttpRequest req = new HttpRequest();
                req.setEndpoint('https://api.box.com/2.0/collaborations/'+collMap.get(collfld));
                req.setMethod('DELETE');
                req.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
                HTTPResponse res = new Http().send(req);
                
                if(res.getStatuscode()==204){
                     Box_Error__c bxerr = new Box_Error__c();
                     bxerr.name = String.valueOf(res.getStatusCode()); 
                     bxerr.Message__c = collfld; 
                     bxerr.Body__c = res.getBody();
                     bxerr.Type__c = 'Delete User Collaboration';
                     bxerr.Status__c = 'Success';
                     bxErrList.add(bxerr); 
                 }
                else if(res.getStatusCode() == 401){
                    isCallSuccess = false;
                }   
            }
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