trigger PMToolTrigger on PM_Tool__c (after update) {
    Trigger_Setting__c ts = Trigger_Setting__c.getInstance();
    if(ts.PM_Trigger__c==true){ 
        if(UtilityController.recursive){
            UtilityController.recursive = false;
            
            Set<Id> pmToolSet = new Set<Id>();
            for(PM_Tool__c pm: (List<PM_Tool__c>)Trigger.New){
                pmToolSet.add(pm.id);
            }    
            
            List<PM_Tool__c> pmToolList = new List<PM_Tool__c>();
    
            for(PM_Tool__c pmTool: [select id, PM_Assignment__c, PM_Assignment_SDT__c, PM_Assignment_EDT__c, EA_State_Approval_Submission_SDT__c,
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
                EE_Audit_SDT__c,EE_Audit_EDT__c,EE_Audit__c,PM_Assignment_NA_Override__c,EA_State_Approval_Submission_NA_Override__c,Intro_Call_NA_Override__c, 
                Feasibility_NA_Override__c,Initial_Utility_Approval_Net_Metering_NA__c,State_Initial_Submission_NA_Override__c,Permitting_NA_Override__c, 
                Sales_Order_NA_Override__c,Upgrade_Modeling_NA_Override__c,R_P_Install_NA_Override__c,Electrical_Install_NA_Override__c,Energy_Upgrade_NA_Override__c,
                Quality_Control_NA_Override__c,M1_ITC_Funding_NA_Override__c,Municipal_Inspection_NA_Override__c,M2_NA_Override__c,PTO_Final_Utility_Approval_NA_Override__c,
                M3_NA_Override__c,Activation_NA_Override__c,EE_Audit_NA_Override__c,State_Final_Submission_NA_Override__c,Closing_Call_NA_Override__c 
                from PM_Tool__c where id in: pmToolSet]){
                
                // update pm assignment start & End date fields
                if(pmTool.PM_Assignment_NA_Override__c){
                    pmTool.PM_Assignment_SDT__c = Null;
                    //pmTool.PM_Assignment_EDT__c = Null;
                }
                /*else{
                    pmTool.PM_Assignment_SDT__c = (pmTool.PM_Assignment__c == 1 && pmTool.PM_Assignment_SDT__c == null) ? Date.today() : pmTool.PM_Assignment_SDT__c;
                    pmTool.PM_Assignment_EDT__c = (pmTool.PM_Assignment__c == 2 && pmTool.PM_Assignment_EDT__c == null) ? Date.today() : pmTool.PM_Assignment_EDT__c;
                }*/
                
                
                // update EA_State_Approval_Submission__c start & End date fields
                if(pmTool.EA_State_Approval_Submission_NA_Override__c){
                    pmTool.EA_State_Approval_Submission_SDT__c = Null;
                    //pmTool.EA_State_Approval_Submission_EDT__c = Null;
                }
                /*else{
                    pmTool.EA_State_Approval_Submission_SDT__c = (pmTool.EA_State_Approval_Submission__c == 1 && pmTool.EA_State_Approval_Submission_SDT__c == null) ?  Date.today() : pmTool.EA_State_Approval_Submission_SDT__c;
                    pmTool.EA_State_Approval_Submission_EDT__c = (pmTool.EA_State_Approval_Submission__c == 2 && pmTool.EA_State_Approval_Submission_EDT__c == null) ?  Date.today() : pmTool.EA_State_Approval_Submission_EDT__c;
                }*/
                
                // update Intro_Call_SDT__c start & End date fields
                if(pmTool.Intro_Call_NA_Override__c){
                    pmTool.Intro_Call_SDT__c = Null;
                    //pmTool.Intro_Call_EDT__c = Null;
                }
                /*else{
                    pmTool.Intro_Call_SDT__c = (pmTool.Intro_Call_Installation__c == 1 && pmTool.Intro_Call_SDT__c == null) ?  Date.today() : pmTool.Intro_Call_SDT__c;
                    pmTool.Intro_Call_EDT__c = (pmTool.Intro_Call_Installation__c == 2 && pmTool.Intro_Call_EDT__c == null) ?  Date.today() : pmTool.Intro_Call_EDT__c;
                }*/
                
                // update Feasibility_SDT__c start & End date fields
                if(pmTool.Feasibility_NA_Override__c){
                    pmTool.Feasibility_SDT__c = Null;
                    //pmTool.Feasibility_EDT__c = Null;
                }
                /*else{
                    pmTool.Feasibility_SDT__c = (pmTool.Feasibility__c == 1 && pmTool.Feasibility_SDT__c == null) ?  Date.today() : pmTool.Feasibility_SDT__c;
                    pmTool.Feasibility_EDT__c = (pmTool.Feasibility__c == 2 && pmTool.Feasibility_EDT__c == null) ?  Date.today() : pmTool.Feasibility_EDT__c;
                }*/
        
                // update Initial_Utility_Approval_Net_MeteringSDT__c start & End date fields
                if(pmTool.Initial_Utility_Approval_Net_Metering_NA__c){
                    pmTool.Initial_Utility_Approval_Net_MeteringSDT__c = Null;
                    //pmTool.Initial_Utility_Approval_Net_MeteringEDT__c = Null;
                }
                /*else{
                    pmTool.Initial_Utility_Approval_Net_MeteringSDT__c = (pmTool.Initial_Utility_Approval_Net_Metering__c == 1 && pmTool.Initial_Utility_Approval_Net_MeteringSDT__c == null) ?  Date.today() : pmTool.Initial_Utility_Approval_Net_MeteringSDT__c;
                    pmTool.Initial_Utility_Approval_Net_MeteringEDT__c = (pmTool.Initial_Utility_Approval_Net_Metering__c == 2 && pmTool.Initial_Utility_Approval_Net_MeteringEDT__c == null) ?  Date.today() : pmTool.Initial_Utility_Approval_Net_MeteringEDT__c;
                }*/
        
                // update State_Initial_Submission_SDT__c start & End date fields
                if(pmTool.State_Initial_Submission_NA_Override__c){
                    pmTool.State_Initial_Submission_SDT__c = Null;
                    //pmTool.State_Initial_Submission_EDT__c = Null;
                }
                /*else{
                    pmTool.State_Initial_Submission_SDT__c = (pmTool.State_Initial_Submission_Installation__c == 1 && pmTool.State_Initial_Submission_SDT__c == null) ?  Date.today() : pmTool.State_Initial_Submission_SDT__c;
                    pmTool.State_Initial_Submission_EDT__c = (pmTool.State_Initial_Submission_Installation__c == 2 && pmTool.State_Initial_Submission_EDT__c == null) ?  Date.today() : pmTool.State_Initial_Submission_EDT__c;
                }*/
         
                // update Permitting__c start & End date fields
                if(pmTool.Permitting_NA_Override__c){
                    pmTool.Permitting_SDT__c = Null;
                    //pmTool.Permitting_EDT__c = Null;
                }
                /*else{
                    pmTool.Permitting_SDT__c = (pmTool.Permitting__c == 1 && pmTool.Permitting_SDT__c == null) ?  Date.today() : pmTool.Permitting_SDT__c;
                    pmTool.Permitting_EDT__c = (pmTool.Permitting__c == 2 && pmTool.Permitting_EDT__c == null) ?  Date.today() : pmTool.Permitting_EDT__c;
                }*/
        
                // update Sales_Order_SDT__c start & End date fields
                if(pmTool.Sales_Order_NA_Override__c){
                    pmTool.Sales_Order_SDT__c = Null;
                    //pmTool.Sales_Order_EDT__c = Null;
                }
                /*else{
                    pmTool.Sales_Order_SDT__c = (pmTool.Sales_Order_Installation__c == 1 && pmTool.Sales_Order_SDT__c == null) ?  Date.today() : pmTool.Sales_Order_SDT__c;
                    pmTool.Sales_Order_EDT__c = (pmTool.Sales_Order_Installation__c == 2 && pmTool.Sales_Order_EDT__c == null) ?  Date.today() : pmTool.Sales_Order_EDT__c;
                }*/
        
                // update Upgrade Modeling start & End date fields
                if(pmTool.Upgrade_Modeling_NA_Override__c){
                    pmTool.Upgrade_Modeling_SDT__c = Null;
                    //pmTool.Upgrade_Modeling_EDT__c = Null;
                }
                /*else{
                    pmTool.Upgrade_Modeling_SDT__c = (pmTool.Upgrade_Modeling__c == 1 && pmTool.Upgrade_Modeling_SDT__c == null) ?  Date.today() : pmTool.Upgrade_Modeling_SDT__c;
                    pmTool.Upgrade_Modeling_EDT__c = (pmTool.Upgrade_Modeling__c == 2 && pmTool.Upgrade_Modeling_EDT__c == null) ?  Date.today() : pmTool.Upgrade_Modeling_EDT__c;
                }*/
        
                // update R_P_Install_SDT__c start & End date fields
                if(pmTool.R_P_Install_NA_Override__c){
                    pmTool.R_P_Install_SDT__c = Null;
                    //pmTool.R_P_Install_EDT__c = Null;
                }
                /*else{
                    pmTool.R_P_Install_SDT__c = (pmTool.R_P_Install__c == 1 && pmTool.R_P_Install_SDT__c == null) ?  Date.today() : pmTool.R_P_Install_SDT__c;
                    pmTool.R_P_Install_EDT__c = (pmTool.R_P_Install__c == 2 && pmTool.R_P_Install_EDT__c == null) ?  Date.today() : pmTool.R_P_Install_EDT__c;
                }*/
        
                // update Electrical_Install__c start & End date fields
                if(pmTool.Electrical_Install_NA_Override__c){
                    pmTool.Electrical_Install_SDT__c = Null;
                    //pmTool.Electrical_Install_EDT__c = Null;
                }
                /*else{
                    pmTool.Electrical_Install_SDT__c = (pmTool.Electrical_Install__c == 1 && pmTool.Electrical_Install_SDT__c == null) ?  Date.today() : pmTool.Electrical_Install_SDT__c;
                    pmTool.Electrical_Install_EDT__c = (pmTool.Electrical_Install__c == 2 && pmTool.Electrical_Install_EDT__c == null) ?  Date.today() : pmTool.Electrical_Install_EDT__c;
                }*/
        
                // update Electrical_Install__c start & End date fields
                if(pmTool.Energy_Upgrade_NA_Override__c){
                    pmTool.Energy_Upgrade_SDT__c = Null;
                    //pmTool.Energy_Upgrade_EDT__c = Null;
                }
                /*else{
                    pmTool.Energy_Upgrade_SDT__c = (pmTool.Energy_Upgrade__c == 1 && pmTool.Energy_Upgrade_SDT__c == null) ?  Date.today() : pmTool.Energy_Upgrade_SDT__c;
                    pmTool.Energy_Upgrade_EDT__c = (pmTool.Energy_Upgrade__c == 2 && pmTool.Energy_Upgrade_EDT__c == null) ?  Date.today() : pmTool.Energy_Upgrade_EDT__c;
                }*/
        
                // update Quality_Control_SDT__c start & End date fields
                if(pmTool.Quality_Control_NA_Override__c){
                    pmTool.Quality_Control_SDT__c = Null;
                    //pmTool.Quality_Control_EDT__c = Null;
                }
                /*else{
                    pmTool.Quality_Control_SDT__c = (pmTool.Quality_Control__c == 1 && pmTool.Quality_Control_SDT__c == null) ?  Date.today() : pmTool.Quality_Control_SDT__c;
                    pmTool.Quality_Control_EDT__c = (pmTool.Quality_Control__c == 2 && pmTool.Quality_Control_EDT__c == null) ?  Date.today() : pmTool.Quality_Control_EDT__c;
                }*/
               
                // update M1_ITC_Funding_SDT__c start & End date fields
                if(pmTool.M1_ITC_Funding_NA_Override__c){
                    pmTool.M1_ITC_Funding_SDT__c = Null;
                    //pmTool.M1_ITC_Funding_EDT__c = Null;
                }
                /*else{
                    pmTool.M1_ITC_Funding_SDT__c = (pmTool.M1_ITC_Funding__c == 1 && pmTool.M1_ITC_Funding_SDT__c == null) ?  Date.today() : pmTool.M1_ITC_Funding_SDT__c;
                    pmTool.M1_ITC_Funding_EDT__c = (pmTool.M1_ITC_Funding__c == 2 && pmTool.M1_ITC_Funding_EDT__c == null) ?  Date.today() : pmTool.M1_ITC_Funding_EDT__c;
                }*/
                
                // update Municipal_Inspection_SDT__c start & End date fields
                if(pmTool.Municipal_Inspection_NA_Override__c){
                    pmTool.Municipal_Inspection_SDT__c = Null;
                    //pmTool.Municipal_Inspection_EDT__c = Null;
                }
                /*else{
                    pmTool.Municipal_Inspection_SDT__c = (pmTool.Municipal_Inspection__c == 1 && pmTool.Municipal_Inspection_SDT__c == null) ?  Date.today() : pmTool.Municipal_Inspection_SDT__c;
                    pmTool.Municipal_Inspection_EDT__c = (pmTool.Municipal_Inspection__c == 2 && pmTool.Municipal_Inspection_EDT__c == null) ?  Date.today() : pmTool.Municipal_Inspection_EDT__c;
                }*/
        
                // update M2__c start & End date fields
                if(pmTool.M2_NA_Override__c){
                    pmTool.M2_SDT__c = Null;
                    //pmTool.M2_EDT__c = Null;
                }
                /*else{
                    pmTool.M2_SDT__c = (pmTool.M2__c == 1 && pmTool.M2_SDT__c == null) ?  Date.today() : pmTool.M2_SDT__c;
                    pmTool.M2_EDT__c = (pmTool.M2__c == 2 && pmTool.M2_EDT__c == null) ?  Date.today() : pmTool.M2_EDT__c;
                }*/
        
                // update PTO_Final_Utility_Approval__c start & End date fields
                if(pmTool.PTO_Final_Utility_Approval_NA_Override__c){
                    pmTool.PTO_Final_Utility_Approval_SDT__c = Null;
                    //pmTool.PTO_Final_Utility_Approval_EDT__c = Null;
                }
                /*else{
                    pmTool.PTO_Final_Utility_Approval_SDT__c = (pmTool.PTO_Final_Utility_Approval__c == 1 && pmTool.PTO_Final_Utility_Approval_SDT__c == null) ?  Date.today() : pmTool.PTO_Final_Utility_Approval_SDT__c;
                    pmTool.PTO_Final_Utility_Approval_EDT__c = (pmTool.PTO_Final_Utility_Approval__c == 2 && pmTool.PTO_Final_Utility_Approval_EDT__c == null) ?  Date.today() : pmTool.PTO_Final_Utility_Approval_EDT__c;
                }*/
        
                // update M3__c start & End date fields
                if(pmTool.M3_NA_Override__c){
                    pmTool.M3_SDT__c = Null;
                    //pmTool.M3_EDT__c = Null;
                }
                /*else{
                    pmTool.M3_SDT__c = (pmTool.M3__c == 1 && pmTool.M3_SDT__c == null) ?  Date.today() : pmTool.M3_SDT__c;
                    pmTool.M3_EDT__c = (pmTool.M3__c == 2 && pmTool.M3_EDT__c == null) ?  Date.today() : pmTool.M3_EDT__c;
                }*/
                
                // update Activation__c start & End date fields
                if(pmTool.Activation_NA_Override__c){
                    pmTool.Activation_SDT__c = Null;
                    //pmTool.Activation_EDT__c = Null;
                }
                /*else{
                    pmTool.Activation_SDT__c = (pmTool.Activation__c == 1 && pmTool.Activation_SDT__c == null) ?  Date.today() : pmTool.Activation_SDT__c;
                    pmTool.Activation_EDT__c = (pmTool.Activation__c == 2 && pmTool.Activation_EDT__c == null) ?  Date.today() : pmTool.Activation_EDT__c;
                }*/
        
                // update EE_Audit__c start & End date fields
                if(pmTool.EE_Audit_NA_Override__c){
                    pmTool.EE_Audit_SDT__c = Null;
                    //pmTool.EE_Audit_EDT__c = Null;
                }
                /*else{
                    pmTool.EE_Audit_SDT__c = (pmTool.EE_Audit__c == 1 && pmTool.EE_Audit_SDT__c == null) ?  Date.today() : pmTool.EE_Audit_SDT__c;
                    pmTool.EE_Audit_EDT__c = (pmTool.EE_Audit__c == 2 && pmTool.EE_Audit_EDT__c == null) ?  Date.today() : pmTool.EE_Audit_EDT__c;
                }*/
        
                // update State_Final_Submission__c start & End date fields
                if(pmTool.State_Final_Submission_NA_Override__c){
                    pmTool.State_Final_Submission_SDT__c = Null;
                    //pmTool.State_Final_Submission_EDT__c = Null;
                }
                /*else{
                    pmTool.State_Final_Submission_SDT__c = (pmTool.State_Final_Submission__c == 1 && pmTool.State_Final_Submission_SDT__c == null) ?  Date.today() : pmTool.State_Final_Submission_SDT__c;
                    pmTool.State_Final_Submission_EDT__c = (pmTool.State_Final_Submission__c == 2 && pmTool.State_Final_Submission_EDT__c == null) ?  Date.today() : pmTool.State_Final_Submission_EDT__c;
                }*/
                
                // update Closing_Call__c start & End date fields
                if(pmTool.Closing_Call_NA_Override__c){
                    pmTool.Closing_Call_SDT__c = Null;
                    //pmTool.Closing_Call_EDT__c = Null;
                }
                
                
                pmToolList.add(pmTool);
            }
            
            update pmToolList;
            PMTool.updateCompletionPercentage(pmToolSet);
        }
    }
}