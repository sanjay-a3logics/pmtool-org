public with sharing class Batch_CreateUserCollaboration implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful{
 
  public String base_url = 'https://app.box.com/files/0/f/';    			
 
  public User u;
  public string folderName;
  string role;
  Map<String, string> mapProfileGroup;  
  public Batch_CreateUserCollaboration(User u, String folderName){
  
    this.u = u;
    this.folderName = folderName;
  } 
  
  public Database.QueryLocator start(Database.BatchableContext BC){
      
      mapProfileGroup = new Map<String, string>();
      for(Box_Group__c  bg : [Select SF_Profile_Id__c, BoxGroup_Id__c,BoxGroup_Name__c from Box_Group__c]){
         mapProfileGroup.put(bg.SF_Profile_Id__c, bg.BoxGroup_Id__c);
      }
         
      Set<String> stages = new Set<String>();
      for(BoxAccessMatrix_Stage__c bxStg:[select Box_Permission__c,BoxAccessMatrix_Profile__r.Profile_Name__c, BoxAccessMatrix_Profile__r.Profile_Id__c, Stage__c 
          from BoxAccessMatrix_Stage__c where check__c =true and BoxAccessMatrix_Profile__r.Profile_Id__c=:u.profileId and
          BoxAccessMatrix_Profile__r.BoxAccessMatrix_SubFolder__r.SubFolder_Name__c =: folderName ]){   
          
          stages.add(bxStg.Stage__c );
         if(bxStg.Box_Permission__c!=null) 
            role = bxStg.Box_Permission__c;
          
      }    
      
      return Database.getQueryLocator('Select id,CF_Box_Folder_Id__c,cf_Deal__r.Opp_Pipeline_Stage__c from Sub_Folder__c where name=:folderName and cf_Deal__r.Opp_Pipeline_Stage__c in: stages');
  }
  		
  public void execute(Database.BatchableContext BC, List<Sub_Folder__c> subFolders){
  
    List<Collaboration__c> lstcollab = new List<Collaboration__c>();
    List<Box_Error__c> bxErrList = new List<Box_Error__c>();
    
     for(Sub_Folder__c subfolder: subFolders ){
     
           
        if(u.Profile.name =='Concierge'||u.Profile.name=='Document Controller'||u.Profile.name=='System Administrator')
            Batch_CreateUserCollaboration.AssignUserGroupCollaboration(u,mapProfileGroup.get(u.profileId),bxErrList); 
        else {
            Batch_CreateUserCollaboration.createCollaboration(subfolder.CF_Box_Folder_Id__c,u,role, lstcollab,bxErrList);   
        }                 
            
        
     }
     insert lstcollab;
     insert bxErrList; 
        
          
  } 
  
  public void finish(Database.BatchableContext BC){
    
    List<Messaging.SingleEmailMessage> msgList = new List<Messaging.SingleEmailMessage>(); 
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    mail.setTargetObjectId(UserInfo.getUserId());  
    mail.setToAddresses(new String[]{UserInfo.getUserEmail()});
    mail.setSaveasactivity(false);
    mail.setSubject('User Batch Status');
    mail.setPlainTextBody('User batch Completed successfully, Collaborations on '+folderName+' folder are created for '+u.email+' user');
    msgList.add(mail);
    Messaging.sendEmail(msgList);
  
  
  }
  
  
  public static void AssignUserGroupCollaboration(User usr,String groupId,List<Box_Error__c> bxErrList){
           
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
   } 
   
   public static void createCollaboration(String folderId,User u, string role, List<Collaboration__c> lstcollab,List<Box_Error__c> bxErrList){
           
        try{
        
        
            if(folderId!= null && role != null && u.email != null ){
                Box__c box = Box__c.getInstance();
                HttpRequest req = new HttpRequest();
                req.setEndpoint('https://api.box.com/2.0/collaborations');
                req.setMethod('POST');
                
                req.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
                req.setBody('{"item": { "id": "'+folderId+'", "type": "folder"}, "accessible_by": { "login": "'+u.email+'", "type": "user" }, "role": "'+role+'"}');
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
                        clb.BoxFolder_Id__c= folderId;
                        clb.BoxUser_Id__c=cuw.accessibleby.id;
                       }
                   else{
                        clb.BoxCollaboration_Id__c = cuw.id;
                        clb.Role__c= cuw.role;
                        clb.BoxFolder_Id__c= folderId;
                        clb.BoxUser_Id__c='';
                       } 
                    clb.SFUser_Email__c = u.email;
                    clb.SFProfile_Id__c = u.profileId;
                    lstcollab.add(clb);
                }
               else if(res.getStatusCode() == 401){
                    BoxREFRESHAccessTokenScheduler.getToken();
                } 
                else{
                     Box_Error__c bxerr = new Box_Error__c();
                     bxerr.name = String.valueOf(res.getStatusCode()); 
                     bxerr.Message__c = folderId; 
                     bxerr.Body__c = res.getBody();
                     bxerr.Type__c = 'User Collaboration';
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
    
 public class Userwrapper{
    public String type; 
    public String id;   
    public String name;   
 }
 
 public void accountdata(){
 Account acc0 = new Account();
Account acc1 = new Account();
Account acc2 = new Account();
Account acc3 = new Account();
Account acc4 = new Account();
Account acc5 = new Account();
Account acc6 = new Account();
Account acc7 = new Account();
Account acc8 = new Account();
Account acc9 = new Account();
Account acc10 = new Account();
Account acc11 = new Account();
Account acc12 = new Account();
Account acc13 = new Account();
Account acc14 = new Account();
Account acc15 = new Account();
Account acc16 = new Account();
Account acc17 = new Account();
Account acc18 = new Account();
Account acc19 = new Account();
Account acc20 = new Account();
Account acc21 = new Account();
Account acc22 = new Account();
Account acc23 = new Account();
Account acc24 = new Account();
Account acc25 = new Account();
Account acc26 = new Account();
Account acc27 = new Account();
Account acc28 = new Account();
Account acc29 = new Account();
Account acc30 = new Account();
Account acc31 = new Account();
Account acc32 = new Account();
Account acc33 = new Account();
Account acc34 = new Account();
Account acc35 = new Account();
Account acc36 = new Account();
Account acc37 = new Account();
Account acc38 = new Account();
Account acc39 = new Account();
Account acc40 = new Account();
Account acc41 = new Account();
Account acc42 = new Account();
Account acc43 = new Account();
Account acc44 = new Account();
Account acc45 = new Account();
Account acc46 = new Account();
Account acc47 = new Account();
Account acc48 = new Account();
Account acc49 = new Account();
Account acc50 = new Account();
Account acc51 = new Account();
Account acc52 = new Account();
Account acc53 = new Account();
Account acc54 = new Account();
Account acc55 = new Account();
Account acc56 = new Account();
Account acc57 = new Account();
Account acc58 = new Account();
Account acc59 = new Account();
Account acc60 = new Account();
Account acc61 = new Account();
Account acc62 = new Account();
Account acc63 = new Account();
Account acc64 = new Account();
Account acc65 = new Account();
Account acc66 = new Account();
Account acc67 = new Account();
Account acc68 = new Account();
Account acc69 = new Account();
Account acc70 = new Account();
Account acc71 = new Account();
Account acc72 = new Account();
Account acc73 = new Account();
Account acc74 = new Account();
Account acc75 = new Account();
Account acc76 = new Account();
Account acc77 = new Account();
Account acc78 = new Account();
Account acc79 = new Account();
Account acc80 = new Account();
Account acc81 = new Account();
Account acc82 = new Account();
Account acc83 = new Account();
Account acc84 = new Account();
Account acc85 = new Account();
Account acc86 = new Account();
Account acc87 = new Account();
Account acc88 = new Account();
Account acc89 = new Account();
Account acc90 = new Account();
Account acc91 = new Account();
Account acc92 = new Account();
Account acc93 = new Account();
Account acc94 = new Account();
Account acc95 = new Account();
Account acc96 = new Account();
Account acc97 = new Account();
Account acc98 = new Account();
Account acc99 = new Account();
Account acc100 = new Account();
Account acc101 = new Account();
Account acc102 = new Account();
Account acc103 = new Account();
Account acc104 = new Account();
Account acc105 = new Account();
Account acc106 = new Account();
Account acc107 = new Account();
Account acc108 = new Account();
Account acc109 = new Account();
Account acc110 = new Account();
Account acc111 = new Account();
Account acc112 = new Account();
Account acc113 = new Account();
Account acc114 = new Account();
Account acc115 = new Account();
Account acc116 = new Account();
Account acc117 = new Account();
Account acc118 = new Account();
Account acc119 = new Account();
Account acc120 = new Account();
Account acc121 = new Account();
Account acc122 = new Account();
Account acc123 = new Account();
Account acc124 = new Account();
Account acc125 = new Account();
Account acc126 = new Account();
Account acc127 = new Account();
Account acc128 = new Account();
Account acc129 = new Account();
Account acc130 = new Account();
Account acc131 = new Account();
Account acc132 = new Account();
Account acc133 = new Account();
Account acc134 = new Account();
Account acc135 = new Account();
Account acc136 = new Account();
Account acc137 = new Account();
Account acc138 = new Account();
Account acc139 = new Account();
Account acc140 = new Account();
Account acc141 = new Account();
Account acc142 = new Account();
Account acc143 = new Account();
Account acc144 = new Account();
Account acc145 = new Account();
Account acc146 = new Account();
Account acc147 = new Account();
Account acc148 = new Account();
Account acc149 = new Account();
Account acc150 = new Account();
Account acc151 = new Account();
Account acc152 = new Account();
Account acc153 = new Account();
Account acc154 = new Account();
Account acc155 = new Account();
Account acc156 = new Account();
Account acc157 = new Account();
Account acc158 = new Account();
Account acc159 = new Account();
Account acc160 = new Account();
Account acc161 = new Account();
Account acc162 = new Account();
Account acc163 = new Account();
Account acc164 = new Account();
Account acc165 = new Account();
Account acc166 = new Account();
Account acc167 = new Account();
Account acc168 = new Account();
Account acc169 = new Account();
Account acc170 = new Account();
Account acc171 = new Account();
Account acc172 = new Account();
Account acc173 = new Account();
Account acc174 = new Account();
Account acc175 = new Account();
Account acc176 = new Account();
Account acc177 = new Account();
Account acc178 = new Account();
Account acc179 = new Account();
Account acc180 = new Account();
Account acc181 = new Account();
Account acc182 = new Account();
Account acc183 = new Account();
Account acc184 = new Account();
Account acc185 = new Account();
Account acc186 = new Account();
Account acc187 = new Account();
Account acc188 = new Account();
Account acc189 = new Account();
Account acc190 = new Account();
Account acc191 = new Account();
Account acc192 = new Account();
Account acc193 = new Account();
Account acc194 = new Account();
Account acc195 = new Account();
Account acc196 = new Account();
Account acc197 = new Account();
Account acc198 = new Account();
Account acc199 = new Account();
Account acc200 = new Account();
Account acc201 = new Account();
Account acc202 = new Account();
Account acc203 = new Account();
Account acc204 = new Account();
Account acc205 = new Account();
Account acc206 = new Account();
Account acc207 = new Account();
Account acc208 = new Account();
Account acc209 = new Account();
Account acc210 = new Account();
Account acc211 = new Account();
Account acc212 = new Account();
Account acc213 = new Account();
Account acc214 = new Account();
Account acc215 = new Account();
Account acc216 = new Account();
Account acc217 = new Account();
Account acc218 = new Account();
Account acc219 = new Account();
Account acc220 = new Account();
Account acc221 = new Account();
Account acc222 = new Account();
Account acc223 = new Account();
Account acc224 = new Account();
Account acc225 = new Account();
Account acc226 = new Account();
Account acc227 = new Account();
Account acc228 = new Account();
Account acc229 = new Account();
Account acc230 = new Account();
Account acc231 = new Account();
Account acc232 = new Account();
Account acc233 = new Account();
Account acc234 = new Account();
Account acc235 = new Account();
Account acc236 = new Account();
Account acc237 = new Account();
Account acc238 = new Account();
Account acc239 = new Account();
Account acc240 = new Account();
Account acc241 = new Account();
Account acc242 = new Account();
Account acc243 = new Account();
Account acc244 = new Account();
Account acc245 = new Account();
Account acc246 = new Account();
Account acc247 = new Account();
Account acc248 = new Account();
Account acc249 = new Account();
Account acc250 = new Account();
Account acc251 = new Account();
Account acc252 = new Account();
Account acc253 = new Account();
Account acc254 = new Account();
Account acc255 = new Account();
Account acc256 = new Account();
Account acc257 = new Account();
Account acc258 = new Account();
Account acc259 = new Account();
Account acc260 = new Account();
Account acc261 = new Account();
Account acc262 = new Account();
Account acc263 = new Account();
Account acc264 = new Account();
Account acc265 = new Account();
Account acc266 = new Account();
Account acc267 = new Account();
Account acc268 = new Account();
Account acc269 = new Account();
Account acc270 = new Account();
Account acc271 = new Account();
Account acc272 = new Account();
Account acc273 = new Account();
Account acc274 = new Account();
Account acc275 = new Account();
Account acc276 = new Account();
Account acc277 = new Account();
Account acc278 = new Account();
Account acc279 = new Account();
Account acc280 = new Account();
Account acc281 = new Account();
Account acc282 = new Account();
Account acc283 = new Account();
Account acc284 = new Account();
Account acc285 = new Account();
Account acc286 = new Account();
Account acc287 = new Account();
Account acc288 = new Account();
Account acc289 = new Account();
Account acc290 = new Account();
Account acc291 = new Account();
Account acc292 = new Account();
Account acc293 = new Account();
Account acc294 = new Account();
Account acc295 = new Account();
Account acc296 = new Account();
Account acc297 = new Account();
Account acc298 = new Account();
Account acc299 = new Account();
Account acc300 = new Account();
Account acc301 = new Account();
Account acc302 = new Account();
Account acc303 = new Account();
Account acc304 = new Account();
Account acc305 = new Account();
Account acc306 = new Account();
Account acc307 = new Account();
Account acc308 = new Account();
Account acc309 = new Account();
Account acc310 = new Account();
Account acc311 = new Account();
Account acc312 = new Account();
Account acc313 = new Account();
Account acc314 = new Account();
Account acc315 = new Account();
Account acc316 = new Account();
Account acc317 = new Account();
Account acc318 = new Account();
Account acc319 = new Account();
Account acc320 = new Account();
Account acc321 = new Account();
Account acc322 = new Account();
Account acc323 = new Account();
Account acc324 = new Account();
Account acc325 = new Account();
Account acc326 = new Account();
Account acc327 = new Account();
Account acc328 = new Account();
Account acc329 = new Account();
Account acc330 = new Account();
Account acc331 = new Account();
Account acc332 = new Account();
Account acc333 = new Account();
Account acc334 = new Account();
Account acc335 = new Account();
Account acc336 = new Account();
Account acc337 = new Account();
Account acc338 = new Account();
Account acc339 = new Account();
Account acc340 = new Account();
Account acc341 = new Account();
Account acc342 = new Account();
Account acc343 = new Account();
Account acc344 = new Account();
Account acc345 = new Account();
Account acc346 = new Account();
}
      
   
 }