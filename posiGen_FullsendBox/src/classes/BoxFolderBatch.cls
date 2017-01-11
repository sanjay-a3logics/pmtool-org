public class BoxFolderBatch implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful{
   public Integer recordCount = 0; 
   //public Integer record_count_stop = 0;
   
   public BoxFolderBatch(Integer recordCount){
       this.recordCount = recordCount;
   } 
   
    public Database.QueryLocator start(Database.BatchableContext BC){
        if (recordCount == 0 ) {
                return Database.getQueryLocator('select Id, name from Opportunity where O_box_folder_id__c = null');
        }
        else {
            return Database.getQueryLocator('select Id, name from Opportunity where O_box_folder_id__c = null limit ' + recordCount);
        }
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
                req.setBody('{"name":"'+oppName+'", "parent": {"id": "4407839250"}}');
                
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
                    hreq3.setBody('{"name":"'+oppName+' - EE", "parent": {"id": "'+fw.Id+'"}}');
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
                        
                        bxErrList.add(bxerr);
                    }

                    
                    /** Creating sub-folder Funding-Vendor **/
                    HttpRequest hreq2 = new HttpRequest();
                    hreq2.setEndpoint('https://api.box.com/2.0/folders');
                    hreq2.setMethod('POST');
                    hreq2.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
                    hreq2.setBody('{"name":"'+oppName+' - Funding-Vendor", "parent": {"id": "'+fw.Id+'"}}');
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
                        System.debug('  ********************** add to list '+CF);
                        CFList.add(CF);
                        System.debug('  ********************** list '+CFList);
                    }
                    else{
                        System.debug(' *** Error *** '+res3.getBody());
                        Box_Error__c bxerr = new Box_Error__c();
                        bxerr.name = String.valueOf(res3.getStatusCode()); 
                        bxerr.Message__c = ''; 
                        bxerr.Body__c = res3.getBody();
                        
                        bxErrList.add(bxerr);
                    }

                    
                    /** Creating sub-folder Application **/
                    HttpRequest hreq1 = new HttpRequest();
                    hreq1.setEndpoint('https://api.box.com/2.0/folders');
                    hreq1.setMethod('POST');
                    hreq1.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
                    hreq1.setBody('{"name":"'+oppName+' - Application", "parent": {"id": "'+fw.Id+'"}}');
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
                        
                        bxErrList.add(bxerr);
                    }
                                                            

                    /** Creating sub-folder Sales **/
                    HttpRequest hreq = new HttpRequest();
                    hreq.setEndpoint('https://api.box.com/2.0/folders');
                    hreq.setMethod('POST');
                    hreq.setHeader('Authorization','Bearer '+box.BoxAccess_Token__c);
                    hreq.setBody('{"name":"'+oppName+' - Sales", "parent": {"id": "'+fw.Id+'"}}');
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
                else{
                    System.debug(' *** Error *** '+res.getBody());
                     Box_Error__c bxerr = new Box_Error__c();
                    bxerr.name = String.valueOf(res.getStatusCode()); 
                    bxerr.Message__c = ''; 
                    bxerr.Body__c = res.getBody();
                    
                    bxErrList.add(bxerr);
                }
            }
            update UpdatedOppList;
            System.debug(' ******************************* child folder list size- '+CFList.size());
            insert CFList;
           
             
        }
        catch(Exception e){
            System.debug(' ***Error '+e.getMessage());
            Box_Error__c bxerr = new Box_Error__c();
            bxerr.name = 'Exception'; 
            bxerr.Message__c = e.getMessage(); 
            bxerr.Body__c = e.getStackTraceString();
            
            bxErrList.add(bxerr);
        }
        insert bxErrList;    
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
   
}