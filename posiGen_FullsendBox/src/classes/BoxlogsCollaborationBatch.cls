public with sharing class BoxlogsCollaborationBatch implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful{
 
  public String base_url = 'https://app.box.com/files/0/f/';
  public string  foldername ='';
  public Set<String> folderSet;
  public List<String> emailSet;
   
  public BoxlogsCollaborationBatch(String folderName,List<String>emailSet,Set<String>folderSet){
    this.emailSet = emailSet;
    this.foldername =foldername;
    this.folderSet= folderSet; 
  } 
  Map<String,string> Usermap;
  Map<string,List<string>> Contactmap;
  public Database.QueryLocator start(Database.BatchableContext BC){
        Usermap = new Map<String,string>();
        
         for(User u:[Select email,profileId from user where Isactive=true and email in:emailSet]){
              Usermap.put(u.email,u.profileId);
          } 
      
    
     return Database.getQueryLocator('Select id,cf_opportunity__c,CF_Box_Folder_Id__c,cf_opportunity__r.Pipeline_Stage__c from Sub_Folder__c where name=:folderName and id in:folderSet');
  }
  
  public void execute(Database.BatchableContext BC, List<Sub_Folder__c> fldList){
     system.debug('======'+fldList);
    List<Collaboration__c> lstcollab = new List<Collaboration__c>();
    List<Box_Error__c> boxlogsList = new List<Box_Error__c>();     
    Set<String> NewstagesSet= new Set<String>();
   
    List<String> foldIdlst = new List<String>(); 
        
   
    for(Sub_Folder__c sb: fldList){
        NewstagesSet.add(sb.cf_opportunity__r.Pipeline_Stage__c);
        foldIdlst.add(sb.CF_Box_Folder_Id__c);
     }
    
    Map<String,String> profilePermissionMap = new Map<String,String>();
      
   for(BoxAccessMatrix_Stage__c bxStg:[select Box_Permission__c,BoxAccessMatrix_Profile__r.Lookup_field_Name__c,
        BoxAccessMatrix_Profile__r.Profile_Name__c, BoxAccessMatrix_Profile__r.Profile_Id__c, Stage__c 
        from BoxAccessMatrix_Stage__c 
        where BoxAccessMatrix_Profile__r.BoxAccessMatrix_SubFolder__r.SubFolder_Name__c =: folderName 
        and check__c =true and Stage__c in:NewstagesSet]){       
            profilePermissionMap.put(bxStg.BoxAccessMatrix_Profile__r.Profile_Id__c,bxStg.Box_Permission__c);
     }
     
    
     system.debug('foldIdlst size='+foldIdlst.size());
          
         for(Sub_Folder__c sb:fldList){
             
                BoxlogsCollaborationBatch.CreateLookupUserCollaboration(emailSet,sb,Usermap,profilePermissionMap,lstcollab,boxlogsList);
            }
         insert lstcollab;
         insert boxlogsList; 
        
        }
     
    
          
  
  
  public void finish(Database.BatchableContext BC){}
  
  
 public static void CreateLookupUserCollaboration(List<String>userEmail,Sub_Folder__c sb,Map<String,String>Usermap,Map<String,String>PermissionMap,List<Collaboration__c> lstcollab,List<Box_Error__c> bxErrList){
           
        try{
        
        boolean isCallSuccess = true;
        Integer lastIndex = -1;
        String  userEm;
        for(integer i=0; i<userEmail.size(); i++){
            
            if(!isCallSuccess)
                i = lastIndex; 
            lastIndex = i;
            userEm = userEmail[i];
         
            if(sb.CF_Box_Folder_Id__c!= null && userEm!= null){
                Box__c box = Box__c.getInstance();
                HttpRequest req = new HttpRequest();
                req.setEndpoint('https://api.box.com/2.0/collaborations');
                req.setMethod('POST');
                req.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
                req.setBody('{"item": { "id": "'+sb.CF_Box_Folder_Id__c+'", "type": "folder"}, "accessible_by": { "login": "'+userEm+'", "type": "user" }, "role": "'+PermissionMap.get(Usermap.get(userEm))+'"}');
                HTTPResponse res = new Http().send(req);
                CollaborationUserWrapper cuw = new CollaborationUserWrapper ();
                system.debug(res.getStatusCode()+'hiiiii'+res.getbody());
                if(res.getStatusCode() == 201){
                    cuw = (CollaborationUserWrapper)JSON.deserialize(res.getBody(),CollaborationUserWrapper.class);
                    Collaboration__c clb = new Collaboration__c();
                    if(cuw.accessibleby!=null){
                        clb.BoxCollaboration_Id__c = cuw.Id;
                        clb.Role__c= cuw.role;
                        clb.BoxFolder_Id__c= sb.CF_Box_Folder_Id__c;
                        clb.BoxUser_Id__c=cuw.accessibleby.id;
                       }
                    else{
                        clb.BoxCollaboration_Id__c = cuw.id;
                        clb.Role__c= cuw.role;
                        clb.BoxFolder_Id__c= sb.CF_Box_Folder_Id__c;
                        clb.BoxUser_Id__c='';
                       } 
                    clb.SFUser_Email__c = userEm;
                    clb.SFProfile_Id__c = Usermap.get(userEm);     
                    lstcollab.add(clb);
                }
               else if(res.getStatusCode() == 401){
                    BoxREFRESHAccessTokenScheduler.getToken();
                    isCallSuccess = false;
                }
                else{
                     Box_Error__c bxerr = new Box_Error__c();
                     bxerr.name = String.valueOf(res.getStatusCode()); 
                     bxerr.Body__c = res.getBody();
                     bxerr.Type__c = 'Collaboration';
                     bxerr.Status__c = 'Error';
                     bxerr.useremail__c = userEm;
                     bxerr.Sub_folder__c = sb.id;
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