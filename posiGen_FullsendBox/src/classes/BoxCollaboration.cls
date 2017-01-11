public class BoxCollaboration {

    public static void createCollaboration(String reference,String ProfId,String role,String folderId,Set<String> emails ,String oppId, String subFolderId, List<Box_Log__c> lstBoxLogs, List<Collaboration__c> lstCollaborations) {

        string status ='';
        //Set<String> clonedEmails = new Set<String>();
        //clonedEmails = emails;
        for(string conEmail: emails){
            try {
                 if(folderId != null && ProfId!= null && role != null){
                      
                    Box__c box = Box__c.getInstance();
                    HttpRequest req = new HttpRequest();
                    req.setEndpoint('https://api.box.com/2.0/collaborations');
                    system.debug('FinalTest222--BoxCollaboration-----------box.BoxAccess_Token__c--'+box.BoxAccess_Token__c+'-----2------folderId---'+folderId+'---3---conEmail----'+conEmail+'---4 --role'+role);  
                    req.setMethod('POST');
                    req.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
                    req.setBody('{"item": { "id": "'+folderId+'", "type": "folder"}, "accessible_by": { "login": "'+conEmail+'", "type": "user" }, "role": "'+role+'"}');  
                    system.debug('BoxCollaboration--request---'+req.getBody());  
                    HTTPResponse res = new Http().send(req);
                    system.debug('BoxCollaboration--response---'+res.getBody());   
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
                            clb.BoxFolder_Id__c= folderId;
                            clb.sub_folder__c= subFolderId;
                            
                            clb.SFProfile_Id__c =ProfId;
                            clb.SFUser_Email__c =conEmail;
                            
                            lstCollaborations.add(clb);
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
                        BoxLogs.createLogs(reference,oppId, subFolderId, res.getBody(), BoxLogs.CREATE_COLLABORATION, status  , res.getStatusCode()+'', conEmail, role, lstBoxLogs);
                    
                    }
                    else{
                        status  = 'Error';
                        BoxLogs.createLogs(reference,oppId, subFolderId, 'Response is Null', BoxLogs.CREATE_COLLABORATION, status , '', conEmail, role, lstBoxLogs);
                    }
                }
                
            } 
            catch(Exception e){
           
                status  = 'Exception';
                BoxLogs.createLogs(reference,oppId, subFolderId, e.getMessage() +'#' +e.getStacktraceString(), BoxLogs.CREATE_COLLABORATION, status  , '', conEmail, role, lstBoxLogs);
            }

        }
        
   }
    
    public static void createCollaborationByGroup() {
    
    
    }
    
    public static void deleteCollaboration(String reference,String oppId, String subFolderId, Set<Collaboration__c> collaboration, List<Box_Log__c> lstBoxLogs, List<Collaboration__c> lstCollaborations) {
        
        string status ='';
        //Set<Collaboration__c> clonedCollaboration = new Set<Collaboration__c>();
        //clonedCollaboration = collaboration;
        
        for(Collaboration__c clb: collaboration){
        
            try{
        
                if(clb.BoxCollaboration_Id__c !=null){
                
                    Box__c box = Box__c.getInstance();
                    HttpRequest req2 = new HttpRequest();
                    req2.setEndpoint('https://api.box.com/2.0/collaborations/'+clb.BoxCollaboration_Id__c +'');
                    req2.setMethod('DELETE');
                    req2.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
                    HTTPResponse res2 = new Http().send(req2);
                    
                    if(res2!=null){
                        DeleteCollaborationWrapper dcw = new DeleteCollaborationWrapper();
                        if (res2.getStatuscode() == 204||res2.getStatuscode()==404) {
                            //success
                            status  = 'Success';
                            lstCollaborations.add(clb);
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
                        BoxLogs.createLogs(reference, oppId, subFolderId, res2.getBody(), BoxLogs.DELETE_COLLABORATION, status  , res2.getStatusCode()+'', clb.BoxCollaboration_Id__c, '', lstBoxLogs);
                    }
                    else{
                        status  = 'Error';
                        BoxLogs.createLogs(reference, oppId, subFolderId, 'Response is Null', BoxLogs.CREATE_COLLABORATION, status , '', clb.BoxCollaboration_Id__c, '', lstBoxLogs);
                    }
                    
                }
             }
            catch(Exception e){
                status  = 'Exception';
                BoxLogs.createLogs(reference, oppId, subFolderId, e.getMessage() +'#' +e.getStacktraceString(), BoxLogs.CREATE_COLLABORATION, status, '', clb.BoxCollaboration_Id__c, '', lstBoxLogs);
            }
            
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