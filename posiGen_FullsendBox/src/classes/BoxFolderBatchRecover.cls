public with sharing class BoxFolderBatchRecover implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful{
    public List<Opportunity> start(Database.BatchableContext BC){
	    List<Opportunity> distinctRecords = new List<Opportunity>();
	    for(Opportunity oppObj: [select id, name from Opportunity where o_box_folder_id__c = null limit 800]){
	        Boolean found = false;
	        for(Integer i=0; i< distinctRecords.size(); i++){
		        //Check if current name has been added yet
		        String opp_name = oppObj.name;
		        if(opp_name.equalsIgnoreCase(distinctRecords[i].name)){ 
		
		            found=true;
		            break;
		        }
		    }
	    	if(!found)
	        distinctRecords.add(oppObj);
	    }
	    return distinctRecords;
    }
    
    
    public void execute(Database.BatchableContext BC, List<Sobject> scope){
	   List<Box_Error__c> bxErrList = new List<Box_Error__c>();
       try{
            Set<Id> OppIds = new Set<Id>();
            
            for(Sobject Sobj : scope){
                Opportunity Opp = (Opportunity) Sobj;
                OppIds.add(Opp.Id);
            }
            
        	List<Opportunity> OppList = SoqlServices.getOpportunityList(OppIds);
            List<Opportunity> UpdatedOppList = new List<Opportunity>();
            List<Sub_Folder__c> CFList = new List<Sub_Folder__c>();
            
            Box__c box = Box__c.getInstance();
            System.debug(OppIds+'OppList Size --------- '+OppList.size());
            for(Opportunity Opp : OppList){
                
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
                req.setBody('{"name":"'+oppName+'", "parent": {"id": "0"}}');
                
                Http http = new Http();
                HTTPResponse res = http.send(req);
                if(res.getStatusCode() == 201){

                    folderWrapper fw=(folderWrapper)JSON.deserialize(res.getBody(),folderWrapper.class);
                    Sub_Folder__c CF = new Sub_Folder__c();
                    
                    /** Creating sub-folder EE **/
                    HttpRequest hreq3 = new HttpRequest();
                    hreq3.setEndpoint('https://api.box.com/2.0/folders');
                    hreq3.setMethod('POST');
                    hreq3.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
                    hreq3.setBody('{"name":"EE", "parent": {"id": "'+fw.Id+'"}}');
                    Http http4 = new Http();
                    HTTPResponse res4 = http4.send(hreq3);
                    System.debug(' ***Sub Folder 4 '+res4.getStatusCode()+' ----- '+res4.getBody());
                    folderWrapper subfw4 = new folderWrapper();
                    if(res4.getStatusCode() == 201){
                        subfw4 = (folderWrapper)JSON.deserialize(res4.getBody(),folderWrapper.class);
                        CF = new Sub_Folder__c();
                        CF.CF_Box_Folder_Id__c = subfw4.Id;
                        CF.CF_Opportunity__c = Opp.Id;
                        CF.Name = subfw4.Name;
                        CFList.add(CF);
                    }
                    else{
                        System.debug(' *** Error *** '+res4.getBody());
                    	Box_Error__c bxerr = new Box_Error__c();
				   		bxerr.name = String.valueOf(res4.getStatusCode()); 
				   		bxerr.Message__c = ''; 
				   		bxerr.Body__c = res4.getBody();
                    }

					
                    /** Creating sub-folder Funding-Vendor **/
                    HttpRequest hreq2 = new HttpRequest();
                    hreq2.setEndpoint('https://api.box.com/2.0/folders');
                    hreq2.setMethod('POST');
                    hreq2.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
                    hreq2.setBody('{"name":"Funding-Vendor", "parent": {"id": "'+fw.Id+'"}}');
                    Http http3 = new Http();
                    HTTPResponse res3 = http3.send(hreq2);
                    
                    System.debug(' ***Sub Folder Funding-Vendor '+res3.getStatusCode()+' ----- '+res3.getBody());
                    
                    folderWrapper subfw3 = new folderWrapper();
                    if(res3.getStatusCode() == 201){
                        subfw3 = (folderWrapper)JSON.deserialize(res3.getBody(),folderWrapper.class);
                        CF = new Sub_Folder__c();
                        CF.CF_Box_Folder_Id__c = subfw3.Id;
                        CF.CF_Opportunity__c = Opp.Id;
                        CF.Name = subfw3.Name;
                        CFList.add(CF);
                    }
                    else{
                        System.debug(' *** Error *** '+res3.getBody());
                    	Box_Error__c bxerr = new Box_Error__c();
				   		bxerr.name = String.valueOf(res3.getStatusCode()); 
				   		bxerr.Message__c = ''; 
				   		bxerr.Body__c = res3.getBody();
                    }

					
                    /** Creating sub-folder Application **/
                    HttpRequest hreq1 = new HttpRequest();
                    hreq1.setEndpoint('https://api.box.com/2.0/folders');
                    hreq1.setMethod('POST');
                    hreq1.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
                    hreq1.setBody('{"name":"Application", "parent": {"id": "'+fw.Id+'"}}');
                    Http http2 = new Http();
                    HTTPResponse res2 = http2.send(hreq1);
                    
                    System.debug(' ***Sub Folder Application '+res2.getStatusCode()+' ----- '+res2.getBody());
                    
                    folderWrapper subfw2 = new folderWrapper();
                    if(res2.getStatusCode() == 201){
                        subfw2 = (folderWrapper)JSON.deserialize(res2.getBody(),folderWrapper.class);
                        CF = new Sub_Folder__c();
                        CF.CF_Box_Folder_Id__c = subfw2.Id;
                        CF.CF_Opportunity__c = Opp.Id;
                        CF.Name = subfw2.Name;
                        CFList.add(CF);
                    }
                    else{
                        System.debug(' *** Error *** '+res2.getBody());
                    	Box_Error__c bxerr = new Box_Error__c();
				   		bxerr.name = String.valueOf(res2.getStatusCode()); 
				   		bxerr.Message__c = ''; 
				   		bxerr.Body__c = res2.getBody();
                    }
															

                    /** Creating sub-folder Sales **/
                    HttpRequest hreq = new HttpRequest();
                    hreq.setEndpoint('https://api.box.com/2.0/folders');
                    hreq.setMethod('POST');
                    hreq.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
                    hreq.setBody('{"name":"Sales", "parent": {"id": "'+fw.Id+'"}}');
                    Http http1 = new Http();
                    HTTPResponse res1 = http1.send(hreq);
                    
                    System.debug(' *** Sub Folder Sales '+res1.getStatusCode()+' ----- '+res1.getBody());
                    
                    folderWrapper subfw1 = new folderWrapper();
                    if(res1.getStatusCode() == 201){
                        subfw1 = (folderWrapper)JSON.deserialize(res1.getBody(),folderWrapper.class);
                        CF = new Sub_Folder__c();
                        CF.CF_Box_Folder_Id__c = subfw1.Id;
                        CF.CF_Opportunity__c = Opp.Id;
                        CF.Name = subfw1.Name;
                        CFList.add(CF);
                      
                    }
                    else{
                        System.debug(' *** Error *** '+res1.getBody());
                    	Box_Error__c bxerr = new Box_Error__c();
				   		bxerr.name = String.valueOf(res1.getStatusCode()); 
				   		bxerr.Message__c = ''; 
				   		bxerr.Body__c = res1.getBody();
				   		
				   		bxErrList.add(bxerr); 
                        
                    }
                    
                    Opp.O_Box_Folder_Id__c = fw.Id;
                    UpdatedOppList.add(Opp);
                }
                else if(res.getStatusCode() == 409){
                        ConflictWrapper conflictw = (ConflictWrapper)JSON.deserialize(res.getBody(),ConflictWrapper.class);
                        for(Conflicts conf: conflictw.context_info.conflicts){
							//update the opportunity field O_box_folder_id__c
							if(oppName == conf.name){
								Opp.O_box_folder_id__c = conf.id; 
								UpdatedOppList.add(Opp);
								
								HttpRequest hreqC = new HttpRequest();
			                    hreqC.setEndpoint('https://api.box.com/2.0/folders/'+conf.id+'/items?limit=4&offset=0');
			                    hreqC.setMethod('GET');
			                    hreqC.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
			                    Http httpC = new Http();
			                    HTTPResponse resC = httpC.send(hreqC);
			                    
			                    if(resC.getStatusCode() == 200){
			                        ItemsWrapper itemw = (ItemsWrapper)JSON.deserialize(resC.getBody(),ItemsWrapper.class);
			                        if(itemw.total_count == 4 ){
										
										// creating sub folder for opportunity
										for(Entries entry : itemw.entries){
											Sub_Folder__c CF = new Sub_Folder__c();
					                        CF.CF_Box_Folder_Id__c = entry.Id;
					                        CF.CF_Opportunity__c = Opp.Id;
					                        CF.Name = entry.Name;
					                        CFList.add(CF);
										}					                				        	
			                        }
			                        else{
			                        	Box_Error__c bxerr = new Box_Error__c();
								   		bxerr.name = String.valueOf(resC.getStatusCode()); 
								   		bxerr.Message__c = 'Total count is not 4 for opportunity -'+Opp.Id+' and folder id -'+conf.id; 
								   		bxerr.Body__c = resC.getBody();
								   		
								   		bxErrList.add(bxerr); 
			                        }
			                    	
			                    }								
		                        else{
		                        	Box_Error__c bxerr = new Box_Error__c();
							   		bxerr.name = String.valueOf(resC.getStatusCode()); 
							   		bxerr.Message__c = 'Status code is not 200 for opportunity -'+Opp.Id+' and folder id -'+conf.id; 
							   		bxerr.Body__c = resC.getBody();
							   		
							   		bxErrList.add(bxerr); 
		                        }
							}
	                        else{
	                        	Box_Error__c bxerr = new Box_Error__c();
						   		bxerr.name = ''; 
						   		bxerr.Message__c = 'opportunity -'+Opp.Id+' name not matched'; 
						   		bxerr.Body__c = '';
						   		
						   		bxErrList.add(bxerr); 
	                        }
                        }
                }
                else{
                	Box_Error__c bxerr = new Box_Error__c();
			   		bxerr.name = String.valueOf(res.getStatusCode()); 
			   		bxerr.Message__c = 'opportunity -'+Opp.Id+' status code is not 201 and 409'; 
			   		bxerr.Body__c = res.getBody();
			   		
			   		bxErrList.add(bxerr); 
                }
            }
            update UpdatedOppList;
            insert CFList;    
	   		insert bxErrList;
        }
        catch(Exception e){
            System.debug(' ***Error '+e.getMessage());
            Box_Error__c bxerr = new Box_Error__c();
	   		bxerr.name = ''; 
	   		bxerr.Message__c = e.getMessage(); 
	   		bxerr.Body__c = e.getStackTraceString();
	   		
	   		bxErrList.add(bxerr);
	   		insert bxErrList;
        }
    }
    
   public void finish(Database.BatchableContext BC){}
    
   public class folderWrapper{
        public String Type;
        public String Id;
        public String Name;
    } 
   public class ErrorWrapper{
        public String type;
        public Integer status;
        public String message;
    }
    
   public class ConflictWrapper {

	public String type;
	public Integer status;
	public String code;
	public Context_info context_info;
	public String help_url;
	public String message;
	public String request_id;
	}
	 
	public class Context_info {
		public List<Conflicts> conflicts;
	}

	public class Conflicts {
		public String type;
		public String id;
		public String sequence_id;
		public String etag;
		public String name;
	}
	
	public class ItemsWrapper {

		public Integer total_count;
		public List<Entries> entries;
	}

	public class Entries {
		public String type;
		public String id;
		public String sequence_id;
		public String etag;
		public String name;
	}
}