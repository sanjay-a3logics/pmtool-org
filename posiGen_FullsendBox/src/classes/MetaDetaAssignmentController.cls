public class MetaDetaAssignmentController{

    public Map<String, Meta_Data_Assignment__c> fileMap{get;set;}
    public Map<String, Map<String,boolean>> fileColumnMap{get;set;}
    public List<Meta_Data_Assignment_Column__c> columnList{get;set;}
    public List<Meta_Data_Assignment__c> metaDataAssignMentList{get;set;}
    List<Meta_Data_Assignment__c> fileList{get;set;}
    public Map<String,String> columnMap{get;set;}
    public List<FeedItem> chatterfileList{get;set;}  
    public Id opportunityId{get;set;}
    public String opportunityName{get;set;}
    public Boolean disabledCheck{get;set;}
    public Meta_Data_Assignment_Column__c metaDataAColumn{get;set;}
    
    public MetaDetaAssignmentController(ApexPages.StandardController controller){
    
        opportunityId = apexpages.currentpage().getparameters().get('id');
        Deal__c opp = [select name from Deal__c where id =: opportunityId];
        opportunityName = opp.name; 
        fileList = new List<Meta_Data_Assignment__c>();
        columnList = new List<Meta_Data_Assignment_Column__c>();
        columnMap = new Map<String,String>();
        metaDataAssignMentList = new List<Meta_Data_Assignment__c>();
        metaDataAColumn = new Meta_Data_Assignment_Column__c();
        
        Profile profile = [select name from profile where id =: userinfo.getProfileId()];
        if(profile.name.equalsIgnoreCase('Billing') || profile.name.equalsIgnoreCase('PV Partner User') || profile.name.equalsIgnoreCase('System Administrator') || profile.name.equalsIgnoreCase('System Administrator - Growth') || profile.name.equalsIgnoreCase('System Administrator - Vendor')){
            disabledCheck = false;
        }
        else{
            disabledCheck = true;
        }
        
        loadData();
    }
    
    public void loadData(){
    
    try{
        columnList = new List<Meta_Data_Assignment_Column__c>();
        columnMap = new Map<String,String>();
        fileList = new List<Meta_Data_Assignment__c>();
    
        for(Meta_Data_Assignment_Column__c mda: [select name, Column_Name__c from Meta_Data_Assignment_Column__c ]){
            columnList.add(mda);
            columnMap.put(mda.Column_Name__c, mda.name);
        }
        
        columnList.sort();
        
        fileMap= new Map<String, Meta_Data_Assignment__c>();
        fileColumnMap = new Map<String, Map<String,boolean>>();

        Sub_folder__c subFolder = [select cf_box_folder_id__c from sub_folder__c where cf_Deal__c =: opportunityId and name = 'Funding-Vendor'];
        
        metaDataAssignMentList = [select id, Check__c, File_Id__c, File_name__c, Uploaded_at__c, Uploaded_by__c, Meta_Data_Assignment_Column__c from Meta_Data_Assignment__c where Deal__c =: opportunityId];
        if(metaDataAssignMentList.size() > 0){
            
            for(Meta_Data_Assignment__c mdassign: metaDataAssignMentList){  

                fileList.add(mdassign);  
            
            }          
        }
        else{
        
            Box__c box = Box__c.getInstance();
            
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://api.box.com/2.0/folders/'+subFolder.cf_box_folder_id__c+'/items');
            req.setMethod('GET');
            req.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
            
            HTTPResponse res = new Http().send(req);
             system.debug('##########################res status'+res.getStatusCode());
             system.debug('##########################res body'+res.getBody());
             
            if(res.getStatusCode() == 200){
               FolderItemsWrapper items = (FolderItemsWrapper) System.JSON.deserialize(res.getBody(), FolderItemsWrapper.class);
               if(items.total_count > 0){
    
                   for(cls_entries entry: items.entries){
                       if(entry.type == 'file'){
                       
                            HttpRequest reqFile = new HttpRequest();
                            reqFile.setEndpoint('https://api.box.com/2.0/files/'+entry.id);
                            reqFile.setMethod('GET');
                            reqFile.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
                            
                            HTTPResponse resFile = new Http().send(reqFile);
                            
                            if(resFile.getStatusCode() == 200){
                                FileInfoWrapper fiw = (FileInfoWrapper) System.JSON.deserialize(resFile.getBody(), FileInfoWrapper.class);
                                
                                for(Meta_Data_Assignment_Column__c mda: columnList) {
                                
                                    Meta_Data_Assignment__c file = new Meta_Data_Assignment__c();
                                    file.Deal__c = opportunityId;
                                    file.File_Id__c = fiw.id;
                                    file.Meta_Data_Assignment_Column__c = mda.id;
                                    String udate = Date.valueOf(fiw.created_at).format();
                                    file.Uploaded_at__c = udate;
                                    file.File_name__c = fiw.name;
                                    file.Uploaded_by__c = fiw.created_by.name;
                                    file.Check__c = false;
                                    
                                    fileList.add(file);
                                }

                            }
                       
                           
                       }
                   }
                   
                  
               }
            }
  
        }
        
         for(Meta_Data_Assignment__c file : fileList){
             if(!fileColumnMap.containsKey(file.File_Id__c)){
                 fileColumnMap.put(file.File_Id__c, new Map<String, boolean>());
             }
             fileMap.put(file.File_Id__c, file);
             
             for(Meta_Data_Assignment_Column__c mda: columnList) {
                 if(mda.Id == file.Meta_Data_Assignment_Column__c){
                     
                     fileColumnMap.get(file.File_Id__c).put(mda.id, file.Check__c);
                 }
             }
         } 
         
         }
         catch(Exception e){
             system.debug(e.getMessage()+'-'+e.getStackTraceString());
         } 
    }
    
    
    
    public void save(){
        try{
            List<Meta_Data_Assignment__c> metaDataAssignList = new List<Meta_Data_Assignment__c>();
                 
                
             for(Meta_Data_Assignment__c mda: fileList) {
    
                     mda.check__c = fileColumnMap.get(mda.File_Id__c).get(mda.Meta_Data_Assignment_Column__c );
                     metaDataAssignList.add(mda);   
             }
    
            upsert metaDataAssignList;
            
        }
         catch(Exception e){
             system.debug(e.getMessage()+'-'+e.getStackTraceString());
         } 
    }
    
    public void saveColumn(){
        try{
            save();
            insert metaDataAColumn;
            List<Meta_Data_Assignment__c> mdaList = new List<Meta_Data_Assignment__c>();
            for(String key: fileMap.keySet()){
                Meta_Data_Assignment__c file = new Meta_Data_Assignment__c();
                file.Deal__c = opportunityId;
                file.File_Id__c = fileMap.get(key).File_Id__c;
                file.Meta_Data_Assignment_Column__c = metaDataAColumn.id;
                file.Uploaded_at__c = fileMap.get(key).Uploaded_at__c;
                file.File_name__c = fileMap.get(key).File_name__c;
                file.Uploaded_by__c = fileMap.get(key).Uploaded_by__c;
                file.Check__c = false;
                
                mdaList.add(file);   
            }
            
            insert mdaList;
            
            loadData(); 
        
         
        }
         catch(Exception e){
             system.debug(e.getMessage()+'-'+e.getStackTraceString());
         } 
    }
    

    public class FileWrapper{
        public String recordId{get;set;}
        public String fileId{get;set;}
        public String uploadedAt{get;set;}
        public String fileName{get;set;}
        public String uploadedBy{get;set;}
        public Boolean checked{get;set;}
         
        public FileWrapper(){
            
        }
        
    }
    
    public class FolderItemsWrapper{
        public Integer total_count; 
        public cls_entries[] entries;
        public Integer offset; 
    }
    
    class cls_entries {
        public String type; 
        public String id;  
        public String sequence_id; 
        public String etag; 
        public String name; 
    }
    
    public class FileInfoWrapper{
        public String type;
        public String id;
        public String sequence_id;  
        public String etag; 
        public String name; 
        public String description;  
        public Integer size;
        public String created_at;
        public String modified_at;
        public cls_created_by created_by;
        public cls_modified_by modified_by;
        public cls_owned_by owned_by;
        public String item_status;
    }   
    
    class cls_created_by {
        public String type;
        public String id;
        public String name; 
        public String login;
    }
    class cls_modified_by {
        public String type; 
        public String id;
        public String name;
        public String login;
    }
    class cls_owned_by {
        public String type;
        public String id;
        public String name;
        public String login;
    }
   
}