public with sharing class BoxDeleteOpportunityCollaborationBatch implements Database.Batchable<Deal__c>,Database.AllowsCallouts, Database.Stateful{
    public List<Deal__c> opplist;    
    public List<Sub_Folder__c> subFolderList;
    public BoxDeleteOpportunityCollaborationBatch (List<Deal__c> opplist,List<Sub_folder__c>subFolderList){
        this.opplist=opplist;     
        this.subFolderList=subFolderList;    
    }
    public Iterable<Deal__c> start(Database.BatchableContext BC){
        return opplist;
    }
     
    public void execute(Database.BatchableContext BC, List<Deal__c> DealList){
        List<Box_Error__c> bxErrList = new List<Box_Error__c>();
        try{
            List<Collaboration__c> deleteCollaborationList = new List<Collaboration__c>();
          
            
            Set<Id> oppIds = new Set<Id>();
            for(Deal__c opp: DealList){
                oppIds.add(opp.id);
            }  
            system.debug('################################### oppIds size'+oppIds.size());
            system.debug('################################### oppIds'+oppIds);
            
            Set<String> subFolders = new Set<String>();
            for(Sub_Folder__c subFolder:subFolderList){
                subFolders.add(subFolder.CF_Box_Folder_Id__c);
            }
            system.debug('################################### subFolders size'+subFolders.size());
            system.debug('################################### subFolders'+subFolders);
            
            List<Collaboration__c> collaborations = new List<Collaboration__c>();
            for(Collaboration__c collab: [select id, BoxCollaboration_Id__c, BoxUser_Id__c from Collaboration__c where BoxFolder_Id__c in: subFolders]){
                    collaborations.add(collab);
               }
            system.debug('################################### collaborations size'+collaborations.size());
            system.debug('################################### collaborations'+collaborations);
            
            Box__c box = Box__c.getInstance();
            
            for(Collaboration__c collaboration: collaborations){
                
                HttpRequest req2 = new HttpRequest();
                req2.setEndpoint('https://api.box.com/2.0/collaborations/'+collaboration.BoxCollaboration_Id__c+'');
                req2.setMethod('DELETE');
                req2.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
                HTTPResponse res2 = new Http().send(req2);
                
                system.debug('##########################res2 status code'+res2.getStatusCode());
                if(res2.getStatusCode() == 204){
                    deleteCollaborationList.add(collaboration);
                }
                else{
                    Box_Error__c bxerr = new Box_Error__c();
                    bxerr.name = String.valueOf(res2.getStatusCode()); 
                    bxerr.Message__c = 'collaboration id: '+collaboration.id; 
                    bxerr.Body__c = res2.getBody();
                    
                    bxErrList.add(bxerr);
                }
            }
            delete deleteCollaborationList;
           } 
        catch(Exception e){          
            system.debug('###############################'+e.getMessage());
            Box_Error__c bxerr = new Box_Error__c();
            bxerr.name = 'delete Deal__c Exception'; 
            bxerr.Message__c = e.getMessage(); 
            bxerr.Body__c = e.getStackTraceString();
            
            bxErrList.add(bxerr);
        }
       insert bxErrList; 
     }
     
     public void finish(Database.BatchableContext BC){
        
        
     }
}