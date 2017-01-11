public with sharing class Batch_BoxCreateCollaborationsFrom implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful{
    
    public Batch_BoxCreateCollaborationsFrom(){		
        
    }   
    
    public Database.QueryLocator start(Database.BatchableContext BC){
        
        Datetime dt = System.now()-1;
        return Database.getQueryLocator('select id, Error_Code__c, Deal__c, Sub_Folder__c,collaboration_role__c,email__c,Sub_Folder__r.CF_Box_Folder_Id__c, type__c,Status__c from Box_Log__c where Status__c != \'Success\' and Error_Code__c != \'404\' and Error_Code__c != \'400\' and Error_Code__c != \'409\' and Error_Code__c != \'201\' and createdDate >:dt');
    }
    
    public void execute(Database.BatchableContext BC,List<Box_Log__c> NewlstBoxLogs){
           
            List<Collaboration__c> createListCollaborations = new List<Collaboration__c>();
            Set<String> deleteListCollaborations = new Set<String>();
            List<Box_Log__c> lstBoxLogs = new List<Box_Log__c>();
            List<Box_Log__c> deleteListBoxLogs = new List<Box_Log__c>();
            
            for(Box_Log__c log :NewlstBoxLogs){
                if(log.type__c == 'Create Collaboration'){
                    Batch_BoxCreateCollaborationsFrom.createCollaborationForUser('', log, log.collaboration_role__c,log.Sub_Folder__c, log.email__c ,log.Deal__c, log.Sub_Folder__r.CF_Box_Folder_Id__c, lstBoxLogs, createListCollaborations, deleteListBoxLogs);
                }
                else if(log.type__c == 'Delete Collaboration'){
                    Batch_BoxCreateCollaborationsFrom.deleteCollaboration('', log, log.Deal__c, log.Sub_Folder__c, log.email__c, lstBoxLogs, deleteListCollaborations, deleteListBoxLogs);
                }
            }  
        
            system.debug('---createListCollaborations--- size='+createListCollaborations.size()+'----------- list='+createListCollaborations);
            if(createListCollaborations.size()>0){
                insert createListCollaborations;
            }
            
            system.debug('---deleteListCollaborations--- size='+deleteListCollaborations.size()+'----------- list='+deleteListCollaborations);
            
            if(deleteListCollaborations.size()>0){
                
                List<collaboration__c> clbList = new List<collaboration__c>();
                for(collaboration__c clb: [select id from collaboration__c where id in:deleteListCollaborations ]){
                    clbList.add(clb);
                }
                
                delete clbList;
            }
            
            system.debug('---lstBoxLogs--- size='+lstBoxLogs.size()+'----------- list='+lstBoxLogs);
            if(lstBoxLogs.size()>0){
                upsert lstBoxLogs;
            }
            
            system.debug('---deleteListBoxLogs--- size='+deleteListBoxLogs.size()+'----------- list='+deleteListBoxLogs);
            if(deleteListBoxLogs.size()>0){
                delete deleteListBoxLogs;
            } 
        
    } 
    
    public void finish(Database.BatchableContext BC){
        
        
    }
    
    
    
    
    public static void createCollaborationForUser(String reference, Box_Log__c bxLog, String role,String folderId, String email ,String oppId, String subFolderId, List<Box_Log__c> lstBoxLogs, List<Collaboration__c> createListCollaborations, List<Box_Log__c> deleteListBoxLogs) {
        
        system.debug('------------------createCollaborationForUser------------------');
        string status ='';
        try {
            if(folderId != null && email!= null && role != null){
                
                Box__c box = Box__c.getInstance();
                HttpRequest req = new HttpRequest();
                req.setEndpoint('https://api.box.com/2.0/collaborations');
                req.setMethod('POST');
                req.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
                req.setBody('{"item": { "id": "'+subFolderId+'", "type": "folder"}, "accessible_by": { "login": "'+email+'", "type": "user" }, "role": "'+role+'"}');
                HTTPResponse res = new Http().send(req);
                
                system.debug('{"item": { "id": "'+subFolderId+'", "type": "folder"}, "accessible_by": { "login": "'+email+'", "type": "user" }, "role": "'+role+'"}');
                
                if(res!=null){                   
                    Collaborationwrapper cw = new Collaborationwrapper();
                    if(res.getStatusCode() == 201){
                        cw = (Collaborationwrapper)JSON.deserialize(res.getBody(),Collaborationwrapper.class);
                        Collaboration__c clb = new Collaboration__c();
                        
                        
                        if(cw.accessible_by!=null){
                            clb.BoxUser_Id__c=cw.accessible_by.id;
                        }
                        else{
                            clb.BoxUser_Id__c='';
                        } 
                        clb.BoxCollaboration_Id__c = cw.id;
                        clb.Role__c= cw.role;
                        clb.BoxFolder_Id__c=subFolderId ;
                        clb.sub_folder__c=folderId;
                        clb.SFUser_Email__c =email;
                        clb.id = null;
                        createListCollaborations.add(clb);
                        deleteListBoxLogs.add(bxLog);
                        status  = 'Success';
                        //clonedEmails.remove(conEmail);
                    }
                    /*else if(res.getStatusCode() == 401){
                        
                        createCollaboration(reference, ProfId,role,folderId,clonedEmails,oppId,subFolderId,lstBoxLogs,lstCollaborations);
                        status  ='Error';
                    } */
                    else{
                        status  ='Error';
                        //clonedEmails.remove(conEmail);
                    }
                    BoxLogs.createLogs(reference,oppId, folderId, res.getBody(), BoxLogs.CREATE_COLLABORATION, status  , res.getStatusCode()+'', email, role, lstBoxLogs);
                    
                }
                else{
                    status  = 'Error';
                    BoxLogs.createLogs(reference,oppId, folderId, 'Response is Null', BoxLogs.CREATE_COLLABORATION, status , '', email, role, lstBoxLogs);
                }
            }
            
        } 
        catch(Exception e){
            status  = 'Exception';
            BoxLogs.createLogs(reference,oppId, folderId, e.getMessage() +'#' +e.getStacktraceString(), BoxLogs.CREATE_COLLABORATION, status  , '', email, role, lstBoxLogs);
        }
    }
    
    public static void deleteCollaboration(String reference, Box_Log__c bxLog, String oppId, String subFolderId, String collaborationId, List<Box_Log__c> lstBoxLogs, Set<String> deleteListCollaborations, List<Box_Log__c> deleteListBoxLogs) {
        
        system.debug('------------------deleteCollaboration------------------');
        string status ='';
        
        try{
            
            if(collaborationId !=null){
                
                Box__c box = Box__c.getInstance();
                HttpRequest req2 = new HttpRequest();
                req2.setEndpoint('https://api.box.com/2.0/collaborations/'+collaborationId +'');
                req2.setMethod('DELETE');
                req2.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
                HTTPResponse res2 = new Http().send(req2);
                
                   system.debug('https://api.box.com/2.0/collaborations/'+collaborationId +'');
                   
                    DeleteCollaborationWrapper dcw = new DeleteCollaborationWrapper();
                    if (res2.getStatuscode() == 204) {
                        //success
                        status  = 'Success';
                        deleteListCollaborations.add(collaborationId);
                        deleteListBoxLogs.add(bxLog);
                        //clonedCollaboration.remove(clb);
                        
                    }
                    /*else if(res2.getStatusCode() == 401){ 
                        // token expired
                        status  = 'Error';
                        deleteCollaboration(reference, oppId, subFolderId, clonedCollaboration,lstBoxLogs, lstCollaborations);
                        
                    } */
                    else{ 
                        // other errors
                        status  = 'Error';
                        //clonedCollaboration.remove(clb);
                        
                    }
                    BoxLogs.createLogs(reference, oppId, subFolderId, res2.getBody(), BoxLogs.DELETE_COLLABORATION, status  , res2.getStatusCode()+'', collaborationId, '', lstBoxLogs);
                }
              
            
        }
        catch(Exception e){
            status  = 'Exception';
            BoxLogs.createLogs(reference, oppId, subFolderId, e.getMessage() +'#' +e.getStacktraceString(), BoxLogs.CREATE_COLLABORATION, status, '', collaborationId, '', lstBoxLogs);
        }
    }
    
    
    public class CollaborationWrapper {
        
        public String type;
        public String id;
        public Created_by created_by;
        public String created_at;
        public String modified_at;
        public String expires_at;
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
    
    public class DeleteCollaborationWrapper {
        
        public Integer total_count;
        public List<Entries> entries;
    }
    
    public class Entries {
        public String type;
        public String id;
        public String created_by;
        public String created_at;
        public String modified_at;
        public String expires_at;
        public String status;
        public String role;
        public String acknowledged_at;
        public Item item;
    }
    
    
    
}