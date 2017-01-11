@isTest
public class TestFormulaBuilder { 
    static testMethod void myUnitTest1() { 
        Business_Market__c bm = new Business_Market__c(name='CT');
        insert bm;
        
        Business_Status__c busStatus = new Business_Status__c(name='Complete',score__c=3);
        insert busStatus;
        
        PMToolV2.runStepTrigger = true;
        
        Business_Stage__c bs = new Business_Stage__c(Name='Feasibility', Business_Market__c = bm.id, Display_In_Tracker__c=true, Formula__c='if(pmtool.feasibility_completed_date__c != null && pmtool.feasibility_project_status__c == \'completed\' && stage.PM_Review__c == true){result = 4;}else if((pmtool.feasibility_completed_date__c != null && pmtool.feasibility_project_status__c == \'completed\' && pmtool.layout_approval_required__c == true && pmtool.layout_appr_rec_date__c != null) || (pmtool.feasibility_completed_date__c != null && pmtool.feasibility_project_status__c == \'completed\' && pmtool.layout_approval_required__c == false)){result = 3;}else if(pmtool.assessment_req_date__c != null){result = 2;}else if(pmStage.Intro Call-CT == 4){result = 1;}else{result = 0;}');
        insert bs;
        
        Business_Installation_Step__c bis = new Business_Installation_Step__c();
        bis.name = 'Assessment';
        bis.formula__c = 'if(pmtool.assessment_comp_date__c != null){result = 3;}else if(pmtool.assessment_req_date__c != null){result = 2;}else if(pmStage.Intro Call-CT == 4){result = 1;}else{result = 0;}';
        bis.Business_Stage__c = bs.id;
        insert bis;
        
        Exception_Threshold__c ex = new Exception_Threshold__c();
        ex.In_Process_Threshold__c = 2; 
        ex.PM_Review_Threshold__c = 3;
        ex.Business_Installation_Step__c = bis.id;
        insert ex;
        
        PM_Steps__c pms = new PM_Steps__c();
        pms.Aging__c = 1;
        pms.Business_Installation_Step__c = bis.id;
        pms.End_Date__c = null; 
        pms.In_Process_Aging__c = 2; 
        pms.In_Process_Aging_Exception__c = false; 
        pms.In_Process_End_Date__c = null; 
        pms.In_Process_Start_Date__c = null; 
        pms.NA_Override__c = false; 
        pms.PM_Review_Aging__c = 3; 
        pms.PM_Review_Aging_Exception__c = true; 
        pms.PM_Review_End_Date__c = null; 
        pms.PM_Review_Start_Date__c = null;
        pms.Start_Date__c = null;
        insert pms;
        
        FormulaBuilder formBuild = new FormulaBuilder();
        formBuild.selectedMarket = bm.id;
        
        formBuild.selectedStage = bs.id;
        formBuild.formulaString = '{"formula":[{"condition":"AND","rules":[{"id":"a56R00000004g2aIAA","field":"a56R00000004g2aIAA","type":"string","input":"text","operator":"equal","value":"4"}],"score":"1"},{"condition":"AND","rules":[{"id":"assessment_req_date__c","field":"assessment_req_date__c","type":"date","input":"text","operator":"is_not_null","value":null}],"score":"2"},{"condition":"AND","rules":[{"id":"feasibility_completed_date__c","field":"feasibility_completed_date__c","type":"date","input":"text","operator":"is_not_null","value":null},{"id":"feasibility_project_status__c","field":"feasibility_project_status__c","type":"string","input":"text","operator":"equal","value":"completed"},{"id":"PM_Review__c","field":"PM_Review__c","type":"boolean","input":"text","operator":"equal","value":"true"}],"score":"4"},{"condition":"OR","rules":[{"condition":"AND","rules":[{"id":"feasibility_completed_date__c","field":"feasibility_completed_date__c","type":"date","input":"text","operator":"is_not_null","value":null},{"id":"feasibility_project_status__c","field":"feasibility_project_status__c","type":"string","input":"text","operator":"equal","value":"completed"},{"id":"layout_approval_required__c","field":"layout_approval_required__c","type":"boolean","input":"text","operator":"equal","value":"true"},{"id":"layout_appr_rec_date__c","field":"layout_appr_rec_date__c","type":"date","input":"text","operator":"is_not_null","value":null}]},{"condition":"AND","rules":[{"id":"feasibility_completed_date__c","field":"feasibility_completed_date__c","type":"date","input":"text","operator":"is_not_null","value":null},{"id":"feasibility_project_status__c","field":"feasibility_project_status__c","type":"string","input":"text","operator":"equal","value":"completed"},{"id":"layout_approval_required__c","field":"layout_approval_required__c","type":"boolean","input":"text","operator":"equal","value":"false"}]}],"score":"3"}]}';
        
        formBuild.saveFormulaForStage();
        
        formBuild.formulaString = '{"formula":[{"condition":"AND","rules":[{"id":"a56R00000004g2aIAA","field":"a56R00000004g2aIAA","type":"string","input":"text","operator":"equal","value":"4"}],"score":"1"},{"condition":"AND","rules":[{"id":"assessment_req_date__c","field":"assessment_req_date__c","type":"date","input":"text","operator":"is_not_null","value":null}],"score":"2"},{"condition":"AND","rules":[{"id":"assessment_comp_date__c","field":"assessment_comp_date__c","type":"date","input":"text","operator":"is_not_null","value":null}],"score":"3"}]}';
        formBuild.selectedStep = bis.id;
        formBuild.saveFormulaForStep();
    }
    
    static testMethod void myUnitTest2() { 
        Business_Market__c bm = new Business_Market__c(name='CT');
        insert bm;
        
        Business_Status__c busStatus = new Business_Status__c(name='Complete',score__c=3);
        insert busStatus;
        
        PMToolV2.runStepTrigger = true;
        
        Business_Stage__c bs = new Business_Stage__c(Name='Closing Call', Business_Market__c = bm.id, Display_In_Tracker__c=true, Formula__c='if(pmtool.closing_call__c == true && stage.PM_Review__c == true){result = 4;}else if(pmtool.closing_call__c == true){result = 3;}else if(pmtool.first_closing_call_made__c == true){result = 2;}else if((pmStage.Awaiting Activation/PTO-CT == 4 && pmtool.ee_accepted__c == true && pmStage.EE-CT == 4) || (pmStage.Awaiting Activation/PTO-CT == 4 && pmtool.ee_accepted__c == false)){result = 1;}else{result = 0;}');
        insert bs;
        
        Business_Installation_Step__c bis = new Business_Installation_Step__c();
        bis.name = 'Closing Call';
        bis.formula__c = 'if(pmtool.closing_call__c == true){result = 3;}else if(pmtool.first_closing_call_made__c == true){result = 2;}else if((pmStage.Awaiting Activation/PTO-CT == 4 && pmtool.ee_accepted__c == true && pmStage.EE-CT == 4) || (pmStage.Awaiting Activation/PTO-CT == 4 && pmtool.ee_accepted__c == false)){result = 1;}else{result = 0;}';
        bis.Business_Stage__c = bs.id;
        insert bis;
        
        Exception_Threshold__c ex = new Exception_Threshold__c();
        ex.In_Process_Threshold__c = 2; 
        ex.PM_Review_Threshold__c = 3;
        ex.Business_Installation_Step__c = bis.id;
        insert ex;
        
        PM_Steps__c pms = new PM_Steps__c();
        pms.Aging__c = 1;
        pms.Business_Installation_Step__c = bis.id;
        pms.End_Date__c = null; 
        pms.In_Process_Aging__c = 2; 
        pms.In_Process_Aging_Exception__c = false; 
        pms.In_Process_End_Date__c = null; 
        pms.In_Process_Start_Date__c = null; 
        pms.NA_Override__c = false; 
        pms.PM_Review_Aging__c = 3; 
        pms.PM_Review_Aging_Exception__c = true; 
        pms.PM_Review_End_Date__c = null; 
        pms.PM_Review_Start_Date__c = null;
        pms.Start_Date__c = null;
        insert pms;
        
        FormulaBuilder formBuild = new FormulaBuilder();
        formBuild.selectedMarket = bm.id;
        
        formBuild.selectedStage = bs.id;
        formBuild.formulaString = '[{"condition":"OR","rules":[{"condition":"AND","rules":[{"id":"a56R00000004g2bIAA","field":"a56R00000004g2bIAA","type":"string","input":"text","operator":"equal","value":"4"},{"id":"ee_accepted__c","field":"ee_accepted__c","type":"boolean","input":"text","operator":"equal","value":"true"},{"id":"a56R00000004g2XIAQ","field":"a56R00000004g2XIAQ","type":"string","input":"text","operator":"equal","value":"4"}]},{"condition":"AND","rules":[{"id":"a56R00000004g2bIAA","field":"a56R00000004g2bIAA","type":"string","input":"text","operator":"equal","value":"4"},{"id":"ee_accepted__c","field":"ee_accepted__c","type":"boolean","input":"text","operator":"equal","value":"false"}]}],"score":"1"},{"condition":"AND","rules":[{"id":"closing_call__c","field":"closing_call__c","type":"boolean","input":"text","operator":"equal","value":"true"},{"id":"PM_Review__c","field":"PM_Review__c","type":"boolean","input":"text","operator":"equal","value":"true"}],"score":"4"},{"condition":"AND","rules":[{"id":"closing_call__c","field":"closing_call__c","type":"boolean","input":"text","operator":"equal","value":"true"}],"score":"3"},{"condition":"AND","rules":[{"id":"first_closing_call_made__c","field":"first_closing_call_made__c","type":"boolean","input":"text","operator":"equal","value":"true"}],"score":"2"}]';
        
        formBuild.saveFormulaForStage();
        
        formBuild.formulaString = '[{"condition":"AND","rules":[{"id":"first_closing_call_made__c","field":"first_closing_call_made__c","type":"boolean","input":"text","operator":"equal","value":"true"}],"score":"2"},{"condition":"AND","rules":[{"id":"closing_call__c","field":"closing_call__c","type":"boolean","input":"text","operator":"equal","value":"true"}],"score":"3"},{"condition":"OR","rules":[{"condition":"AND","rules":[{"id":"a56R00000004g2bIAA","field":"a56R00000004g2bIAA","type":"string","input":"text","operator":"equal","value":"4"},{"id":"ee_accepted__c","field":"ee_accepted__c","type":"boolean","input":"text","operator":"equal","value":"true"},{"id":"a56R00000004g2XIAQ","field":"a56R00000004g2XIAQ","type":"string","input":"text","operator":"equal","value":"4"}]},{"condition":"AND","rules":[{"id":"a56R00000004g2bIAA","field":"a56R00000004g2bIAA","type":"string","input":"text","operator":"equal","value":"4"},{"id":"ee_accepted__c","field":"ee_accepted__c","type":"boolean","input":"text","operator":"equal","value":"false"}]}],"score":"1"}]';
        formBuild.selectedStep = bis.id;
        formBuild.saveFormulaForStep();
    }
    
    static testMethod void myUnitTest3() { 
        Business_Market__c bm = new Business_Market__c(name='CT');
        insert bm;
        
        Business_Status__c busStatus = new Business_Status__c(name='Complete',score__c=3);
        insert busStatus;
        
        PMToolV2.runStepTrigger = true;
        
        Business_Stage__c bs = new Business_Stage__c(Name='Feasibility', Business_Market__c = bm.id, Display_In_Tracker__c=true, Formula__c='if(pmtool.feasibility_completed_date__c != null && pmtool.feasibility_project_status__c == \'completed\' && stage.PM_Review__c == true){result = 4;}else if((pmtool.feasibility_completed_date__c != null && pmtool.feasibility_project_status__c == \'completed\' && pmtool.layout_approval_required__c == true && pmtool.layout_appr_rec_date__c != null) || (pmtool.feasibility_completed_date__c != null && pmtool.feasibility_project_status__c == \'completed\' && pmtool.layout_approval_required__c == false)){result = 3;}else if(pmtool.assessment_req_date__c != null){result = 2;}else if(pmStage.Intro Call-CT == 4){result = 1;}else{result = 0;}');
        insert bs;
        
        Business_Installation_Step__c bis = new Business_Installation_Step__c();
        bis.name = 'Assessment';
        bis.formula__c = 'if(pmtool.assessment_comp_date__c != null){result = 3;}else if(pmtool.assessment_req_date__c != null){result = 2;}else if(pmStage.Intro Call-CT == 4){result = 1;}else{result = 0;}';
        bis.Business_Stage__c = bs.id;
        insert bis;
        
        Exception_Threshold__c ex = new Exception_Threshold__c();
        ex.In_Process_Threshold__c = 2; 
        ex.PM_Review_Threshold__c = 3;
        ex.Business_Installation_Step__c = bis.id;
        insert ex;
        
        PM_Steps__c pms = new PM_Steps__c();
        pms.Aging__c = 1;
        pms.Business_Installation_Step__c = bis.id;
        pms.End_Date__c = null; 
        pms.In_Process_Aging__c = 2; 
        pms.In_Process_Aging_Exception__c = false; 
        pms.In_Process_End_Date__c = null; 
        pms.In_Process_Start_Date__c = null; 
        pms.NA_Override__c = false; 
        pms.PM_Review_Aging__c = 3; 
        pms.PM_Review_Aging_Exception__c = true; 
        pms.PM_Review_End_Date__c = null; 
        pms.PM_Review_Start_Date__c = null;
        pms.Start_Date__c = null;
        insert pms;
        
        FormulaBuilder formBuild = new FormulaBuilder();
        formBuild.selectedMarket = bm.id;
        formBuild.filterDataJson = 'test';
        
        formBuild.selectedStage = bs.id;
        formBuild.formulaString = '[{"condition":"AND","rules":[{"id":"a56R00000004g2aIAA","field":"a56R00000004g2aIAA","type":"string","input":"text","operator":"equal","value":"4"}],"score":"1"},{"condition":"AND","rules":[{"id":"assessment_req_date__c","field":"assessment_req_date__c","type":"date","input":"text","operator":"is_not_null","value":null}],"score":"2"},{"condition":"AND","rules":[{"id":"feasibility_completed_date__c","field":"feasibility_completed_date__c","type":"date","input":"text","operator":"is_not_null","value":null},{"id":"feasibility_project_status__c","field":"feasibility_project_status__c","type":"string","input":"text","operator":"equal","value":"completed"},{"id":"PM_Review__c","field":"PM_Review__c","type":"boolean","input":"text","operator":"equal","value":"true"}],"score":"4"},{"condition":"OR","rules":[{"condition":"AND","rules":[{"id":"feasibility_completed_date__c","field":"feasibility_completed_date__c","type":"date","input":"text","operator":"is_not_null","value":null},{"id":"feasibility_project_status__c","field":"feasibility_project_status__c","type":"string","input":"text","operator":"equal","value":"completed"},{"id":"layout_approval_required__c","field":"layout_approval_required__c","type":"boolean","input":"text","operator":"equal","value":"true"},{"id":"layout_appr_rec_date__c","field":"layout_appr_rec_date__c","type":"date","input":"text","operator":"is_not_null","value":null}]},{"condition":"AND","rules":[{"id":"feasibility_completed_date__c","field":"feasibility_completed_date__c","type":"date","input":"text","operator":"is_not_null","value":null},{"id":"feasibility_project_status__c","field":"feasibility_project_status__c","type":"string","input":"text","operator":"equal","value":"completed"},{"id":"layout_approval_required__c","field":"layout_approval_required__c","type":"boolean","input":"text","operator":"equal","value":"false"}]}],"score":"3"}]';
        
        formBuild.saveFormulaForStage();
        
        formBuild.formulaString = '[{"condition":"AND","rules":[{"id":"a56R00000004g2aIAA","field":"a56R00000004g2aIAA","type":"string","input":"text","operator":"equal","value":"4"}],"score":"1"},{"condition":"AND","rules":[{"id":"assessment_req_date__c","field":"assessment_req_date__c","type":"date","input":"text","operator":"is_not_null","value":null}],"score":"2"},{"condition":"AND","rules":[{"id":"assessment_comp_date__c","field":"assessment_comp_date__c","type":"date","input":"text","operator":"is_not_null","value":null}],"score":"3"}]';
        formBuild.selectedStep = bis.id;
        formBuild.saveFormulaForStep();
    }
    
    static testMethod void myUnitTest4() { 
        Business_Market__c bm = new Business_Market__c(name='CT');
        insert bm;
        
        Business_Status__c busStatus = new Business_Status__c(name='Complete',score__c=3);
        insert busStatus;
        
        PMToolV2.runStepTrigger = true;
        
        Business_Stage__c bs = new Business_Stage__c(Name='Closing Call', Business_Market__c = bm.id, Display_In_Tracker__c=true, Formula__c='if(pmtool.closing_call__c == true && stage.PM_Review__c == true){result = 4;}else if(pmtool.closing_call__c == true){result = 3;}else if(pmtool.first_closing_call_made__c == true){result = 2;}else if((pmStage.Awaiting Activation/PTO-CT == 4 && pmtool.ee_accepted__c == true && pmStage.EE-CT == 4) || (pmStage.Awaiting Activation/PTO-CT == 4 && pmtool.ee_accepted__c == false)){result = 1;}else{result = 0;}');
        insert bs;
        
        Business_Installation_Step__c bis = new Business_Installation_Step__c();
        bis.name = 'Closing Call';
        bis.formula__c = 'if(pmtool.closing_call__c == true){result = 3;}else if(pmtool.first_closing_call_made__c == true){result = 2;}else if((pmStage.Awaiting Activation/PTO-CT == 4 && pmtool.ee_accepted__c == true && pmStage.EE-CT == 4) || (pmStage.Awaiting Activation/PTO-CT == 4 && pmtool.ee_accepted__c == false)){result = 1;}else{result = 0;}';
        bis.Business_Stage__c = bs.id;
        insert bis;
        
        Exception_Threshold__c ex = new Exception_Threshold__c();
        ex.In_Process_Threshold__c = 2; 
        ex.PM_Review_Threshold__c = 3;
        ex.Business_Installation_Step__c = bis.id;
        insert ex;
        
        PM_Steps__c pms = new PM_Steps__c();
        pms.Aging__c = 1;
        pms.Business_Installation_Step__c = bis.id;
        pms.End_Date__c = null; 
        pms.In_Process_Aging__c = 2; 
        pms.In_Process_Aging_Exception__c = false; 
        pms.In_Process_End_Date__c = null; 
        pms.In_Process_Start_Date__c = null; 
        pms.NA_Override__c = false; 
        pms.PM_Review_Aging__c = 3; 
        pms.PM_Review_Aging_Exception__c = true; 
        pms.PM_Review_End_Date__c = null; 
        pms.PM_Review_Start_Date__c = null;
        pms.Start_Date__c = null;
        insert pms;
        
        FormulaBuilder formBuild = new FormulaBuilder();
        formBuild.selectedMarket = bm.id;
        
        formBuild.selectedStage = bs.id;
        formBuild.formulaString = '[{"condition":"OR","rules":[{"condition":"AND","rules":[{"id":"a56R00000004g2bIAA","field":"a56R00000004g2bIAA","type":"string","input":"text","operator":"equal","value":"4"},{"id":"ee_accepted__c","field":"ee_accepted__c","type":"boolean","input":"text","operator":"equal","value":"true"},{"id":"a56R00000004g2XIAQ","field":"a56R00000004g2XIAQ","type":"string","input":"text","operator":"equal","value":"4"}]},{"condition":"AND","rules":[{"id":"a56R00000004g2bIAA","field":"a56R00000004g2bIAA","type":"string","input":"text","operator":"equal","value":"4"},{"id":"ee_accepted__c","field":"ee_accepted__c","type":"boolean","input":"text","operator":"equal","value":"false"}]}],"score":"1"},{"condition":"AND","rules":[{"id":"closing_call__c","field":"closing_call__c","type":"boolean","input":"text","operator":"equal","value":"true"},{"id":"PM_Review__c","field":"PM_Review__c","type":"boolean","input":"text","operator":"equal","value":"true"}],"score":"4"},{"condition":"AND","rules":[{"id":"closing_call__c","field":"closing_call__c","type":"boolean","input":"text","operator":"equal","value":"true"}],"score":"3"},{"condition":"AND","rules":[{"id":"first_closing_call_made__c","field":"first_closing_call_made__c","type":"boolean","input":"text","operator":"equal","value":"true"}],"score":"2"}]';
        
        formBuild.formulaString = '[{"condition":"AND","rules":[{"id":"a56R00000004g2aIAA","field":"a56R00000004g2aIAA","type":"string","input":"text","operator":"equal","value":"4"}],"score":"1"},{"condition":"AND","rules":[{"id":"assessment_req_date__c","field":"assessment_req_date__c","type":"date","input":"text","operator":"is_not_null","value":null}],"score":"2"},{"condition":"AND","rules":[{"id":"assessment_comp_date__c","field":"assessment_comp_date__c","type":"date","input":"text","operator":"is_not_null","value":null}],"score":"3"}]';
        formBuild.selectedStep = bis.id;
        formBuild.saveFormulaForStep();
        
        formBuild.calculateSubstring('if(pmtool.closing_call__c == true){result = 3;}else if(pmtool.first_closing_call_made__c == true){result = 2;}else if((pmStage.Awaiting Activation/PTO-CT == 4 && pmtool.ee_accepted__c == true && pmStage.EE-CT == 4) || (pmStage.Awaiting Activation/PTO-CT == 4 && pmtool.ee_accepted__c == false)){result = 1;}else{result = 0;}', 1, 'AND');
        formBuild.getBusinessStages();
        formBuild.getBusinessSteps();
        formBuild.getMainFilter();
        formBuild.getBasicRulesForStep();
        formBuild.getBasicRulesForStage();
        formBuild.populateSelectedMarketForStage();
        formBuild.populateSelectedMarketForStep();
        formBuild.getPmToolFilterData();
    }
    
}