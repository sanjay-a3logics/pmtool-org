public with sharing class DealTriggerHandler implements ITrigger{
      // Constructor
    public static boolean firstRun = true;  
    public static boolean firstRunPmTool = true;  
    public DealTriggerHandler(){
      
        
    }
    

    /**
     * bulkBefore
     *
     * This method is called prior to execution of a BEFORE trigger. Use this to cache
     * any data required into maps prior execution of the trigger.
     */
    public void bulkBefore()
    {
       
    }
    
    public void bulkAfter()
    {
        
    }
    
    
    public void beforeInsert()
    {
        //write code here
    }
    
    public void beforeUpdate()
    {
        //write code here
    }
    
    /**
     * beforeDelete
     *
     * This method is called for records to be deleted during a BEFORE
     * trigger.
     */
    public void beforeDelete()
    {   
       List<Deal__c> opportunityDeleteList = (List<Deal__c>)Trigger.Old;
        Set<Id> oppIds = new Set<Id>();
        for(Deal__c opp: opportunityDeleteList){  
            oppIds.add(opp.id);
        }
        List<Sub_Folder__c> subFolderList = [select CF_Box_Folder_Id__c from Sub_folder__c where CF_Deal__c in: oppIds];
        Database.executeBatch(new BoxDeleteOpportunityBatch(opportunityDeleteList,subFolderList),1);
    }
    
    public void afterInsert()
    {   
      
        Set<Id> OppSet = new Set<Id>();
        Set<Id> oppSetToCreatePMRecord = new Set<Id>();
        
        List<Deal__c> opportunityList = (List<Deal__c>)Trigger.New;
        for(Deal__c Opp : opportunityList){
            OppSet.add(Opp.Id);
            

            if(Opp.Contracts_Approved_Date__c != null && Opp.Opp_Pipeline_Stage__c != 'Need To Board' && Opp.Opp_Pipeline_Stage__c != 'Closed Won' && Opp.Opp_Pipeline_Stage__c != 'Boarded' && Opp.Opp_Pipeline_Stage__c != 'Lost' && Opp.Opp_Pipeline_Stage__c != 'Removed & Terminated' && Opp.Opp_Pipeline_Stage__c != 'Removed' && Opp.Opp_Pipeline_Stage__c != 'Transfer' && !Opp.Opp_Pipeline_Stage__c.containsIgnoreCase('Lost') && !Opp.Opp_Pipeline_Stage__c.containsIgnoreCase('Transfer')){
            //if(Opp.Contracts_Approved_Date__c != null){
                 oppSetToCreatePMRecord.add(Opp.Id);
            }
        }
        
        if(OppSet.size() > 0){
            BoxAPIServicesController.createFolder(OppSet);
        }
        

        if(oppSetToCreatePMRecord.size() > 0){
            PMTool.createPMRecord(oppSetToCreatePMRecord);
            
            if(firstRunPmTool){
                firstRunPmTool = false;
                PMToolV2.insertPMRecord(oppSetToCreatePMRecord);
            }
        }

    }
    
    public void afterUpdate()
    {
        try{
             if(OpportunityTriggerHandler.firstRun){ 
                OpportunityTriggerHandler.firstRun =false; 
                Set<Id> OppSet = new Set<Id>();
                Set<Id> oppSetToCreatePMRecord = new Set<Id>();
                Set<Id> oppSetToUpdatePMRecord = new Set<Id>();
                
                Set<Id> oppSetToCreatePMRecordv1 = new Set<Id>();
                Set<Id> oppSetToUpdatePMRecordv1 = new Set<Id>();
                Set<Id> oppSetToInsertPMStageRecord = new Set<Id>();
                Map<Id,String> oldOppStageMap = new Map<Id,String>();
                Map<Id,String> oldCensusTractMap = new Map<Id,String>();
                
                 List<Deal__c> opportunityUpdateList = (List<Deal__c>)Trigger.New;
                 for(Deal__c Opp : opportunityUpdateList){
                    OppSet.add(Opp.Id);
                    
                    Deal__c oldOpportunity = (Deal__c)Trigger.OldMap.get(Opp.id);
                                
                    //check if pm tool record exists            
                    
                    if([select id from PM_Tool__c where Deal__c =:Opp.Id].size() > 0){
                        oppSetToUpdatePMRecordv1.add(Opp.Id);
                       
                    }
                    else{
                        if(Opp.Contracts_Approved_Date__c != null && Opp.Opp_Pipeline_Stage__c != 'Need To Board' && Opp.Opp_Pipeline_Stage__c != 'Closed Won' && Opp.Opp_Pipeline_Stage__c != 'Boarded' && Opp.Opp_Pipeline_Stage__c != 'Lost' && Opp.Opp_Pipeline_Stage__c != 'Removed & Terminated' && Opp.Opp_Pipeline_Stage__c != 'Removed' && Opp.Opp_Pipeline_Stage__c != 'Transfer' && !Opp.Opp_Pipeline_Stage__c.containsIgnoreCase('Lost') && !Opp.Opp_Pipeline_Stage__c.containsIgnoreCase('Transfer')){
                           oppSetToCreatePMRecordv1.add(Opp.Id);			
                        }
                    }
                    
                    if([select id from PM_Tool_V2__c where Deal__c =:Opp.Id].size() > 0){
                        oppSetToUpdatePMRecord.add(Opp.Id);
                        if((oldOpportunity.Property__c !=  Opp.Property__c) && (Opp.Property__c != null)){
                            oppSetToInsertPMStageRecord.add(Opp.Id);
                        }
                    }
                    else{
                        if(Opp.Contracts_Approved_Date__c != null && Opp.Opp_Pipeline_Stage__c != 'Need To Board' && Opp.Opp_Pipeline_Stage__c != 'Closed Won' && Opp.Opp_Pipeline_Stage__c != 'Boarded' && Opp.Opp_Pipeline_Stage__c != 'Lost' && Opp.Opp_Pipeline_Stage__c != 'Removed & Terminated' && Opp.Opp_Pipeline_Stage__c != 'Removed' && Opp.Opp_Pipeline_Stage__c != 'Transfer' && !Opp.Opp_Pipeline_Stage__c.containsIgnoreCase('Lost') && !Opp.Opp_Pipeline_Stage__c.containsIgnoreCase('Transfer')){
                        //if(Opp.Contracts_Approved_Date__c != null){		
                           oppSetToCreatePMRecord.add(Opp.Id);
                        }
                    }
                    
                    oldOppStageMap.put(Opp.id,oldOpportunity.stageName__c);
                    oldCensusTractMap.put(Opp.id,oldOpportunity.Census_Tract__c);
                 }
                 
                 if(oppSetToCreatePMRecordv1.size() > 0){
                    PMTool.createPMRecord(oppSetToCreatePMRecordv1);
                 }
                 
                 if(oppSetToUpdatePMRecordv1.size() > 0){
                    PMTool.updatePMRecordFromOpportunity(oppSetToUpdatePMRecordv1);
                 }
                 
                 if(oppSetToCreatePMRecord.size() > 0){
                    
                    PMToolV2.insertPMRecord(oppSetToCreatePMRecord);
                 }   
                 
                 if(oppSetToUpdatePMRecord.size() > 0){
                    
                    PMToolV2.updatePMRecordFromOpportunity(oppSetToUpdatePMRecord);
                    if(oppSetToInsertPMStageRecord.size() > 0){
                        PMToolV2.insertStages(oppSetToInsertPMStageRecord, UserInfo.getSessionId());
                    }
                 }
                 
                 Datetime newTime = datetime.now().addSeconds(5);    
                 String sched= String.valueOf(newtime.second()) +' ' + String.valueOf(newtime.minute()) + ' ' + String.valueOf(newTime.hour()) + ' ' + String.valueOf(newTime.day()) + ' ' + String.valueOf(newTime.month()) + ' ? ' +  String.valueOf(newTime.year()); 
                 Double st = Math.random();
                 CensusTract ct = new CensusTract(OppSet,oldOppStageMap,oldCensusTractMap);
                 System.schedule('CensusTract '+newTime+String.valueOf(st), sched, ct);
                
                system.debug('#################################### BoxAPIServicesController.callStageChange '+BoxAPIServicesController.callStageChange);
                
                if(BoxAPIServicesController.callStageChange == null || BoxAPIServicesController.callStageChange == true){
                    
                   /* List<Deal__c> opportunityUpdateList = (List<Deal__c>)Trigger.New;
                     for(Deal__c Opp : Deal__cUpdateList){
                        OppSet.add(Opp.Id);
                     } */
                    
                     Map<String,boolean> stageMap = new Map<String,boolean>();
                   
                     Map<String,Set<string>> profileMapSet = new Map<String,Set<string>>();
                     Set<String> profileSet= new Set<String>();
                     for(BoxAccessMatrix_stage__c bam: [select  stage__c, check__c,  BoxAccessMatrix_Profile__r.Profile_id__c from BoxAccessMatrix_stage__c where check__c=true]){
                           if(!profileMapSet.containsKey(bam.stage__c)) {
                                profileMapSet.put(bam.stage__c,new Set<String>());
                              }
                             profileMapSet.get(bam.stage__c).add(bam.BoxAccessMatrix_Profile__r.Profile_id__c);  
                     }
                  
                   
                    Map<String,String> FolderNameMap = new Map<String,String>();
                    Map<String,Sub_folder__c> SubfolderMap = new Map<String,Sub_folder__c>();
                    Map<Id,List<Sub_folder__c>> oppSubFolderMap = new Map<Id,List<Sub_folder__c>>();
                    Map<Id,List<String>> oppSubFolderMapString = new Map<Id,List<String>>();
                     for(Sub_folder__c  sbf: [select id,name, cf_box_folder_id__c, cf_Deal__c  from Sub_folder__c where  cf_Deal__c in: OppSet]){
                            FolderNameMap.put(sbf.CF_Box_Folder_Id__c,sbf.name);
                         if(!oppSubFolderMap.containsKey(sbf.cf_Deal__c)){
                             oppSubFolderMap.put(sbf.cf_Deal__c, new List<Sub_folder__c>());
                             oppSubFolderMapString.put(sbf.cf_Deal__c, new List<String>());
                         }
                         SubfolderMap.put(sbf.CF_Box_Folder_Id__c,sbf);
                         oppSubFolderMap.get(sbf.cf_Deal__c).add(sbf);
                         oppSubFolderMapString.get(sbf.cf_Deal__c).add(sbf.cf_box_folder_id__c);
                     }          
                             
                       for(Deal__c Opp : opportunityUpdateList){ 
                          
                               Deal__c oldopp = (Deal__c)Trigger.OldMap.get(Opp.id);
                            
                              
                          if(oppSubFolderMap.get(opp.id)!=null){    
                            if(opp.Opp_Pipeline_Stage__c!= oldopp.Opp_Pipeline_Stage__c){
                                 if(oppSubFolderMap.get(opp.id)!=null && profileMapSet.get(oldopp.Opp_Pipeline_Stage__c)!=null)
                                    for(Sub_folder__c sf :oppSubFolderMap.get(opp.id)){
                                        Database.executebatch(New BoxDeleteCollobrationBatch(sf,opp.Opp_Pipeline_Stage__c,oldopp.Opp_Pipeline_Stage__c),2);
                                     }
                                  }
                            if(opp.Owner.name!= oldopp.Owner.name){ 						   
                                   BoxAPIServicesController.changeOpportunityOwner(opp.id,opp.Owner.name,opp.Opp_Pipeline_Stage__c,oldopp.Owner.name);
                              } 
                            }  
                        }   
                    
                   }
                else{
                    BoxAPIServicesController.callStageChange = true;
                } 
            
            }
        
        }
        catch(Exception e){
            

            Messaging.reserveSingleEmailCapacity(2);
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            
            String[] toAddresses = new String[] {'sanjays@appcino.com'}; 
            String[] ccAddresses = new String[] {};
              
            mail.setToAddresses(toAddresses);
            mail.setCcAddresses(ccAddresses);
            
           // mail.setReplyTo();
            
            mail.setSenderDisplayName('Deal Trigger Exeption');

            mail.setSubject('Deal Trigger Exeption');
            
            mail.setBccSender(false);
            
            mail.setUseSignature(false);
            
            mail.setPlainTextBody('Deal Trigger Exeption: ' +e.getMessage()+' --- Line Number:'+e.getLineNumber()+' --- '+e.getStackTraceString());
            
            mail.setHtmlBody('Deal Trigger Exeption: ' +e.getMessage()+' --- Line Number:'+e.getLineNumber()+' --- '+e.getStackTraceString());
                 
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
    }
    
    public void afterDelete()
    {
    }
    
    public void afterUnDelete()
    {
    }
    
    /**
     * andFinally
     *
     * This method is called once all records have been processed by the trigger. Use this 
     * method to accomplish any final operations such as creation or updates of other records.
     */
    public void andFinally()
    {
        
    }
  
}