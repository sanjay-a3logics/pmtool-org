public with sharing class CreateCollaborationOnStageChangeBatch implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful{
 
  public String base_url = 'https://app.box.com/files/0/f/';
  public String folderName;    
  public string folderId;								
  public String NewStage;
  public List<Collaboration__c> createcollabList;
  public Integer abc=0;

  public CreateCollaborationOnStageChangeBatch(String folderName,String NewStage,string folderId){
    this.folderName=folderName; 
    this.folderId = folderId;
    this.NewStage  = NewStage;
    						
  } 						
  Map<Id,string> Usermap;
  Map<string,List<string>> Contactmap;
   Map<String,List<String>> profileUserMap;
  public Database.QueryLocator start(Database.BatchableContext BC){
  	 			
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
  
      if(Test.isRunningTest()){
          return Database.getQueryLocator('Select id,Name,CF_Box_Folder_Id__c,cf_deal__c,cf_deal__r.Opp_Pipeline_Stage__c from Sub_Folder__c where CF_Box_Folder_Id__c=:folderId and Name=:folderName limit 10');
      }
      else{
          return Database.getQueryLocator('Select id,Name,CF_Box_Folder_Id__c,cf_deal__c,cf_deal__r.Opp_Pipeline_Stage__c from Sub_Folder__c where CF_Box_Folder_Id__c=:folderId and Name=:folderName');
      }
      
  }  			
  
  public void execute(Database.BatchableContext BC, List<Sub_Folder__c> fldList){
  
    List<Collaboration__c> lstCollaborations = new List<Collaboration__c>();
    List<Box_Log__c> lstBoxLogs = new List<Box_Log__c>(); 
  
    createcollabList = new List<Collaboration__c>();

    Set<String>stagesSet  = new Set<String>(); 
    List<String>folderNameLst = new List<String>();
    Set<String>oppSet = new Set<String>();     
    
    Map<String,String> profileGroupMap = new Map<String,String>();
    
    
    List<String> foldIdlst = new List<String>();    
    for(Sub_Folder__c sbFolder: fldList){
        oppSet.add(sbFolder.cf_deal__c);
        foldIdlst.add(sbFolder.CF_Box_Folder_Id__c);
    }
    
    Map<String,String> profilePermissionMap = new Map<String,String>();
    Map<String,String> profileNameMap = new Map<String,String>();
    Map<String,String> profileLookUpNameMap = new Map<String,String>();
    profileUserMap = new Map<String,List<String>>();
    
    for(BoxAccessMatrix_Stage__c bxStg:[select Box_Permission__c,BoxAccessMatrix_Profile__r.Lookup_field_Name__c,BoxAccessMatrix_Profile__r.Profile_Name__c, BoxAccessMatrix_Profile__r.Profile_Id__c, Stage__c from BoxAccessMatrix_Stage__c where  BoxAccessMatrix_Profile__r.BoxAccessMatrix_SubFolder__r.SubFolder_Name__c =: folderName and check__c =true and Stage__c =:NewStage]){       
            profileUserMap.put(bxStg.BoxAccessMatrix_Profile__r.Profile_Id__c,new List<String>());
            profilePermissionMap.put(bxStg.BoxAccessMatrix_Profile__r.Profile_Id__c,bxStg.Box_Permission__c);
            profileNameMap.put(bxStg.BoxAccessMatrix_Profile__r.Profile_Id__c,bxStg.BoxAccessMatrix_Profile__r.Profile_Name__c);
            if(bxStg.BoxAccessMatrix_Profile__r.Lookup_field_Name__c!=null)
               profileLookUpNameMap.put(bxStg.BoxAccessMatrix_Profile__r.Profile_Id__c,bxStg.BoxAccessMatrix_Profile__r.Lookup_field_Name__c);
          
           system.debug('----profileUserMap----->>'+ profileUserMap + '------1---profilePermissionMap------->>'+ profilePermissionMap +'---2---------------'+ profileNameMap ); 
               
       }
   
    Usermap = new Map<Id,string>();
    for(User u:[Select id ,email from user where Isactive=true and profileId in:profileNameMap.keyset()]){
         if(u.email!=null) 
          Usermap.put(u.id,u.email);
      }
    
   
    for(Profile prf:[Select id,(Select email from users where Isactive=true) from profile where id in:profileUserMap.keyset()]){
             if(prf.Users!=null){
                     for(User us: prf.Users){
                           profileUserMap.get(prf.id).add(us.email);   
                      }
                  }    
           }   
    
  system.debug('---------'+profileUserMap);
   
     system.debug('foldIdlst size='+foldIdlst.size());
     if(foldIdlst.size() > 0){
     
         for(Box_Group__c  bg : [Select SF_Profile_Id__c, BoxGroup_Id__c,BoxGroup_Name__c from Box_Group__c]){
             profileGroupMap.put(bg.SF_Profile_Id__c, bg.BoxGroup_Id__c);
         }
         
           
   
    for(string ProfId : profileNameMap.keySet()){
        
        if(profileLookUpNameMap.get(ProfId)!=null){
              system.debug('hellooooooooo'+profileLookUpNameMap.get(ProfId));  
                 String query;
                 String sObjName;
                 String FolderIDstring; 
                 
               integer i = 1;  
               FolderIDstring = '(';
               for(String str:oppSet){               
                   if(oppSet.size() == i){
                       FolderIDstring += '\''+str+'\'';
                   }
                   else{
                       FolderIDstring += '\''+str+'\',';
                   }
                   i++;
                }
               FolderIDstring += ')';
             
             system.debug('********'+FolderIDstring);  
                   
                if(profileLookUpNameMap.get(ProfId)=='Subcontractor__c' || profileLookUpNameMap.get(ProfId)=='EE_Assessor__c')
                    query = 'Select id,ownerId from deal__c where id in'+FolderIDstring;
                else{
                   query = 'Select id, O_Box_Folder_Id__c,'+ profileLookUpNameMap.get(ProfId)+' from deal__c where  id in '+FolderIDstring;
                    }
                 system.debug('****'+query);							
              
             system.debug('AppcinoTest----->'+profileLookUpNameMap);   
                for(deal__c opp : Database.query(query)){ 
                     if(profileLookUpNameMap.get(ProfId)=='Subcontractor__c'){
                     
                            String prjquery = 'Select '+ profileLookUpNameMap.get(ProfId)+', RecordType.Name from project__c where deal__c=\''+opp.id+'\'';
                            system.debug('----'+prjquery);
                           for(Project__c prj:Database.query(prjquery)){
                               if(prj.get(profileLookUpNameMap.get(ProfId))!=null){
                                   Id LookupPrjId = String.valueOf(prj.get(profileLookUpNameMap.get(ProfId)));
                             
                              
                                   string LookUpAccId = String.valueof(LookupPrjId);
                                   sObjName = LookupPrjId.getSObjectType().getDescribe().getName();   
                                if(sObjName=='Account' && LookUpAccId!=null){
                                  
                                  if(folderName == 'EE' && (prj.RecordType.Name == 'EE Assessment'|| prj.RecordType.Name == 'EE Upgrade')){  
                                      Set<String> emails = new Set<String>();
                                      for(String acSt:Contactmap.get(LookUpAccId)){
                                         system.debug(foldIdlst+'======'+acSt);
                                        if(acSt!=null) 
                                            emails.add(acSt);
                                        }
                                        CreatePrfLookupUserCollaboration(fldList,emails,profilePermissionMap.get(ProfId),ProfId, lstBoxLogs, lstCollaborations);
                                   }
                                  if(folderName != 'EE' && (prj.RecordType.Name != 'EE Assessment' && prj.RecordType.Name !='EE Upgrade')){  
                                      Set<String> emails = new Set<String>();
                                      for(String acSt:Contactmap.get(LookUpAccId)){
                                         system.debug(foldIdlst+'======'+acSt);
                                        if(acSt!=null) 
                                            emails.add(acSt);
                                        }
                                        CreatePrfLookupUserCollaboration(fldList,emails,profilePermissionMap.get(ProfId),ProfId, lstBoxLogs, lstCollaborations);
                                   } 
                                 } 
                               }   
                             }
                         }
                     else if(profileLookUpNameMap.get(ProfId)=='EE_Assessor__c'){
                        String prjquery = 'Select '+ profileLookUpNameMap.get(ProfId)+' from project__c where deal__c=\''+opp.id+'\'';
                        system.debug('hiiiiiii'+prjquery);
                         for(Project__c prj:Database.query(prjquery)){
                            if(prj.get(profileLookUpNameMap.get(ProfId))!=null){
                               Id LookupPrjId = String.valueOf(prj.get(profileLookUpNameMap.get(ProfId))); 
                                   Set<String> emails = new Set<String>();
                                   if(Usermap.get(LookupPrjId) != null){
                                       emails.add(Usermap.get(LookupPrjId));
                                   }
                                   CreatePrfLookupUserCollaboration(fldList,emails,profilePermissionMap.get(ProfId),ProfId, lstBoxLogs, lstCollaborations);
                                 }
                             }
                       
                        }   
                    else{
                         if(opp.get(profileLookUpNameMap.get(ProfId))!=null){
                               Id LookupId = String.valueOf(opp.get(profileLookUpNameMap.get(ProfId)));
                               system.debug('====&&&&'+sObjName);  
                               Set<String> emails = new Set<String>();
                               if(Usermap.get(LookupId) != null){
                                   emails.add(Usermap.get(LookupId));
                               }
                               CreatePrfLookupUserCollaboration(fldList,emails, profilePermissionMap.get(ProfId),ProfId, lstBoxLogs, lstCollaborations);
                          }
                          
                      }
                   }
             
              }
            else{
               if(profileNameMap.get(ProfId)=='Concierge'||profileNameMap.get(ProfId)=='Document Controller'||profileNameMap.get(ProfId)=='System Administrator')
                  {   //system.debug('sanjay'+fldList);			
                     CreateUserGroupCollaboration(fldList,profileGroupMap.get(ProfId),profilePermissionMap.get(ProfId),ProfId,lstCollaborations,lstBoxLogs);
                  } 
             else {
               system.debug('========'+profileUserMap.get(ProfId)+'hiiii'+ProfId);
               Set<String> emails = new Set<String>();
               for(String usEmail:profileUserMap.get(ProfId)){
                if(usEmail!=null){
                    emails.add(usEmail);
                }
              }
              CreateLookupUserCollaboration(fldList,ProfId,emails,profilePermissionMap.get(ProfId), lstBoxLogs, lstCollaborations);   
            }
          }
        }  
        
        insert lstCollaborations;
        insert lstBoxLogs; 
                            
    }
   
  } 
  
  public void finish(Database.BatchableContext BC){
   
  }
  
  
   public void CreateUserGroupCollaboration(List<Sub_Folder__c >fIdlst,String groupId, String role,String ProfId,List<Collaboration__c> lstCollaborations, List<Box_Log__c> lstBoxLogs){
        system.debug('----fIdlst----'+fIdlst+'---groupId-----'+groupId+'----role---'); 							
        boolean isCallSuccess = true;
        Integer lastIndex = -1;
        String collfld;
        String status = '';
        for(Sub_Folder__c folder: fIdlst){
            try{

                if(groupId!= null && role != null){
                    Box__c box = Box__c.getInstance();
                    HttpRequest req = new HttpRequest();
                    system.debug('FinalTest--CreateUserGroupCollaboration----box.BoxAccess_Token__c--'+box.BoxAccess_Token__c+'2------folder.CF_box_folder_id__c---'+folder.CF_box_folder_id__c+'---2-----'+groupId+'---4 --role'+role);
                    req.setEndpoint('https://api.box.com/2.0/collaborations');
                    req.setMethod('POST');
                    req.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
                    req.setBody('{"item": { "id": "'+folder.CF_box_folder_id__c+'", "type": "folder"}, "accessible_by": { "id": "'+groupId+'", "type": "group" }, "role": "'+role+'"}');
                    system.debug('TestTest'+req.getBody() );                
                    HTTPResponse res = new Http().send(req);
                    // Collaboration__c clb; 
                    Collaborationwrapper cw = new Collaborationwrapper();
                    system.debug(res.getStatusCode()+'hiiiii'+res.getbody());
                    if(res.getStatusCode() == 201){
                        status = 'Success';
                        cw = (Collaborationwrapper)JSON.deserialize(res.getBody(),Collaborationwrapper.class);
                        lstCollaborations.add(new Collaboration__c(BoxCollaboration_Id__c = cw.Id,Role__c= cw.role,BoxFolder_Id__c= folder.CF_box_folder_id__c,Sub_folder__c= folder.id,BoxGroup_Id__c=groupId,SFUser_Email__c = 'group@test.com',SFProfile_Id__c = ProfId));
                        isCallSuccess = true;
                    }
                    else if(res.getStatusCode() == 401){
                        status = 'Error';
                        BoxREFRESHAccessTokenScheduler.getToken();
                        isCallSuccess = false;
                        
                    }
                    else{
                        status = 'Error';
                    }
                    BoxLogs.createLogs('CreateCollaborationOnStageChangeBatch-CreateUserGroupCollaboration',folder.CF_deal__c, folder.id, res.getBody(), BoxLogs.CREATE_GROUP_COLLABORATION , status  , res.getStatusCode()+'', '', role, lstBoxLogs);
                }
            }
            catch(Exception e){
                status  = 'Exception';
                BoxLogs.createLogs('CreateCollaborationOnStageChangeBatch-CreateUserGroupCollaboration',folder.CF_deal__c, folder.id, e.getMessage() +'#' +e.getStacktraceString(), BoxLogs.CREATE_GROUP_COLLABORATION , status, '', '', role, lstBoxLogs);
                
            }
      }  
        
   }  
   
    public void CreateLookupUserCollaboration(List<Sub_Folder__c>fIdlst,String ProfId,Set<String> userEmails, String role, List<Box_Log__c> lstBoxLogs, List<Collaboration__c> lstCollaborations){
        system.debug('--CreateLookupUserCollaboration--------------'+fIdlst+'-----------ProfId---------'+ProfId);      
        for(Sub_Folder__c folder : fIdlst){
            if(role != null){
                BoxCollaboration.createCollaboration('CreateCollaborationOnStageChangeBatch-CreateLookupUserCollaboration',ProfId,role,folder.CF_box_folder_id__c, userEmails ,folder.CF_deal__c, folder.id, lstBoxLogs, lstCollaborations); 
            }
        }  
    } 
       
    public void CreatePrfLookupUserCollaboration(List<Sub_Folder__c> fIdlst,Set<String> userEmails, String role,String ProfId, List<Box_Log__c> lstBoxLogs, List<Collaboration__c> lstCollaborations){
    
        for(Sub_Folder__c folder : fIdlst){
    
            if(role != null){
                BoxCollaboration.createCollaboration('CreateCollaborationOnStageChangeBatch-CreatePrfLookupUserCollaboration',ProfId,role,folder.CF_box_folder_id__c, userEmails ,folder.CF_deal__c, folder.id, lstBoxLogs, lstCollaborations); 
            }
        }
    }  
    
    
    public class CollaborationWrapper {
    
        public String type;
        public String id;
        public Accessible_by accessible_by;
        public String role;
        public String acknowledged_at;
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