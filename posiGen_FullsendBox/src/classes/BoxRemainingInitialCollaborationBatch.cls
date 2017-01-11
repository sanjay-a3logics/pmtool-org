public with sharing class BoxRemainingInitialCollaborationBatch implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful{
 
  public String base_url = 'https://app.box.com/files/0/f/';
  public Integer record_count = 0; 
  public Integer record_count_stop = 0;
  public string  foldername ='';
  public Set<String>IdSet;
  public BoxRemainingInitialCollaborationBatch(String folderName,Integer record_count_stop,Set<String>IdSet){
    this.record_count_stop = record_count_stop;
    this.foldername =foldername; 
    this.IdSet= IdSet;
  } 
  Map<Id,string> Usermap;
  Map<string,List<string>> Contactmap;
  public Database.QueryLocator start(Database.BatchableContext BC){
        Usermap = new Map<Id,string>();
        
         for(User u:[Select id ,email from user where Isactive=true]){
              Usermap.put(u.id,u.email);
          } 
      
     Contactmap = new Map<string,List<string>>(); 
   
    for(Account acc:[Select id, (Select email from contacts where email!=null) from Account where id!=null]){
       if(acc.contacts!=null){   
        for(Contact con :acc.contacts){
            
            if(!Contactmap.containsKey(acc.id)){
                Contactmap.put(acc.id, new List<string>());
            }
            Contactmap.get(acc.id).add(con.email);
          }
         } 
      
      } 
      
     return Database.getQueryLocator('Select id,cf_opportunity__c,CF_Box_Folder_Id__c,cf_opportunity__r.Pipeline_Stage__c from Sub_Folder__c where name=:folderName and CF_Box_Folder_Id__c in:IdSet');
  }
  
  public void execute(Database.BatchableContext BC, List<Sub_Folder__c> fldList){
     system.debug('======'+fldList);
    List<Collaboration__c> lstcollab = new List<Collaboration__c>();
    List<Box_Error__c> bxErrList = new List<Box_Error__c>();     
    Set<String> stagesSet= new Set<String>();
    Set<String> NewstagesSet= new Set<String>();
    Set<String> profileSet= new Set<String>();
    
    Map<String,String> folderIdMap= new Map<String,String>();
    Map<String,String> profileGroupMap = new Map<String,String>();
    List<String> foldIdlst = new List<String>(); 
    Set<String> BoxfoldIdlst = new Set<String>();
    List<Box_Log__c> boxLogsLst = new List<Box_Log__c>();     
   
    for(Sub_Folder__c sb: fldList){
        NewstagesSet.add(sb.cf_opportunity__r.Pipeline_Stage__c);
        foldIdlst.add(sb.CF_Box_Folder_Id__c);
        BoxfoldIdlst.add(sb.cf_opportunity__c);
        folderIdMap.put(sb.cf_opportunity__c,sb.CF_Box_Folder_Id__c); 
    }
    
    Map<String,String> profilePermissionMap = new Map<String,String>();
    Map<String,String> profileLookupMap = new Map<String,String>();
    Map<String,String> profileNameMap = new Map<String,String>();
    Map<String,List<String>> profileUserMap = new Map<String,List<String>>();
    
   
     
    for(BoxAccessMatrix_Stage__c bxStg:[select Box_Permission__c,BoxAccessMatrix_Profile__r.Lookup_field_Name__c,
    BoxAccessMatrix_Profile__r.Profile_Name__c, BoxAccessMatrix_Profile__r.Profile_Id__c, Stage__c 
    from BoxAccessMatrix_Stage__c 
    where BoxAccessMatrix_Profile__r.BoxAccessMatrix_SubFolder__r.SubFolder_Name__c =: folderName 
    and check__c =true and Stage__c in:NewstagesSet]){       
        stagesSet.add(bxStg.Stage__c);
        
        profileSet.add(bxStg.BoxAccessMatrix_Profile__r.Profile_Id__c);
        profilePermissionMap.put(bxStg.BoxAccessMatrix_Profile__r.Profile_Id__c,bxStg.Box_Permission__c);
        profileLookupMap.put(bxStg.BoxAccessMatrix_Profile__r.Profile_Id__c,bxStg.BoxAccessMatrix_Profile__r.Lookup_field_Name__c);
        profileNameMap.put(bxStg.BoxAccessMatrix_Profile__r.Profile_Id__c,bxStg.BoxAccessMatrix_Profile__r.Profile_Name__c);
        profileUserMap.put(bxStg.BoxAccessMatrix_Profile__r.Profile_Id__c,new List<String>());
       
    }
    
    for(Profile prf:[Select id,(Select id,email,Isactive  from users where isActive = true) from profile where id in:profileUserMap.keyset()]){
         
         for(User us: prf.Users){
             if(us.Isactive == true)
                 profileUserMap.get(prf.id).add(us.email);
             }
       }

     
    
     system.debug('foldIdlst size='+foldIdlst.size());
     if(foldIdlst.size() > 0){
     
         for(Box_Group__c  bg : [Select SF_Profile_Id__c, BoxGroup_Id__c,BoxGroup_Name__c from Box_Group__c]){
             profileGroupMap.put(bg.SF_Profile_Id__c, bg.BoxGroup_Id__c);
         }
     
         for(String prf: profileSet){
            system.debug('========='+profileNameMap.get(prf));
             if(profileLookupMap.get(prf) != null){
                 String query;
                 String sObjName;
                 String FolderIDstring; 
                 
               integer i = 1;  
               FolderIDstring = '(';
               for(String str:BoxfoldIdlst){
               
                   if(BoxfoldIdlst.size() == i){
                       FolderIDstring += '\''+str+'\'';
                   }
                   else{
                       FolderIDstring += '\''+str+'\',';
                   }
                   i++;
                }
               FolderIDstring += ')';
             
             system.debug('********'+FolderIDstring);  
                   
                if(profileLookupMap.get(prf)=='Subcontractor__c' || profileLookupMap.get(prf)=='EE_Assessor__c')
                    query = 'Select id,ownerId from opportunity where id in'+FolderIDstring;
                else{
                   query = 'Select id, O_Box_Folder_Id__c,'+ profileLookupMap.get(prf)+' from opportunity where  id in '+FolderIDstring;
                    }
                 system.debug('****'+query);
              
             
                for(Opportunity opp : Database.query(query)){ 
                     if(profileLookupMap.get(prf)=='Subcontractor__c'){
                     
                            String prjquery = 'Select '+ profileLookupMap.get(prf)+', RecordType.Name from project__c where opportunity__c=\''+opp.id+'\'';
                            system.debug('----'+prjquery);
                           for(Project__c prj:Database.query(prjquery)){
                                   Id LookupPrjId = String.valueOf(prj.get(profileLookupMap.get(prf)));
                                  if(LookupPrjId!=null){ 
                                   string LookUpAccId = String.valueof(LookupPrjId);
                                   sObjName = LookupPrjId.getSObjectType().getDescribe().getName();   
                                if(sObjName=='Account' && LookUpAccId!=null){
                              
                                   if((prj.RecordType.Name == 'EE Assessment'|| prj.RecordType.Name =='EE Upgrade') && folderName == 'EE'){
                                       
                                           for(String acSt:Contactmap.get(LookUpAccId)){
                                             system.debug(foldIdlst+'======'+acSt);
                                            if(acSt!=null) //change
                                                BoxInitialCollaborationBatch.CreatePrfLookupUserCollaboration(opp.id,LookUpAccId,folderIdMap.get(opp.id),acSt,profilePermissionMap.get(prf),prf,lstcollab,boxLogsLst );
                                            }
                                            
                                     }
                                  if((prj.RecordType.Name != 'EE Assessment'||prj.RecordType.Name !='EE Upgrade') && folderName != 'EE'){  
                                 
                                        for(String acSt:Contactmap.get(LookUpAccId)){
                                         system.debug(foldIdlst+'======'+acSt);
                                        if(acSt!=null) 
                                            BoxInitialCollaborationBatch.CreatePrfLookupUserCollaboration(opp.id,LookUpAccId,folderIdMap.get(opp.id),acSt,profilePermissionMap.get(prf),prf,lstcollab,boxLogsLst );
                                        }
                                      }
                                }
                               }   
                              }
                         }
                     else if(profileLookupMap.get(prf)=='EE_Assessor__c'){
                        String prjquery = 'Select '+ profileLookupMap.get(prf)+' from project__c where opportunity__c=\''+opp.id+'\'';
                        system.debug('hiiiiiii'+prjquery);
                         for(Project__c prj:Database.query(prjquery)){
                               Id LookupPrjId = String.valueOf(prj.get(profileLookupMap.get(prf))); 
                              
                                if(LookupPrjId!=null) 
                                     BoxInitialCollaborationBatch.CreatePrfLookupUserCollaboration(opp.id,LookupPrjId ,folderIdMap.get(opp.id),LookupPrjId ,profilePermissionMap.get(prf),prf,lstcollab,boxLogsLst );
                                 
                             }
                       
                        }   
                    else{
                         if(opp.get(profileLookupMap.get(prf))!=null){
                            Id LookupId = String.valueOf(opp.get(profileLookupMap.get(prf)));
                            system.debug('====&&&&'+sObjName);  
                            BoxInitialCollaborationBatch.CreatePrfLookupUserCollaboration(opp.id,LookupId,folderIdMap.get(opp.id),LookupId ,profilePermissionMap.get(prf),prf,lstcollab,boxLogsLst );
                          }
                       else{
                          if(profileNameMap.get(prf)=='Concierge')
                               BoxInitialCollaborationBatch.CreatePrfLookupUserCollaboration(opp.id,opp.id,folderIdMap.get(opp.id),opp.id,profilePermissionMap.get(prf),prf,lstcollab,boxLogsLst );
                          } 
                         }
                       }  
                    }     
             else{
              system.debug('======'+profileNameMap.get(prf));
               if(profileNameMap.get(prf)=='Concierge'||profileNameMap.get(prf)=='Document Controller'||profileNameMap.get(prf)=='System Administrator'){
                 //BoxInitialCollaborationBatch.CreatePrfLookupUserCollaboration(opp.id,LookupPrjId ,folderIdMap.get(opp.id),LookupPrjId ,profilePermissionMap.get(prf),prf,lstcollab,boxLogsLst );
                 }
             else {
               system.debug('======'+profileNameMap.get(prf));      
                     for(String stEmail:profileUserMap.get(prf)){
                           system.debug(foldIdlst+'======'+stEmail); 
                          if(stEmail!=null){
                             //BoxInitialCollaborationBatch.CreateLookupUserCollaboration(foldIdlst,stEmail,profilePermissionMap.get(prf),prf,lstcollab,bxErrList);   
                        }
                        } 
                   
               
                 }                 
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
  
  public void finish(Database.BatchableContext BC){}
  
  
  public static void CreateUserGroupCollaboration(List<String>fIdlst,String groupId, String role,String ProfId,List<Collaboration__c> lstcollab,List<Box_Error__c> bxErrList){
           
        try{
        
        boolean isCallSuccess = true;
        Integer lastIndex = -1;
        String collfld;
        for(integer i=0; i<fIdlst.size(); i++){
            if(!isCallSuccess)
                i = lastIndex; 
            lastIndex = i;
            collfld = fIdlst[i];
            if(collfld != null && groupId!= null && role != null){
                Box__c box = Box__c.getInstance();
                HttpRequest req = new HttpRequest();
                req.setEndpoint('https://api.box.com/2.0/collaborations');
                req.setMethod('POST');
                req.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
                req.setBody('{"item": { "id": "'+collfld+'", "type": "folder"}, "accessible_by": { "id": "'+groupId+'", "type": "group" }, "role": "'+role+'"}');
                HTTPResponse res = new Http().send(req);
                // Collaboration__c clb; 
                Collaborationwrapper cw = new Collaborationwrapper();
                system.debug(res.getStatusCode()+'hiiiii'+res.getbody());
                if(res.getStatusCode() == 201){
                    cw = (Collaborationwrapper)JSON.deserialize(res.getBody(),Collaborationwrapper.class);
                    Collaboration__c clb = new Collaboration__c();
                    clb.BoxCollaboration_Id__c = cw.Id;
                    clb.Role__c= cw.role;
                    clb.BoxFolder_Id__c= collfld;
                    clb.BoxGroup_Id__c=groupId;
                    clb.SFUser_Email__c = 'group@test.com';
                    clb.SFProfile_Id__c = ProfId;
                    lstcollab.add(clb);
                    isCallSuccess = true;
                }
                else if(res.getStatusCode() == 401){
                    BoxREFRESHAccessTokenScheduler.getToken();
                    isCallSuccess = false;
                }
                else{
                     Box_Error__c bxerr = new Box_Error__c();
                     bxerr.name = String.valueOf(res.getStatusCode()); 
                     bxerr.Message__c = collfld; 
                     bxerr.Body__c = res.getBody();
                     bxerr.Type__c = 'Collaboration';
                     bxerr.Status__c = 'Error';
                     bxErrList.add(bxerr); 
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
   
   public static void CreateLookupUserCollaboration(List<String>fIdlst,String userEmail, String role,String ProfId,List<Collaboration__c> lstcollab,List<Box_Error__c> bxErrList){
           
        try{
        
        boolean isCallSuccess = true;
        Integer lastIndex = -1;
        String  collfld;
        for(integer i=0; i<fIdlst.size(); i++){
            
            if(!isCallSuccess)
                i = lastIndex; 
            lastIndex = i;
            collfld = fIdlst[i];
         
            if(collfld!= null && userEmail!= null && role != null){
                Box__c box = Box__c.getInstance();
                HttpRequest req = new HttpRequest();
                req.setEndpoint('https://api.box.com/2.0/collaborations');
                req.setMethod('POST');
                req.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
                req.setBody('{"item": { "id": "'+collfld+'", "type": "folder"}, "accessible_by": { "login": "'+userEmail+'", "type": "user" }, "role": "'+role+'"}');
                HTTPResponse res = new Http().send(req);
                CollaborationUserWrapper cuw = new CollaborationUserWrapper ();
                system.debug(res.getStatusCode()+'hiiiii'+res.getbody());
                if(res.getStatusCode() == 201){
                    cuw = (CollaborationUserWrapper)JSON.deserialize(res.getBody(),CollaborationUserWrapper.class);
                    Collaboration__c clb = new Collaboration__c();
                    if(cuw.accessibleby!=null){
                        clb.BoxCollaboration_Id__c = cuw.Id;
                        clb.Role__c= cuw.role;
                        clb.BoxFolder_Id__c= collfld;
                        clb.BoxUser_Id__c=cuw.accessibleby.id;
                       }
                    else{
                        clb.BoxCollaboration_Id__c = cuw.id;
                        clb.Role__c= cuw.role;
                        clb.BoxFolder_Id__c= collfld;
                        clb.BoxUser_Id__c='';
                       } 
                    clb.SFUser_Email__c = userEmail;
                    clb.SFProfile_Id__c = ProfId;     
                    lstcollab.add(clb);
                }
               else if(res.getStatusCode() == 401){
                    BoxREFRESHAccessTokenScheduler.getToken();
                    isCallSuccess = false;
                }
                else{
                     Box_Error__c bxerr = new Box_Error__c();
                     bxerr.name = String.valueOf(res.getStatusCode()); 
                     bxerr.Message__c = collfld; 
                     bxerr.Body__c = res.getBody();
                     bxerr.Type__c = 'Collaboration';
                     bxerr.Status__c = 'Error';
                     bxErrList.add(bxerr); 
                    
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
  
   public static void CreatePrfLookupUserCollaboration(string fId,String userEmail, String role,String ProfId,List<Collaboration__c> lstcollab,List<Box_Error__c> bxErrList){
           
        try{
           //boolean isCallSuccess = true;
          system.debug(fId+'-------'+userEmail+'%%%%%%%'+role);
            if(fId!= null && userEmail!= null && role != null){
                Box__c box = Box__c.getInstance();
                HttpRequest req = new HttpRequest();
                req.setEndpoint('https://api.box.com/2.0/collaborations');
                req.setMethod('POST');
                req.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
                req.setBody('{"item": { "id": "'+fId+'", "type": "folder"}, "accessible_by": { "login": "'+userEmail+'", "type": "user" }, "role": "'+role+'"}');
                HTTPResponse res = new Http().send(req);
                // Collaboration__c clb; 
                CollaborationUserWrapper cuw = new CollaborationUserWrapper ();
                system.debug(res.getStatusCode()+'hiiiii'+res.getbody());
                if(res.getStatusCode() == 201){
                    cuw = (CollaborationUserWrapper)JSON.deserialize(res.getBody(),CollaborationUserWrapper.class);
                    Collaboration__c clb = new Collaboration__c();
                    if(cuw.accessibleby!=null){
                        clb.BoxCollaboration_Id__c = cuw.Id;
                        clb.Role__c= cuw.role;
                        clb.BoxFolder_Id__c= fId;
                        clb.BoxUser_Id__c=cuw.accessibleby.id;
                       }
                    else{
                        clb.BoxCollaboration_Id__c = cuw.id;
                        clb.Role__c= cuw.role;
                        clb.BoxFolder_Id__c= fId;
                        clb.BoxUser_Id__c='';
                       }
                    clb.SFUser_Email__c = userEmail;
                    clb.SFProfile_Id__c = ProfId;
                    lstcollab.add(clb);
                }
              else if(res.getStatusCode() == 401){
                 BoxREFRESHAccessTokenScheduler.getToken();
                 //BoxInitialCollaborationBatch.CreatePrfLookupUserCollaboration(fId,userEmail, role,ProfId,lstcollab,bxErrList);
               }  
                else{
                     Box_Error__c bxerr = new Box_Error__c();
                     bxerr.name = String.valueOf(res.getStatusCode()); 
                     bxerr.Message__c = fId; 
                     bxerr.Body__c = res.getBody();
                     bxerr.Type__c = 'Collaboration';
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
   }  
  
    public class CollaborationWrapper {

        public String type;
        public String id;
        public Created_by created_by;
        public String created_at;
        public String modified_at;
        public Object expires_at;
        public String status;
        public Created_by accessible_by;
        public String role;
        public String acknowledged_at;
        public Item item;
    
    }
    
    public class Created_by {
        public String type;
        public String id;
        public String name;
        public String login;
    }

    public class Item {
        public String type;
        public String id;
        public String sequence_id;
        public String etag;
        public String name;
    }
    
    public class CollaborationItemsWrapper {

        public Integer total_count;
        public List<Item> entries;
        public Integer offset;
    }

    public class CollaborationInfoWrapper {

        public Integer total_count;
        public List<Entries> entries;
    }
    
    public class Entries {
        public String type;
        public String id;
        public Object created_by;
        public String created_at;
        public String modified_at;
        public Object expires_at;
        public String status;
        public Accessible_by accessible_by;
        public String role;
        public String acknowledged_at;
        public Item item;
    }
    
    public class Accessible_by {
        public String type;
        public String id;
        public String name;
    }
 public class CollaborationUserWrapper {
    public String id;
    public cls_accessible_by accessibleby;
    public String role; 
   } 
 public class cls_accessible_by {
    public String type; 
    public String id;   
    public String name; 
    public String login;   
    }
 
      
   
 }