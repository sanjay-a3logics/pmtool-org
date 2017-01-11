public with sharing class BoxAPIServicesController{
      
   // public static Collaboration__c clbSales{get;set;}
    //public static Boolean insertCollaborationSales{get;set;}
    
    public static Boolean callStageChange{get;set;}
    
    //public static Boolean callStageChange{get;set;}     
    
    public BoxAPIServicesController(){
        //insertCollaborationSales = false;
    }                      
    
  
   /* Function for creating folder structure in box.com account when an opportunity is created.
    * Description: This function will create one main folder of 'Opportunity (with its name)' 
    *              and four sub-folders 'Sales', 'Application', 'Funding-Vendor' and 'EE' in
    *              main folder of opportunity.  
    * Params:
    *     1. Name: OppIds, Type: Set of Id, Description: Opportunity record ids Set 
    */
    @future(callout = true)
    public static void CreateFolder(Set<Id> OppIds){
        String status = '';
        List<Box_Log__c> boxLogsLst = new List<Box_Log__c>();
        List<Collaboration__c> collaborationList = new List<Collaboration__c>();
        Map<String,Sub_folder__c> SubfolderMap = new Map<String,Sub_folder__c>();
        
            List<Deal__c> OppList = SoqlServices.getDealList(OppIds);
            List<Deal__c> UpdatedOppList = new List<Deal__c>();         
            List<Sub_Folder__c> subFolderLIst = new List<Sub_Folder__c>();
            
            Box__c box = Box__c.getInstance();
            System.debug(OppIds+'OppList Size --------- '+OppList.size());
            for(Deal__c Opp : OppList){
            
            try{
            
                //Replace the unsupported characters from opportunity name with "-".
                String oppName = Opp.Name;
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
                req.setBody('{"name":"'+oppName+'", "parent": {"id": "11590061268"}}');  //4407839250 //11590061268  //11590061268		
                
                Http http = new Http();
                HTTPResponse res = http.send(req);
                system.Debug('#######'+res.getBody());
                if(res.getStatusCode() == 201){
                
                    status = 'Success';     
                    folderWrapper fw=(folderWrapper)JSON.deserialize(res.getBody(),folderWrapper.class);
                    
                    createSubFolder('EE',fw.Id, oppName,Opp.Id,box, subFolderList, boxLogsLst);
                    createSubFolder('Funding-Vendor',fw.Id, oppName,Opp.Id,box, subFolderList, boxLogsLst);
                    createSubFolder('Application',fw.Id, oppName,Opp.Id,box, subFolderList, boxLogsLst);
                    createSubFolder('Sales',fw.Id, oppName,Opp.Id,box, subFolderList, boxLogsLst);
                    
                    Opp.O_Box_Folder_Id__c = fw.Id;
                    UpdatedOppList.add(Opp);
                }
                else if(res.getStatusCode() == 409){ // if opportunity folder name is duplicate
                     status = 'Error'; 
                     system.debug('======'+opp.id);
                     List<Deal__c> opps = [select id from Deal__c where name =: opp.name];
                     if (opps.size() > 0) {
                         integer count = (opps.size());
                        oppName =  opp.name + ' ('+ count +')';
                        res = createOpportunityFolder(oppName, box);
                        
                        folderWrapper fw = (folderWrapper)JSON.deserialize(res.getBody(),folderWrapper.class);
                        
                        createSubFolder('EE',fw.Id, oppName,Opp.Id,box, subFolderList, boxLogsLst);
                        createSubFolder('Funding-Vendor',fw.Id, oppName,Opp.Id,box, subFolderList, boxLogsLst);
                        createSubFolder('Application',fw.Id, oppName,Opp.Id,box, subFolderList, boxLogsLst);
                        createSubFolder('Sales',fw.Id, oppName,Opp.Id,box, subFolderList, boxLogsLst);
                        Opp.O_Box_Folder_Id__c = fw.Id;
                        UpdatedOppList.add(Opp);
                     }
                   
                }  
                else{
                    
                    status = 'Error';
                }
                BoxLogs.createLogs('BoxAPIServicesController-CreateFolder',String.valueOf(Opp.Id), null, res.getBody(), 'Create Deal Folder', status , res.getStatusCode()+'', '', '', boxLogsLst); 
                
            }
            catch(Exception e){
                BoxLogs.createLogs('BoxAPIServicesController-CreateFolder',Opp.Id, null, e.getMessage() +'#' +e.getStacktraceString(), 'Create folder', 'Exception', '', '', '', boxLogsLst);
            }
            }
            update UpdatedOppList;
            callStageChange = false;
            insert subFolderList;
            insert boxLogsLst; 
            
            for(Sub_Folder__c fold :subFolderList){
                SubfolderMap.put(fold.CF_Box_Folder_Id__c,fold);
            }
            
            
            for(Sub_Folder__c folder :subFolderList){
             
             if(folder.Name == 'Sales'){
                 
                  Datetime newTime = datetime.now().addSeconds(2);    
                  String sched= String.valueOf(newtime.second()) +' ' + String.valueOf(newtime.minute()) + ' ' + String.valueOf(newTime.hour()) + ' ' + String.valueOf(newTime.day()) + ' ' + String.valueOf(newTime.month()) + ' ? ' +  String.valueOf(newTime.year()); 
                  Double st = Math.random();
                  Scheduler_class1 SC = new Scheduler_class1('Sales',OppList[0].Opp_Pipeline_Stage__c,folder.CF_Box_Folder_Id__c); 
                  System.schedule('My batchNew Job1'+newTime+String.valueOf(st), sched, SC);
             }
             else if(folder.Name == 'Application'){
                 
                  Datetime newTime = datetime.now().addSeconds(2);    
                  String sched= String.valueOf(newtime.second()) +' ' + String.valueOf(newtime.minute()) + ' ' + String.valueOf(newTime.hour()) + ' ' + String.valueOf(newTime.day()) + ' ' + String.valueOf(newTime.month()) + ' ? ' +  String.valueOf(newTime.year()); 
                  Double st = Math.random();
                  Scheduler_class1 SC = new Scheduler_class1('Application',OppList[0].Opp_Pipeline_Stage__c,folder.CF_Box_Folder_Id__c); 
                  System.schedule('My batchNew Job1'+newTime+String.valueOf(st), sched, SC);
                 }
             else if(folder.Name == 'Funding-Vendor'){
                 
                  Datetime newTime = datetime.now().addSeconds(2);    
                  String sched= String.valueOf(newtime.second()) +' ' + String.valueOf(newtime.minute()) + ' ' + String.valueOf(newTime.hour()) + ' ' + String.valueOf(newTime.day()) + ' ' + String.valueOf(newTime.month()) + ' ? ' +  String.valueOf(newTime.year()); 
                  Double st = Math.random();
                  Scheduler_class1 SC = new Scheduler_class1('Funding-Vendor',OppList[0].Opp_Pipeline_Stage__c,folder.CF_Box_Folder_Id__c); 
                  System.schedule('My batchNew Job1'+newTime+String.valueOf(st), sched, SC);
                 }
             else if(folder.Name == 'EE'){
                
                  Datetime newTime = datetime.now().addSeconds(2);  		 						 
                  String sched= String.valueOf(newtime.second()) +' ' + String.valueOf(newtime.minute()) + ' ' + String.valueOf(newTime.hour()) + ' ' + String.valueOf(newTime.day()) + ' ' + String.valueOf(newTime.month()) + ' ? ' +  String.valueOf(newTime.year()); 
                  Double st = Math.random();
                  Scheduler_class1 SC = new Scheduler_class1('EE',OppList[0].Opp_Pipeline_Stage__c,folder.CF_Box_Folder_Id__c); 
                  System.schedule('My batchNew Job1'+newTime+String.valueOf(st), sched, SC);
                 }        
             
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
    
    
   public static void createSubFolder(string folderName,String parentFolderId, string oppName, string OppId,Box__c box, LIst<Sub_Folder__c> subFolderList,  List<Box_Log__c> boxLogsLst) {
        
        /** Creating sub-folder EE **/
        String status = '';
        String newFolderId = '';
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.box.com/2.0/folders');
        req.setMethod('POST');
        req.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
        req.setBody('{"name":"'+oppName+' - '+folderName+'", "parent": {"id": "'+parentFolderId+'"}}');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        
        folderWrapper fw = new folderWrapper();
        if(res.getStatusCode() == 201){
            
            fw = (folderWrapper)JSON.deserialize(res.getBody(),folderWrapper.class);
            
            string tempFolderName = '';
            List<string> splittedFolderName = fw.Name.split(' - ');
            tempFolderName = splittedFolderName[splittedFolderName.size()-1];
            if(tempFolderName.trim() == 'Vendor'){
                tempFolderName = 'Funding-Vendor';
            }
            
            system.debug('tempFolderName----'+tempFolderName);
           
            Sub_Folder__c sFolder = new Sub_Folder__c(CF_Box_Folder_Id__c = fw.Id,CF_Deal__c = OppId,Name = tempFolderName.trim());
            subFolderList.add(sFolder);
            
            status = 'Success';
            newFolderId = sFolder.id; 
        } 
        else{
            status = 'Error';
            newFolderId = '';
        }
       BoxLogs.createLogs('BoxAPIServicesController-createSubFolder',OppId, newFolderId, res.getBody(), 'Create Folder '+folderName, status , res.getStatusCode()+'', '', '', boxLogsLst);

   } 
    

 
 @future(callout = true)
  public static void deleteContactCollaborationOnStageChange(String ProfId, String boxFolderId, String oppId, String subFolderId){
  
       List<Collaboration__c> lstCollaborations = new List<Collaboration__c>();
       List<Box_Log__c> lstBoxLogs = new List<Box_Log__c>(); 

  
      Set<Collaboration__c> collaboration = new Set<Collaboration__c>([select BoxCollaboration_Id__c from Collaboration__c where SfProfile_Id__c=:ProfId and boxFolder_id__c=:boxFolderId]);
  
      BoxCollaboration.deleteCollaboration('BoxAPIServicesController-deleteContactCollaborationOnStageChange',oppId, subFolderId, collaboration, lstBoxLogs, lstCollaborations);

      delete lstCollaborations;
      insert lstBoxLogs;      
  }
   
 @future(Callout=true)  
  public static void  createcollaborationOnFolder(String ProfId,String role,String folderId,Set<String> emails, String oppId,string subFolderId  ){
  
      List<Collaboration__c> lstCollaborations = new List<Collaboration__c>();
      List<Box_Log__c> lstBoxLogs = new List<Box_Log__c>(); 
        
      BoxCollaboration.createCollaboration('BoxAPIServicesController-createcollaborationOnFolder',ProfId,role,folderId, emails ,oppId, subFolderId, lstBoxLogs, lstCollaborations) ; 
      
      insert lstCollaborations;
      insert lstBoxLogs;
  }   


 @future(callout = true)
  public static void changeOpportunityOwner(Id opportunityId, String newSfUserId,String stage, String oldSfUserId){
  
        List<Collaboration__c> lstCreateCollaborations = new List<Collaboration__c>();
        List<Collaboration__c> lstDeleteCollaborations = new List<Collaboration__c>();
        List<Box_Log__c> lstBoxLogs = new List<Box_Log__c>(); 

        system.debug('########################## changeOpportunityOwner called');

        // =========================== delete old collaboration =======================================
        Set<String>foldSet = new Set<String>(); 
        Set<Sub_Folder__c>folderSet = new Set<Sub_Folder__c>();
        Map<String,String> profilePermissionMap = new Map<String,String>();
        for(Sub_Folder__c childFolder:[Select CF_Box_Folder_Id__c,Name from Sub_Folder__c where Cf_Deal__c =:opportunityId]){
                   foldSet.add(childFolder.CF_Box_Folder_Id__c);
                   folderSet.add(childFolder);
        }
                  
        User Nu = [Select email,profileId from user where id=:newSfUserId];
        for(BoxAccessMatrix_Stage__c bxStg:[select Box_Permission__c,BoxAccessMatrix_Profile__r.Profile_Name__c, BoxAccessMatrix_Profile__r.Profile_Id__c, Stage__c,BoxAccessMatrix_Profile__r.BoxAccessMatrix_SubFolder__r.SubFolder_Name__c from BoxAccessMatrix_Stage__c where  check__c =true and BoxAccessMatrix_Profile__r.Profile_Id__c=:Nu.profileId and  Stage__c=:stage]){       
             profilePermissionMap.put(bxStg.BoxAccessMatrix_Profile__r.BoxAccessMatrix_SubFolder__r.SubFolder_Name__c,bxStg.Box_Permission__c);
        } 
            
        system.debug(folderSet+'========'+profilePermissionMap);            
        User Ou = [Select email from user where id=:oldSfUserId];
          
        Set<Collaboration__c> collaboration = new Set<Collaboration__c>([select BoxCollaboration_Id__c from Collaboration__c where SFUser_email__c=:Ou.email and BoxFolder_Id__c in:foldSet]);
        BoxCollaboration.deleteCollaboration('BoxAPIServicesController-changeOpportunityOwner',String.valueOf(opportunityId), null, collaboration, lstBoxLogs, lstDeleteCollaborations);
             
        Set<String> emails = new Set<String>();
        emails.add(Nu.email);
        // =========================== create new collaboration =======================================
        for(Sub_Folder__c fld:folderSet){  
           
           if(fld.CF_Box_Folder_Id__c!=null && profilePermissionMap.get(fld.Name)!=null){
            
               BoxCollaboration.createCollaboration('BoxAPIServicesController-changeOpportunityOwner',null,profilePermissionMap.get(fld.Name), fld.CF_Box_Folder_Id__c,emails,String.valueOf(opportunityId), fld.id, lstBoxLogs, lstCreateCollaborations);
           }
               
        } 
        
        insert lstCreateCollaborations;
        delete lstDeleteCollaborations;
        insert lstBoxLogs;
        
        
   }
  
    
 
    public class folderWrapper{
        public String Type;
        public String Id;
        public String Name;
    }
   public Void accData(){
   
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
}  

}