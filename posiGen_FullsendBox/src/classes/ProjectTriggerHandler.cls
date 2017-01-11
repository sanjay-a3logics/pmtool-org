public with sharing class ProjectTriggerHandler implements ITrigger{
      // Constructor
    public static boolean firstRun = true; 
    public Map<String,String> StageMap; 
    public Map<String,String> PermissionMap;
    public Map<Id,set<string>> contactMap;   
    public ProjectTriggerHandler(){
    
     StageMap = new Map<String,String>();
     PermissionMap = new Map<String,String>();
     contactMap = new Map<Id,Set<string>>();  
     for(BoxAccessMatrix_Stage__c bxStg:[select Box_Permission__c,BoxAccessMatrix_Profile__r.BoxAccessMatrix_SubFolder__r.SubFolder_Name__c, BoxAccessMatrix_Profile__r.Profile_Id__c, Stage__c 
                                        from BoxAccessMatrix_Stage__c where BoxAccessMatrix_Profile__r.Lookup_field_Name__c ='Subcontractor__c' and check__c =true]){
                                        
                 StageMap.put(bxStg.Stage__c+'#'+bxStg.BoxAccessMatrix_Profile__r.BoxAccessMatrix_SubFolder__r.SubFolder_Name__c,
                 bxStg.BoxAccessMatrix_Profile__r.Profile_Id__c);                         
                 
                 PermissionMap.put(bxStg.BoxAccessMatrix_Profile__r.Profile_Id__c,bxStg.Box_Permission__c);                          
           } 
     
       
      
       for(Account acc:[Select id, (Select email from contacts where email!=null) from Account where id!=null]){
       if(acc.contacts!=null){   
            for(Contact con :acc.contacts){
                
                if(!Contactmap.containsKey(acc.id)){
                    Contactmap.put(acc.id, new set<string>());
                }
                Contactmap.get(acc.id).add(con.email);
              }
             } 
         }   
          
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
       
    }
    
    /**
     * beforeDelete
     *
     * This method is called for records to be deleted during a BEFORE
     * trigger.
     */
    public void beforeDelete()
    {   
      
    }
    
    public void afterInsert()
    {   
        //UpdateEEStatusFromProjectInsert starts here
        List<Project__c> projsToUpdate = [SELECT Id, Status__c, Record_Type_Name__c, Deal__r.Id, EE_Completed_Date__c
                                      FROM Project__c 
                                      WHERE (Project__c.Record_Type_Name__c LIKE '%EE%Assessment%' OR 
                                      Project__c.Record_Type_Name__c LIKE '%EE%Upgrade%')
                                       AND Id IN : Trigger.newMap.keySet()];
    
        List<Deal__c> oppsToUpdate = new List<Deal__c>();
        
        for (Project__c p : projsToUpdate)
        {
            Deal__c o = p.Deal__r;
            if (p.Status__c != null && p.Record_Type_Name__c == 'EE Assessment')
            {
                o.EA_Status__c = p.Status__c;
            }
            if (p.EE_Completed_Date__c != null && p.Record_Type_Name__c == 'EE Assessment')
            {
              o.EA_Completed_Date__c = p.EE_Completed_Date__c;    
            }
            if (p.Status__c != null && p.Record_Type_Name__c == 'EE Upgrade') 
            {
                o.EU_Status__c = p.Status__c;
            }
            if (p.EE_Completed_Date__c != null && p.Record_Type_Name__c == 'EE Upgrade')
            {
                o.EU_Completed_Date__c = p.EE_Completed_Date__c;
            }
            oppsToUpdate.add(o);
        }
        update oppsToUpdate;
        // UpdateEEStatusFromProjectInsert ends here
        
        
        Set<Id> projSet = new Set<Id>();
        Set<Id> oppSet = new Set<Id>();
        List<Project__c> projectList = (List<Project__c>)Trigger.New;
        Set<Id> prjSetToUpdatePMRecord = new Set<Id>();
        Set<Id> oppSetToUpdatePMRecord = new Set<Id>();
        Map<Id, Datetime> contractAppDateMap = new Map<Id, Datetime>();
        
        for(Project__c prj : [select id, Deal__c, Deal__r.Contracts_Approved_Date__c from Project__c 
        where id in:projectList ]){
           if(prj.Deal__c!=null){
               projSet.add(prj.id);
               oppSet.add(prj.Deal__c);
           } 
           
           if(prj.Deal__c != null && prj.Deal__r.Contracts_Approved_Date__c != null){
               prjSetToUpdatePMRecord.add(prj.id);
               oppSetToUpdatePMRecord.add(prj.Deal__c);
           }
        }

        if(prjSetToUpdatePMRecord.size() > 0){
            PMTool.updatePMRecord(prjSetToUpdatePMRecord, 'afterInsert');
        }
        
        if(oppSetToUpdatePMRecord.size() > 0){
            PMToolV2.updatePMRecordFromProject(oppSetToUpdatePMRecord);
        }
        
        
        if(projSet != null && oppSet!= null){}
       
      Map<String,Sub_folder__c > folderIdMap = new Map<String,Sub_folder__c >();
      
      for(Sub_folder__c sf: [Select id,Name,cf_Deal__c,CF_Box_Folder_Id__c from Sub_Folder__c where cf_Deal__c in:oppSet]){
          folderIdMap.put(sf.cf_Deal__c+'#'+sf.Name,sf); 
          
      }
     
       for(Project__c prj:[Select id, subcontractor__c,EE_Assessor__c, RecordType.Name,Deal__c,Deal__r.Opp_Pipeline_Stage__c  from project__c where id in:projSet]){
             
             
              if(prj.subcontractor__c!=null){
                    string boxfolderId = '';
                    string oppId = '';
                    string subFolderId = '';
                    
                   if(prj.RecordType.Name == 'EE Assessment'||prj.RecordType.Name == 'EE Upgrade'){
                        
                          if(StageMap.get(prj.Deal__r.Opp_Pipeline_Stage__c+'#'+'EE')!=null){   
                               if (folderIdMap.containskey(prj.Deal__c+'#'+'EE')) {
                                   boxfolderId = folderIdMap.get(prj.Deal__c+'#'+'EE').CF_Box_Folder_Id__c;
                                   oppId = folderIdMap.get(prj.Deal__c+'#'+'EE').cf_Deal__c;
                                   subFolderId = folderIdMap.get(prj.Deal__c+'#'+'EE').Id;
                               }
                               else {
                                   boxfolderId = folderIdMap.get(prj.Deal__c+'#'+ prj.Deal__r.name + ' - '+ 'EE').CF_Box_Folder_Id__c;
                                   oppId = folderIdMap.get(prj.Deal__c+'#'+ prj.Deal__r.name + ' - '+ 'EE').cf_Deal__c;
                                   subFolderId = folderIdMap.get(prj.Deal__c+'#'+ prj.Deal__r.name + ' - '+ 'EE').Id;
                               
                               }
                               
                               BoxAPIServicesController.createcollaborationOnFolder(StageMap.get(prj.Deal__r.Opp_Pipeline_Stage__c+'#'+'EE'),
                               PermissionMap.get(StageMap.get(prj.Deal__r.Opp_Pipeline_Stage__c+'#'+'EE')),
                               boxfolderId,
                               Contactmap.get(prj.subcontractor__c),
                               OppId,
                               subFolderId);  
                                             
                          }
                     }
                     else{
                              
                        if(StageMap.get(prj.Deal__r.Opp_Pipeline_Stage__c+'#'+'Sales')!=null){ 
                           
                           if (folderIdMap.containskey(prj.Deal__c+'#'+'Sales')) {
                               boxfolderId = folderIdMap.get(prj.Deal__c+'#'+'Sales').CF_Box_Folder_Id__c;
                               oppId = folderIdMap.get(prj.Deal__c+'#'+'Sales').cf_Deal__c;
                               subFolderId = folderIdMap.get(prj.Deal__c+'#'+'Sales').Id;
                           }
                           else {
                               boxfolderId = folderIdMap.get(prj.Deal__c+'#'+ prj.Deal__r.name + ' - '+ 'Sales').CF_Box_Folder_Id__c;
                               oppId = folderIdMap.get(prj.Deal__c+'#'+ prj.Deal__r.name + ' - '+ 'Sales').cf_Deal__c;
                               subFolderId = folderIdMap.get(prj.Deal__c+'#'+ prj.Deal__r.name + ' - '+ 'Sales').Id;
                           
                           }
                           
                           BoxAPIServicesController.createcollaborationOnFolder(
                               StageMap.get(prj.Deal__r.Opp_Pipeline_Stage__c+'#'+'Sales'),
                               PermissionMap.get(StageMap.get(prj.Deal__r.Opp_Pipeline_Stage__c+'#'+'Sales')),
                               boxfolderId ,
                               Contactmap.get(prj.subcontractor__c),
                               oppId,
                               subFolderId);
                        }                       
                        
                        if(StageMap.get(prj.Deal__r.Opp_Pipeline_Stage__c+'#'+'Application')!=null){
                           if (folderIdMap.containskey(prj.Deal__c+'#'+'Application')) {
                               boxfolderId = folderIdMap.get(prj.Deal__c+'#'+'Application').CF_Box_Folder_Id__c;
                               oppId = folderIdMap.get(prj.Deal__c+'#'+'Application').cf_Deal__c;
                               subFolderId = folderIdMap.get(prj.Deal__c+'#'+'Application').Id;
                           }
                           else {
                               boxfolderId = folderIdMap.get(prj.Deal__c+'#'+ prj.Deal__r.name + ' - '+ 'Application').CF_Box_Folder_Id__c;
                               oppId = folderIdMap.get(prj.Deal__c+'#'+ prj.Deal__r.name + ' - '+ 'Application').cf_Deal__c;
                               subFolderId = folderIdMap.get(prj.Deal__c+'#'+ prj.Deal__r.name + ' - '+ 'Application').Id;
                           
                           }
                           
                           BoxAPIServicesController.createcollaborationOnFolder(StageMap.get(prj.Deal__r.Opp_Pipeline_Stage__c+'#'+'Application'),
                           PermissionMap.get(StageMap.get(prj.Deal__r.Opp_Pipeline_Stage__c+'#'+'Application')),
                           boxfolderId ,
                           Contactmap.get(prj.subcontractor__c),
                           oppId,
                           subFolderId);
                        }
                        if(StageMap.get(prj.Deal__r.Opp_Pipeline_Stage__c+'#'+'Funding-Vendor')!=null){
                           
                           if (folderIdMap.containskey(prj.Deal__c+'#'+'Funding-Vendor')) {
                               boxfolderId = folderIdMap.get(prj.Deal__c+'#'+'Funding-Vendor').CF_Box_Folder_Id__c;
                               oppId = folderIdMap.get(prj.Deal__c+'#'+'Funding-Vendor').cf_Deal__c;
                               subFolderId = folderIdMap.get(prj.Deal__c+'#'+'Funding-Vendor').Id;
                           }
                           else {
                               boxfolderId = folderIdMap.get(prj.Deal__c+'#'+ prj.Deal__r.name + ' - '+ 'Funding-Vendor').CF_Box_Folder_Id__c;
                               oppId = folderIdMap.get(prj.Deal__c+'#'+ prj.Deal__r.name + ' - '+ 'Funding-Vendor').cf_Deal__c;
                               subFolderId = folderIdMap.get(prj.Deal__c+'#'+ prj.Deal__r.name + ' - '+ 'Funding-Vendor').Id;
                           
                           }
                           
                           BoxAPIServicesController.createcollaborationOnFolder(StageMap.get(prj.Deal__r.Opp_Pipeline_Stage__c+'#'+'Funding-Vendor'),
                           PermissionMap.get(StageMap.get(prj.Deal__r.Opp_Pipeline_Stage__c+'#'+'Funding-Vendor')),
                           boxfolderId ,
                           Contactmap.get(prj.subcontractor__c),
                           OppId,
                           subFolderId);
                        }
                    }
              
             }  
        
         } 
     
       
    }
    
    public void afterUpdate()
    {  
        
        List<Project__c> projects = (List<Project__c>)Trigger.New;
        
        Map<String, String> mapOppProject = new Map<String,String>();
        Set<String> oppIds = new Set<String>();
        Set<String> RailPanelOpps = new Set<String>();
        set<String> idstoupdatePMTool = new Set<String>();
        Set<Id> oppSetToUpdatePMRecord = new Set<Id>();
        
        //Get list of all the related opportunities
        List<Project__c> projectList = (List<Project__c>)Trigger.New;
        Map<Id,String> mapProjectOpportunity = new Map<Id,String>();		
        for( Project__c project : projects){
            
            oppIds.add(project.Deal__c);
            // filter out records for UpdateOppFromPVInstall
            if (project.recordtypeId == Schema.Sobjecttype.Project__c.getRecordTypeInfosByName().get('PV Install').getRecordTypeId()
                ||project.recordtypeId == Schema.Sobjecttype.Project__c.getRecordTypeInfosByName().get('PV Feasibility').getRecordTypeId()) {
                mapProjectOpportunity.put(project.id, project.Deal__c);
            }
            
            // TO Update related PMTOOL record
            if (project.recordtypeId == Schema.Sobjecttype.Project__c.getRecordTypeInfosByName().get('PV Install').getRecordTypeId()){
                if((project.Utility_Final_Approval_Completed_Date__c  != Trigger.OldMap.get(project.id).get('Utility_Final_Approval_Completed_Date__c')) || (project.Inspection_Complete_With_Letter_Date__c != Trigger.OldMap.get(project.id).get('Inspection_Complete_With_Letter_Date__c'))){
                    idstoupdatePMTool.add(project.id);
                }				
                
            }
            
            if(project.Deal__c != null && project.Deal__r.Contracts_Approved_Date__c != null){
               oppSetToUpdatePMRecord.add(project.Deal__c);
           }
        }
        
        
        // update PMTOOL 
        if(idstoupdatePMTool.size() > 0){
            List<PM_Tool__c> pmtoolList = new List<PM_Tool__c>();
            for(PM_Tool__c pmtool : [select id,name from PM_Tool__c where Project__c in : idstoupdatePMTool]){
                pmtoolList.add(pmtool );
            }
            
            if(pmtoolList.size() > 0){
                update pmtoolList;
            }
        }
        
        
        if(oppSetToUpdatePMRecord.size() > 0){
            PMToolV2.updatePMRecordFromProject(oppSetToUpdatePMRecord);
        } 
        
        try{
        
        Map<Id, Deal__c> mapOpportunity = new Map<Id, Deal__c>([SELECT Id,EU_Completed_Date__c,PVI_Rails_and_Panels_Left_WH_Date__c
        FROM Deal__c 
        WHERE ID in : oppIds]);
        
        //List of opportunity that needs to be updated
        Map<Id, Deal__c> mapOpportunitiesRequireUpdate = new Map<Id, Deal__c>();
        
        
        for( Project__c project : projects){
            
            //Get the old version of the project from the collection of old versions of the record
            Project__c oldProject = (Project__c)trigger.oldMap.get(project.Id);
            
            // EE Upgrade, SHW  project types
            if( (project.EE_Completed_Date__c != null && oldProject.EE_Completed_Date__c == null) && 
                (project.Record_Type_Name__c == 'EE Upgrade' || project.Record_Type_Name__c == 'SHW Install' || project.Record_Type_Name__c == 'SHW Feasibility')  
              ){
                 Deal__c opp = mapOpportunity.get(project.Deal__c);
                 if(mapOpportunitiesRequireUpdate.containsKey(project.Deal__c))
                     opp = mapOpportunitiesRequireUpdate.get(project.Deal__c);
                 opp.EU_Completed_Date__c = project.EE_Completed_Date__c;
                 mapOpportunitiesRequireUpdate.put(opp.id, opp);
                 
            }
            
            // updatePVIRPLWHDate
            if(project.PVI_Rails_and_Panels_Left_Warehouse_Date__c != null && 
            oldProject.PVI_Rails_and_Panels_Left_Warehouse_Date__c == null) {
                Deal__c opp = mapOpportunity.get(project.Deal__c);
                if(mapOpportunitiesRequireUpdate.containsKey(project.Deal__c))
                     opp = mapOpportunitiesRequireUpdate.get(project.Deal__c);
                opp.PVI_Rails_and_Panels_Left_WH_Date__c = project.PVI_Rails_and_Panels_Left_Warehouse_Date__c;
                mapOpportunitiesRequireUpdate.put(opp.id, opp);
            }
            
            //updatePVIRPLWHDate
            if( project.PVI_Rails_Installed_Date__c != null && oldProject.PVI_Rails_Installed_Date__c == null  ){
                
                //Assign project's *date field* value to the Opportunity's *date field* value
                Deal__c opp = mapOpportunity.get(project.Deal__c);
                if(mapOpportunitiesRequireUpdate.containsKey(project.Deal__c))
                     opp = mapOpportunitiesRequireUpdate.get(project.Deal__c);
                opp.PVI_Rails_Installed_Date__c = project.PVI_Rails_Installed_Date__c; //NOT ACTUAL FIELD VALUES. CHANGE TO ACTUAL FIELD VALUES OR ELSE!!!!!
                mapOpportunitiesRequireUpdate.put(opp.id, opp);
            }
            
            //UpdateOppFromSHW starts here
            if( (project.Record_Type_Name__c == 'SHW Install' || project.Record_Type_Name__c == 'SHW Feasibility'
                )  && project.PVI_Placed_In_Service_Date__c != null){
                
                Deal__c opp = mapOpportunity.get(project.Deal__c);
                if(mapOpportunitiesRequireUpdate.containsKey(project.Deal__c))
                     opp = mapOpportunitiesRequireUpdate.get(project.Deal__c);
                opp.PVI_Placed_In_Service_Date__c = project.PVI_Placed_In_Service_Date__c;
                mapOpportunitiesRequireUpdate.put(opp.id, opp);
                
            }
            
            //UpdateEAProjectFields
            if(project.Record_Type_Name__c.contains('EE') && project.Record_Type_Name__c.contains('Assessment')){
                
                Deal__c opp = mapOpportunity.get(project.Deal__c);
                if(mapOpportunitiesRequireUpdate.containsKey(project.Deal__c))
                     opp = mapOpportunitiesRequireUpdate.get(project.Deal__c);
                if (project.EE_Completed_Date__c != null)
                    opp.EA_Completed_Date__c = project.EE_Completed_Date__c; 
                if (project.Status__c != null)
                    opp.EA_Status__c = project.Status__c;
                mapOpportunitiesRequireUpdate.put(opp.id, opp);    
            }
            
            //UpdateOppFromPVAFeasibilityProject
            if(project.Record_Type_Name__c.contains('PV') && project.Record_Type_Name__c.contains('Feasibility')){
                
                Deal__c opp = mapOpportunity.get(project.Deal__c);
                if(mapOpportunitiesRequireUpdate.containsKey(project.Deal__c))
                     opp = mapOpportunitiesRequireUpdate.get(project.Deal__c);
                if (project.Result__c != null)
                    opp.Result__c = project.Result__c; 
                if (project.Marked_Completed_On_Date__c != null)
                    opp.PVA_Assessment_Complete_Date__c = project.Marked_Completed_On_Date__c.date();
                    
                mapOpportunitiesRequireUpdate.put(opp.id, opp);    
            }
        }
        
        
        
        /*****************************************************************************************/
        
        
        
        // UpdateOppFromPVInstall      
        if (mapProjectOpportunity.size() > 0) {
            List<Project__c> projsWithSavings = [SELECT Id, PVI_Placed_In_Service_Date__c,
                     PVI_Rails_and_Panels_Left_Warehouse_Date__c, 
                     PVI_Electrical_Installed_Date__c, 
                     PVI_Electrical_Left_Warehouse_Date__c,
                     PV_Net_Meter_Install_Verified_Date__c,
                     Final_3rd_Party_Inspection_Compete_Date__c,
                     PVI_Rails_Installed_Date__c,
                     PVI_Panels_Installed_Date__c,
                     Gross_System_Cost_In_Dollars__c,
                     Billing_Packet_Approved_Date__c,
                     PVI_Activation_Date__c,
                     Deal__c, Deal__r.Id 
                     FROM Project__c WHERE (Project__c.Record_Type_Name__c
                     LIKE '%PV%Install%' OR Project__c.Record_Type_Name__c LIKE '%PV%Feasibility%') 
                     AND Deal__c IN :mapProjectOpportunity.values() order by createddate desc limit 1];
                     
            if (projsWithSavings.size() > 0) {
                List<Deal__c> oppsToUpdate = new List<Deal__c>();
                for(Project__c prj: projectList) {
                    if (mapProjectOpportunity.containskey(projsWithSavings[0].id)){  
                         for(Project__c p: projsWithSavings){    
                               Deal__c o = p.Deal__r;
                               if(mapOpportunitiesRequireUpdate.containsKey(p.Deal__c))
                                   o = mapOpportunitiesRequireUpdate.get(p.Deal__c);
                                
                                o.PVI_Placed_In_Service_Date__c = p.PVI_Placed_In_Service_Date__c;
                            
                            
                                o.PVI_Rails_and_Panels_Left_WH_Date__c = p.PVI_Rails_and_Panels_Left_Warehouse_Date__c;
                            
                                o.PVI_Electrical_Installed_Date__c = p.PVI_Electrical_Installed_Date__c;
                            
                            
                                o.PVI_Electric_Left_WH_Date__c = p.PVI_Electrical_Left_Warehouse_Date__c;
                            
                            
                                o.PVI_Net_Meter_Install_Date__c = p.PV_Net_Meter_Install_Verified_Date__c;
                           
                            
                                o.Final_3rd_Party_Inspection_Compete_Date__c = p.Final_3rd_Party_Inspection_Compete_Date__c;
                            
                            
                                o.PVI_Rails_Installed_Date__c = p.PVI_Rails_Installed_Date__c;
                            
                            
                                o.PVI_Panels_Installed_Date__c = p.PVI_Panels_Installed_Date__c;
                            
                                o.Gross_System_Cost_in_Dollars__c = p.Gross_System_Cost_in_Dollars__c;
                            
                                o.Billing_Packet_Approved_Date__c = p.Billing_Packet_Approved_Date__c;
                            
                                o.PVI_Activation_Date__c = p.PVI_Activation_Date__c;
                                
                                mapOpportunitiesRequireUpdate.put(o.id, o);
                        }
                    }
                
                }         
            }
        }
        //Update the opportunities
        if(mapOpportunitiesRequireUpdate.size() > 0)
            update mapOpportunitiesRequireUpdate.values(); 
        
        // trigger UpdateOppFromEEUpgradeProjects - after update
        List<Project__c> projsWithSavings = [SELECT Id, EU_Projected_Elec_Savings_DlrsPerYr__c,
        EU_Projected_Elec_kWh_perYear_Savings__c,
        EU_Projected_Nat_Gas_Savings_yr__c,
        EU_Projected_NG_Therms_PerYear_Savings__c,
        EE_Completed_Date__c,
        Status__c,
        Deal__c, Deal__r.Id FROM Project__c WHERE Project__c.Record_Type_Name__c
        LIKE '%EE%Upgrade%' AND Id IN :Trigger.newMap.keySet()];
        
        List<Deal__c> oppsToUpdate = new List<Deal__c>{};
        for(Project__c p: projsWithSavings)
        {
            Deal__c o = p.Deal__r;
            if (p.EU_Projected_Elec_Savings_DlrsPerYr__c != null){
                o.EU_Projected_Elec_Savings_DlrsPerYr__c = p.EU_Projected_Elec_Savings_DlrsPerYr__c;
            }
            if (p.EU_Projected_Elec_kWh_perYear_Savings__c != null)
            {
                o.EU_Projected_Elec_kWh_perYear_Savings__c = p.EU_Projected_Elec_kWh_perYear_Savings__c;
            }
            if (p.EU_Projected_Nat_Gas_Savings_yr__c != null) 
            {
                o.EU_Projected_Nat_Gas_Savings_yr__c = p.EU_Projected_Nat_Gas_Savings_yr__c;
            }
            if (p.EU_Projected_NG_Therms_PerYear_Savings__c != null) 
            {
                o.EU_Projected_NG_Therms_PerYear_Savings__c = p.EU_Projected_NG_Therms_PerYear_Savings__c;
            }
            if (p.EE_Completed_Date__c != null)
            {
                o.EU_Completed_Date__c = p.EE_Completed_Date__c;
            }
            if (p.Status__c != null)
            {
                o.EU_Status__c = p.Status__c;
            }
            oppsToUpdate.add(o);
        }
        
        
        update oppsToUpdate;
        // trigger UpdateOppFromEEUpgradeProjects - after update
    
        }
        catch(Exception e){
            system.assert(false, e.getLineNumber()+'--'+e.getMessage());
        }
        
        Set<Id> projSet = new Set<Id>();
        Set<Id> oppSet = new Set<Id>();
        projectList = (List<Project__c>)Trigger.New;
        Set<Id> prjSetToUpdatePMRecord = new Set<Id>();
        
        for(Project__c prj : [select id, Deal__c, Deal__r.Contracts_Approved_Date__c from Project__c where id in:projectList ]){
           if(prj.Deal__c!=null){
               projSet.add(prj.id);
               oppSet.add(prj.Deal__c);
           } 
           
           if(prj.Deal__c != null && prj.Deal__r.Contracts_Approved_Date__c != null){
               prjSetToUpdatePMRecord.add(prj.id);
           }
        }
        
        if(prjSetToUpdatePMRecord.size() > 0){
            PMTool.updatePMRecord(prjSetToUpdatePMRecord, 'afterUpdate');
        } 
       
      Map<String,Sub_folder__c > folderIdMap = new Map<String,Sub_folder__c >();
      
      for(Sub_folder__c sf: [Select id,Name,cf_Deal__c,CF_Box_Folder_Id__c from Sub_Folder__c 
      where cf_Deal__c in:oppSet]){
          folderIdMap.put(sf.cf_Deal__c+'#'+sf.Name, sf); 
      }

       
       for(Project__c prj:[Select id, subcontractor__c,EE_Assessor__c, RecordType.Name,Deal__c,Deal__r.Opp_Pipeline_Stage__c ,Deal__r.name  from project__c where id in:projSet]){
             
             Project__c oldprj = (Project__c)Trigger.OldMap.get(prj.id);
             string boxfolderId = '';
             string oppId = '';
             string subFolderId = '';
             
             if(prj.subcontractor__c!=oldprj.subcontractor__c){
               
                  if(prj.RecordType.Name == 'EE Assessment'||prj.RecordType.Name == 'EE Upgrade'){
                    
                   if(StageMap.get(prj.Deal__r.Opp_Pipeline_Stage__c+'#'+'EE')!=null){   
                        
                       if (folderIdMap.containskey(prj.Deal__c+'#'+'EE')) {
                           boxfolderId = folderIdMap.get(prj.Deal__c+'#'+'EE').CF_Box_Folder_Id__c;
                           oppId = folderIdMap.get(prj.Deal__c+'#'+'EE').cf_Deal__c;
                           subFolderId = folderIdMap.get(prj.Deal__c+'#'+'EE').Id;
                       }
                       else {
                           boxfolderId = folderIdMap.get(prj.Deal__c+'#'+ prj.Deal__r.name + ' - '+ 'EE').CF_Box_Folder_Id__c;
                           oppId = folderIdMap.get(prj.Deal__c+'#'+ prj.Deal__r.name + ' - '+ 'EE').cf_Deal__c;
                           subFolderId = folderIdMap.get(prj.Deal__c+'#'+ prj.Deal__r.name + ' - '+ 'EE').Id;
                       
                       }
                       if(oldprj.subcontractor__c!=null){
                           
                               
                              /* BoxAPIServicesController.deleteContactCollaborationOnStageChange(StageMap.get(prj.Deal__r.Opp_Pipeline_Stage__c+'#'+'EE'),
                                   folderIdMap.get(prj.Deal__c+'#'+'EE').CF_Box_Folder_Id__c, 
                                   folderIdMap.get(prj.Deal__c+'#'+'EE').cf_Deal__c,
                                   folderIdMap.get(prj.Deal__c+'#'+'EE').Id);
                                   
                                   */
                           BoxAPIServicesController.deleteContactCollaborationOnStageChange(StageMap.get(prj.Deal__r.Opp_Pipeline_Stage__c+'#'+'EE'),
                           boxfolderId, 
                           oppId,
                           subFolderId);
                        }  
                        
                        if(prj.subcontractor__c!=null){   
                           
                           /*
                           BoxAPIServicesController.createcollaborationOnFolder(StageMap.get(prj.Deal__r.Opp_Pipeline_Stage__c+'#'+'EE'),
                           PermissionMap.get(StageMap.get(prj.Deal__r.Opp_Pipeline_Stage__c+'#'+'EE')),
                           folderIdMap.get(prj.Deal__c+'#'+'EE').CF_Box_Folder_Id__c,
                           Contactmap.get(prj.subcontractor__c),
                           folderIdMap.get(prj.Deal__c+'#'+'EE').cf_Deal__c,
                           folderIdMap.get(prj.Deal__c+'#'+'EE').Id); 
                           */
                           BoxAPIServicesController.createcollaborationOnFolder(StageMap.get(prj.Deal__r.Opp_Pipeline_Stage__c+'#'+'EE'),
                           PermissionMap.get(StageMap.get(prj.Deal__r.Opp_Pipeline_Stage__c+'#'+'EE')),
                           boxFolderId,
                           Contactmap.get(prj.subcontractor__c),
                           oppId,
                           subFolderId); 
                        }  
                                         
                      }
                 }
                 else{
                          
                    if(StageMap.get(prj.Deal__r.Opp_Pipeline_Stage__c+'#'+'Sales')!=null) { 
                        if (folderIdMap.containskey(prj.Deal__c+'#'+'Sales')) {
                           boxfolderId = folderIdMap.get(prj.Deal__c+'#'+'Sales').CF_Box_Folder_Id__c;
                           oppId = folderIdMap.get(prj.Deal__c+'#'+'Sales').cf_Deal__c;
                           subFolderId = folderIdMap.get(prj.Deal__c+'#'+'Sales').Id;
                        }
                        else {
                           boxfolderId = folderIdMap.get(prj.Deal__c+'#'+ prj.Deal__r.name + ' - '+ 'Sales').CF_Box_Folder_Id__c;
                           oppId = folderIdMap.get(prj.Deal__c+'#'+ prj.Deal__r.name + ' - '+ 'Sales').cf_Deal__c;
                           subFolderId = folderIdMap.get(prj.Deal__c+'#'+ prj.Deal__r.name + ' - '+ 'Sales').Id;
                        
                        }
                        
                        if(oldprj.subcontractor__c!=null){
                           BoxAPIServicesController.deleteContactCollaborationOnStageChange(StageMap.get(prj.Deal__r.Opp_Pipeline_Stage__c+'#'+'Sales'),
                           boxfolderId, 
                           oppId,
                           subFolderId);
                        }  
                        
                        if(prj.subcontractor__c!=null){
                          BoxAPIServicesController.createcollaborationOnFolder(
                           StageMap.get(prj.Deal__r.Opp_Pipeline_Stage__c+'#'+'Sales'),
                           PermissionMap.get(StageMap.get(prj.Deal__r.Opp_Pipeline_Stage__c+'#'+'Sales')),
                           boxfolderId ,
                           Contactmap.get(prj.subcontractor__c),
                           oppId,
                           subFolderId);
                        }  
                    } 
                    
                                          
                    if(StageMap.get(prj.Deal__r.Opp_Pipeline_Stage__c+'#'+'Application')!=null) {
                        if (folderIdMap.containskey(prj.Deal__c+'#'+'Application')) {
                           boxfolderId = folderIdMap.get(prj.Deal__c+'#'+'Application').CF_Box_Folder_Id__c;
                           oppId = folderIdMap.get(prj.Deal__c+'#'+'Application').cf_Deal__c;
                           subFolderId = folderIdMap.get(prj.Deal__c+'#'+'Application').Id;
                        }
                        else {
                           boxfolderId = folderIdMap.get(prj.Deal__c+'#'+ prj.Deal__r.name + ' - '+ 'Application').CF_Box_Folder_Id__c;
                           oppId = folderIdMap.get(prj.Deal__c+'#'+ prj.Deal__r.name + ' - '+ 'Application').cf_Deal__c;
                           subFolderId = folderIdMap.get(prj.Deal__c+'#'+ prj.Deal__r.name + ' - '+ 'Application').Id;
                        
                        }
                        
                        if(oldprj.subcontractor__c!=null){
                            BoxAPIServicesController.deleteContactCollaborationOnStageChange(StageMap.get(prj.Deal__r.Opp_Pipeline_Stage__c+'#'+'Application'),
                            boxfolderId, 
                            oppId,
                            subFolderId);
                        } 
                        
                        if(prj.subcontractor__c!=null){ 
                           BoxAPIServicesController.createcollaborationOnFolder(StageMap.get(prj.Deal__r.Opp_Pipeline_Stage__c+'#'+'Application'),
                           PermissionMap.get(StageMap.get(prj.Deal__r.Opp_Pipeline_Stage__c+'#'+'Application')),
                           boxfolderId ,
                           Contactmap.get(prj.subcontractor__c),
                           oppId,
                           subFolderId);
                        } 
                    }
                    
                    
                    if(StageMap.get(prj.Deal__r.Opp_Pipeline_Stage__c+'#'+'Funding-Vendor')!=null){
                       
                        if (folderIdMap.containskey(prj.Deal__c+'#'+'Funding-Vendor')) {
                           boxfolderId = folderIdMap.get(prj.Deal__c+'#'+'Funding-Vendor').CF_Box_Folder_Id__c;
                           oppId = folderIdMap.get(prj.Deal__c+'#'+'Funding-Vendor').cf_Deal__c;
                           subFolderId = folderIdMap.get(prj.Deal__c+'#'+'Funding-Vendor').Id;
                        }
                        else {
                           boxfolderId = folderIdMap.get(prj.Deal__c+'#'+ prj.Deal__r.name + ' - '+ 'Funding-Vendor').CF_Box_Folder_Id__c;
                           oppId = folderIdMap.get(prj.Deal__c+'#'+ prj.Deal__r.name + ' - '+ 'Funding-Vendor').cf_Deal__c;
                           subFolderId = folderIdMap.get(prj.Deal__c+'#'+ prj.Deal__r.name + ' - '+ 'Funding-Vendor').Id;
                        
                       }
                       if(oldprj.subcontractor__c!=null){
                           BoxAPIServicesController.deleteContactCollaborationOnStageChange(StageMap.get(prj.Deal__r.Opp_Pipeline_Stage__c+'#'+'Funding-Vendor'),
                           boxfolderId, 
                           oppId,
                           subFolderId);
                       } 
                       
                      if(prj.subcontractor__c!=null){				 
                           BoxAPIServicesController.createcollaborationOnFolder(StageMap.get(prj.Deal__r.Opp_Pipeline_Stage__c+'#'+'Funding-Vendor'),
                           PermissionMap.get(StageMap.get(prj.Deal__r.Opp_Pipeline_Stage__c+'#'+'Funding-Vendor')),
                           boxfolderId ,
                           Contactmap.get(prj.subcontractor__c),
                           oppId,
                           subFolderId);
                        }   
                    }
                }  

         }
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