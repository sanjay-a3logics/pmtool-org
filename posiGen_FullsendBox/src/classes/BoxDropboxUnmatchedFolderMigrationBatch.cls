public with sharing class BoxDropboxUnmatchedFolderMigrationBatch implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful{
	public String base_url = 'https://posigen.app.box.com/files/0/f/';
	public Integer record_count = 0; 
	public Integer record_count_stop = 0;
	
	public BoxDropboxUnmatchedFolderMigrationBatch(Integer record_count_stop){
		this.record_count_stop = record_count_stop;
	} 
    
    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('select Id, directory_path__c, folder_name__c, box_folder_id__c, opportunity_id__c, type__c, done__c from Dropbox_Files_in_Box__c where opportunity_id__c = null and done__c = false');
    }
    
    public void execute(Database.BatchableContext BC, List<Dropbox_Files_in_Box__c> dropboxList){
       List<Box_Error__c> bxErrList = new List<Box_Error__c>();
       try{
       	
            List<Dropbox_Files_in_Box__c> updatedDropboxList = new List<Dropbox_Files_in_Box__c>();
            
            system.debug('##################################### dropboxList.size'+dropboxList.size());
            Box__c box = Box__c.getInstance();
            
            for(Dropbox_Files_in_Box__c dropBoxFile : dropboxList){
	            
                HttpRequest req = new HttpRequest();
                req.setEndpoint('https://api.box.com/2.0/folders/'+dropBoxFile.box_folder_id__c+'/copy');
                req.setMethod('POST');
                req.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
                req.setBody('{"parent": {"id" : 4408116546}}');
                
                Http http = new Http();
                HTTPResponse res = http.send(req);
                  if(res.getStatusCode() == 201){
                  	dropBoxFile.done__c = true;
                    updatedDropboxList.add(dropBoxFile);
                    
                    Box_Error__c bxerr = new Box_Error__c();
			   		bxerr.Opportunity__c = dropBoxFile.opportunity_id__c; 
			   		bxerr.name = String.valueOf(res.getStatusCode()); 
			   		bxerr.Message__c = 'opportunity id: '+dropBoxFile.opportunity_id__c+'--- folder id'+dropBoxFile.box_folder_id__c; 
			   		bxerr.Body__c = res.getBody();
			   		bxerr.Type__c = dropBoxFile.type__c;
			   		bxerr.Status__c = 'Success';
			   		FolderWrapper fw = (FolderWrapper)JSON.deserialize(res.getBody(),FolderWrapper.class);
			   		
					// constructing manual url
			   		String manual_url = base_url;
			   		manual_url += fw.id;
			   		manual_url += '/';
			   		
			   		String folder_name = fw.name;
			   		folder_name = folder_name.trim();
			   		folder_name = folder_name.replaceAll('(\\s+)', '_');
			   		folder_name = EncodingUtil.urlEncode(folder_name, 'UTF-8');
			   		
			   		manual_url += folder_name;
			   		bxerr.Manual_Url__c = manual_url;
			   		
			   		system.debug('######################################## manual_url'+ manual_url);
			   		
			   		bxErrList.add(bxerr);
                    
                  }
                  else{
                  	Box_Error__c bxerr = new Box_Error__c();
			   		bxerr.Opportunity__c = dropBoxFile.opportunity_id__c; 
			   		bxerr.name = String.valueOf(res.getStatusCode()); 
			   		bxerr.Message__c = 'opportunity id: '+dropBoxFile.opportunity_id__c+'--- folder id'+dropBoxFile.box_folder_id__c; 
			   		bxerr.Body__c = res.getBody();
			   		bxerr.Type__c = 'KDH Folder move';
			   		bxerr.Status__c = 'Error';
			   		
			   		bxErrList.add(bxerr);
                  }
            }
            
            update updatedDropboxList;
            insert bxErrList;
            
            record_count += dropboxList.size();
            if(record_count == record_count_stop){
		   		system.debug('######################################## job aborted record_count is'+ record_count);
		   		System.abortJob(BC.getJobId());
            }
    
        }
        catch(Exception e){
            System.debug(' ***Error '+e.getMessage());
          	Box_Error__c bxerr = new Box_Error__c();
	   		bxerr.name = 'Exception'; 
	   		bxerr.Message__c = e.getMessage(); 
	   		bxerr.Body__c = e.getStackTraceString();
	   		
	   		bxErrList.add(bxerr);
        }
    }
    
    
   public void finish(Database.BatchableContext BC){}
    
   public class FolderWrapper{
        public String Type;
        public String Id;
        public String Name;
    } 
}