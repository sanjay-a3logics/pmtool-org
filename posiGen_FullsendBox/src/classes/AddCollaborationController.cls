public without sharing class AddCollaborationController{
    
    public Deal__c opp;			
    public Map<String,List<BoxAccessMatrix_Stage__c>> matrixMap;
    public List<Collaboration__c> lstcollab;
    public List<Sub_Folder__c> subFolderList;
    public List<Box_Log__c> boxLoglst;
    public List<folderlogwrapper> boxfolderLog{get;set;}
    public List<LogWrapper> boxLogList{get;set;}
    public Map<String,String> profileLookUpNameMap;
    public String status;
    public Set<String> emailSet;
    public Set<String> profileIdset;
    
    
    public AddCollaborationController(ApexPages.StandardController controller){
        opp = (Deal__c)controller.getRecord();
        emailSet = new Set<String>{userInfo.getUseremail()};
        matrixMap = new Map<String,List<BoxAccessMatrix_Stage__c>>(); 
        lstcollab = new List<Collaboration__c>();
        subFolderList = new List<Sub_Folder__c>();
        boxLoglst= new List<Box_Log__c>();
        boxfolderLog = new List<folderlogwrapper>();
        boxLogList = new List<LogWrapper >();
        profileLookUpNameMap = new Map<String,String>();
        profileIdset = new Set<String>();
    }
    
    
    public void createCollaboration(){
        status = '';
        
        try{ 
            Box__c box = Box__c.getInstance();
            opp = [Select id,Name,Opp_Pipeline_Stage__c,O_Box_Folder_Id__c from Deal__c where id=:opp.Id];
            boxLoglst = new  List<Box_log__c>();
           
            
            for(BoxAccessMatrix_Stage__c bxStg:[select BoxAccessMatrix_Profile__r.BoxAccessMatrix_SubFolder__r.SubFolder_Name__c, Box_Permission__c,BoxAccessMatrix_Profile__r.Lookup_field_Name__c,BoxAccessMatrix_Profile__r.Profile_Name__c, BoxAccessMatrix_Profile__r.Profile_Id__c, Stage__c from BoxAccessMatrix_Stage__c where  check__c =true and Stage__c =:opp.Opp_Pipeline_Stage__c]){       
                if(!matrixMap.containskey(bxStg.BoxAccessMatrix_Profile__r.BoxAccessMatrix_SubFolder__r.SubFolder_Name__c)){ 
                    matrixMap.put(bxStg.BoxAccessMatrix_Profile__r.BoxAccessMatrix_SubFolder__r.SubFolder_Name__c,new List<BoxAccessMatrix_Stage__c>());
                }
                matrixMap.get(bxStg.BoxAccessMatrix_Profile__r.BoxAccessMatrix_SubFolder__r.SubFolder_Name__c).add(bxStg);
                profileLookUpNameMap.put(bxStg.BoxAccessMatrix_Profile__r.Profile_Id__c,bxStg.BoxAccessMatrix_Profile__r.Lookup_field_Name__c); 
                profileIdset.add(bxStg.BoxAccessMatrix_Profile__r.Profile_Id__c); 
                
            }
            
            
            if(opp.O_Box_Folder_Id__c==null){
            
                
                String oppName = opp.Name;
                System.debug('############## name before replace'+oppName);
                oppName = oppName.replace('\t', '');
                oppName = oppName.replace('"', '\'');
                oppName = oppName.replace('\\', '-');
                oppName = oppName.replace('/', '-');
                System.debug('############## name after replace'+oppName);
                
                /** Creating Main Folder **/
                HttpRequest req = new HttpRequest();
                req.setEndpoint('https://api.box.com/2.0/folders');
                req.setMethod('POST');
                req.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
                
                req.setBody('{"name":"'+oppName+'", "parent": {"id": "11590061268"}}');
                
                Http http = new Http();
                HTTPResponse res = http.send(req);
                system.Debug('#######'+res.getBody());
                if(res.getStatusCode() == 201){
                    
                    status = 'Success';     
                    folderWrapper fw=(folderWrapper)JSON.deserialize(res.getBody(),folderWrapper.class);
                    
                    BoxAPIServicesController.createSubFolder('EE',fw.Id, oppName,Opp.Id,box, subFolderList, boxLoglst);
                    BoxAPIServicesController.createSubFolder('Funding-Vendor',fw.Id, oppName,Opp.Id,box, subFolderList, boxLoglst);
                    BoxAPIServicesController.createSubFolder('Application',fw.Id, oppName,Opp.Id,box, subFolderList, boxLoglst);
                    BoxAPIServicesController.createSubFolder('Sales',fw.Id, oppName,Opp.Id,box, subFolderList, boxLoglst);
                    
                    Opp.O_Box_Folder_Id__c = fw.Id;
                    
                }
                else if(res.getStatusCode() == 409){ // if Deal__c folder name is duplicate
                    status = 'Error'; 
                    system.debug('======'+opp.id);
                    List<Deal__c> opps = [select id from Deal__c where name =: opp.name];
                    if (opps.size() > 0) {
                        integer count = (opps.size());
                        oppName =  opp.name + ' ('+ count +')';
                        res = createOpportunityFolder(oppName, box);
                          
                        folderWrapper fw = (folderWrapper)JSON.deserialize(res.getBody(),folderWrapper.class);
                        
                        BoxAPIServicesController.createSubFolder('EE',fw.Id, oppName,Opp.Id,box, subFolderList, boxLoglst);
                        BoxAPIServicesController.createSubFolder('Funding-Vendor',fw.Id, oppName,Opp.Id,box, subFolderList, boxLoglst);
                        BoxAPIServicesController.createSubFolder('Application',fw.Id, oppName,Opp.Id,box, subFolderList, boxLoglst);
                        BoxAPIServicesController.createSubFolder('Sales',fw.Id, oppName,Opp.Id,box, subFolderList, boxLoglst);
                        Opp.O_Box_Folder_Id__c = fw.Id;
                        
                    }
                    
                }  
                update opp; 
                insert  subFolderList; 
                
            }
            else{
                Map<String,String> SubfolderMap = new Map<String,String>();
                
                for(Sub_folder__c sf:[Select Name,CF_Box_Folder_Id__c from Sub_folder__c where CF_Deal__c=:opp.id]){
                    SubfolderMap.put(sf.Name,sf.CF_Box_Folder_Id__c);
                }
                
                if(SubfolderMap.values().size()<4){  
                    for(BoxAccessMatrix_SubFolder__c bsf:[Select SubFolder_Name__c from BoxAccessMatrix_SubFolder__c where name!=null]){
                        
                        if(SubfolderMap.get(bsf.SubFolder_Name__c)==null){
                            BoxAPIServicesController.createSubFolder(bsf.SubFolder_Name__c,opp.O_Box_Folder_Id__c,opp.Name,opp.id,box, subFolderList, boxLoglst);
                        }
                        
                    }
                    
                    
                    insert  subFolderList;  
                }
                
            }
            
        }
        catch(Exception e){
            system.debug('--Check Create Collaboration'+e.getmessage()+'--'+e.getLineNumber());
            Apexpages.addMessages(e);
            
        }   
        
    }
    public static HTTPResponse createOpportunityFolder(string oppName, Box__c box) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.box.com/2.0/folders');
        req.setMethod('POST');
        req.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
        req.setBody('{"name":"'+oppName+'", "parent": {"id": "11590061268"}}');  		
        
        Http http = new Http();   					
        HTTPResponse res = http.send(req);	  										
        return res;
    } 
    
    public void collaborationlogist(){
        boxLogList = new List<LogWrapper>();
        
        try{
            if(subFolderList.size()>0){
                List<String>folderIdlist = new List<String>();
                for(Box_Log__c bl: [Select id,Error_Code__c,Error_Message__c,Deal__r.Name,Status__c,Sub_Folder__r.name,Type__c from Box_Log__c where Deal__c =:opp.id and (not type__c  like '%collaboration')]){
                    
                    folderlogwrapper flw = new folderlogwrapper();
                    flw.Oppname = bl.Deal__r.Name;
                    flw.StatusCode= bl.Error_Code__c;
                    flw.Status =bl.Status__c;
                    
                    if(bl.Error_Message__c != null && bl.Error_Message__c != 'TOKEN IS NULL'){
                        foldermessagewrapper msgTxt = (foldermessagewrapper)JSON.deserialize(bl.Error_Message__c,foldermessagewrapper.class);
                        flw.subfolder= msgTxt.name;
                        flw.msg = msgTxt.message;
                    } 
                    else{
                        flw.msg = bl.Error_Message__c;
                    } 
                    boxfolderLog.add(flw); 
                }
                
                
            } 
            
            for(Box_Log__c bl: [Select id,Collaboration_Role__c,email__c,Error_Code__c,Error_Message__c,Deal__c,Deal__r.Opp_Pipeline_Stage__c,Status__c,Sub_Folder__r.name,Type__c from Box_Log__c where Deal__c=:opp.id and email__c =:userInfo.getUseremail()]){
                
                LogWrapper logWrap = new LogWrapper();
                logWrap.SubFolder = bl.Sub_Folder__r.name;
                logWrap.email = bl.email__c;
                logWrap.ErrorCode = bl.Error_Code__c;
                logWrap.Status = bl.Status__c;
                logWrap.role = bl.Collaboration_Role__c;
                logWrap.stagename = bl.Deal__r.Opp_Pipeline_Stage__c;			
                
                if(bl.Error_Message__c != null && bl.Error_Message__c != 'TOKEN IS NULL'){
                    LogMessageWrapper msgTxt = (LogMessageWrapper)JSON.deserialize(bl.Error_Message__c,LogMessageWrapper.class);
                    logWrap.msg = msgTxt.message;
                }
                else{
                    logWrap.msg = bl.Error_Message__c;
                }
                
                boxLogList.add(logWrap);
            }    
            
        }
        catch(Exception e){
            Apexpages.addMessages(e);
        }
        
        
        
    } 
    public Pagereference backtoOpportunity(){
        Pagereference pr = new Pagereference('/'+opp.id);
        return pr;
    } 
    public void createColl(){
        try{
             String sObjName;
             Map<string,List<string>> Contactmap = new Map<string,List<string>>(); 
           
             Map<Id,string> Usermap = new Map<Id,string>();
              for(User u:[Select id ,email from user where Isactive=true and profileId in:profileIdset]){
                     if(u.email!=null) 
                      Usermap.put(u.id,u.email);
                }
           
      
            for(Account acc:[Select id, (Select email from contacts where email!=null) from Account where id!=null]){
              if(acc.contacts.size()>0){   
                 for(Contact con :acc.contacts){
                    if(!Contactmap.containsKey(acc.id)){
                        Contactmap.put(acc.id, new List<string>());
                    }
                    Contactmap.get(acc.id).add(con.email);
                  }
                } 
              
              } 
           
            for(Sub_folder__c  sf:[Select Name,CF_Box_Folder_Id__c from Sub_folder__c where CF_Deal__c=:opp.id]){
               
                if(matrixMap.containsKey(sf.name)){
                    
                    for(BoxAccessMatrix_Stage__c  bsm :matrixMap.get(sf.name)){
                           
                        if(bsm.BoxAccessMatrix_Profile__r.Profile_Id__c==userinfo.getprofileId()){ 
                             
                         if(profileLookUpNameMap.get(bsm.BoxAccessMatrix_Profile__r.Profile_Id__c)!=null){
                              
                            if(profileLookUpNameMap.get(bsm.BoxAccessMatrix_Profile__r.Profile_Id__c)=='Subcontractor__c' || profileLookUpNameMap.get(bsm.BoxAccessMatrix_Profile__r.Profile_Id__c)=='EE_Assessor__c'){
                                
                                if(profileLookUpNameMap.get(bsm.BoxAccessMatrix_Profile__r.Profile_Id__c)=='Subcontractor__c'){
                                    
                                    String prjquery = 'Select '+ profileLookUpNameMap.get(bsm.BoxAccessMatrix_Profile__r.Profile_Id__c)+', RecordType.Name from project__c where Deal__c=\''+opp.id+'\'';
                                    
                                    for(Project__c prj:Database.query(prjquery)){
                                        if(prj.get(profileLookUpNameMap.get(bsm.BoxAccessMatrix_Profile__r.Profile_Id__c))!=null){
                                            Id LookupPrjId = String.valueOf(prj.get(profileLookUpNameMap.get(bsm.BoxAccessMatrix_Profile__r.Profile_Id__c)));
                                            
                                            
                                            string LookUpAccId = String.valueof(LookupPrjId);
                                            sObjName = LookupPrjId.getSObjectType().getDescribe().getName();   
                                            if(sObjName=='Account' && LookUpAccId!=null){
                                                
                                                if(sf.Name == 'EE' && (prj.RecordType.Name == 'EE Assessment'|| prj.RecordType.Name == 'EE Upgrade')){  
                                                    Set<String> emailSet = new Set<String>();
                                                    for(String acSt:Contactmap.get(LookUpAccId)){
                                                        if(acSt!=null) 
                                                        emailSet.add(acSt);
                                                    }
                                                   
                                                   //CreatePrfLookupUserCollaboration(fldList,emails,profilePermissionMap.get(ProfId),ProfId, lstBoxLogs, lstCollaborations);
                                                   
                                                    BoxCollaboration.createCollaboration('CreatePermission',bsm.BoxAccessMatrix_Profile__r.Profile_Id__c,bsm.Box_permission__c,sf.CF_Box_Folder_Id__c,emailSet,opp.id,sf.id,boxLoglst,lstcollab);
                                                }
                                                if(sf.Name != 'EE' && (prj.RecordType.Name != 'EE Assessment' && prj.RecordType.Name !='EE Upgrade')){  
                                                    Set<String> emailSet = new Set<String>();
                                                    for(String acSt:Contactmap.get(LookUpAccId)){
                                                        if(acSt!=null) 
                                                        emailSet.add(acSt);
                                                    }
                                                    //CreatePrfLookupUserCollaboration(fldList,emails,profilePermissionMap.get(ProfId),ProfId, lstBoxLogs, lstCollaborations);
                                                    BoxCollaboration.createCollaboration('CreatePermission',userinfo.getprofileId(),bsm.Box_permission__c,sf.CF_Box_Folder_Id__c,emailSet,opp.id,sf.id,boxLoglst,lstcollab);
                                                } 
                                            } 
                                        }   
                                    }
                                }
                                else if(profileLookUpNameMap.get(bsm.BoxAccessMatrix_Profile__r.Profile_Id__c)=='EE_Assessor__c'){
                                    String prjquery = 'Select '+ profileLookUpNameMap.get(bsm.BoxAccessMatrix_Profile__r.Profile_Id__c)+' from project__c where Deal__c=\''+opp.id+'\'';
                                    system.debug('hiiiiiii'+prjquery);
                                    for(Project__c prj:Database.query(prjquery)){
                                        if(prj.get(profileLookUpNameMap.get(bsm.BoxAccessMatrix_Profile__r.Profile_Id__c))!=null){
                                            Id LookupPrjId = String.valueOf(prj.get(profileLookUpNameMap.get(bsm.BoxAccessMatrix_Profile__r.Profile_Id__c))); 
                                            Set<String> emailSet = new Set<String>();
                                            if(Usermap.get(LookupPrjId) != null){
                                                emailSet.add(Usermap.get(LookupPrjId));
                                            }
                                            //CreatePrfLookupUserCollaboration(fldList,emails,profilePermissionMap.get(ProfId),ProfId, lstBoxLogs, lstCollaborations);
                                            BoxCollaboration.createCollaboration('CreatePermission',userinfo.getprofileId(),bsm.Box_permission__c,sf.CF_Box_Folder_Id__c,emailSet,opp.id,sf.id,boxLoglst,lstcollab);
                                        }
                                    }
                                    
                                }   
                                
                                
                                
                            }
                            
                            
                        }
                       else{
                        BoxCollaboration.createCollaboration('CreatePermission',userinfo.getprofileId(),bsm.Box_permission__c,sf.CF_Box_Folder_Id__c,emailSet,opp.id,sf.id,boxLoglst,lstcollab);
                       }
                      } 
                    }
                    
                }
                
            }
            insert lstcollab;  
            insert boxLoglst; 
        }
        catch(Exception e){
            system.debug(e.getStackTraceString());
            Apexpages.addMessages(e);
        }   
    }
    
    public class folderWrapper{
        public String Type;
        public String Id;
        public String Name;
    }  
    
    
    
    public class LogWrapper{
        
        public String SubFolder{get;set;}
        public String email{get;set;}
        public String ErrorCode{get;set;}
        public String Status{get;set;}
        public String msg{get;set;}
        public String role{get;set;}
        public String stagename{get;set;}
    }  
    
    public class LogMessageWrapper{
        
        public String message;
    }
    public class folderlogwrapper{
        public String SubFolder{get;set;}
        public String OppName{get;set;}
        public String StatusCode{get;set;}
        public String Status{get;set;}
        public string msg{get;set;}
    }
    public class foldermessagewrapper{
        public String name;
        public String message; 
    }  
    
    
    
}