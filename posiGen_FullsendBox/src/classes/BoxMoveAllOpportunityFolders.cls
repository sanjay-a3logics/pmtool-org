public class BoxMoveAllOpportunityFolders implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful{
	 public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('select Id, name, O_box_folder_id__c from opportunity where id != null');
    }
    
    public void execute(Database.BatchableContext BC, List<Opportunity> opportunityList){
       List<Box_Error__c> bxErrList = new List<Box_Error__c>();
       try{
       		Set<Id> oppIds = new Set<Id>();
       		List<Opportunity> updateOpportunityList = new List<Opportunity>(); 
       		
       		Box__c box = Box__c.getInstance();
       		
       		for(Opportunity opp: opportunityList){
       			
				HttpRequest req = new HttpRequest();
                req.setEndpoint('https://api.box.com/2.0/folders/'+opp.O_box_folder_id__c+'');
                req.setMethod('PUT');
                req.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
                req.setBody('{"parent": {"id" : 4407839250}}');
                
                Http http = new Http();
                HTTPResponse res = http.send(req);
            	system.debug('########################### res'+res.getStatusCode());
	            if(res.getStatusCode() != 200){
                	Box_Error__c bxerr = new Box_Error__c();
			   		bxerr.name = String.valueOf(res.getStatusCode()); 
			   		bxerr.Message__c = 'opportunity id :'+opp.id; 
			   		bxerr.Body__c = res.getBody();
			   		
			   		bxErrList.add(bxerr);
	            }       			
       		}
       		update updateOpportunityList;
       		insert bxErrList;
       }
       catch(Exception e){
       		Box_Error__c bxerr = new Box_Error__c();
	   		bxerr.name = 'Exception'; 
	   		bxerr.Message__c = e.getMessage(); 
	   		bxerr.Body__c = e.getStackTraceString();
	   		
	   		bxErrList.add(bxerr);
       }
       	
    }
    
    public void finish(Database.BatchableContext BC){}
    
    public class folderWrapper{
        public String Type;
        public String Id;
        public String Name;
    }
}