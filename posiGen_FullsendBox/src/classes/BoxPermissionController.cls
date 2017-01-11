public class BoxPermissionController{
    public Map<String, Map<Id, BoxAccessMatrix_Profile__c>> mapCustomProfile {get;set;}
    public Map<String, Map<String, Map<String, BoxAccessMatrix_Stage__c>>> mapLstAccessMatrixStage {get;set;}
    public List<SelectOption> permissionList  {get;set;}
    public List<String> stagesList  {get;set;}
    public List<SelectOption>LookupList{get;set;}
    public List<SelectOption>accLookupList{get;set;}
    public Map<String, Map<String, String>> permissionMap {get;set;}
    private Map<Id, Profile> mapProfiles;
    public BoxPermissionController() {
        try{
            intialize();
            checkForCustomProfiles();
            checkForMatrixStage();  
           
        }catch(Exception e) {
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getmessage()+'---'+e.getStacktraceString());
             ApexPages.addMessage(myMsg);
        }
         
    }			
    
    public void intialize() {
         mapCustomProfile = new Map<String,Map<Id, BoxAccessMatrix_Profile__c>>();
         mapLstAccessMatrixStage = new Map<String, Map<String, Map<String, BoxAccessMatrix_Stage__c>>>();
         List<String> NotPfList = new List<String>{'API Only','Chatter External User','Chatter Free User','Chatter Moderator User','Contract Manager','Customer Community Login User','Customer Community Profile','Emma Profile','Gold Partner User','Guest License User','Marketing User','Ops Sunrise','Partner Community User','Posigen Project Manager User','Posigen Partner User','Solution Manager','Standard Platform User','Standard User','Subcontractor Community Profile','Underwriter','Funding User','EE Customer Service','EE SysAdmin','Funding','Marketing Emma','Marketing Manager','SHW Partner User','PV QC Partner User','Read Only','Read Only - Sunrun input'}; //,'PV Partner User'
         mapProfiles = new Map<Id, Profile>([Select id, Name from Profile where Name != null and name not in : NotPfList order by Name asc]);
         permissionMap = new Map<String, Map<String, String>>();
         stagesList = new List<String>();
         permissionList = new List<SelectOption>();
         permissionList = getPicklistPermissionValues();
         stagesList =  getPicklistValues();
         LookupList = getUserlookupValues();
         accLookupList = getAccountlookupValues();
    }
    public Map<String, Map<Id, BoxAccessMatrix_Profile__c>> checkForCustomProfiles() {
        

        try{
            Map<Id, BoxAccessMatrix_SubFolder__c> mapSubFolders = new Map<Id,BoxAccessMatrix_SubFolder__c>([Select id,SubFolder_Name__c from BoxAccessMatrix_SubFolder__c]); 
            for(BoxAccessMatrix_SubFolder__c bam : mapSubFolders.values()) {
                mapCustomProfile.put(bam.SubFolder_Name__c , new Map<Id, BoxAccessMatrix_Profile__c>());   
                mapLstAccessMatrixStage.put(bam.SubFolder_Name__c , new Map<String, Map<String, BoxAccessMatrix_Stage__c>>());      
            }
            for(BoxAccessMatrix_Profile__c bamp : [Select id, BoxAccessMatrix_SubFolder__r.SubFolder_Name__c , Profile_Id__c,Lookup_Field_Name__c, Profile_Name__c from BoxAccessMatrix_Profile__c]){
                if(bamp.BoxAccessMatrix_SubFolder__c != null && bamp.BoxAccessMatrix_SubFolder__r.SubFolder_Name__c != null && bamp.Profile_Id__c != null){
                    mapCustomProfile.get(bamp.BoxAccessMatrix_SubFolder__r.SubFolder_Name__c ).put(bamp.Profile_Id__c, bamp);
                    mapLstAccessMatrixStage.get(bamp.BoxAccessMatrix_SubFolder__r.SubFolder_Name__c ).put(bamp.Profile_Id__c, new Map<String, BoxAccessMatrix_Stage__c>());
                }
                
            }
           
            for(Profile prf : mapProfiles.values()){
                for(BoxAccessMatrix_SubFolder__c subfolder : mapSubFolders.values()){
                    if(!mapCustomProfile.get(subfolder.SubFolder_Name__c).containsKey(prf.id)){  
                        BoxAccessMatrix_Profile__c newProfile = new BoxAccessMatrix_Profile__c();
                        newProfile.Profile_Id__c = prf.id;
                        newProfile.BoxAccessMatrix_SubFolder__c = subfolder.id;
                        newProfile.Profile_Name__c = prf.Name;
                        //newProfile.Lookup_Field_Name__c= 'Concerige'  ;   
                        if(mapCustomProfile.containsKey(subfolder.SubFolder_Name__c) && mapCustomProfile.get(subfolder.SubFolder_Name__c).containsKey(prf.id) && mapCustomProfile.get(subfolder.SubFolder_Name__c).get(prf.id).Lookup_Field_Name__c  != null)
                            newProfile.Lookup_Field_Name__c = mapCustomProfile.get(subfolder.SubFolder_Name__c).get(prf.id).Lookup_Field_Name__c ;     
                        else
                            newProfile.Lookup_Field_Name__c = '';
                        mapCustomProfile.get(subfolder.SubFolder_Name__c).put(prf.id, newProfile); 
                        mapLstAccessMatrixStage.get(subfolder.SubFolder_Name__c).put(prf.id, new Map<String, BoxAccessMatrix_Stage__c>()); 
                   }
                   
                   
                }    
            }  
          
            return mapCustomProfile;
        }catch(Exception e) {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getmessage()+'---'+e.getStacktraceString());
             ApexPages.addMessage(myMsg);
            return mapCustomProfile;
        }
    }
    
    public void checkForMatrixStage() {
        List<Boolean> lst = new List<Boolean>();
        try{
            Map<String, BoxAccessMatrix_Stage__c> mapMatrixStage = new Map<String, BoxAccessMatrix_Stage__c>();
            for(BoxAccessMatrix_Stage__c bams : [Select id,BoxAccessMatrix_Profile__r.Profile_Name__c , BoxAccessMatrix_Profile__c, BoxAccessMatrix_Profile__r.Profile_Id__c,  BoxAccessMatrix_Profile__r.BoxAccessMatrix_SubFolder__c, Box_Permission__c, Check__c, Stage__c from BoxAccessMatrix_Stage__c ]) {
                 mapMatrixStage.put(bams.BoxAccessMatrix_Profile__r.BoxAccessMatrix_SubFolder__c + ':' +  bams.BoxAccessMatrix_Profile__r.Profile_Id__c + ':' + bams.Stage__c , bams);
                
            }
           
            for(String subFolder : mapCustomProfile.keySet()) {
                Map<Id, BoxAccessMatrix_Profile__c> mapAccessMatrix  = new Map<Id, BoxAccessMatrix_Profile__c>();
                mapAccessMatrix =  mapCustomProfile.get(subFolder);
                permissionMap.put(subFolder, new Map<String,String>());
                for(BoxAccessMatrix_Profile__c bamp : mapAccessMatrix.values()) {
                  
                    permissionMap.get(subFolder).put(bamp.Profile_Id__c, '');
                   
                    for(String stage : stagesList) {
                    
                        if(mapMatrixStage.containsKey(bamp.BoxAccessMatrix_SubFolder__c + ':' + bamp.Profile_Id__c +':'+stage)) {
                           
                               mapLstAccessMatrixStage.get(subFolder).get(bamp.Profile_Id__c).put(stage, mapMatrixStage.get(bamp.BoxAccessMatrix_SubFolder__c + ':' + bamp.Profile_Id__c +':'+stage));    
                               String value = mapMatrixStage.get(bamp.BoxAccessMatrix_SubFolder__c + ':' + bamp.Profile_Id__c +':'+stage ).Box_Permission__c != null ? mapMatrixStage.get(bamp.BoxAccessMatrix_SubFolder__c + ':' + bamp.Profile_Id__c +':'+stage ).Box_Permission__c : '';
                               permissionMap.get(subFolder).put(bamp.Profile_Id__c, value);
                        } 
                        else{
                              
                            BoxAccessMatrix_Stage__c newStage = new BoxAccessMatrix_Stage__c();
                            newStage.BoxAccessMatrix_Profile__c = bamp.id;
                            newStage.Box_Permission__c = '';
                            
                            for(Id mappid : mapProfiles.keySet()){
                                system.debug('mapProfiles-'+mappid+'--'+ mapProfiles.get(mappid));
                            }
                            if(mapProfiles.containsKey(bamp.Profile_Id__c) && mapProfiles.get(bamp.Profile_Id__c).name != null){
                                if(mapProfiles.get(bamp.Profile_Id__c).name=='System Administrator'){
                                    newStage.Check__c = true;
                                }else{
                                    newStage.Check__c = false;
                                }    
                            }
                            else{
                                newStage.Check__c = false;
                            }    
                            newStage.Stage__c = stage;
                            mapLstAccessMatrixStage.get(subFolder).get(bamp.Profile_Id__c).put(stage, newStage);
                            //system.debug(subFolder+'________'+bamp.Profile_Id__c+'____________'+stage+'____________'+newStage);
                             
                        }  
                    }   
                    
                }
                 
            } 
            
           
        }catch(Exception e) {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getmessage()+'---'+e.getStacktraceString());
             ApexPages.addMessage(myMsg);
        }   
    }
    
    public List<String> getPicklistValues(){ 
       List<String> allStage = new List<String>();
       Set<String> pipelineSt = new Set<String>();
       //List<String> lstValues = new List<String>();
       
     /* for(OpportunityStage opps :[Select MasterLabel From OpportunityStage where IsActive=true  order by DefaultProbability asc]){ 
                
             lstValues.add(opps.MasterLabel);
         }*/
        
  
      // allStage.addAll(lstValues);  
  for (Deal__c opp: [Select  Opp_Pipeline_Stage__c from Deal__c]){
          pipelineSt.add(Opp.Opp_Pipeline_Stage__c );  			
        }    
        allStage.addAll(pipelineSt);
       
       
       return allStage;
    }
   
     public List<selectOption> getUserlookupValues(){ 
       List<selectOption> lstValues = new List<selectOption>();
       lstValues.add(new SelectOption('','--Select--'));
       Schema.SObjectType targettype= Schema.getGlobalDescribe().get('Deal__c'); 
       sObject obj = targetType.newSObject();
       Schema.sObjectType objType = obj.getSObjectType();
       Schema.DescribeSObjectResult describeresult = objType.getDescribe();
       
         Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
         Schema.SObjectType ObjectSchema = schemaMap.get('Deal__c');
         Map<String, Schema.SObjectField> fieldMap = ObjectSchema.getDescribe().fields.getMap(); 
         Schema.SObjectType parentSchema ;
      
        for (Schema.SObjectField f : describeresult.fields.getMap().values())
            {
                Schema.DescribeFieldResult dfr  = f.getDescribe();
                
                if (dfr.getType() == DisplayType.Reference)
                {   
                   
                  parentSchema = fieldMap.get(dfr.getname()).getDescribe().getReferenceTo().get(0);
                  String Parent =    parentSchema.getDescribe().getLabel();
                  if(Parent =='User'){
                     lstValues.add(new selectoption(dfr.getName(),dfr.getlabel()));
                    }
                                                           
                 }                                       
               }
          

       
       return lstValues;
    } 
 
     public List<selectOption> getAccountlookupValues(){ 
       List<selectOption> acclstValues = new List<selectOption>();
       acclstValues.add(new SelectOption('','--Select--'));
       Schema.SObjectType targettype= Schema.getGlobalDescribe().get('Project__c'); 
       sObject obj = targetType.newSObject();
       Schema.sObjectType objType = obj.getSObjectType();
       Schema.DescribeSObjectResult describeresult = objType.getDescribe();
       
         Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
         Schema.SObjectType ObjectSchema = schemaMap.get('Project__c');
         Map<String, Schema.SObjectField> fieldMap = ObjectSchema.getDescribe().fields.getMap(); 
         Schema.SObjectType parentSchema ;
      
        for (Schema.SObjectField f : describeresult.fields.getMap().values())
            {
                Schema.DescribeFieldResult dfr  = f.getDescribe();
                
                if (dfr.getType() == DisplayType.Reference)
                {   
                   
                  parentSchema = fieldMap.get(dfr.getname()).getDescribe().getReferenceTo().get(0);
                  String Parent =    parentSchema.getDescribe().getLabel();
                  if(Parent =='Account'||Parent == 'User'){
                     acclstValues.add(new selectoption(dfr.getName(),dfr.getlabel()));
                    }
                   
                                                           
                 }                                       
               }
          

       
       return acclstValues;
    }
 
 
    
    public List<selectOption> getPicklistPermissionValues(){ 
        List<SelectOption> lstOptions = new List<SelectOption>();
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get('BoxAccessMatrix_Stage__c');
        Sobject Object_name = targetType.newSObject();
        Schema.sObjectType sobject_type = Object_name.getSObjectType();
        Schema.DescribeSObjectResult sobject_describe = sobject_type.getDescribe(); 
        Map<String, Schema.SObjectField> field_map = sobject_describe.fields.getMap(); 
        List<Schema.PicklistEntry> pick_list_values = field_map.get('Box_Permission__c').getDescribe().getPickListValues(); 
        lstOptions.add(new selectOption('','--Select--'));
        for (Schema.PicklistEntry a : pick_list_values) {
            lstOptions.add(new selectOption(a.getValue(),a.getLabel()));
        }
      
        lstOptions.sort();   
        return lstOptions;
    }
    
    public void saveSales() {
        try{
          
            List<BoxAccessMatrix_Stage__c> lstMatrixStages = new List<BoxAccessMatrix_Stage__c>();
            List<BoxAccessMatrix_Profile__c> lstProfiles = new List<BoxAccessMatrix_Profile__c>();
            
            /*String str = '';
            for(BoxAccessMatrix_Profile__c bamp : mapCustomProfile.get('Sales').values()){
                str = str + ' _____ '+ bamp.Lookup_Field_Name__c;
            }*/
            
            upsert  mapCustomProfile.get('Sales').values();
            
            for(String key : mapLstAccessMatrixStage.get('Sales').keySet()) {
                for(String stage: mapLstAccessMatrixStage.get('Sales').get(key).keyset()) {
                    BoxAccessMatrix_Stage__c bamp = mapLstAccessMatrixStage.get('Sales').get(key).get(stage);
                    bamp.Stage__c = stage;
                    bamp.BoxAccessMatrix_Profile__c = mapCustomProfile.get('Sales').get(key).id; 
                    bamp.Box_Permission__c = permissionMap.get('Sales').get(key);
                    lstMatrixStages.add(bamp);
                }
            }
            
            upsert lstMatrixStages;
            intialize();
            checkForCustomProfiles();
            checkForMatrixStage(); 
        }
        
        catch(Exception e) {
           ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getmessage()+'---'+e.getStacktraceString());
             ApexPages.addMessage(myMsg);
        }
    }
    public void saveApplication() {
        try{
            List<BoxAccessMatrix_Stage__c> lstMatrixStages = new List<BoxAccessMatrix_Stage__c>();
            List<BoxAccessMatrix_Profile__c> lstProfiles = new List<BoxAccessMatrix_Profile__c>();
            
            upsert mapCustomProfile.get('Application').values();
            
            for(String key : mapLstAccessMatrixStage.get('Application').keySet()) {
                for(String stage: mapLstAccessMatrixStage.get('Application').get(key).keyset()) {
                    BoxAccessMatrix_Stage__c bamp = mapLstAccessMatrixStage.get('Application').get(key).get(stage);
                    bamp.Stage__c = stage;
                    bamp.BoxAccessMatrix_Profile__c = mapCustomProfile.get('Application').get(key).id; 
                    bamp.Box_Permission__c = permissionMap.get('Application').get(key);
                    lstMatrixStages.add(bamp);
                }
            }  
              
            upsert lstMatrixStages;
            intialize();
            checkForCustomProfiles();
            checkForMatrixStage(); 
        }
        catch(Exception e) {
           ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getmessage()+'---'+e.getStacktraceString());
             ApexPages.addMessage(myMsg);
        }
    }
    public void saveFunding() {
        try{
            List<BoxAccessMatrix_Stage__c> lstMatrixStages = new List<BoxAccessMatrix_Stage__c>();
            List<BoxAccessMatrix_Profile__c> lstProfiles = new List<BoxAccessMatrix_Profile__c>();
           
            upsert mapCustomProfile.get('Funding-Vendor').values();
            
            for(String key : mapLstAccessMatrixStage.get('Funding-Vendor').keySet()) {
                for(String stage: mapLstAccessMatrixStage.get('Funding-Vendor').get(key).keyset()) {
                    BoxAccessMatrix_Stage__c bamp = mapLstAccessMatrixStage.get('Funding-Vendor').get(key).get(stage);
                    bamp.Stage__c = stage;
                    bamp.BoxAccessMatrix_Profile__c = mapCustomProfile.get('Funding-Vendor').get(key).id; 
                    bamp.Box_Permission__c = permissionMap.get('Funding-Vendor').get(key);
                    lstMatrixStages.add(bamp);
                }
            }    
            upsert lstMatrixStages;
            intialize();
            checkForCustomProfiles();
            checkForMatrixStage(); 
        }
        catch(Exception e) {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getmessage()+'---'+e.getStacktraceString());
            ApexPages.addMessage(myMsg);
        }
    }
    public void saveEE() {
        try{
            List<BoxAccessMatrix_Stage__c> lstMatrixStages = new List<BoxAccessMatrix_Stage__c>();
            List<BoxAccessMatrix_Profile__c> lstProfiles = new List<BoxAccessMatrix_Profile__c>();
           
            upsert mapCustomProfile.get('EE').values();
            
            for(String key : mapLstAccessMatrixStage.get('EE').keySet()) {
                for(String stage: mapLstAccessMatrixStage.get('EE').get(key).keyset()) {
                    BoxAccessMatrix_Stage__c bamp = mapLstAccessMatrixStage.get('EE').get(key).get(stage);
                    bamp.Stage__c = stage;
                    bamp.BoxAccessMatrix_Profile__c = mapCustomProfile.get('EE').get(key).id; 
                    bamp.Box_Permission__c = permissionMap.get('EE').get(key);
                    lstMatrixStages.add(bamp);
                }
            }    
            upsert lstMatrixStages;
            intialize();
            checkForCustomProfiles();
            checkForMatrixStage(); 
        }
        catch(Exception e) {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getmessage()+'---'+e.getStacktraceString());
             ApexPages.addMessage(myMsg);
        }
    }   
}