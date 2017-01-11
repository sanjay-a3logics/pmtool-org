/*
*  This is the controller for the visualforce page PMTool
*/
public class PMTool{

    //public variables
    public List<Market_Installation_Step__c> marketInstallationStepList{get;set;}
    public String selectedMarket{get;set;}
    public Decimal averageCompletion{get;set;}
    public Integer activeProjects{get;set;}
    public String selectedProjectManager{get;set;}
    public String customerId{get;set;}
    public List<PMWrapper> lstPMWrapper{get;set;}
    public List<SelectOption> projectManagerList{get;set;}
    public CustomerDetailWrapper customerDetailWrapperObj{get;set;}
    public Boolean stateChanged{get;set;}
    
    //class constructor
    public PMTool(){
    
       try{
           selectedMarket = '';
           averageCompletion = 0;
           activeProjects = 0;
           customerId = '';
           stateChanged = false;
           selectedProjectManager = '';
           customerDetailWrapperObj = new CustomerDetailWrapper(new PM_Tool__c(), 0.00, new List<CustomerDetailFieldWrapper>());
           filterData();
       }
       catch(Exception e){
           system.debug(e.getMessage()+' '+e.getStackTraceString());
       }
    }
    
    public List<SelectOption> getBusinessMarkets() {
        List<SelectOption> options = new List<SelectOption>();
        try{
            
            for(Business_Market__c bm : [select id,name from business_market__c order by name]){
                options.add(new SelectOption(bm.id, bm.Name));
            }
            return options;
        }
        catch(Exception e){
           ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()+' '+e.getStackTraceString());
           ApexPages.addMessage(errMsg);
           return options;
       }
    }
    
    public static void updatePMRecord(Set<Id> projectSet, String operation){
    
        //system.assert(false,'pmTool.EU_Approved_Date__c');
    
        try{
            List<PM_Tool__c> pmToolList = new List<PM_Tool__c>();
            Map<Id, Map<String, Project__c>> projectMap = new Map<Id, Map<String, Project__c>>();
            Set<Id> OppSet = new Set<Id>();
            
            for(Project__c prj: [select id, Deal__c, Deal__r.Project_Manager__c, Deal__r.Opp_Numeric_ID__c, 
                Deal__r.Property__c, Deal__r.Property__r.AssessorOwnerName1__c, Deal__r.Touch_Milestones__c, 
                EA_Rebate_Submitted_Date__c, Status__c, Result__c, PVFA_System_Size_kW__c, BrightPath_True_Up_Completed__c, 
                createddate, RecordType.Name, Electrical_Permit_Received_Date__c, Work_Scope_Approved__c,EE_Approved_Date__c from Project__c 
                where id in:projectSet]){
                if(!projectMap.containsKey(prj.Deal__c)){
                    projectMap.put(prj.Deal__c, new Map<String, Project__c>());
                }
                
                if(projectMap.get(prj.Deal__c).containsKey(prj.RecordType.Name)){
                    if(projectMap.get(prj.Deal__c).get(prj.RecordType.Name).createddate < prj.createddate){
                        projectMap.get(prj.Deal__c).remove(prj.RecordType.Name);
                    }
                }
                projectMap.get(prj.Deal__c).put(prj.RecordType.Name, prj);
                OppSet.add(prj.Deal__c);
            }
            
            
            
            for(PM_Tool__c pmTool: [select id, Deal__c, Project__c, EA_Rebate_Submitted_Date_Parallel__c, 
             EA_Project_Status_Parallel__c, Project_EE_Assessment__c, Project_EE_Upgrade__c, EU_Project_Status_Parallel__c, 
             Project_PV_Feasibility__c, Feasibility_Project_Status_Parallel__c, Feasibility_Result_Parallel__c, 
             Actual_System_Size_Parallel__c, BrightPath_True_Up_Completed_Parallel__c, Electrical_Permit_Received__c, 
             Work_Scope_Approved__c,EU_Approved_Date__c from PM_Tool__c where Deal__c in:OppSet]){
            
                 if(projectMap != null && projectMap.get(pmTool.Deal__c) != null){
                    if(projectMap.get(pmTool.Deal__c).containsKey('PV Install')){
                    
                        if(operation == 'afterInsert'){
                            pmTool.Project__c = projectMap.get(pmTool.Deal__c).get('PV Install').Id;
                        }
                        pmTool.Electrical_Permit_Received__c = projectMap.get(pmTool.Deal__c).get('PV Install').Electrical_Permit_Received_Date__c;
                    }
                    
                    if(projectMap.get(pmTool.Deal__c).containsKey('EE Assessment')){
                        if(operation == 'afterInsert'){
                            pmTool.Project_EE_Assessment__c = projectMap.get(pmTool.Deal__c).get('EE Assessment').Id;
                        }
                        pmTool.EA_Project_Status_Parallel__c = projectMap.get(pmTool.Deal__c).get('EE Assessment').Status__c;
                        pmTool.EA_Rebate_Submitted_Date_Parallel__c = projectMap.get(pmTool.Deal__c).get('EE Assessment').EA_Rebate_Submitted_Date__c;
                    }
                    
                    if(projectMap.get(pmTool.Deal__c).containsKey('EE Upgrade')){
                        if(operation == 'afterInsert'){
                            pmTool.Project_EE_Upgrade__c = projectMap.get(pmTool.Deal__c).get('EE Upgrade').Id;
                        }    
                        pmTool.EU_Project_Status_Parallel__c = projectMap.get(pmTool.Deal__c).get('EE Upgrade').Status__c;
                        pmTool.Work_Scope_Approved__c = projectMap.get(pmTool.Deal__c).get('EE Upgrade').Work_Scope_Approved__c;
                        pmTool.EU_Approved_Date__c = projectMap.get(pmTool.Deal__c).get('EE Upgrade').EE_Approved_Date__c;
                        
                       // 
                    }
                    
                    if(projectMap.get(pmTool.Deal__c).containsKey('PV Feasibility')){
                        if(operation == 'afterInsert'){
                            pmTool.Project_PV_Feasibility__c = projectMap.get(pmTool.Deal__c).get('PV Feasibility').Id;
                        }
                        pmTool.Feasibility_Project_Status_Parallel__c = projectMap.get(pmTool.Deal__c).get('PV Feasibility').Status__c;
                        pmTool.Feasibility_Result_Parallel__c = projectMap.get(pmTool.Deal__c).get('PV Feasibility').Result__c;
                        pmTool.Actual_System_Size_Parallel__c = (projectMap.get(pmTool.Deal__c).get('PV Feasibility').PVFA_System_Size_kW__c) / 1000;
                        pmTool.BrightPath_True_Up_Completed_Parallel__c = projectMap.get(pmTool.Deal__c).get('PV Feasibility').BrightPath_True_Up_Completed__c;
                    }
                }
                
                pmToolList.add(pmTool);
            }
            
            update pmToolList;
            updateDateFields(oppSet);
        }    
        catch(Exception e){
           system.debug(e.getMessage()+' '+e.getStackTraceString());
       }   
    }
    
    
    public static void createPMRecord(Set<Id> OppSet){
        
        try{
            List<PM_Tool__c> pmToolList = new List<PM_Tool__c>();
            Map<Id, Map<String, Project__c>> projectMap = new Map<Id, Map<String, Project__c>>();

            
            for(Project__c prj: [select id, Deal__c, Deal__r.Project_Manager__c, Deal__r.Opp_Numeric_ID__c, 
                Deal__r.Property__c, Deal__r.Property__r.AssessorOwnerName1__c, Deal__r.Touch_Milestones__c, 
                EA_Rebate_Submitted_Date__c, Status__c, Result__c, PVFA_System_Size_kW__c, BrightPath_True_Up_Completed__c, 
                createddate, RecordType.Name, Work_Scope_Approved__c, Electrical_Permit_Received_Date__c,EE_Approved_Date__c 
                from Project__c where Deal__c in:OppSet]){
                if(!projectMap.containsKey(prj.Deal__c)){
                    projectMap.put(prj.Deal__c, new Map<String, Project__c>());
                }
                
                if(projectMap.get(prj.Deal__c).containsKey(prj.RecordType.Name)){
                    if(projectMap.get(prj.Deal__c).get(prj.RecordType.Name).createddate < prj.createddate){
                        projectMap.get(prj.Deal__c).remove(prj.RecordType.Name);
                    }
                }
                projectMap.get(prj.Deal__c).put(prj.RecordType.Name, prj);
            }
            
            for(Deal__c opp : [select id, Opportunity__c, Project_Manager__c, Opp_Numeric_ID__c, Property__r.AssessorOwnerName1__c, Property__c, Touch_Milestones__c from Deal__c where id in:OppSet]){
                PM_Tool__c pmTool = new PM_Tool__c();
                pmTool.Deal__c = opp.id;
                pmTool.Opportunity__c = opp.Opportunity__c;			 									 			    		
                
                pmTool.Name = opp.Opp_Numeric_ID__c +' - '+ opp.Property__r.AssessorOwnerName1__c;
                pmTool.Project_Manager__c = opp.Project_Manager__c;
                pmTool.Property__c = opp.Property__c;
                
                if(projectMap != null && projectMap.get(opp.Id) != null){
                    if(projectMap.get(opp.Id).containsKey('PV Install')){
                        pmTool.Project__c = projectMap.get(opp.Id).get('PV Install').Id;
                        pmTool.Electrical_Permit_Received__c = projectMap.get(opp.Id).get('PV Install').Electrical_Permit_Received_Date__c;
                    }
                    
                    if(projectMap.get(opp.Id).containsKey('EE Assessment')){
                        pmTool.Project_EE_Assessment__c = projectMap.get(opp.Id).get('EE Assessment').Id;
                        pmTool.EA_Project_Status_Parallel__c = projectMap.get(opp.Id).get('EE Assessment').Status__c;
                        pmTool.EA_Rebate_Submitted_Date_Parallel__c = projectMap.get(opp.Id).get('EE Assessment').EA_Rebate_Submitted_Date__c;
                    }
                    
                    if(projectMap.get(opp.Id).containsKey('EE Upgrade')){
                        pmTool.Project_EE_Upgrade__c = projectMap.get(opp.Id).get('EE Upgrade').Id;
                        pmTool.EU_Project_Status_Parallel__c = projectMap.get(opp.Id).get('EE Upgrade').Status__c;
                        pmTool.Work_Scope_Approved__c = projectMap.get(opp.Id).get('EE Upgrade').Work_Scope_Approved__c;
                        pmTool.EU_Approved_Date__c = projectMap.get(opp.Id).get('EE Upgrade').EE_Approved_Date__c;
                    }
                    
                    if(projectMap.get(opp.Id).containsKey('PV Feasibility')){
                        pmTool.Project_PV_Feasibility__c = projectMap.get(opp.Id).get('PV Feasibility').Id;
                        pmTool.Feasibility_Project_Status_Parallel__c = projectMap.get(opp.Id).get('PV Feasibility').Status__c;
                        pmTool.Feasibility_Result_Parallel__c = projectMap.get(opp.Id).get('PV Feasibility').Result__c;
                        pmTool.Actual_System_Size_Parallel__c = (projectMap.get(opp.Id).get('PV Feasibility').PVFA_System_Size_kW__c) / 1000;
                        pmTool.BrightPath_True_Up_Completed_Parallel__c = projectMap.get(opp.Id).get('PV Feasibility').BrightPath_True_Up_Completed__c;
                    }
                }
    
                pmToolList.add(pmTool);
            }
            
            insert pmToolList;
            updateDateFields(oppSet);

        }    
        catch(Exception e){
           system.debug(e.getMessage()+' '+e.getStackTraceString());
        } 
    }
    
    public static void updatePMRecordFromOpportunity(Set<Id> oppSet){

        try{
            List<PM_Tool__c> pmToolList = new List<PM_Tool__c>();
            for(PM_Tool__c pm: [select id, Deal__r.Project_Manager__c, Deal__r.Property__c, Deal__r.Property__r.AssessorOwnerName1__c, Deal__r.Opp_Numeric_ID__c  from PM_Tool__c where Deal__c in: oppSet]){
                pm.Project_Manager__c = pm.Deal__r.Project_Manager__c;
                pm.Property__c = pm.Deal__r.Property__c;
                pm.Name = pm.Deal__r.Opp_Numeric_ID__c +' - '+ pm.Deal__r.Property__r.AssessorOwnerName1__c;
                pmToolList.add(pm);
            }                      
            update pmToolList;
            updateDateFields(oppSet);
        }
        catch(Exception e){
           system.debug(e.getMessage()+' '+e.getStackTraceString());
        } 
    }
    
    public static void updateDateFields(Set<Id> oppSet){

        try{
      
            List<PM_Tool__c> pmToolList = new List<PM_Tool__c>();
            Set<Id> pmToolSet = new Set<Id>();
            
            for(PM_Tool__c pm: [select id, PM_Assignment__c, PM_Assignment_SDT__c, PM_Assignment_EDT__c, EA_State_Approval_Submission_SDT__c,
            EA_State_Approval_Submission_EDT__c, EA_State_Approval_Submission__c,Intro_Call_SDT__c,Intro_Call_Installation__c, Intro_Call_EDT__c, 
            Feasibility_SDT__c,Feasibility_EDT__c,Feasibility__c,Initial_Utility_Approval_Net_MeteringSDT__c,Initial_Utility_Approval_Net_MeteringEDT__c,
            Initial_Utility_Approval_Net_Metering__c,State_Initial_Submission_SDT__c,State_Initial_Submission_EDT__c,State_Initial_Submission_Installation__c,
            Permitting_SDT__c,Permitting_EDT__c,Permitting__c,Sales_Order_SDT__c,Sales_Order_EDT__c,Sales_Order_Installation__c,
            Upgrade_Modeling_SDT__c,Upgrade_Modeling_EDT__c,Upgrade_Modeling__c,R_P_Install_SDT__c,R_P_Install_EDT__c,R_P_Install__c,
            Electrical_Install_SDT__c,Electrical_Install_EDT__c,Electrical_Install__c,Energy_Upgrade_SDT__c,Energy_Upgrade_EDT__c,
            Energy_Upgrade__c,Quality_Control_SDT__c,Quality_Control_EDT__c,Quality_Control__c,M1_ITC_Funding_SDT__c,M1_ITC_Funding_EDT__c,
            M1_ITC_Funding__c,Municipal_Inspection_SDT__c,Municipal_Inspection_EDT__c,Municipal_Inspection__c,M2_SDT__c,M2_EDT__c,M2__c,
            PTO_Final_Utility_Approval_SDT__c,PTO_Final_Utility_Approval_EDT__c,PTO_Final_Utility_Approval__c,M3_SDT__c,M3_EDT__c,M3__c,
            State_Final_Submission_SDT__c,State_Final_Submission_EDT__c,State_Final_Submission__c,Activation_SDT__c,Activation_EDT__c,Activation__c,
            EE_Audit_SDT__c,EE_Audit_EDT__c,EE_Audit__c,Closing_Call__c,Closing_Call_SDT__c,Closing_Call_EDT__c from PM_Tool__c where Deal__c in: oppSet]){
                
    
                // update pm assignment start & End date fields
                pm.PM_Assignment_SDT__c = (pm.PM_Assignment__c == 1 && pm.PM_Assignment_SDT__c == null) ? Date.today() : pm.PM_Assignment_SDT__c;
                pm.PM_Assignment_EDT__c = (pm.PM_Assignment__c == 2 && pm.PM_Assignment_EDT__c == null) ? Date.today() : pm.PM_Assignment_EDT__c;
                
                // update EA_State_Approval_Submission__c start & End date fields
                pm.EA_State_Approval_Submission_SDT__c = (pm.EA_State_Approval_Submission__c == 1 && pm.EA_State_Approval_Submission_SDT__c == null) ?  Date.today() : pm.EA_State_Approval_Submission_SDT__c;
                pm.EA_State_Approval_Submission_EDT__c = (pm.EA_State_Approval_Submission__c == 2 && pm.EA_State_Approval_Submission_EDT__c == null) ?  Date.today() : pm.EA_State_Approval_Submission_EDT__c;
                
                // update Intro_Call_SDT__c start & End date fields
                pm.Intro_Call_SDT__c = (pm.Intro_Call_Installation__c == 1 && pm.Intro_Call_SDT__c == null) ?  Date.today() : pm.Intro_Call_SDT__c;
                pm.Intro_Call_EDT__c = (pm.Intro_Call_Installation__c == 2 && pm.Intro_Call_EDT__c == null) ?  Date.today() : pm.Intro_Call_EDT__c;
                
                // update Feasibility_SDT__c start & End date fields
                pm.Feasibility_SDT__c = (pm.Feasibility__c == 1 && pm.Feasibility_SDT__c == null) ?  Date.today() : pm.Feasibility_SDT__c;
                pm.Feasibility_EDT__c = (pm.Feasibility__c == 2 && pm.Feasibility_EDT__c == null) ?  Date.today() : pm.Feasibility_EDT__c;
    
                // update Initial_Utility_Approval_Net_MeteringSDT__c start & End date fields
                pm.Initial_Utility_Approval_Net_MeteringSDT__c = (pm.Initial_Utility_Approval_Net_Metering__c == 1 && pm.Initial_Utility_Approval_Net_MeteringSDT__c == null) ?  Date.today() : pm.Initial_Utility_Approval_Net_MeteringSDT__c;
                pm.Initial_Utility_Approval_Net_MeteringEDT__c = (pm.Initial_Utility_Approval_Net_Metering__c == 2 && pm.Initial_Utility_Approval_Net_MeteringEDT__c == null) ?  Date.today() : pm.Initial_Utility_Approval_Net_MeteringEDT__c;
    
                // update State_Initial_Submission_SDT__c start & End date fields
                pm.State_Initial_Submission_SDT__c = (pm.State_Initial_Submission_Installation__c == 1 && pm.State_Initial_Submission_SDT__c == null) ?  Date.today() : pm.State_Initial_Submission_SDT__c;
                pm.State_Initial_Submission_EDT__c = (pm.State_Initial_Submission_Installation__c == 2 && pm.State_Initial_Submission_EDT__c == null) ?  Date.today() : pm.State_Initial_Submission_EDT__c;
    
                // update Permitting__c start & End date fields
                pm.Permitting_SDT__c = (pm.Permitting__c == 1 && pm.Permitting_SDT__c == null) ?  Date.today() : pm.Permitting_SDT__c;
                pm.Permitting_EDT__c = (pm.Permitting__c == 2 && pm.Permitting_EDT__c == null) ?  Date.today() : pm.Permitting_EDT__c;
    
                // update Sales_Order_SDT__c start & End date fields
                pm.Sales_Order_SDT__c = (pm.Sales_Order_Installation__c == 1 && pm.Sales_Order_SDT__c == null) ?  Date.today() : pm.Sales_Order_SDT__c;
                pm.Sales_Order_EDT__c = (pm.Sales_Order_Installation__c == 2 && pm.Sales_Order_EDT__c == null) ?  Date.today() : pm.Sales_Order_EDT__c;
    
                // update Upgrade Modeling start & End date fields
                pm.Upgrade_Modeling_SDT__c = (pm.Upgrade_Modeling__c == 1 && pm.Upgrade_Modeling_SDT__c == null) ?  Date.today() : pm.Upgrade_Modeling_SDT__c;
                pm.Upgrade_Modeling_EDT__c = (pm.Upgrade_Modeling__c == 2 && pm.Upgrade_Modeling_EDT__c == null) ?  Date.today() : pm.Upgrade_Modeling_EDT__c;
    
                // update R_P_Install_SDT__c start & End date fields
                pm.R_P_Install_SDT__c = (pm.R_P_Install__c == 1 && pm.R_P_Install_SDT__c == null) ?  Date.today() : pm.R_P_Install_SDT__c;
                pm.R_P_Install_EDT__c = (pm.R_P_Install__c == 2 && pm.R_P_Install_EDT__c == null) ?  Date.today() : pm.R_P_Install_EDT__c;
    
                // update Electrical_Install__c start & End date fields
                pm.Electrical_Install_SDT__c = (pm.Electrical_Install__c == 1 && pm.Electrical_Install_SDT__c == null) ?  Date.today() : pm.Electrical_Install_SDT__c;
                pm.Electrical_Install_EDT__c = (pm.Electrical_Install__c == 2 && pm.Electrical_Install_EDT__c == null) ?  Date.today() : pm.Electrical_Install_EDT__c;
    
                // update Electrical_Install__c start & End date fields
                pm.Energy_Upgrade_SDT__c = (pm.Energy_Upgrade__c == 1 && pm.Energy_Upgrade_SDT__c == null) ?  Date.today() : pm.Energy_Upgrade_SDT__c;
                pm.Energy_Upgrade_EDT__c = (pm.Energy_Upgrade__c == 2 && pm.Energy_Upgrade_EDT__c == null) ?  Date.today() : pm.Energy_Upgrade_EDT__c;
    
                // update Quality_Control_SDT__c start & End date fields
                pm.Quality_Control_SDT__c = (pm.Quality_Control__c == 1 && pm.Quality_Control_SDT__c == null) ?  Date.today() : pm.Quality_Control_SDT__c;
                pm.Quality_Control_EDT__c = (pm.Quality_Control__c == 2 && pm.Quality_Control_EDT__c == null) ?  Date.today() : pm.Quality_Control_EDT__c;
               
                // update M1_ITC_Funding_SDT__c start & End date fields
                pm.M1_ITC_Funding_SDT__c = (pm.M1_ITC_Funding__c == 1 && pm.M1_ITC_Funding_SDT__c == null) ?  Date.today() : pm.M1_ITC_Funding_SDT__c;
                pm.M1_ITC_Funding_EDT__c = (pm.M1_ITC_Funding__c == 2 && pm.M1_ITC_Funding_EDT__c == null) ?  Date.today() : pm.M1_ITC_Funding_EDT__c;
    
                // update Municipal_Inspection_SDT__c start & End date fields
                pm.Municipal_Inspection_SDT__c = (pm.Municipal_Inspection__c == 1 && pm.Municipal_Inspection_SDT__c == null) ?  Date.today() : pm.Municipal_Inspection_SDT__c;
                pm.Municipal_Inspection_EDT__c = (pm.Municipal_Inspection__c == 2 && pm.Municipal_Inspection_EDT__c == null) ?  Date.today() : pm.Municipal_Inspection_EDT__c;
    
                // update M2__c start & End date fields
                pm.M2_SDT__c = (pm.M2__c == 1 && pm.M2_SDT__c == null) ?  Date.today() : pm.M2_SDT__c;
                pm.M2_EDT__c = (pm.M2__c == 2 && pm.M2_EDT__c == null) ?  Date.today() : pm.M2_EDT__c;
    
                // update PTO_Final_Utility_Approval__c start & End date fields
                pm.PTO_Final_Utility_Approval_SDT__c = (pm.PTO_Final_Utility_Approval__c == 1 && pm.PTO_Final_Utility_Approval_SDT__c == null) ?  Date.today() : pm.PTO_Final_Utility_Approval_SDT__c;
                pm.PTO_Final_Utility_Approval_EDT__c = (pm.PTO_Final_Utility_Approval__c == 2 && pm.PTO_Final_Utility_Approval_EDT__c == null) ?  Date.today() : pm.PTO_Final_Utility_Approval_EDT__c;
    
                // update M3__c start & End date fields
                pm.M3_SDT__c = (pm.M3__c == 1 && pm.M3_SDT__c == null) ?  Date.today() : pm.M3_SDT__c;
                pm.M3_EDT__c = (pm.M3__c == 2 && pm.M3_EDT__c == null) ?  Date.today() : pm.M3_EDT__c;
                
                // update Activation__c start & End date fields
                pm.Activation_SDT__c = (pm.Activation__c == 1 && pm.Activation_SDT__c == null) ?  Date.today() : pm.Activation_SDT__c;
                pm.Activation_EDT__c = (pm.Activation__c == 2 && pm.Activation_EDT__c == null) ?  Date.today() : pm.Activation_EDT__c;
    
                // update EE_Audit__c start & End date fields
                pm.EE_Audit_SDT__c = (pm.EE_Audit__c == 1 && pm.EE_Audit_SDT__c == null) ?  Date.today() : pm.EE_Audit_SDT__c;
                pm.EE_Audit_EDT__c = (pm.EE_Audit__c == 2 && pm.EE_Audit_EDT__c == null) ?  Date.today() : pm.EE_Audit_EDT__c;
    
                // update State_Final_Submission__c start & End date fields
                pm.State_Final_Submission_SDT__c = (pm.State_Final_Submission__c == 1 && pm.State_Final_Submission_SDT__c == null) ?  Date.today() : pm.State_Final_Submission_SDT__c;
                pm.State_Final_Submission_EDT__c = (pm.State_Final_Submission__c == 2 && pm.State_Final_Submission_EDT__c == null) ?  Date.today() : pm.State_Final_Submission_EDT__c;

                // update Closing_Call__c start & End date fields
                pm.Closing_Call_SDT__c = (pm.Closing_Call__c == 1 && pm.Closing_Call_SDT__c == null) ?  Date.today() : pm.Closing_Call_SDT__c;
                pm.Closing_Call_EDT__c = (pm.Closing_Call__c == 2 && pm.Closing_Call_EDT__c == null) ?  Date.today() : pm.Closing_Call_EDT__c;

                pmToolList.add(pm);
                pmToolSet.add(pm.id);
            }
            
            
            update pmToolList;

            updateCompletionPercentage(pmToolSet);
        
        }    
        catch(Exception e){
           system.debug(e.getMessage()+' '+e.getStackTraceString());
        }   

    }
    
    public static void updateCompletionPercentage(Set<Id> pmToolSet){
             
           try{     
    
               Set<PM_Tool__c> pmToolListToUpdateCompletionPer = new Set<PM_Tool__c>();
               Map<id,PM_Tool__c> pmToolMapForUpdate = new Map<id,PM_Tool__c>();
               Set<String> marketSet = new Set<String>();
               List<String> marketFieldsSet = new List<String>();
               Map<String,List<Market_Installation_Step__c>> marketInstallationStepMap = new Map<String,List<Market_Installation_Step__c>>();
               
               for(PM_Tool__c pmTool: [select id, state__c from PM_Tool__c where id in:pmToolSet]){
                   marketSet.add(pmTool.state__c);
               }
               
               for(Market_Installation_Step__c mis: [select id, name, Business_Market__c, Business_Market__r.Name, Installation_Step__c,Installation_Step__r.Name, 
               Sequence__c from Market_Installation_Step__c where Business_Market__r.Name in:marketSet]){
                   if(!marketInstallationStepMap.containsKey(mis.Business_Market__r.Name)){
                       marketInstallationStepMap.put(mis.Business_Market__r.Name, new List<Market_Installation_Step__c>());
                   }
                   marketInstallationStepMap.get(mis.Business_Market__r.Name).add(mis);
               }
                                                 
               String query = 'select ';
               Schema.DescribeSObjectResult r = PM_Tool__c.sObjectType.getDescribe();
               
               integer totalFields = r.fields.getMap().keySet().size();
               integer count = 0;
                
               for(String apiName: r.fields.getMap().keySet()){
               
                   count++;
                   if(count < totalFields){
                       query += ' '+apiName+',';
                   }
                   else{
                       query += ' '+apiName;
                   }
               }  
               
               query += ' from PM_Tool__c where id in:pmToolSet';                       
                                      
               for(String market: marketInstallationStepMap.keySet()){
                   if(marketInstallationStepMap.get(market).size() > 0){
                       //String query = 'select id,';
                       for(Market_Installation_Step__c mis : marketInstallationStepMap.get(market)){
                          String fieldName = mis.Installation_Step__r.Name.replace(' ','_');
                          fieldName = fieldName.replace('&','_');
                          if(fieldName == 'Initial_Utility_Approval/Net_Metering'){
                              fieldName = 'Initial_Utility_Approval_Net_Metering';
                          }
                          
                          if(fieldName == 'State_Initial_Submission'){
                              fieldName = 'State_Initial_Submission_Installation';
                          }
                          
                          if(fieldName == 'M1/ITC_Funding'){
                              fieldName = 'M1_ITC_Funding';
                          }
                          if(fieldName == 'PTO/Final_Utility_Approval'){
                              fieldName = 'PTO_Final_Utility_Approval';
                          }
                          
                          if(fieldName == 'Sales_Order'){
                              fieldName = 'Sales_Order_Installation';
                          }
                          
                          if(fieldName == 'Intro_Call'){
                              fieldName = 'Intro_Call_Installation';
                          }
                          
                          if(r.fields.getMap().containsKey(fieldName+'__c')){
                               marketFieldsSet.add(fieldName+'__c');
                          }
                         
                      }
                       
                       Decimal completionAvg = 0;
                       Decimal totalCompletionAvg = 0;
                       Integer noOfSteps = 0;
        
                       for(PM_Tool__c pmtool : Database.query(query)){
                           for(String fName: marketFieldsSet){
                               
                               if(pmtool.get(fName) != null && pmtool.get(fName) != ''){
                                   completionAvg = completionAvg + Integer.valueOf(pmtool.get(fName));
                                   noOfSteps++;
                               }
                           }
                           
                           Decimal avg = 0;
                           if(noOfSteps>0){
                           
                               Integer nos = 2*noOfSteps;
                               avg = completionAvg / nos;
                               avg = avg*100;
                           }
                           
                           avg = avg.setScale(2, RoundingMode.HALF_UP);
                           
                           pmtool.Completion_Average__c = avg;
                           
                           pmToolMapForUpdate.put(pmtool.id, pmtool);
                           //pmToolListToUpdateCompletionPer.add(pmtool);
                           
                           system.debug('-----------------------------------'+pmtool);
                       }
                   
                   }               
                }
                
                /*system.debug('-------------------------------- Set---'+pmToolListToUpdateCompletionPer);
                
                List<PM_tool__c> pmSetToList = new List<PM_tool__c>();
                system.debug('-------------------------------- SetSize---'+pmToolListToUpdateCompletionPer.size());
                for(PM_Tool__c pm: pmToolListToUpdateCompletionPer){
                System.debug('Befor::::'+pm);
                    pmSetToList.add(pm);
                     System.debug('AfterSize::::'+pmSetToList.size());
                            System.debug('After::::'+pmSetToList);
                }
                system.debug('-------------------------------- List---'+pmSetToList);*/
                
                List<PM_tool__c> pmSetToList = new List<PM_tool__c>();
                for(Id pmId: pmToolMapForUpdate.keySet()){
                    pmSetToList.add(pmToolMapForUpdate.get(pmId));
                }
                
                update pmSetToList;
                
                }
            catch(Exception e){
                system.debug(e.getMessage());
            }
         
    }
    
    public void populateProjectManagersList(String market) {
        projectManagerList = new List<SelectOption>();
        try{
        
            Set<SelectOption> innerSet = new Set<SelectOption>();
            projectManagerList.add(new SelectOption('', '--Select--'));
            for(PM_Tool__c pm : [select Project_Manager__c, Project_Manager__r.Name from PM_Tool__c where Project_Manager__c != null and State__c =:market]){
                innerSet.add(new SelectOption(pm.Project_Manager__c, pm.Project_Manager__r.Name));
            }
            
            for(SelectOption so : innerSet){
                projectManagerList.add(so);
            }
        }
        catch(Exception e){
           ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()+' '+e.getStackTraceString());
           ApexPages.addMessage(errMsg);
       }
    }
    
    public void loadData() {
        
        try{
        
             filterData();
        }
        catch(Exception e){
           ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()+' '+e.getStackTraceString());
           ApexPages.addMessage(errMsg);
       }
    }
    
    public void filterData(){
    
        lstPMWrapper = new List<PMWrapper>();
        
        Business_Market__c bm;
    
       if(selectedMarket == ''){
          bm = [select id, Name from Business_Market__c where name = 'CT'];
          selectedMarket = String.valueOf(bm.id);
       }
       else{
          bm = [select id, Name from Business_Market__c where id =: selectedMarket];
       }
       
       populateProjectManagersList(bm.Name);
       
       List<String> marketFieldsSet = new List<String>();
       
       String query = 'select id,';
       marketInstallationStepList = new List<Market_Installation_Step__c>([select id, name, Business_Market__c, Installation_Step__c,
       Installation_Step__r.Name, Sequence__c from Market_Installation_Step__c where Business_Market__c =: bm.id and Display_In_Tracker__c = true
       order by Sequence__c asc]);

       Schema.DescribeSObjectResult r = PM_Tool__c.sObjectType.getDescribe();
        
       if(marketInstallationStepList.size() > 0){
           for(Market_Installation_Step__c mis : marketInstallationStepList){
              String fieldName = mis.Installation_Step__r.Name.replace(' ','_');
              fieldName = fieldName.replace('&','_');
              if(fieldName == 'Initial_Utility_Approval/Net_Metering'){
                  fieldName = 'Initial_Utility_Approval_Net_Metering';
              }
              
              if(fieldName == 'State_Initial_Submission'){
                  fieldName = 'State_Initial_Submission_Installation';
              }
              
              if(fieldName == 'M1/ITC_Funding'){
                  fieldName = 'M1_ITC_Funding';
              }
              if(fieldName == 'PTO/Final_Utility_Approval'){
                  fieldName = 'PTO_Final_Utility_Approval';
              }
              
              if(fieldName == 'Sales_Order'){
                  fieldName = 'Sales_Order_Installation';
              }
              
              if(fieldName == 'Intro_Call'){
                  fieldName = 'Intro_Call_Installation';
              }
              
              if(r.fields.getMap().containsKey(fieldName+'__c')){
                  query += ' '+fieldName+'__c,';
                  marketFieldsSet.add(fieldName+'__c');
              }

           }    
       }
       
       query += 'Completion_Average__c, Aging_since_Contract_Signed__c, Aging_Since_Contract_Approved__c, Project_Manager__r.Name, Customer_Name__c, State__c, Address__c,Deal_Numeric_ID__c, Deal__c, Contract_Signed_Date__c, Contract_Approved_Date__c, System_Size__c from PM_Tool__c where Project_Status__c = \'Active\'';
       
       if(bm.Name == 'CT'){
           query += ' and (State__c = \'CT\' or State__c = \'Connecticut\')';
       }
       else if(bm.Name == 'NY'){
           query += ' and (State__c = \'NY\' or State__c = \'New York\')';
       }
       else if(bm.Name == 'LA'){
           query += ' and (State__c = \'LA\' or State__c = \'LOUISIANA\')';
       }
       
       if(selectedProjectManager == null){
           selectedProjectManager = '';
       }

       if(!stateChanged && selectedProjectManager != ''){
           query += ' and Project_Manager__c = \''+selectedProjectManager+'\'';
       }
       else{
           selectedMarket = null;
           stateChanged = false;
       }

       Decimal totalCompletionAvg = 0;
       for(PM_Tool__c pmtool : Database.query(query)){
           
           List<PMFieldWrapper> fieldWrapper = new List<PMFieldWrapper>(); 
           
           for(String fName: marketFieldsSet){
               
               fieldWrapper.add(new PMFieldWrapper(fname, String.valueOf(pmtool.get(fName))));

           }
           
           Decimal avg = 0;
           
           if(pmtool.Completion_Average__c!=null){
               avg = pmtool.Completion_Average__c.setScale(2, RoundingMode.HALF_UP);
           }
           
           totalCompletionAvg = totalCompletionAvg + avg;
           
           lstPMWrapper.add(new PMWrapper(pmtool,pmtool.Completion_Average__c,fieldWrapper));
       }
       
       activeProjects = lstPMWrapper.size();
       
       if(lstPMWrapper.size()>0){
           averageCompletion = totalCompletionAvg / lstPMWrapper.size();
           averageCompletion = averageCompletion.setScale(0, RoundingMode.HALF_UP); 
       }
           
    }
    
    public PageReference viewCustomerDetail(){
    
       PageReference customerPage = new PageReference('/apex/PM_Customer_Detail');
       try{
           Business_Market__c bm;
        
           if(selectedMarket == ''){
              bm = [select id, Name from Business_Market__c where name = 'CT'];
              selectedMarket = String.valueOf(bm.id);
           }
           else{
              bm = [select id, Name from Business_Market__c where id =: selectedMarket];
           }
           
           List<String> marketFieldsSet = new List<String>();
            
           String query = 'select id,';
           marketInstallationStepList = new List<Market_Installation_Step__c>([select id, name, Business_Market__c, Installation_Step__c,
           Installation_Step__r.Name, Sequence__c from Market_Installation_Step__c where Business_Market__c =: bm.id
           order by Sequence__c asc]);
           
           Schema.DescribeSObjectResult r = PM_Tool__c.sObjectType.getDescribe();
            
           if(marketInstallationStepList.size() > 0){
               for(Market_Installation_Step__c mis : marketInstallationStepList){
                  String fieldName = mis.Installation_Step__r.Name.replace(' ','_');
                 
                  
                  String fieldNameAging = mis.Installation_Step__r.Name.replace(' ','_');
                  String fieldNameSD = mis.Installation_Step__r.Name.replace(' ','_');
                  String fieldNameED = mis.Installation_Step__r.Name.replace(' ','_');
                  String fieldNaOver = mis.Installation_Step__r.Name.replace(' ','_');
                  
                  fieldName = fieldName.replace('&','_');
                  fieldNameAging = fieldNameAging.replace('&','_');
                  fieldNameED = fieldNameED.replace('&','_');
                  fieldNameSD = fieldNameSD.replace('&','_');
                  fieldNaOver = fieldNaOver.replace('&','_');
                  
                  if(fieldName == 'Initial_Utility_Approval/Net_Metering'){
                      fieldName = 'Initial_Utility_Approval_Net_Metering';
                      fieldNameAging = 'Initial_Utility_Approval_Net_Metering_Ag';
                      fieldNameSD = 'Initial_Utility_Approval_Net_Metering';
                      fieldNameED = 'Initial_Utility_Approval_Net_Metering';
                      fieldNaOver = 'Initial_Utility_Approval_Net_Metering';
                  }
                  
                  if(fieldName == 'State_Initial_Submission'){
                      fieldName = 'State_Initial_Submission_Installation';
                      fieldNameAging = 'State_Initial_Submission';
                      fieldNameSD = 'State_Initial_Submission';
                      fieldNameED = 'State_Initial_Submission';
                      fieldNaOver = 'State_Initial_Submission';
                  }
                  
                  if(fieldName == 'M1/ITC_Funding'){
                      fieldName = 'M1_ITC_Funding';
                      fieldNaOver = 'M1_ITC_Funding';
                  }
                  
                  if(fieldName == 'PTO/Final_Utility_Approval'){
                      fieldName = 'PTO_Final_Utility_Approval';
                      fieldNameAging = 'PTO_Final_Utility_Approval';
                      fieldNameSD = 'PTO_Final_Utility_Approval';
                      fieldNameED = 'PTO_Final_Utility_Approval';
                      fieldNaOver = 'PTO_Final_Utility_Approval';
                  }
                  
                  if(fieldName == 'Sales_Order'){
                      fieldName = 'Sales_Order_Installation';
                      fieldNameAging = 'Sales_Order';
                      fieldNameSD = 'Sales_Order';
                      fieldNameED = 'Sales_Order';
                      fieldNaOver = 'Sales_Order';
                  }
                  
                  if(fieldName == 'Intro_Call'){
                      fieldName = 'Intro_Call_Installation';
                      fieldNameAging = 'Intro_Call';
                      fieldNameSD = 'Intro_Call';
                      fieldNameED = 'Intro_Call';
                      fieldNaOver = 'Intro_Call';
                  }
                  
                 /* if(fieldName == 'EE_Audit'){

                      fieldNaOver = 'EE_Audit_NA_Override_P__c';
                      fieldName = 'EE_Audit';
                      fieldNameAging = 'EE_Audit';
                      fieldNameSD = 'EE_Audit';
                      fieldNameED = 'EE_Audit';
                  }*/
                  
                  
                  if(r.fields.getMap().containsKey(fieldName+'__c')){
                      query += ' '+fieldName+'__c,';
                      query += ' '+fieldNameSD+'_SD__c,';
                      query += ' '+fieldNameED+'_ED__c,';
                      
                      if(fieldNameAging == 'Initial_Utility_Approval_Net_Metering_Ag'){
                          query += ' '+fieldNameAging+'__c,';
                          query += ' Initial_Utility_Approval_Net_Metering_NA__c,';
                      }
                      else{
                          query += ' '+fieldNameAging+'_Aging__c,';
                          query += ' '+fieldNaOver+'_NA_Override__c,';
    
                      }
                      
                      marketFieldsSet.add(fieldName+'__c');
                  }

               }
           }
           
           query += 'Completion_Average__c, Project_Manager__r.Name, Actual_System_Size_Parallel__c, Email__c, Primary_Phone__c, Secondary_Phone__c, Lease_Type__c, EE_Accepted__c, PV_Lease_Payment__c, EE_Lease_Payment__c, Sales_Person__c, Telemarketer_Parallel__c, Referring_Customer__c, Deal__r.Numeric_ID__c, Customer_Name__c, State__c, Address__c,Deal_Numeric_ID__c, Deal__c, Contract_Signed_Date__c, Contract_Approved_Date__c, System_Size__c from PM_Tool__c where Project_Status__c = \'Active\' and id = \''+customerId+'\'';
          
              
           if(selectedProjectManager != '' && selectedProjectManager != null){
               query += ' and Project_Manager__c = \''+selectedProjectManager+'\'';
           }
           
           List<CustomerDetailFieldWrapper> CustomerDetailFieldWrapperList = new List<CustomerDetailFieldWrapper>();
           
           PM_Tool__c pmtool = Database.query(query);           
               
           for(String fName: marketFieldsSet){
           
              String fnAging = fName;
              String fnSD = fName;
              String fnED = fName;
              String naOver = fName;
              
              String fNameWrap = fName;
               
              if(fName == 'Initial_Utility_Approval_Net_Metering__c'){
                 fnAging = 'Initial_Utility_Approval_Net_Metering_Ag';
                 fNameWrap = 'Initial_Utility_Approval/Net_Metering__c';
                 naOver = 'Initial_Utility_Approval_Net_Metering';
              }
              
              if(fName == 'State_Initial_Submission_Installation__c'){
                  fnAging = 'State_Initial_Submission';
                  fnSD = 'State_Initial_Submission';
                  fnED = 'State_Initial_Submission';
                  fNameWrap = 'State_Initial_Submission';
                  naOver = 'State_Initial_Submission';
              }
              
              if(fName == 'Sales_Order_Installation__c'){
                  fnAging = 'Sales_Order';
                  fnSD = 'Sales_Order';
                  fnED = 'Sales_Order';
                  fNameWrap = 'Sales_Order';
                  naOver = 'Sales_Order';
              }
              
              if(fName == 'Intro_Call_Installation__c'){
                  fnAging = 'Intro_Call';
                  fnSD = 'Intro_Call';
                  fnED = 'Intro_Call';
                  fNameWrap = 'Intro_Call';
                  naOver = 'Intro_Call';
              }
              
             /* if(fName == 'EE_Audit__c'){
                  naOver = 'EE_Audit_NA_Override_P__c';
                  fnAging = 'EE_Audit';
                  fnSD = 'EE_Audit';
                  fnED = 'EE_Audit';
                  fNameWrap = 'EE_Audit';
              }*/
              
              fnAging = fnAging.removeEndIgnoreCase('__c');
              fnSD = fnSD.removeEndIgnoreCase('__c');
              fnED = fnED.removeEndIgnoreCase('__c');
              naOver = naOver.removeEndIgnoreCase('__c');
              
              if(fnAging == 'Initial_Utility_Approval_Net_Metering_Ag'){
                  fnAging = 'Initial_Utility_Approval_Net_Metering_Ag__c';
                  naOver = naOver+'_NA__c';
              }
              else{
                  fnAging = fnAging+'_Aging__c';
                  naOver = naOver+'_NA_Override__c';

              }
              
              fnSD = fnSD+'_SD__C';
              fnED = fnED+'_ED__C';
              
              
              if(fNameWrap == 'M1_ITC_Funding__c'){
                  fNameWrap = 'M1/ITC_Funding';
              }
              
              if(fNameWrap == 'PTO_Final_Utility_Approval__c'){
                  fNameWrap = 'PTO/Final_Utility_Approval';
              }
              
              fNameWrap = fNameWrap.removeEndIgnoreCase('__c');
              fNameWrap = fNameWrap.replace('_',' ');
           
              CustomerDetailFieldWrapper cdfw = new CustomerDetailFieldWrapper(fNameWrap, String.valueOf(pmtool.get(naOver)), integer.valueOf(pmtool.get(fName)), String.valueOf(pmtool.get(fnAging)), Date.valueOf(pmtool.get(fnSD)), Date.valueOf(pmtool.get(fnED)));
              CustomerDetailFieldWrapperList.add(cdfw);
    
           }
           
           Decimal avg = 0;
           if(pmtool.Completion_Average__c!=null){
               avg = pmtool.Completion_Average__c.setScale(2, RoundingMode.HALF_UP);
           }
           
           customerDetailWrapperObj = new CustomerDetailWrapper(pmtool, avg, CustomerDetailFieldWrapperList);

            return customerPage; 
        }    
        catch(Exception e){
          
           ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()+' '+e.getStackTraceString());
           ApexPages.addMessage(errMsg);
           return customerPage;
        } 
    }
    
    public class CustomerDetailWrapper {
        
        public PM_Tool__c pmTool{get;set;}
        public Decimal avg{get;set;}
        public List<CustomerDetailFieldWrapper> cdFieldWrapperList{get;set;}
        
        public CustomerDetailWrapper(PM_Tool__c pmTool, Decimal avg, List<CustomerDetailFieldWrapper> cdFieldWrapperList) {
            this.pmTool = pmTool;
            this.avg = avg;
            this.cdFieldWrapperList = cdFieldWrapperList;
        }
    }
    
    public class CustomerDetailFieldWrapper {
        
        public string step{get;set;}
        public string na{get;set;}
        public integer score{get;set;}
        public string aging{get;set;}
        public Date startDate{get;set;}
        public Date endDate{get;set;}
        
        public CustomerDetailFieldWrapper(string step, string na, integer score, string aging, Date startDate, Date endDate) {
            this.step = step;
            this.na = na;
            this.score = score;
            this.aging = aging;
            this.startDate = startDate;
            this.endDate = endDate;
        }
    }
    
    public class PMWrapper {
        public PM_Tool__c pmtool{get;set;}
        public Decimal avg{get;set;}
        public List<PMFieldWrapper> pmFieldWrapper{get;set;}
        
        public PMWrapper(PM_Tool__c pmtool, Decimal avg, List<PMFieldWrapper> pmFieldWrapper) {
            this.pmtool = pmtool;
            this.avg = avg;
            this.pmFieldWrapper = pmFieldWrapper;
        }
    }
    
    public class PMFieldWrapper {
        
        public string fieldname{get;set;}
        public string fieldValue{get;set;}
        
        public PMFieldWrapper(string fieldname, string fieldValue) {
            this.fieldname = fieldname;
            this.fieldValue = fieldValue;
        }
    }
}