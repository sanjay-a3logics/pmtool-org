/* Author: Irfan Khan (Appcino Technologies Pvt. Ltd.)
 * Batch for moving deleted opportunity folder to 'Posigen/Salesforce/Deleted Customers' in box
 */
public with sharing class BoxDeleteOpportunityBatch implements Database.Batchable<Deal__c>,Database.AllowsCallouts, Database.Stateful{
    public List<Deal__c> opplist;
    public List<Sub_Folder__c> subFolderList;
    public BoxDeleteOpportunityBatch(List<Deal__c> opplist, List<Sub_Folder__c> subFolderList){
        this.opplist=opplist;
        this.subFolderList=subFolderList;
    }
    public Iterable<Deal__c> start(Database.BatchableContext BC){
        return opplist;
    }      
         
    public void execute(Database.BatchableContext BC, List<Deal__c> opportunityList){
        List<Box_Error__c> bxErrList = new List<Box_Error__c>();
        try{
            Box__c box = Box__c.getInstance();
            
            for(Deal__c opp: opportunityList){
                
                String oppName = opp.name;
                System.debug('############## name before replace'+oppName);
                oppName = oppName.replace('\t', '');
                oppName = oppName.replace('"', '\'');
                oppName = oppName.replace('\\', '-');
                oppName = oppName.replace('/', '-');
                oppName = 'Deleted - '+oppName;
                System.debug('############## name after replace'+oppName);
            
                HttpRequest req = new HttpRequest();
                req.setEndpoint('https://api.box.com/2.0/folders/'+opp.O_box_folder_Id__c+'');
                req.setMethod('PUT');
                req.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
                req.setBody('{"name":"'+oppName+'"}');
                HTTPResponse res = new Http().send(req);
                
                system.debug('##########################res status code'+res.getStatusCode());
                if(res.getStatusCode() == 200){
                    
                    HttpRequest req2 = new HttpRequest();
                    req2.setEndpoint('https://api.box.com/2.0/folders/'+opp.O_box_folder_Id__c+'');
                    req2.setMethod('PUT');
                    req2.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
                    req2.setBody('{"parent": {"id" : 4407849350}}');
                    HTTPResponse res2 = new Http().send(req2);
                    
                    system.debug('##########################res2 status code'+res2.getStatusCode());
                    system.debug('####################### response'+res2.getBody());
                    if(res2.getStatusCode() != 200){
                         Box_Error__c bxerr = new Box_Error__c();
                         bxerr.name = String.valueOf(res2.getStatusCode()); 
                         bxerr.Message__c = 'Deal id: '+opp.id; 
                         bxerr.Body__c = res2.getBody();
                        
                         bxErrList.add(bxerr);
                    }
                }
                else{
                     Box_Error__c bxerr = new Box_Error__c();
                     bxerr.name = String.valueOf(res.getStatusCode()); 
                     bxerr.Message__c = 'Deal id: '+opp.id; 
                     bxerr.Body__c = res.getBody();
                    
                     bxErrList.add(bxerr);
                }
                
            }
            insert bxErrList;  
        }
        catch(Exception e){
            system.debug('###############################'+e.getMessage());
            Box_Error__c bxerr = new Box_Error__c();
            bxerr.name = 'delete Deal Exception'; 
            bxerr.Message__c = e.getMessage(); 
            bxerr.Body__c = e.getStackTraceString();
            
            bxErrList.add(bxerr);
        }
     }
     
     public void finish(Database.BatchableContext BC){
        Database.executeBatch(new BoxDeleteOpportunityCollaborationBatch(opplist,subFolderList),1);
     }
}