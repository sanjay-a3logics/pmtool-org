public class PmToolDataMigration implements Database.Batchable<Sobject>,Database.Stateful{

    public Integer record_limit = null;
    public String oppId = null;
    public Map<Integer,id> bStatusMap;
    
    public PmToolDataMigration(Integer record_limit, String oppId){
        
        this.record_limit = record_limit;
        this.oppId = oppId;
    }
    
    public Database.QueryLocator start(Database.BatchableContext BC){
    
        bStatusMap = new Map<Integer,id>();
        for(Business_Status__c status : [select id, Score__c from Business_Status__c]){
            bStatusMap.put(Integer.valueOf(status.Score__c), status.id);
        }
        
        if(oppId != null){
        
            return Database.getQueryLocator('Select id, opportunity__c from PM_Tool_V2__c where opportunity__c =: oppId');
        }
        else{
        
            if(record_limit == 0){
                return Database.getQueryLocator('Select id, opportunity__c from PM_Tool_V2__c where opportunity__c != null');
            }
            else{
                return Database.getQueryLocator('Select id, opportunity__c from PM_Tool_V2__c where opportunity__c != null limit :record_limit');
            }
        }
    }
    
    public void execute(Database.BatchableContext BC, List<PM_Tool_V2__c> pmToolList){
        
        Set<Id> oppIdSet = new Set<Id>();
        Set<Id> pmToolV2Set = new Set<Id>();
        for(PM_Tool_V2__c pmToolV2 : pmToolList){
            pmToolV2Set.add(pmToolV2.id);
            oppIdSet.add(pmToolV2.opportunity__c);
        }
        
        updateSteps(pmToolV2Set, oppIdSet);

    }
    
    public void finish(Database.BatchableContext BC){
     
    }
    
    public void updateSteps(Set<Id> pmToolSet, Set<Id> oppIdSet){
        
        try{
        
                Map<Id, PM_Tool__c> pmToolOldMap = new Map<Id, PM_Tool__c>();
                for(PM_Tool__c pmTool : [select id, Opportunity__c, Activation__c,Activation_DT__c,Activation_NA_Override__c,
                    Activation_SD__c,Closing_Call__c,Closing_Call_ED__c,Closing_Call_NA_Override__c,Closing_Call_SD__c,
                    EA_State_Approval_Submission__c,EA_State_Approval_Submission_NA_Override__c,EE_Audit__c,EE_Audit_ED__c,
                    EE_Audit_NA_Override__c,EE_Audit_SD__c,Electrical_Install__c,Electrical_Install_ED__c,Electrical_Install_NA_Override__c,
                    Electrical_Install_SD__c,Energy_Upgrade__c,Energy_Upgrade_ED__c,Energy_Upgrade_NA_Override__c,Energy_Upgrade_SD__c,
                    Initial_Utility_Approval_Net_Metering__c,Initial_Utility_Approval_Net_Metering_NA__c,Initial_Utility_Approval_Net_Metering_SD__c,
                    Municipal_Inspection__c,Municipal_Inspection_ED__c,Municipal_Inspection_NA_Override__c,Permitting__c,Permitting_ED__c,
                    Permitting_NA_Override__c,Quality_Control__c,Quality_Control_ED__c,Quality_Control_NA_Override__c,Quality_Control_SD__c,
                    R_P_Install__c,R_P_Install_ED__c,R_P_Install_NA_Override__c,R_P_Install_SD__c,State_Initial_Submission_Installation__c,
                    State_Initial_Submission_ED__c,State_Initial_Submission_NA_Override__c,State_Initial_Submission_SD__c,Upgrade_Modeling__c,
                    Upgrade_Modeling_ED__c,Upgrade_Modeling_NA_Override__c,Upgrade_Modeling_SD__c,Municipal_Inspection_SD__c,Permitting_SD__c,
                    Feasibility_SD__c,Feasibility__c,Feasibility_ED__c, Intro_Call_ED__c,Intro_Call_NA_Override__c,Intro_Call_SD__c,
                    Sales_Order_ED__c,Sales_Order_NA_Override__c,Sales_Order_SD__c from PM_Tool__c where Opportunity__c in : oppIdSet]){
                    
                    pmToolOldMap.put(pmTool.Opportunity__c, pmTool);
                    
                }
                
                
                List<PM_Steps__c> pmStepList = new List<PM_Steps__c>();
                
                for(PM_Steps__c pmStep : [select id, PM_Tool_V2__r.Opportunity__c, Name,Aging__c,End_Date__c,In_Process_Aging__c,
                    In_Process_Aging_Exception__c,In_Process_End_Date__c,In_Process_Start_Date__c,NA_Override__c,PM_Review_Aging__c,
                    PM_Review_End_Date__c,PM_Review_Start_Date__c,Start_Date__c, PM_Tool_V2__c, PM_Tool_V2__r.State__c, 
                    Business_Installation_step__r.Name, PM_Tool_V2__r.EA_St_App_Approved_Date__c, PM_Tool_V2__r.EA_Assigned_Date__c,
                    PM_Tool_V2__r.Inspection_Requested_Date__c,PM_Tool_V2__r.Building_Permit_Applied_For__c, PM_Tool_V2__r.Electrical_Permit_Applied_For__c,
                    PM_Tool_V2__r.R_P_Inst_Sch_date__c, PM_Tool_V2__r.State_Prog_App_Sub_Date__c, PM_Tool_V2__r.Work_Scope_Submitted__c, PM_Tool_V2__r.EA_St_App_Sub_Date__c, 
                    PM_Tool_V2__r.EA_Scheduled_Date__c, PM_Tool_V2__r.Elec_Install_Sch_date__c, PM_Tool_V2__r.EU_Scheduled_Date__c, 
                    PM_Tool_V2__r.Field_Verif_Req_Date__c, PM_Tool_V2__r.Field_Verif_Comp_Date__c, PM_Tool_V2__r.Eng_Report_Rec_Date__c,
                    PM_Tool_V2__r.Eng_Report_Req_Date__c, PM_Tool_V2__r.Feasibility_Completed_Date__c, PM_Tool_V2__r.Assessment_Req_Date__c, 
                    PM_Tool_V2__r.Assessment_Comp_Date__c, PM_Tool_V2__r.Layout_Appr_Rec_Date__c, PM_Tool_V2__r.Layout_Appr_Sub_Date__c, Business_status__c 
                    from PM_Steps__c where PM_Tool_V2__c in : pmToolSet]){
                    
                    if(pmToolOldMap.containsKey(pmStep.PM_Tool_V2__r.Opportunity__c)){
                    
                        PM_Tool__c oldPmToolRecord = pmToolOldMap.get(pmStep.PM_Tool_V2__r.Opportunity__c);
                        
                        //system.assert(false, pmStep.Business_Installation_step__r.Name);
                    
                        if(pmStep.Business_Installation_step__r.Name == 'Activation'){
                        
                            pmStep.Start_Date__c = oldPmToolRecord.Activation_SD__c;
                            pmStep.End_Date__c = oldPmToolRecord.Activation_DT__c;
                            
                            if(!pmStep.NA_Override__c){
                                pmStep.NA_Override__c = oldPmToolRecord.Activation_NA_Override__c;
                            }
                            
                            if(pmStep.NA_Override__c){
                                pmStep.Business_status__c = bStatusMap.get(-1);
                            }
                        }
                        
                        if(pmStep.Business_Installation_step__r.Name == 'Closing Call'){
                        
                            pmStep.Start_Date__c = oldPmToolRecord.Closing_Call_SD__c;
                            pmStep.End_Date__c = oldPmToolRecord.Closing_Call_ED__c;
                            
                            if(pmStep.In_Process_Start_Date__c == null && pmStep.In_Process_End_Date__c != null){
                                
                                pmStep.In_Process_End_Date__c = null;
                            }
                            
                            if(!pmStep.NA_Override__c){
                                pmStep.NA_Override__c = oldPmToolRecord.Closing_Call_NA_Override__c;
                            }
                            
                            if(pmStep.NA_Override__c){
                                pmStep.Business_status__c = bStatusMap.get(-1);
                            }
                        }
                        
                        if(pmStep.Business_Installation_step__r.Name == 'EA State Application Approval'){
                        
                            if(!pmStep.NA_Override__c){
                                pmStep.NA_Override__c = oldPmToolRecord.EA_State_Approval_Submission_NA_Override__c;
                            }
                            
                            if(pmStep.NA_Override__c){
                                pmStep.Business_status__c = bStatusMap.get(-1);
                            }
                        }
                        
                         if(pmStep.Business_Installation_step__r.Name == 'EE Audit'){
                        
                            pmStep.Start_Date__c = oldPmToolRecord.EE_Audit_SD__c;
                            pmStep.End_Date__c = oldPmToolRecord.EE_Audit_ED__c;
                            
                            pmStep.In_Process_End_Date__c = oldPmToolRecord.EE_Audit_ED__c;
                            pmStep.PM_Review_Start_Date__c = oldPmToolRecord.EE_Audit_SD__c;
                            pmStep.In_Process_Start_Date__c = pmStep.PM_Tool_V2__r.EA_Scheduled_Date__c;
                            pmStep.PM_Review_End_Date__c = pmStep.PM_Tool_V2__r.EA_Scheduled_Date__c;
                            
                            if(!pmStep.NA_Override__c){
                                pmStep.NA_Override__c = oldPmToolRecord.EE_Audit_NA_Override__c;
                            }
                            
                            if(pmStep.NA_Override__c){
                                pmStep.Business_status__c = bStatusMap.get(-1);
                            }
                        }
                        
                        if(pmStep.Business_Installation_step__r.Name == 'Electrical Install'){
                        
                            pmStep.Start_Date__c = oldPmToolRecord.Electrical_Install_SD__c;
                            pmStep.End_Date__c = oldPmToolRecord.Electrical_Install_ED__c;
                            
                            pmStep.In_Process_End_Date__c = oldPmToolRecord.Electrical_Install_ED__c;
                            pmStep.PM_Review_Start_Date__c = oldPmToolRecord.Electrical_Install_SD__c;
                            pmStep.In_Process_Start_Date__c = pmStep.PM_Tool_V2__r.Elec_Install_Sch_date__c;
                            pmStep.PM_Review_End_Date__c = pmStep.PM_Tool_V2__r.Elec_Install_Sch_date__c;
                            
                            if(!pmStep.NA_Override__c){
                                pmStep.NA_Override__c = oldPmToolRecord.Electrical_Install_NA_Override__c;
                            }
                            
                            if(pmStep.NA_Override__c){
                                pmStep.Business_status__c = bStatusMap.get(-1);
                            }
                        }
                        
                        if(pmStep.Business_Installation_step__r.Name == 'EE Upgrade'){
                        
                            pmStep.Start_Date__c = oldPmToolRecord.Energy_Upgrade_SD__c;
                            pmStep.End_Date__c = oldPmToolRecord.Energy_Upgrade_ED__c;
                            
                            pmStep.In_Process_End_Date__c = oldPmToolRecord.Energy_Upgrade_ED__c;
                            pmStep.PM_Review_Start_Date__c = oldPmToolRecord.Energy_Upgrade_SD__c;
                            pmStep.In_Process_Start_Date__c = pmStep.PM_Tool_V2__r.EU_Scheduled_Date__c;
                            pmStep.PM_Review_End_Date__c = pmStep.PM_Tool_V2__r.EU_Scheduled_Date__c;
                            
                            if(!pmStep.NA_Override__c){
                                pmStep.NA_Override__c = oldPmToolRecord.Energy_Upgrade_NA_Override__c;
                            }
                            
                            if(pmStep.NA_Override__c){
                                pmStep.Business_status__c = bStatusMap.get(-1);
                            }
                        }
                        
                        if(pmStep.Business_Installation_step__r.Name == 'Inspection'){
                        
                            pmStep.Start_Date__c = oldPmToolRecord.Municipal_Inspection_SD__c;
                            pmStep.End_Date__c = oldPmToolRecord.Municipal_Inspection_ED__c;
                            
                            pmStep.In_Process_End_Date__c = oldPmToolRecord.Municipal_Inspection_ED__c;
                            pmStep.PM_Review_Start_Date__c = oldPmToolRecord.Municipal_Inspection_SD__c;
                            pmStep.In_Process_Start_Date__c = pmStep.PM_Tool_V2__r.Inspection_Requested_Date__c;
                            pmStep.PM_Review_End_Date__c = pmStep.PM_Tool_V2__r.Inspection_Requested_Date__c;
                            
                            if(!pmStep.NA_Override__c){
                                pmStep.NA_Override__c = oldPmToolRecord.Municipal_Inspection_NA_Override__c;
                            }
                            
                            if(pmStep.NA_Override__c){
                                pmStep.Business_status__c = bStatusMap.get(-1);
                            }
                        }
                        
                        if(pmStep.Business_Installation_step__r.Name == 'Permitting'){
                        
                            pmStep.Start_Date__c = pmStep.PM_Tool_V2__r.Feasibility_Completed_Date__c;
                            pmStep.End_Date__c = oldPmToolRecord.Permitting_ED__c;
                            
                            pmStep.In_Process_End_Date__c = oldPmToolRecord.Permitting_ED__c;
                            pmStep.PM_Review_Start_Date__c = oldPmToolRecord.Permitting_SD__c;
                            
                            if(pmStep.PM_Tool_V2__r.Building_Permit_Applied_For__c != null && pmStep.PM_Tool_V2__r.Electrical_Permit_Applied_For__c != null){
                                if(pmStep.PM_Tool_V2__r.Building_Permit_Applied_For__c > pmStep.PM_Tool_V2__r.Electrical_Permit_Applied_For__c){
                                    
                                    pmStep.In_Process_Start_Date__c = pmStep.PM_Tool_V2__r.Building_Permit_Applied_For__c;
                                    pmStep.PM_Review_End_Date__c = pmStep.PM_Tool_V2__r.Building_Permit_Applied_For__c;
                                }
                                else{
                                    pmStep.In_Process_Start_Date__c = pmStep.PM_Tool_V2__r.Electrical_Permit_Applied_For__c;
                                    pmStep.PM_Review_End_Date__c = pmStep.PM_Tool_V2__r.Electrical_Permit_Applied_For__c;
                                }
                            }
                            else if(pmStep.PM_Tool_V2__r.Building_Permit_Applied_For__c != null){
                            
                                pmStep.In_Process_Start_Date__c = pmStep.PM_Tool_V2__r.Building_Permit_Applied_For__c;
                                pmStep.PM_Review_End_Date__c = pmStep.PM_Tool_V2__r.Building_Permit_Applied_For__c;
                            }
                            else{
                                pmStep.In_Process_Start_Date__c = pmStep.PM_Tool_V2__r.Electrical_Permit_Applied_For__c;
                                pmStep.PM_Review_End_Date__c = pmStep.PM_Tool_V2__r.Electrical_Permit_Applied_For__c;
                            }
                            
                            if(!pmStep.NA_Override__c){
                                pmStep.NA_Override__c = oldPmToolRecord.Permitting_NA_Override__c;
                            }
                            
                            if(pmStep.NA_Override__c){
                                pmStep.Business_status__c = bStatusMap.get(-1);
                            }
                        }
                        
                        if(pmStep.Business_Installation_step__r.Name == 'Quality Control'){
                        
                            pmStep.Start_Date__c = oldPmToolRecord.Quality_Control_SD__c;
                            pmStep.End_Date__c = oldPmToolRecord.Quality_Control_ED__c;
                            
                            //pmStep.In_Process_End_Date__c = oldPmToolRecord.Permitting_ED__c;
                            //pmStep.PM_Review_Start_Date__c = oldPmToolRecord.Energy_Upgrade_SD__c;
                            
                            if(!pmStep.NA_Override__c){
                                pmStep.NA_Override__c = oldPmToolRecord.Quality_Control_NA_Override__c;
                            }
                            
                            if(pmStep.NA_Override__c){
                                pmStep.Business_status__c = bStatusMap.get(-1);
                            }
                        }
                        
                        if(pmStep.Business_Installation_step__r.Name == 'R&P Install'){
                        
                            pmStep.Start_Date__c = oldPmToolRecord.R_P_Install_SD__c;
                            pmStep.End_Date__c = oldPmToolRecord.R_P_Install_ED__c;
                            
                            pmStep.In_Process_End_Date__c = oldPmToolRecord.R_P_Install_ED__c;
                            pmStep.PM_Review_Start_Date__c = oldPmToolRecord.R_P_Install_SD__c;
                            pmStep.In_Process_Start_Date__c = pmStep.PM_Tool_V2__r.R_P_Inst_Sch_date__c;
                            pmStep.PM_Review_End_Date__c = pmStep.PM_Tool_V2__r.R_P_Inst_Sch_date__c;
                            
                            if(!pmStep.NA_Override__c){
                                pmStep.NA_Override__c = oldPmToolRecord.R_P_Install_NA_Override__c;
                            }
                            
                            if(pmStep.NA_Override__c){
                                pmStep.Business_status__c = bStatusMap.get(-1);
                            }
                        }
                        
                        if(pmStep.Business_Installation_step__r.Name == 'State Initial Approval'){
                        
                            pmStep.Start_Date__c = pmStep.PM_Tool_V2__r.Feasibility_Completed_Date__c;
                            pmStep.End_Date__c = oldPmToolRecord.State_Initial_Submission_ED__c;
                            
                            pmStep.In_Process_End_Date__c = oldPmToolRecord.State_Initial_Submission_ED__c;
                            pmStep.PM_Review_Start_Date__c = pmStep.PM_Tool_V2__r.Feasibility_Completed_Date__c;
                            pmStep.In_Process_Start_Date__c = pmStep.PM_Tool_V2__r.State_Prog_App_Sub_Date__c;
                            pmStep.PM_Review_End_Date__c = pmStep.PM_Tool_V2__r.State_Prog_App_Sub_Date__c;
                            
                            if(!pmStep.NA_Override__c){
                                pmStep.NA_Override__c = oldPmToolRecord.State_Initial_Submission_NA_Override__c;
                            }
                            
                            if(pmStep.NA_Override__c){
                                pmStep.Business_status__c = bStatusMap.get(-1);
                            }
                        }
                        
                        if(pmStep.Business_Installation_step__r.Name == 'Work Scope Approval'){
                        
                            pmStep.Start_Date__c = oldPmToolRecord.Upgrade_Modeling_SD__c;
                            pmStep.End_Date__c = oldPmToolRecord.Upgrade_Modeling_ED__c;
                            
                            pmStep.In_Process_End_Date__c = oldPmToolRecord.Upgrade_Modeling_ED__c;
                            pmStep.PM_Review_Start_Date__c = oldPmToolRecord.Upgrade_Modeling_SD__c;
                            pmStep.In_Process_Start_Date__c = pmStep.PM_Tool_V2__r.Work_Scope_Submitted__c;
                            pmStep.PM_Review_End_Date__c = pmStep.PM_Tool_V2__r.Work_Scope_Submitted__c;
                            
                            if(!pmStep.NA_Override__c){
                                pmStep.NA_Override__c = oldPmToolRecord.Upgrade_Modeling_NA_Override__c;
                            }
                            
                            if(pmStep.NA_Override__c){
                                pmStep.Business_status__c = bStatusMap.get(-1);
                            }
                        }
                        
                        if(pmStep.Business_Installation_step__r.Name == 'Determination'){
                        
                            pmStep.Start_Date__c = oldPmToolRecord.Feasibility_SD__c;
                            pmStep.End_Date__c = oldPmToolRecord.Feasibility_ED__c;
                            //pmStep.NA_Override__c = oldPmToolRecord.Upgrade_Modeling_NA_Override__c;
                            //pmStep.In_Process_End_Date__c = oldPmToolRecord.Upgrade_Modeling_ED__c;
                            //pmStep.PM_Review_Start_Date__c = oldPmToolRecord.Upgrade_Modeling_SD__c;
                            
                            if(pmStep.In_Process_Start_Date__c == null && pmStep.In_Process_End_Date__c != null){
                                
                                pmStep.In_Process_End_Date__c = null;
                            }
                        }
                        
                        if(pmStep.Business_Installation_step__r.Name == 'EA State Application Approval'){
                        
                            pmStep.Start_Date__c = pmStep.PM_Tool_V2__r.EA_Assigned_Date__c;
                            pmStep.End_Date__c = pmStep.PM_Tool_V2__r.EA_St_App_Approved_Date__c;
                            //pmStep.NA_Override__c = oldPmToolRecord.Upgrade_Modeling_NA_Override__c;
                            pmStep.In_Process_End_Date__c = pmStep.PM_Tool_V2__r.EA_St_App_Approved_Date__c;
                            pmStep.PM_Review_Start_Date__c = pmStep.PM_Tool_V2__r.EA_Assigned_Date__c;
                            pmStep.In_Process_Start_Date__c = pmStep.PM_Tool_V2__r.EA_St_App_Sub_Date__c;
                            pmStep.PM_Review_End_Date__c = pmStep.PM_Tool_V2__r.EA_St_App_Sub_Date__c;
                        }
                        
                        if(pmStep.Business_Installation_step__r.Name == 'Site Verification'){
                        
                            pmStep.Start_Date__c = pmStep.PM_Tool_V2__r.Field_Verif_Req_Date__c;
                            pmStep.End_Date__c = pmStep.PM_Tool_V2__r.Field_Verif_Comp_Date__c;
                            //pmStep.NA_Override__c = oldPmToolRecord.Upgrade_Modeling_NA_Override__c;
                            //pmStep.In_Process_End_Date__c = pmStep.PM_Tool_V2__r.EA_St_App_Approved_Date__c;
                            //pmStep.PM_Review_Start_Date__c = pmStep.PM_Tool_V2__r.EA_Assigned_Date__c;
                            //pmStep.In_Process_Start_Date__c = pmStep.PM_Tool_V2__r.EA_St_App_Sub_Date__c;
                            //pmStep.PM_Review_End_Date__c = pmStep.PM_Tool_V2__r.EA_St_App_Sub_Date__c;
                            
                            if(pmStep.In_Process_Start_Date__c == null && pmStep.In_Process_End_Date__c != null){
                                
                                pmStep.In_Process_End_Date__c = null;
                            }
                        }
                        
                        if(pmStep.Business_Installation_step__r.Name == 'Engineering'){
                        
                            pmStep.Start_Date__c = pmStep.PM_Tool_V2__r.Eng_Report_Req_Date__c;
                            pmStep.End_Date__c = pmStep.PM_Tool_V2__r.Eng_Report_Rec_Date__c;
                            //pmStep.NA_Override__c = oldPmToolRecord.Upgrade_Modeling_NA_Override__c;
                            //pmStep.In_Process_End_Date__c = pmStep.PM_Tool_V2__r.EA_St_App_Approved_Date__c;
                            //pmStep.PM_Review_Start_Date__c = pmStep.PM_Tool_V2__r.EA_Assigned_Date__c;
                            //pmStep.In_Process_Start_Date__c = pmStep.PM_Tool_V2__r.EA_St_App_Sub_Date__c;
                            //pmStep.PM_Review_End_Date__c = pmStep.PM_Tool_V2__r.EA_St_App_Sub_Date__c;
                            
                            if(pmStep.In_Process_Start_Date__c == null && pmStep.In_Process_End_Date__c != null){
                                
                                pmStep.In_Process_End_Date__c = null;
                            }
                        }
                        
                        if(pmStep.Business_Installation_step__r.Name == 'Intro Call'){
                        
                            pmStep.Start_Date__c = oldPmToolRecord.Intro_Call_SD__c;
                            pmStep.End_Date__c = oldPmToolRecord.Intro_Call_ED__c;
                            
                            //pmStep.In_Process_End_Date__c = pmStep.PM_Tool_V2__r.EA_St_App_Approved_Date__c;
                            //pmStep.PM_Review_Start_Date__c = pmStep.PM_Tool_V2__r.EA_Assigned_Date__c;
                            //pmStep.In_Process_Start_Date__c = pmStep.PM_Tool_V2__r.EA_St_App_Sub_Date__c;
                            //pmStep.PM_Review_End_Date__c = pmStep.PM_Tool_V2__r.EA_St_App_Sub_Date__c;
                            
                            if(pmStep.In_Process_Start_Date__c == null && pmStep.In_Process_End_Date__c != null){
                                
                                pmStep.In_Process_End_Date__c = null;
                            }
                            
                            if(!pmStep.NA_Override__c){
                                pmStep.NA_Override__c = oldPmToolRecord.Intro_Call_NA_Override__c;
                            }
                            
                            if(pmStep.NA_Override__c){
                                pmStep.Business_status__c = bStatusMap.get(-1);
                            }
                            
                        }
                        
                        if(pmStep.Business_Installation_step__r.Name == 'Sales Order Creation'){
                        
                            pmStep.Start_Date__c = oldPmToolRecord.Sales_Order_SD__c;
                            pmStep.End_Date__c = oldPmToolRecord.Sales_Order_ED__c;
                            
                            //pmStep.In_Process_End_Date__c = pmStep.PM_Tool_V2__r.EA_St_App_Approved_Date__c;
                            //pmStep.PM_Review_Start_Date__c = pmStep.PM_Tool_V2__r.EA_Assigned_Date__c;
                            //pmStep.In_Process_Start_Date__c = pmStep.PM_Tool_V2__r.EA_St_App_Sub_Date__c;
                            //pmStep.PM_Review_End_Date__c = pmStep.PM_Tool_V2__r.EA_St_App_Sub_Date__c;
                            
                            if(!pmStep.NA_Override__c){
                                pmStep.NA_Override__c = oldPmToolRecord.Sales_Order_NA_Override__c;
                            }
                            
                            if(pmStep.NA_Override__c){
                                pmStep.Business_status__c = bStatusMap.get(-1);
                            }
                        }
                        
                        if(pmStep.Business_Installation_step__r.Name == 'Assessment'){
                        
                            pmStep.Start_Date__c = oldPmToolRecord.Intro_Call_ED__c;
                            pmStep.End_Date__c = pmStep.PM_Tool_V2__r.Assessment_Comp_Date__c;
                            //pmStep.NA_Override__c = oldPmToolRecord.Sales_Order_NA_Override__c;
                            pmStep.In_Process_End_Date__c = pmStep.PM_Tool_V2__r.Assessment_Comp_Date__c;
                            pmStep.PM_Review_Start_Date__c = oldPmToolRecord.Intro_Call_ED__c;
                            pmStep.In_Process_Start_Date__c = pmStep.PM_Tool_V2__r.Assessment_Req_Date__c;
                            pmStep.PM_Review_End_Date__c = pmStep.PM_Tool_V2__r.Assessment_Req_Date__c;
                        }
                        
                        if(pmStep.Business_Installation_step__r.Name == 'Layout Approval'){
                        
                            //pmStep.Start_Date__c = oldPmToolRecord.Intro_Call_ED__c;
                            pmStep.End_Date__c = pmStep.PM_Tool_V2__r.Layout_Appr_Rec_Date__c;
                            //pmStep.NA_Override__c = oldPmToolRecord.Sales_Order_NA_Override__c;
                            pmStep.In_Process_End_Date__c = pmStep.PM_Tool_V2__r.Layout_Appr_Rec_Date__c;
                            //pmStep.PM_Review_Start_Date__c = oldPmToolRecord.Intro_Call_ED__c;
                            pmStep.In_Process_Start_Date__c = pmStep.PM_Tool_V2__r.Layout_Appr_Sub_Date__c;
                            pmStep.PM_Review_End_Date__c = pmStep.PM_Tool_V2__r.Layout_Appr_Sub_Date__c;
                        }
                        
                        pmStepList.add(pmStep);
                    }

                }
                
                PMToolV2.runStepTrigger = false;
                update pmStepList;
            
        }
        catch(Exception e){
            
            system.assert(false, e.getMessage()+'----'+e.getStackTraceString());
        }
        
    }
}