/*
*  This is the controller for the visualforce page PMTool
*/
public without sharing class PMToolV2{

    //public variables
    public static integer fresult;
    public List<BusinessStageWrapper> businessInstallationStepList{get;set;}
    public String selectedMarket{get;set;}
    public Decimal averageCompletion {get;set;}
    public Integer activeProjects{get;set;}
    public String selectedProjectManager{get;set;}
    public String customerId{get;set;} public List<PMWrapper> lstPMWrapper{get;set;}  public List<SelectOption> projectManagerList{get;set;}
    public Boolean stateChanged{get;set;}
    public List<SelectOption> filterStepList{get;set;}
    public List<Business_Installation_Step__c> bisFilterList{get;set;}
    public List<Business_Status__c> bStatusFilterList{get;set;} public String filterText{get;set;} public String filterConditions{get;set;}
    public List<String> temList{get;set;}
    public static Boolean updateStagesFirstRun = true;
    public Static Set<String> naOverrideLA;
    public Static Set<String> naOverrideCT;
    public Static Boolean runStepTrigger = true;
    public Static Boolean insertStageFirstRun = true;
    
    public Static Map<String, Integer> globalFrMap;
    //class constructor
    public PMToolV2(){
    
       try{
           selectedMarket = '';
           averageCompletion = 0;
           activeProjects = 0;
           customerId = '';
           stateChanged = false;
           selectedProjectManager = '';
           businessInstallationStepList = new List<BusinessStageWrapper>();
           filterStepList = new List<SelectOption>();
           bisFilterList = new List<Business_Installation_Step__c>();
           bStatusFilterList = new List<Business_Status__c>();
           temList = new List<String>();
           temList.add('1');
           for(Business_Status__c bStatus: [select id, name, score__c from Business_Status__c]){
               bStatusFilterList.add(bStatus);
           }

       }
       catch(Exception e){
           system.debug('PMTool v2 Error : '+e.getMessage()+' '+e.getStackTraceString());
       }
    }
    
    public static void insertPMRecord(Set<Id> oppSet){
        system.debug('--------------insertPMRecord-----------------');
        
        try{
            List<PM_Tool_V2__c> pmToolList = new List<PM_Tool_V2__c >();
            Map<Id, Map<String, Project__c>> projectMap = new Map<Id, Map<String, Project__c>>();
            
            for(Project__c prj: [select id, Opportunity__c, RecordType.Name, createddate from Project__c where Opportunity__c in:OppSet]){
                if(!projectMap.containsKey(prj.Opportunity__c)){
                    projectMap.put(prj.Opportunity__c, new Map<String, Project__c>());
                }
                
                if(projectMap.get(prj.Opportunity__c).containsKey(prj.RecordType.Name)){
                    if(projectMap.get(prj.Opportunity__c).get(prj.RecordType.Name).createddate < prj.createddate){
                        projectMap.get(prj.Opportunity__c).remove(prj.RecordType.Name);
                    }
                }
                projectMap.get(prj.Opportunity__c).put(prj.RecordType.Name, prj);
            }
            
            for(Opportunity opp : [select id, RecordType.Name, Opp_Numeric_ID__c, Property__r.State__c, Property__r.AssessorOwnerName1__c from Opportunity where id in:OppSet]){
                PM_Tool_V2__c pmTool = new PM_Tool_V2__c();
                pmTool.Opportunity__c = opp.id;
                
                if(opp.Property__c != null && opp.Property__r.AssessorOwnerName1__c != null){
                    pmTool.Name = opp.Opp_Numeric_ID__c +' - '+ opp.Property__r.AssessorOwnerName1__c;
                }
                else{
                    pmTool.Name = opp.Opp_Numeric_ID__c;
                }
                
                pmTool.Lease_Type__c = opp.RecordType.Name;
                if(projectMap != null && projectMap.get(opp.Id) != null){
                    if(projectMap.get(opp.Id).containsKey('PV Install')){
                        pmTool.Project_PV_Install__c = projectMap.get(opp.Id).get('PV Install').Id;
                    }
                    
                    if(projectMap.get(opp.Id).containsKey('EE Assessment')){
                        pmTool.Project_EE_Assessment__c = projectMap.get(opp.Id).get('EE Assessment').Id;
                    }
                    
                    if(projectMap.get(opp.Id).containsKey('EE Upgrade')){
                        pmTool.Project_EE_Upgrade__c = projectMap.get(opp.Id).get('EE Upgrade').Id;
                    }
                    
                    if(projectMap.get(opp.Id).containsKey('PV Feasibility')){
                        pmTool.Project_PV_Feasibility__c = projectMap.get(opp.Id).get('PV Feasibility').Id;
                    }
                    
                    if(projectMap.get(opp.Id).containsKey('PV Removal')){
                        pmTool.Project_PV_Removal__c = projectMap.get(opp.Id).get('PV Removal').Id;
                    }
                }
    
                pmToolList.add(pmTool);
            }
            
            
            insert pmToolList;
            
            Set<Id> oppSetPmTool = new Set<Id>();
            for ( PM_Tool_V2__c pmtool : pmToolList) {
                oppSetPmTool.add(pmtool.Opportunity__c);
            }
            
            if(insertStageFirstRun){
                insertStageFirstRun = false;
                
                
                insertStages(oppSetPmTool,UserInfo.getSessionId());
                insertStageFirstRun = false;
            }

        }    
        catch(Exception e){
           
           system.debug('PMTool v2 Error : '+e.getMessage()+' '+e.getStackTraceString());
        } 
    }
    
    public static void updatePMRecordFromProject(Set<Id> oppSet){
    
        try{
            List<PM_Tool_V2__c> pmToolList = new List<PM_Tool_V2__c >();
            Map<Id, Map<String, Project__c>> projectMap = new Map<Id, Map<String, Project__c>>();
            
            for(Project__c prj: [select id, Opportunity__c, RecordType.Name, createddate from Project__c where Opportunity__c in:OppSet]){
                if(!projectMap.containsKey(prj.Opportunity__c)){
                    projectMap.put(prj.Opportunity__c, new Map<String, Project__c>());
                }
                
                if(projectMap.get(prj.Opportunity__c).containsKey(prj.RecordType.Name)){ if(projectMap.get(prj.Opportunity__c).get(prj.RecordType.Name).createddate < prj.createddate){ projectMap.get(prj.Opportunity__c).remove(prj.RecordType.Name);}
                }
                projectMap.get(prj.Opportunity__c).put(prj.RecordType.Name, prj);
            }
            
            for(PM_Tool_V2__c pmTool : [select id, Opportunity__c, Opportunity__r.Opp_Numeric_ID__c, Opportunity__r.Property__r.State__c, Opportunity__r.Property__r.AssessorOwnerName1__c, Project_PV_Install__c,
            Project_EE_Assessment__c, Project_EE_Upgrade__c, Project_PV_Feasibility__c, Project_PV_Removal__c from PM_Tool_V2__c where Opportunity__c in:oppSet]){
                
                if(projectMap != null && projectMap.get(pmTool.Opportunity__c) != null){
                    if(projectMap.get(pmTool.Opportunity__c).containsKey('PV Install')){
                        pmTool.Project_PV_Install__c = projectMap.get(pmTool.Opportunity__c).get('PV Install').Id;
                    }
                    
                    if(projectMap.get(pmTool.Opportunity__c).containsKey('EE Assessment')){
                        pmTool.Project_EE_Assessment__c = projectMap.get(pmTool.Opportunity__c).get('EE Assessment').Id;
                    }
                    
                    if(projectMap.get(pmTool.Opportunity__c).containsKey('EE Upgrade')){
                        pmTool.Project_EE_Upgrade__c = projectMap.get(pmTool.Opportunity__c).get('EE Upgrade').Id;
                    }
                    
                    if(projectMap.get(pmTool.Opportunity__c).containsKey('PV Feasibility')){
                        pmTool.Project_PV_Feasibility__c = projectMap.get(pmTool.Opportunity__c).get('PV Feasibility').Id;
                    }
                    
                    if(projectMap.get(pmTool.Opportunity__c).containsKey('PV Removal')){
                        pmTool.Project_PV_Removal__c = projectMap.get(pmTool.Opportunity__c).get('PV Removal').Id;
                    }
                }
    
                pmToolList.add(pmTool);
            }
            
            update pmToolList;
            
            
            if(PMToolV2.updateStagesFirstRun){
                Set<Id> pmtoolSet = new Set<Id>();
                for ( PM_Tool_V2__c pmtool : pmToolList) {
                    updateStages(pmtool.id, UserInfo.getSessionId());
                }
                PMToolV2.updateStagesFirstRun = false;
            }

        }    
        catch(Exception e){
           
            system.debug('PMTool v2 Error : '+e.getMessage()+' '+e.getStackTraceString());
        } 
    }
    
    public static void updatePMRecordFromOpportunity(Set<Id> oppSet){

        try{
            List<PM_Tool_V2__c> pmToolList = new List<PM_Tool_V2__c>();
            for(PM_Tool_V2__c pm: [select id, Opportunity__r.Property__r.AssessorOwnerName1__c, Opportunity__r.Opp_Numeric_ID__c  from PM_Tool_V2__c where Opportunity__c in: oppSet]){
                
                if(pm.Opportunity__r.Property__c != null && pm.Opportunity__r.Property__r.AssessorOwnerName1__c != null){
                    pm.Name = pm.Opportunity__r.Opp_Numeric_ID__c +' - '+ pm.Opportunity__r.Property__r.AssessorOwnerName1__c;
                }
                else{
                    pm.Name = pm.Opportunity__r.Opp_Numeric_ID__c;
                }
                
                pmToolList.add(pm);
            }
            update pmToolList;
            
            if(PMToolV2.updateStagesFirstRun){
                
                for ( PM_Tool_V2__c pmtool : pmToolList) {
                    updateStages(pmtool.id, UserInfo.getSessionId());
                }
                PMToolV2.updateStagesFirstRun = false;
            }
            
        }
        catch(Exception e){
           system.debug('PMTool v2 Error : '+e.getMessage()+' '+e.getStackTraceString());

        } 
    }
    
    public static void updatePMRecordFromSalesOrder(Set<Id> oppSet, Map<Id,Id> salesOrderMap){

        try{
            List<PM_Tool_V2__c> pmToolList = new List<PM_Tool_V2__c>();
            for(PM_Tool_V2__c pmTool: [select id, Sales_order__c, Opportunity__c from PM_Tool_V2__c where Opportunity__c in: oppSet]){
                pmTool.Sales_order__c = salesOrderMap.get(pmTool.Opportunity__c);
                pmToolList.add(pmTool);
            }
            
            update pmToolList;
            
            if(PMToolV2.updateStagesFirstRun){
                
                for ( PM_Tool_V2__c pmtool : pmToolList) {
                    updateStages(pmtool.id, UserInfo.getSessionId());
                }
                PMToolV2.updateStagesFirstRun = false;
            }
        }
        catch(Exception e){
           system.debug('PMTool v2 Error : '+e.getMessage()+' '+e.getStackTraceString());

        } 
    }
    
    public static void insertStages(Set<Id> oppSet, String sessionId){
    
        for(PM_Tool_V2__c pmtool : [select id, Opportunity__r.Property__c from PM_Tool_V2__c where Opportunity__c in :oppSet]){
            
            PMToolV2.updateStagesFirstRun = false;
            system.debug('pmtool.Opportunity__r.Property__c='+pmtool.Opportunity__r.Property__c);
            if(pmtool.Opportunity__r.Property__c != null){
                insertStage(pmtool.id, sessionId);
            }
            PMToolV2.updateStagesFirstRun = false;
        }
        
    }
    
    @future(callout=true)
    public static void insertStage(Id pmtoolId, String sessionId){
  
        try{
        
            PMToolV2.updateStagesFirstRun = false;
            
            sessionId = ExplicitLogin.login();
                   
            Set<String> marketSet = new Set<String>();
            for(PM_Tool_V2__c pmtool : [select id, State__c from PM_Tool_V2__c where id = :pmtoolId]){
                marketSet.add(pmtool.State__c);
            }
            
            Map<String, List<Business_Stage__c>> bStageMap = new Map<String, List<Business_Stage__c>>();
            Set<String> businessStages = new Set<String>();
            for(Business_Stage__c bStage : [select id, Name,  Business_Market__r.Name, Formula__c from Business_Stage__c where Business_Market__r.Name in : marketSet order by Execution_sequence__c asc]){
                if(!bStageMap.containsKey(bStage.Business_Market__r.Name)){
                    bStageMap.put(bStage.Business_Market__r.Name, new List<Business_Stage__c>());
                }
                bStageMap.get(bStage.Business_Market__r.Name).add(bStage);
                
                businessStages.add(bstage.id);
            }
            
            Map<String, List<Business_Installation_Step__c>> bStepMap = new Map<String, List<Business_Installation_Step__c>>();
            for(Business_Installation_Step__c bStep : [select id, Name, Business_Stage__c, Business_Stage__r.Business_Market__r.Name, 
            Formula__c from Business_Installation_Step__c where Business_Stage__r.Business_Market__r.Name in : marketSet 
            and Business_Stage__c in: businessStages
            order by Execution_sequence__c asc]){
                
                if(!bStepMap.containsKey(bStep.Business_Stage__c)){
                    bStepMap.put(bStep.Business_Stage__c, new List<Business_Installation_Step__c>());
                }
                bStepMap.get(bStep.Business_Stage__c).add(bStep);
            }
            
            Map<Integer,id> bStatusMap = new Map<Integer,id>();
            Map<Integer,Business_Status__c> bStatusMapFormula = new Map<Integer,Business_Status__c>();
            for(Business_Status__c status : [select id, Score__c from Business_Status__c]){
                bStatusMap.put(Integer.valueOf(status.Score__c), status.id);
                
                bStatusMapFormula.put(Integer.valueOf(status.Score__c), status);
            }
            
            
            List<PM_Stage__c> pmStageList = new List<PM_Stage__c>();
            Map<String, Map<String,PM_Steps__c>> mapPMStep = new Map<String, Map<String,PM_Steps__c>>();
            Map<String, PM_Stage__c> pmStageRandomMap = new Map<String, PM_Stage__c>();
            Map<String, PM_Steps__c> pmStepRandomMap = new Map<String, PM_Steps__c>();
            Map<String, PM_Stage__c> pmsMap = new Map<String, PM_Stage__c>();

            
            globalFrMap = new Map<String, Integer>();
            Map<String, String> randomStageNameMap = new Map<String, String>();
            Map<String, String> randomStepNameMap = new Map<String, String>();
            for(PM_Tool_V2__c pmtool : [select id, HOA_Approval_Required__c, HDLC_Approval__c, Layout_Approval_Required__c, Opportunity__r.Property__c, Opportunity__r.Property__r.State__c from PM_Tool_V2__c 
            where id =: pmtoolId]){
                
                for(Business_Stage__c bStage : bStageMap.get(pmtool.Opportunity__r.Property__r.State__c)){
                    
                    String random_step_formula = generateRandomString(9);
                    String random_formula = generateRandomString(9);
                    String random = random_formula+'_'+bStage.Name;
                    
                    PM_Stage__c pmStage = new PM_Stage__c();
                    pmStage.Business_Installation_Stage__c = bStage.id;
                    pmStage.PM_Tool_V2__c = pmtool.id;
                    pmStage.PM_Review__c = false;
                    
                    PM_Stage__c previousStage = new PM_Stage__c();
                    previousStage.PM_Review__c = false;
                    
                    randomStageNameMap.put(bStage.Name, random_formula);
                    Set<Id> pmTSet = new Set<Id>();
                    pmTSet.add(pmtoolId);
                    
                    pmsMap.put(bStage.Name, pmStage);
                    
                    if(bStepMap.containsKey(bStage.id)){
                        for(Business_Installation_Step__c bStep : bStepMap.get(bStage.id)){
                            system.debug('step name='+bStep.Name);
                            String random_step = random_step_formula+'_'+bStep.Name;
                            
                            PM_Steps__c pmStep = new PM_Steps__c();
                            pmStep.PM_Tool_V2__c = pmtool.id;
                            pmStep.Business_Installation_Step__c = bStep.id;
                            pmStep.PM_Stage__c = null;
                            pmStep.NA_Override__c = false;
                            pmStep.Manual_Bypass__c = false;
                            pmStep.Business_Status__c = bStatusMapFormula.get(0).id;
                            
                            randomStepNameMap.put(bStep.Name, random_step);
                            pmStepRandomMap.put(random_step_formula+'_'+bStep.Name, pmStep);
                            
                            String pmStageForFormula_step = calculatePmStageStatus(pmtoolId,bStep.formula__c, bStatusMapFormula, randomStageNameMap, random_formula, pmsMap,'insert');
                            String pmStepForFormula = calculatePmStepStatus(pmtoolId,bStep.formula__c, bStatusMapFormula, randomStepNameMap, random_step_formula, pmStepRandomMap, 'insert');

                            
                            executeFormula(pmtool.id, pmStage, previousStage, pmStageForFormula_step, pmStep, pmStepForFormula, replaceFormulaString(bStep.Formula__c), random_step, sessionId);
                            pmStepRandomMap.put(random, pmStep);
                            
                            if (!mapPMStep.containskey(random_formula)) {
                                mapPMStep.put(random_formula, new Map<String,PM_Steps__c>());
                            }
                            mapPMStep.get(random_formula).put(random_step, pmStep);
                        }   
                    }
                    system.debug('stage name='+bStage.Name);
                    String pmStageForFormula = calculatePmStageStatus(pmtoolId,bStage.formula__c, bStatusMapFormula, randomStageNameMap, random_formula, pmsMap,'insert');
                    String pmStepForFormula_stage = calculatePmStepStatus(pmtoolId,bStage.formula__c, bStatusMapFormula, randomStepNameMap, random_step_formula, pmStepRandomMap, 'insert');
                    
                    executeFormula(pmtool.id, pmStage, previousStage, pmStageForFormula, null, pmStepForFormula_stage, replaceFormulaString(bStage.Formula__c), random_formula, sessionId);
                    
                    pmStageList.add(pmStage);  
                    pmStageRandomMap.put(random_formula, pmStage);             
                }
                
            }
            
            Map<String, Integer> frMap = new Map<String, Integer>();
            for(Formula_Result__c fr : [select id, Random_No__c,Result__c from Formula_Result__c where PM_Tool_V2__c =: pmtoolId]){
                system.debug('fr--------------fr.Random_No__c'+fr.Random_No__c+'--------fr.Result__c'+fr.Result__c);
                frMap.put(fr.Random_No__c, Integer.valueOf(fr.Result__c));
            }
            
            for(String ran : pmStageRandomMap.keySet()){
                system.debug('frMap--------'+frMap.get(ran));
                pmStageRandomMap.get(ran).Business_Status__c = bStatusMap.get(frMap.get(ran));
            }

            
            insert pmStageRandomMap.values();
            
            List<PM_Steps__c> pmStepList = new List<PM_Steps__c>();
            for (String ran : pmStageRandomMap.keyset()) {
                
                if(mapPMStep.containsKey(ran)){
                    for (String ran_step: mapPMStep.get(ran).keySet()) {
                        
                        system.debug('ran_step--------------'+ran_step);
                        Integer score = frMap.get(ran_step);
                        PM_Steps__c pmStep = mapPMStep.get(ran).get(ran_step);
                        pmStep.Business_Status__c = bStatusMap.get(score);
                        
                        if(score != -1){pmStep.NA_Override__c = false;}
                        
                        if(score == 0){ pmStep.PM_Review_Start_Date__c = null; }
                        else if(score == 1){
                        
                            if(pmStep.PM_Review_Start_Date__c == null){
                                pmStep.PM_Review_Start_Date__c = Date.today();
                            }
                            pmStep.PM_Review_End_Date__c = null;
                            
                            if(pmStep.Start_Date__c == null){
                                pmStep.Start_Date__c = Date.today();
                            }
                            pmStep.End_Date__c = null;
                            
                        }
                        else if(score == 2){
                        
                            if(pmStep.PM_Review_End_Date__c == null){
                                pmStep.PM_Review_End_Date__c = Date.today();
                            }
                            
                            if(pmStep.In_Process_Start_Date__c == null){
                                pmStep.In_Process_Start_Date__c = Date.today();
                            }
                            pmStep.In_Process_End_Date__c= null;
                            
                        }
                        else if(score == 3){
                        
                            if(pmStep.In_Process_End_Date__c == null){
                                pmStep.In_Process_End_Date__c= Date.today();
                            }
                            
                            if(pmStep.End_Date__c == null){
                                pmStep.End_Date__c= Date.today();
                            }
                        }
                        else if(score == -1){
                            pmStep.NA_Override__c = true;
                            pmStep.PM_Review_Start_Date__c = null;
                            pmStep.PM_Review_End_Date__c = null;
                            pmStep.In_Process_End_Date__c = null;
                            pmStep.In_Process_Start_Date__c = null;
                            pmStep.Start_Date__c = null;
                            pmStep.End_Date__c = null;
                        }
                        
                        if(pmStep.PM_Review_Start_Date__c != null && pmStep.PM_Review_End_Date__c == null){
                            pmStep.PM_Review_Aging__c =  pmStep.PM_Review_Start_Date__c.daysBetween(Date.Today());
                        }
                        else if(pmStep.PM_Review_Start_Date__c != null && pmStep.PM_Review_End_Date__c != null){
                            pmStep.PM_Review_Aging__c =  pmStep.PM_Review_Start_Date__c.daysBetween(pmStep.PM_Review_End_Date__c);
                        }
                        else{
                            pmStep.PM_Review_Aging__c = null;
                        }
                        
                        if(pmStep.In_Process_Start_Date__c != null && pmStep.In_Process_End_Date__c == null){pmStep.In_Process_Aging__c =  pmStep.In_Process_Start_Date__c.daysBetween(Date.Today());}
                        else if(pmStep.In_Process_Start_Date__c != null && pmStep.In_Process_End_Date__c!= null){pmStep.In_Process_Aging__c =  pmStep.In_Process_Start_Date__c.daysBetween(pmStep.In_Process_End_Date__c);}
                        else{
                            pmStep.In_Process_Aging__c = null;
                        }
                        
                        if(pmStep.Start_Date__c != null && pmStep.End_Date__c == null){pmStep.Aging__c =  pmStep.Start_Date__c.daysBetween(Date.Today());
                        }
                        else if(pmStep.Start_Date__c != null && pmStep.End_Date__c!= null){pmStep.Aging__c =  pmStep.Start_Date__c.daysBetween(pmStep.End_Date__c);
                        }
                        else{
                            pmStep.Aging__c = null;
                        }
                        
                       
                        
                        pmStep.PM_Stage__c = pmStageRandomMap.get(ran).id;
                        
                        pmStepList.add(pmStep);
                    }
                }
            }
            
            insert pmStepList;
            
            Set<Id> pmToolIds = new Set<Id>();
            pmToolIds.add(pmtoolId);
            
            calculateCompletionAverage(pmToolIds);
        }
        catch(Exception e){
            system.debug('PMTool v2 Error : '+e.getMessage()+' '+e.getStackTraceString());
        }
        
        finally {
            delete [select id from Formula_Result__c where PM_Tool_V2__c =:pmtoolId];
        }
    }
    
    public Static String replaceFormulaString(String formula){
    
        String original_formula = formula;
        
        if(formula != '' && formula != null && formula.contains('pmStep')){
            
            integer pos = formula.indexOf('pmStep');
            List<String> formulaSplitter = new List<String>();
            system.debug('pos ='+pos );
            while(pos != -1){
                
                String splitStr = formula.substring(pos,formula.indexOf(')', pos));

                if(splitStr.contains('&&')){
                    
                    List<String> andSplitterArr = new List<String>();
                    andSplitterArr = splitStr.split('&&');
                    system.debug('andSplitterArr =='+andSplitterArr );
                    for(String s: andSplitterArr){
                        formulaSplitter.add(s);
                    } 
                }
                else if(splitStr.contains('||')){
                    
                    
                    List<String> andSplitterArr = new List<String>();
                    andSplitterArr = splitStr.split('\\|\\|');
                    system.debug('andSplitterArr == &#124'+andSplitterArr );
                    for(String s: andSplitterArr){
                        formulaSplitter.add(s);
                    } 
                    
                }
                else{
                    formulaSplitter.add(splitStr);
                }
                
                
                system.debug('formulaSplitter='+formulaSplitter);
                formula = formula.substring(pos + splitStr.length(), formula.length());
                system.debug('formula ='+formula );
                pos = formula.indexOf('pmStep');
                system.debug('pos ='+pos );
            }
            for(String ss: formulaSplitter){
                system.debug('SS='+ss);
            }
            
            if(formulaSplitter.size() > 0){
                
                
                for(String sFormula : formulaSplitter){
                    
                    String[] fSplitted = sFormula.split('\\.');
                    system.debug('fSplitted ==='+fSplitted);
                    system.debug('fSplitted[0]****'+ fSplitted[0]);
                    system.debug('fSplitted****'+ fSplitted[0].equals('pmStep'));
                    if(fSplitted[0].trim().equals('pmStep')){
                        system.debug('irfan*******************');
                        String[] fSplittedStep = fSplitted[1].split('==');
                        system.debug('fSplittedStep *******************'+fSplittedStep);
                        String stepName = fSplittedStep[0].trim();
                        system.debug('stepName *******************'+stepName );
                        String original_stepName = stepName;
                        
                        stepName = stepName.replace(' ','_');
                        stepName = stepName.replace('-','_'); 
                        stepName = stepName.replace('/','_');
                        stepName = stepName.replace('&','_');
                        
                        original_formula = original_formula.replace('pmStep.'+original_stepName, 'pmStep'+stepName+'.Business_Status__r.Score__c');
                    }
                    
                }
            }
            
        }
        
        formula = original_formula;
        
        if(formula != '' && formula != null && formula.contains('pmStage')){
        
            integer pos = formula.indexOf('pmStage');
            List<String> formulaSplitter = new List<String>();
            system.debug('pos ='+pos );
            while(pos != -1){
                
                String splitStr = formula.substring(pos,formula.indexOf(')', pos));
                
                if(splitStr.contains('&&')){
                    List<String> andSplitterArr = new List<String>();
                    andSplitterArr = splitStr.split('&&');
                    for(String s: andSplitterArr){
                        formulaSplitter.add(s);
                    } 
                    
                }
                else if(splitStr.contains('||')){
                
                    
                    List<String> andSplitterArr = new List<String>();
                    andSplitterArr = splitStr.split('\\|\\|');
                    system.debug('andSplitterArr == &#124'+andSplitterArr );
                    for(String s: andSplitterArr){
                        formulaSplitter.add(s);
                    } 
                    
                }
                else{
                    formulaSplitter.add(splitStr);
                }
                
                
                
                formula = formula.substring(pos + splitStr.length(), formula.length());
                
                pos = formula.indexOf('pmStage');
                
            }
            
            if(formulaSplitter.size() > 0){
                
                
                for(String sFormula : formulaSplitter){
                    
                    String[] fSplitted = sFormula.split('\\.');
                    
                    if(fSplitted[0].trim().equals('pmStage')){
                        String[] fSplittedStep = fSplitted[1].split('==');
                    
                        String stageName = fSplittedStep[0].trim();
                        
                        String original_stageName = stageName;
                        
                        stageName = stageName.replace(' ','_');
                        stageName = stageName.replace('-','_'); 
                        stageName = stageName.replace('/','_');
                        stageName = stageName.replace('&','_');
                    
                        original_formula = original_formula.replace('pmStage.'+original_stageName, 'pmStage'+stageName+'.Business_Status__r.Score__c');
                    }
                    
                }
            }
            
        }
        
        system.debug('original_formula============'+original_formula);
        return original_formula;
    
    }
    
    public Static String calculatePmStageStatus(String pmtoolId,String formula, Map<Integer,Business_Status__c> bStatusMap, Map<String, String> randomStageNameMap, String random_formula, Map<String, PM_Stage__c> pmsMap, String operation){
        
            for(Formula_Result__c fr : [select id, Random_No__c,Result__c from Formula_Result__c where PM_Tool_V2__c =:pmtoolId Limit 50000]){
                globalFrMap.put(fr.Random_No__c, Integer.valueOf(fr.Result__c));
            }
            
            PM_Stage__c pmStageForFormula = new PM_Stage__c();
            pmStageForFormula.Business_Status__c = bStatusMap.get(0).id;
            String formula_str = '';
            
            system.debug('formula==============='+formula);
            system.debug('formula.contains(\'pmStage\')==============='+formula.contains('pmStage'));
            
            if(formula != '' && formula != null && formula.contains('pmStage')){
            
                integer pos = formula.indexOf('pmStage');
                List<String> formulaSplitter = new List<String>();
                
                while(pos != -1){
                    
                    String splitStr = formula.substring(pos,formula.indexOf(')', pos));
                    if(splitStr.contains('&&')){
                    
                        List<String> andSplitterArr = new List<String>();
                        andSplitterArr = splitStr.split('&&');
                        system.debug('andSplitterArr =='+andSplitterArr );
                        for(String s: andSplitterArr){
                            formulaSplitter.add(s);
                        } 
                    }
                    else if(splitStr.contains('||')){
                        
                        
                        List<String> andSplitterArr = new List<String>();
                        andSplitterArr = splitStr.split('\\|\\|');
                        system.debug('andSplitterArr == &#124'+andSplitterArr );
                        for(String s: andSplitterArr){
                            formulaSplitter.add(s);
                        } 
                        
                    }
                    else{
                        formulaSplitter.add(splitStr);
                    }

                    formula = formula.substring(pos + splitStr.length(), formula.length());
                    pos = formula.indexOf('pmStage');
                }
                
                system.debug('formulaSplitter================='+formulaSplitter);
                
                if(formulaSplitter.size() > 0){
                    
                    Integer stageNumber = 0;
                    for(String sFormula : formulaSplitter){
                        
                        String[] fSplitted = sFormula.split('\\.');
                        String[] fSplittedStage = fSplitted[1].split('==');
                        
                        String stageName = fSplittedStage[0].trim();
                        
                        system.debug('randomStageNameMap================='+randomStageNameMap);
                        system.debug('globalFrMap================='+globalFrMap);
                        
                        system.debug('randomStageNameMap.containsKey(stageName)================='+randomStageNameMap.containsKey(stageName));
                        system.debug('globalFrMap.containsKey(randomStageNameMap.get(stageName))================='+globalFrMap.containsKey(randomStageNameMap.get(stageName)));
                        System.debug('################ Stage Name #############' + random_formula);
                       
                        if(randomStageNameMap.containsKey(stageName)){
                            if(globalFrMap.containsKey(randomStageNameMap.get(stageName))){
                                pmStageForFormula = pmsMap.get(stageName);
                                system.debug('pmsMap=='+pmsMap);
                               
                                
                                pmStageForFormula.Business_Status__c = bStatusMap.get(globalFrMap.get(randomStageNameMap.get(stageName))).id;
                                
                                if(operation == 'update'){
                                  
                                  
                                  system.debug('randomStageNameMap.get(stageName)==='+randomStageNameMap.get(stageName));
                                  system.debug('globalFrMap.get(randomStageNameMap.get(stageName))==='+globalFrMap.get(randomStageNameMap.get(stageName)));
                                  system.debug('pmStageForFormula==='+pmStageForFormula);
                                  
                                  if(pmStageForFormula != null && pmStageForFormula.Business_Status__c != null){
                                      //pmStageForFormula.Business_Status__r.Score__c = globalFrMap.get(randomStageNameMap.get(stageName));
                                  }
                                    
                                    
                                }
                                
                                String json_str = String.escapeSingleQuotes(JSON.serialize(pmStageForFormula));
                                stageName = stageName.replace(' ','_');
                                stageName = stageName.replace('-','_'); 
                                stageName = stageName.replace('/','_');
                                stageName = stageName.replace('&','_');
                                
                                
                                if(formula_str.contains('pmStage'+stageName) || formula_str.contains('pmStage'+stageName+stageNumber)){
                                    stageNumber++;
                                    formula_str += 'PM_Stage__c pmStage'+stageName+stageNumber+'= (PM_Stage__c)JSON.deserialize(\''+json_str+'\',PM_Stage__c.class);';
                                }
                                else{
                                    formula_str += 'PM_Stage__c pmStage'+stageName+'= (PM_Stage__c)JSON.deserialize(\''+json_str+'\',PM_Stage__c.class);';
                                }
                                
                            }
                        }
                        
                    }
                }
                else{
                    String json_str = String.escapeSingleQuotes(JSON.serialize(pmStageForFormula));
                    formula_str += 'PM_Stage__c pmStage= (PM_Stage__c)JSON.deserialize(\''+json_str+'\',PM_Stage__c.class);';
                }
                system.debug('formula_str ================='+formula_str );
            }
            else{
                String json_str = String.escapeSingleQuotes(JSON.serialize(pmStageForFormula));
                formula_str += 'PM_Stage__c pmStage= (PM_Stage__c)JSON.deserialize(\''+json_str+'\',PM_Stage__c.class);';
            }
            
      
        
        return formula_str;
    
    }
    
    public Static String calculatePmStepStatus(String pmtoolId, String formula, Map<Integer,Business_Status__c> bStatusMap,  Map<String, String> randomStepNameMap, String random_formula, Map<String, PM_Steps__c> pmsMap, String operation){
    
        for(Formula_Result__c fr : [select id, Random_No__c,Result__c from Formula_Result__c where PM_Tool_V2__c =:pmtoolId]){
            globalFrMap.put(fr.Random_No__c, Integer.valueOf(fr.Result__c));
        }
            
        PM_Steps__c pmStepForFormula = new PM_Steps__c();
        pmStepForFormula.Business_Status__c = bStatusMap.get(0).id;
        String formula_str = '';
        string aaa=formula;
        system.debug('formula step==============='+formula);
        system.debug('formula.contains(\'pmStep\')==============='+formula.contains('pmStep'));

        if(formula != '' && formula != null && formula.contains('pmStep')){
        
            integer pos = formula.indexOf('pmStep');
            List<String> formulaSplitter = new List<String>();
            
            while(pos != -1){
                
                String splitStr = formula.substring(pos,formula.indexOf(')', pos));
                if(splitStr.contains('&&')){
                    
                    List<String> andSplitterArr = new List<String>();
                    andSplitterArr = splitStr.split('&&');
                    system.debug('andSplitterArr =='+andSplitterArr );
                    for(String s: andSplitterArr){
                        formulaSplitter.add(s);
                    } 
                }
                else if(splitStr.contains('||')){
                    
                    
                    List<String> andSplitterArr = new List<String>();
                    andSplitterArr = splitStr.split('\\|\\|');
                    system.debug('andSplitterArr == &#124'+andSplitterArr );
                    for(String s: andSplitterArr){
                        formulaSplitter.add(s);
                    } 
                    
                }
                else{
                    formulaSplitter.add(splitStr);
                }

                formula = formula.substring(pos + splitStr.length(), formula.length());
                pos = formula.indexOf('pmStep');
            }
            system.debug('formulaSplitter step================='+formulaSplitter);
            if(formulaSplitter.size() > 0){
                
                Integer stepNumber = 0;
                for(String sFormula : formulaSplitter){
                    
                   
                    String[] fSplitted = sFormula.split('\\.');
                    String[] fSplittedStep = fSplitted[1].split('==');
                    
                    String stepName = fSplittedStep[0].trim();
                    
                    
                    if(operation == 'insert'){
                        system.debug('randomStepNameMap================='+randomStepNameMap);
                        system.debug('globalFrMap================='+globalFrMap);
                        
                        system.debug('random_formula================='+random_formula);
                        
                        system.debug('randomStepNameMap.containsKey(stepName)================='+randomStepNameMap.containsKey(stepName));
                        system.debug('globalFrMap.containsKey(randomStepNameMap.get(stepName))================='+globalFrMap.containsKey(randomStepNameMap.get(stepName)));

                    
                        if(randomStepNameMap.containsKey(stepName)){
                        
                            //=====================================================================
                            if(globalFrMap.containsKey(randomStepNameMap.get(stepName))){
                
                                
                                system.debug('pmsMap=='+pmsMap);
                                
                                if(pmsMap.containsKey(random_formula+'_'+stepName)){
                                    pmStepForFormula = pmsMap.get(random_formula+'_'+stepName);           
                                   
                                }
                                
                                
                                 if(bStatusMap.containsKey(globalFrMap.get(randomStepNameMap.get(stepName)))){
                                    pmStepForFormula.Business_Status__c = bStatusMap.get(globalFrMap.get(randomStepNameMap.get(stepName))).id;
                                 }
                                
                                String json_str = String.escapeSingleQuotes(JSON.serialize(pmStepForFormula));
                                stepName = stepName.replace(' ','_');
                                stepName = stepName.replace('-','_'); 
                                stepName = stepName.replace('/','_');
                                stepName = stepName.replace('&','_');
        
                                if(formula_str.contains('pmStep'+stepName) || formula_str.contains('pmStep'+stepName+stepNumber)){
                                    stepNumber++;
                                    formula_str += 'PM_Steps__c pmStep'+stepName+stepNumber+'= (PM_Steps__c)JSON.deserialize(\''+json_str+'\',PM_Steps__c.class);';
                                }
                                else{
                                    formula_str += 'PM_Steps__c pmStep'+stepName+'= (PM_Steps__c)JSON.deserialize(\''+json_str+'\',PM_Steps__c.class);';
                                }
                                
                            } 
                            
                        }
                    }
                    else{
                    
                        system.debug('randomStepNameMap================='+randomStepNameMap);
                        system.debug('globalFrMap================='+globalFrMap);
                        
                        system.debug('random_formula================='+random_formula);
                        system.debug('stepName================='+stepName);
                        
                        system.debug('randomStepNameMap.containsKey(random_formula)================='+randomStepNameMap.containsKey(random_formula+'_'+stepName));
                        system.debug('globalFrMap.containsKey(randomStepNameMap.get(random_formula))================='+globalFrMap.containsKey(randomStepNameMap.get(random_formula+'_'+stepName)));

                        if(randomStepNameMap.containsKey(random_formula+'_'+stepName)){
                        
                            //=====================================================================
                            if(globalFrMap.containsKey(randomStepNameMap.get(random_formula+'_'+stepName))){

                                pmStepForFormula = pmsMap.get(random_formula+'_'+stepName);
                                system.debug('pmsMap=='+pmsMap);
                                pmStepForFormula.Business_Status__c = bStatusMap.get(globalFrMap.get(randomStepNameMap.get(random_formula+'_'+stepName))).id;
                                
                               //pmStepForFormula.Business_Status__r.Score__c = globalFrMap.get(randomStepNameMap.get(random_formula+'_'+stepName));
                               system.debug('pmStepForFormula.Business_Status__c ===='+pmStepForFormula.Business_Status__c);                                    
                               system.debug('pmStepForFormula.Business_Status__r.Score__c ===='+pmStepForFormula.Business_Status__r.Score__c );
                                
                                
                                String json_str = String.escapeSingleQuotes(JSON.serialize(pmStepForFormula));
                                stepName = stepName.replace(' ','_');
                                stepName = stepName.replace('-','_'); 
                                stepName = stepName.replace('/','_');
                                stepName = stepName.replace('&','_');
        
                                if(formula_str.contains('pmStep'+stepName) || formula_str.contains('pmStep'+stepName+stepNumber)){
                                    stepNumber++;
                                    formula_str += 'PM_Steps__c pmStep'+stepName+stepNumber+'= (PM_Steps__c)JSON.deserialize(\''+json_str+'\',PM_Steps__c.class);';
                                }
                                else{
                                    formula_str += 'PM_Steps__c pmStep'+stepName+'= (PM_Steps__c)JSON.deserialize(\''+json_str+'\',PM_Steps__c.class);';
                                }
                                
                            } 
                            
                        }
                        else if(stepName == 'R&P Install'){
                            String rkey = random_formula+'_R&P Install';
                            for(String key: pmsMap.keySet()){
                                
                                if(key.contains('_R&P Install')){
                                    rkey = key;
                                }
                            }
                            
                            pmStepForFormula = pmsMap.get(rkey);
                            String json_str = String.escapeSingleQuotes(JSON.serialize(pmStepForFormula));
                            formula_str += 'PM_Steps__c pmStepR_P_Install= (PM_Steps__c)JSON.deserialize(\''+json_str+'\',PM_Steps__c.class);';
                        }
                    
                    }
                }
            }
            else{
                String json_str = String.escapeSingleQuotes(JSON.serialize(pmStepForFormula));
                formula_str += 'PM_Steps__c pmStep= (PM_Steps__c)JSON.deserialize(\''+json_str+'\',PM_Steps__c.class);';
            }
            system.debug('formula_str ================='+formula_str );
            
        }
        else{
            String json_str = String.escapeSingleQuotes(JSON.serialize(pmStepForFormula));
            formula_str += 'PM_Steps__c pmStep= (PM_Steps__c)JSON.deserialize(\''+json_str+'\',PM_Steps__c.class);';
        }
        
        return formula_str;
    
    }
    
    @future(callout=true)
    public static void updateStages(Id pmToolId, String sessionId){
        
        try{
            if(PMToolV2.updateStagesFirstRun){
                PMToolV2.updateStagesFirstRun = false;
                
                sessionId = ExplicitLogin.login();
                
                globalFrMap = new Map<String, Integer>();
                
                Set<String> marketSet = new Set<String>();
                Map<String, String> pmStepRandomMap = new Map<String, String>();
                Map<Id, List<PM_Steps__c>> pmStepMap = new Map<Id, List<PM_Steps__c>>();
                for(PM_Steps__c pmStep : [select id, Name, Business_Installation_Step__c, Business_Installation_Step__r.Formula__c, Business_Status__c,
                    Aging__c,End_Date__c,In_Process_Aging__c,In_Process_Aging_Exception__c,In_Process_End_Date__c,In_Process_Start_Date__c,NA_Override__c,PM_Tool_V2__r.HDLC_Approval__c,
                    PM_Review_Aging__c,PM_Review_End_Date__c,PM_Review_Start_Date__c,Start_Date__c,PM_Stage__c, PM_Stage__r.PM_Tool_V2__c, PM_Tool_V2__r.Layout_Approval_Required__c,PM_Tool_V2__r.HOA_Approval_Required__c,
                    Business_Installation_Step__r.Name, PM_Stage__r.PM_Tool_V2__r.State__c,Manual_Bypass__c from PM_Steps__c where PM_Stage__r.PM_Tool_V2__c = : pmToolId  order by Business_Installation_Step__r.Execution_sequence__c asc]){
                    
                    if(!pmStepMap.containsKey(pmStep.PM_Stage__c)){
                        pmStepMap.put(pmStep.PM_Stage__c, new List<PM_Steps__c>());
                    }
                    pmStepMap.get(pmStep.PM_Stage__c).add(pmStep);
                    marketSet.add(pmStep.PM_Stage__r.PM_Tool_V2__r.State__c);
                    
                    pmStepRandomMap.put(pmStep.PM_Stage__c+'_'+pmStep.Business_Installation_Step__r.Name, pmStep.id);
                }
                system.debug('marketSet--------------'+marketSet);
                Map<Integer,id> bStatusMap = new Map<Integer,id>();
                for(Business_Status__c status : [select id, Score__c from Business_Status__c]){
                    bStatusMap.put(Integer.valueOf(status.Score__c), status.id);
                }
                
                Map<Integer,Business_Status__c> bStatusMapFormula = new Map<Integer,Business_Status__c>();
                for(Business_Status__c status : [select id, name, Score__c from Business_Status__c]){
                    bStatusMapFormula.put(Integer.valueOf(status.Score__c), status);
                }
                
                Map<Id,Id> pmStageMappingMap = new  Map<Id,Id>();
                for(PM_Stage_Mapping__c  mapping : [select id, Business_Stage__c, Previous_Business_Stage__c from PM_Stage_Mapping__c where Business_Stage__r.Business_market__r.Name in : marketSet]){
                    pmStageMappingMap.put(mapping.Business_Stage__c, mapping.Previous_Business_Stage__c);
                }
                system.debug('pmStageMappingMap--------------'+pmStageMappingMap);
                Map<String, PM_Stage__c> previousStageMap = new  Map<String,PM_Stage__c>();
                for(PM_Stage__c s: [select id, PM_Tool_V2__c, Business_Installation_Stage__c, PM_Review__c from PM_Stage__c where Business_Installation_Stage__c in: pmStageMappingMap.values() and PM_Tool_V2__c = : pmToolId]){
                    previousStageMap.put(s.Business_Installation_Stage__c+'__'+s.PM_Tool_V2__c, s);
                }
                system.debug('previousStageMap--------------'+previousStageMap);
                List<PM_Stage__c> pmStageList = new List<PM_Stage__c>();
                List<PM_Steps__c> pmStepList = new List<PM_Steps__c>();
                
                Map<String, PM_Stage__c> pmStageRandomMap = new Map<String, PM_Stage__c>();
                Map<String, String> randomStageNameMap = new Map<String, String>();
                Map<String, String> randomStepNameMap = new Map<String, String>();
                Map<String, PM_Steps__c> pmsStepMap = new Map<String, PM_Steps__c>();
                for(PM_Stage__c pmStage : [select id, Business_Installation_Stage__r.Name, Business_Status__r.Score__c from PM_Stage__c where PM_Tool_V2__c = : pmToolId]){
                    pmStageRandomMap.put(pmStage.id+'_'+pmStage.Business_Installation_Stage__r.Name, pmStage);
                    randomStageNameMap.put(pmStage.Business_Installation_Stage__r.Name, pmStage.id);
                }
                
                for(PM_Steps__c pmStep : [select id, name, PM_Stage__c, Business_Installation_Step__r.Name,Business_Status__c,Business_Status__r.Score__c from PM_Steps__c where PM_Tool_V2__c = : pmToolId]){
                    pmsStepMap.put(pmStep.PM_Stage__c+'_'+pmStep.Business_Installation_Step__r.Name, pmStep);
                    randomStepNameMap.put(pmStep.Business_Installation_Step__r.Name, pmStep.id);
                }
                
                Map<String, PM_Stage__c> pmsMap = new Map<String, PM_Stage__c>();
                for(PM_Stage__c pmStage : [select id, Name, PM_Review__c, Business_Installation_Stage__c, Business_installation_Stage__r.name, Business_Installation_Stage__r.Formula__c, Business_Status__c,Business_Status__r.Score__c,Business_Installation_Stage__r.Execution_sequence__c, 
                PM_Tool_V2__c from PM_Stage__c where PM_Tool_V2__c = : pmToolId order by Business_Installation_Stage__r.Execution_sequence__c asc]){
                    
                    system.debug('pmStage ============*****===='+pmStage.Business_Installation_Stage__r.Name+' *** '+pmStage.Business_Installation_Stage__r.Execution_sequence__c);
                        
                    PM_Stage__c previousStage;
                    if(pmStageMappingMap.containsKey(pmStage.Business_Installation_Stage__c) && previousStageMap.containsKey(pmStageMappingMap.get(pmStage.Business_Installation_Stage__c)+'__'+pmStage.PM_Tool_V2__c)){
                        previousStage = previousStageMap.get(pmStageMappingMap.get(pmStage.Business_Installation_Stage__c)+'__'+pmStage.PM_Tool_V2__c);
                    }
                    
                    pmsMap.put(pmStage.Business_Installation_Stage__r.Name, pmStage);
                    
                    system.debug('pmStage.id as random===='+pmStage.id);
                    
                    
                    String pmStageForFormula = '';
                    String pmStepForFormula = '';
                                        
                    if(pmStepMap.containsKey(pmStage.id)){
                    
                    
                        for(PM_Steps__c pmStep : pmStepMap.get(pmStage.id)){
                        
                            system.debug('pmStep-------------------------------------------'+pmStep.Business_Installation_Step__r.Name);
                        
                            pmStageForFormula = calculatePmStageStatus(pmStage.PM_Tool_V2__c,pmStep.Business_Installation_Step__r.formula__c, bStatusMapFormula, randomStageNameMap, pmStep.id, pmsMap,'update');
                            pmStepForFormula = calculatePmStepStatus(pmStage.PM_Tool_V2__c,pmStep.Business_Installation_Step__r.formula__c, bStatusMapFormula, pmStepRandomMap, pmStage.id, pmsStepMap, 'update');
                            executeFormula(pmStep.PM_Stage__r.PM_Tool_V2__c, pmStage, previousStage, pmStageForFormula, pmStep, pmStepForFormula, replaceFormulaString(pmStep.Business_Installation_Step__r.Formula__c), pmStep.id, sessionId);
                        }
                    } 
                    
                    pmStageForFormula = calculatePmStageStatus(pmStage.PM_Tool_V2__c,pmStage.Business_Installation_Stage__r.formula__c, bStatusMapFormula, randomStageNameMap, pmStage.id, pmsMap,'update');
                    pmStepForFormula = calculatePmStepStatus(pmStage.PM_Tool_V2__c,pmStage.Business_Installation_Stage__r.formula__c, bStatusMapFormula, pmStepRandomMap, pmStage.id, pmsStepMap, 'update');
                    executeFormula(pmStage.PM_Tool_V2__c, pmStage, previousStage, pmStageForFormula, null, pmStepForFormula, replaceFormulaString(pmStage.Business_Installation_Stage__r.Formula__c), pmStage.id, sessionId);
                   

                }
                
                Map<String, Integer> frMap = new Map<String, Integer>();
                for(Formula_Result__c fr : [select id, Random_No__c,Result__c from Formula_Result__c where PM_Tool_V2__c = : pmToolId]){
                    frMap.put(fr.Random_No__c, Integer.valueOf(fr.Result__c));
                }
                
                Map<id, Exception_Threshold__c> exceptionMap = new Map<id, Exception_Threshold__c>();
                for(Exception_Threshold__c et: [select id, Business_Installation_Step__c, In_Process_Threshold__c, PM_Review_Threshold__c from Exception_Threshold__c]){
                      exceptionMap.put(et.Business_Installation_Step__c, et);              
                }
                
                system.debug('frMap=============='+frMap);
                
                for(PM_Stage__c pmStage : [select id, Business_Status__c, Business_Status__r.Score__c, PM_Review__c from PM_Stage__c where PM_Tool_V2__c = : pmToolId]){
                    
                    system.debug('bStatusMap.get(frMap.get(pmStage.id)=============='+bStatusMap.get(frMap.get(pmStage.id)));
                    system.debug('frMap.get(pmStage.id)=============='+frMap.get(pmStage.id));
                    system.debug('pmStage.Business_Status__c=============='+pmStage.Business_Status__c);
                    system.debug('pmStage.id=============='+pmStage.id);
                    
                    if(pmStage.Business_Status__r.Score__c != 4){
                       pmStage.Business_Status__c = bStatusMap.get(frMap.get(pmStage.id));
                    }
                    else{
                       pmStage.PM_Review__c = true; 
                    }
                    pmStageList.add(pmStage);
                    
                    if(pmStepMap.containsKey(pmStage.id)){
                        for(PM_Steps__c pmStep : pmStepMap.get(pmStage.id)){
                        
                            Integer score = frMap.get(pmStep.id);
                            system.debug('score ==============='+score );
                            if(score != null){
                                system.debug('bStatusMap.get(score)=============='+bStatusMap.get(score));
                                
                                pmStep.Business_Status__c = bStatusMap.get(score);
                                system.debug('pmStep.Business_Status__c=============='+pmStep.Business_Status__c);
                                
                                if(score != -1){pmStep.NA_Override__c = false;
                                }
                                
                                if(score == 0){
                                    pmStep.PM_Review_Start_Date__c = null;
                                    pmStep.Start_Date__c = null;
                                    pmStep.End_Date__c = null;
                                }
                                else if(score == 1){
                                
                                    if(pmStep.PM_Review_Start_Date__c == null){
                                        pmStep.PM_Review_Start_Date__c = Date.today();
                                    }
                                    pmStep.PM_Review_End_Date__c = null;
                                    
                                    if(pmStep.Start_Date__c == null){
                                        pmStep.Start_Date__c = Date.today();
                                    }
                                    pmStep.End_Date__c = null;
                                    pmStep.In_Process_Start_Date__c = null;
                                    
                                }
                                else if(score == 2){
                                
                                    if(pmStep.Start_Date__c == null){
                                        pmStep.Start_Date__c = Date.today();
                                    }
                                
                                    if(pmStep.PM_Review_End_Date__c == null){
                                        pmStep.PM_Review_End_Date__c = Date.today();
                                        
                                        if(pmStep.PM_Review_Start_Date__c == null){
                                            pmStep.PM_Review_Start_Date__c = Date.today();
                                        }
                                    }
                                    
                                    if(pmStep.In_Process_Start_Date__c == null){
                                        pmStep.In_Process_Start_Date__c = Date.today();
                                    }
                                    pmStep.In_Process_End_Date__c= null;
                                    pmStep.End_Date__c = null;
                                    
                                }
                                else if(score == 3){
                                
                                    if(pmStep.In_Process_End_Date__c == null){
                                        pmStep.In_Process_End_Date__c= Date.today();
                                        
                                        if(pmStep.In_Process_Start_Date__c == null){
                                            pmStep.In_Process_Start_Date__c = Date.today();
                                        }
                                    }
                                    
                                    if(pmStep.End_Date__c == null){
                                        pmStep.End_Date__c= Date.today();
                                        
                                        if(pmStep.Start_Date__c == null){
                                            pmStep.Start_Date__c = Date.today();
                                        }
                                    }
                                }
                                else if(score == -1){
                                    pmStep.NA_Override__c = true;
                                    pmStep.PM_Review_Start_Date__c = null;
                                    pmStep.PM_Review_End_Date__c = null;
                                    pmStep.In_Process_End_Date__c = null;
                                    pmStep.In_Process_Start_Date__c = null;
                                    pmStep.Start_Date__c = null;
                                    pmStep.End_Date__c = null;
                                }
                                
                                if(pmStep.PM_Review_Start_Date__c != null && pmStep.PM_Review_End_Date__c == null){pmStep.PM_Review_Aging__c =  pmStep.PM_Review_Start_Date__c.daysBetween(Date.Today());
                                }
                                else if(pmStep.PM_Review_Start_Date__c != null && pmStep.PM_Review_End_Date__c != null){pmStep.PM_Review_Aging__c =  pmStep.PM_Review_Start_Date__c.daysBetween(pmStep.PM_Review_End_Date__c);
                                }
                                else{
                                    pmStep.PM_Review_Aging__c = null;
                                }
                                
                                
                                if(pmStep.In_Process_Start_Date__c != null && pmStep.In_Process_End_Date__c == null){pmStep.In_Process_Aging__c =  pmStep.In_Process_Start_Date__c.daysBetween(Date.Today());
                                }
                                else if(pmStep.In_Process_Start_Date__c != null && pmStep.In_Process_End_Date__c!= null){pmStep.In_Process_Aging__c =  pmStep.In_Process_Start_Date__c.daysBetween(pmStep.In_Process_End_Date__c);
                                }
                                else{
                                    pmStep.In_Process_Aging__c = null;
                                }
                                
                                if(pmStep.Start_Date__c != null && pmStep.End_Date__c == null){pmStep.Aging__c =  pmStep.Start_Date__c.daysBetween(Date.Today());
                                }
                                else if(pmStep.Start_Date__c != null && pmStep.End_Date__c!= null){pmStep.Aging__c =  pmStep.Start_Date__c.daysBetween(pmStep.End_Date__c);
                                }
                                else{
                                    pmStep.Aging__c = null;
                                }
                                
                                
                                
                                if(exceptionMap.containsKey(pmStep.Business_Installation_Step__c)){
                                
                                    if(score == 1){
                                        if(exceptionMap.get(pmStep.Business_Installation_Step__c).PM_Review_Threshold__c < pmStep.PM_Review_Aging__c){
                                            pmStep.PM_Review_Aging_Exception__c = true;
                                        }
                                    }
                                    if(score == 2){
                                        if(exceptionMap.get(pmStep.Business_Installation_Step__c).In_Process_Threshold__c < pmStep.In_Process_Aging__c){
                                            pmStep.In_Process_Aging_Exception__c = true;
                                        }
                                    }
                                }

                            }

                            
                            pmStepList.add(pmStep);
                        }
                    }    
                }
                
                system.debug('pmStageList ==============='+pmStageList );
                
                update pmStageList;
                
                runStepTrigger = false;
                update pmStepList;
                
                Set<Id> pmToolSet = new Set<Id>();
                pmToolSet.add(pmToolId);
                calculateCompletionAverage(pmToolSet);
            }    
        }
        catch(Exception e){
            
            system.debug('PMTool v2 Error : '+e.getMessage()+' '+e.getStackTraceString());
        }
        
        finally {
            delete [select id from Formula_Result__c where PM_Tool_V2__c = :pmToolId];
        }
    }
    

    public static void updateStageFromTrigger(Set<Id> pmStageSet, String sessionId){

        try{
            
            if(PMToolV2.updateStagesFirstRun){
                for(PM_Stage__c pmStage : [select id, PM_Tool_V2__c, PM_Tool_V2__r.State__c from PM_Stage__c where id in : pmStageSet]){
                   
                    updateStages(pmStage.PM_Tool_V2__c,UserInfo.getSessionId());
                }
                PMToolV2.updateStagesFirstRun = false;
            }
            
          
        }
        catch(Exception e){
            system.debug('PMTool v2 Error : '+e.getMessage()+' '+e.getStackTraceString());
        }
    }

    public static void executeFormula(Id pmToolId, PM_Stage__c stage, PM_Stage__c previousStage, String pmStage, PM_Steps__c step, String pmStep,  String formula, String random, String sessionId){
        system.debug('stage executeFormula'+stage);
        PM_Tool_V2__c pmtool = [select id, Name, Activation_Date__c,Activation_Scheduled_Date__c,Actual_System_Size__c,Address__c,
        Agreement_Appr_Date__c,Assessment_Comp_Date__c,Assessment_Req_Date__c,Billing_Packet_Status__c,Billing_Packet_Submitted__c,
        Building_Permit_Applied_For__c,Building_Permit_received__c,City__c,Closing_Call__c,Completion_Average__c,
        Contract_Approved_Date__c,Contract_Signed_Date__c,Cust_Accept_Rec_Date__c,Customer_Name__c,EA_Approved_Date__c,
        EA_Assigned_Date__c,EA_Completed_Date__c,EA_Project_Status__c,EA_Rebate_Submitted_Date__c,EA_Scheduled_Date__c,
        EA_St_App_Approved_Date__c,EA_St_App_Sub_Date__c,EE_Accepted__c,EE_Lease_Payment__c,Electrical_Install_Completed_date__c,
        Electrical_Installed_Date__c,Elec_Install_Sch_date__c,Electrical_Permit_Applied_For__c,Electrical_Permit_received__c,
        Email__c,Eng_Report_Rec_Date__c,Eng_Report_Req_Date__c,Engineering_Required__c,EU_Approved_Date__c,EU_Completed_Date__c,
        EU_Project_Status__c,EU_Scheduled_Date__c,Feasibility_Completed_Date__c,Feasibility_Project_Status__c,Feasibility_Result__c,
        Feasibility_result_call__c,Field_Verif_Comp_Date__c,Field_Verif_Req_Date__c,First_Closing_Call_Made__c,First_Intro_Call_Made__c,
        HDLC_Approval__c,HDLC_Appr_Comp_Date__c,HDLC_Appr_Req_Date__c,HOA_Appr_Comp_Date__c,HOA_Appr_Req_Date__c,HOA_Approval_Required__c,
        Inf_Net_Meter_Inst_Date__c,Initial_Determination_Result__c,Inspection_Completed_Date__c,Insp_Comp_With_Letter_Date__c,
        Inspection_Requested_Date__c,Inspection_Result__c,Intro_Call__c,Layout_Appr_Rec_Date__c,Layout_Approval_Required__c,
        Layout_Appr_Sub_Date__c,Lease_Type__c,LMI_Accpt_Rec_Date__c,LMI_Acceptance_Result__c,LMI_Accpt_Sub_Date__c,M2_submission_date__c,
        M3_submission_date__c,Net_Meter_Inst_Verified_Date__c,Net_Meter_Inst_Sch_Date__c,Opportunity__c,Opportunity_Numeric_ID__c,
        Permanent_Removal__c,Pipeline_Stage__c,Placed_In_Service_Date__c,Primary_Phone__c,Project_Completion_Date__c,Project_EE_Assessment__c,
        Project_EE_Upgrade__c,Project_Manager__c,Project_PV_Feasibility__c,Project_PV_Install__c,Project_PV_Removal__c,Project_Status__c,
        PV_Comp_EU_Sch_Call__c,PV_Install_Status__c,PV_Lease_Payment__c,QC_Completed_Date__c,QC_Passed__c,QC_Requested_Date__c,QC_Result__c,
        R_P_Installed_Date__c,R_P_Inst_Sch_date__c,R_P_Removal_Date__c,Rebate_Sub_Date__c,Referring_Customer__c,Removal_Project__c,
        Removal_Project_Status__c,Removal_Reason__c,Removal_Scheduled_Date__c,Sales_Order__c,Sales_Order_Created__c,Sales_Person__c,
        Secondary_Phone__c,Site_Verification_Required__c,State__c,State_Prog_App_Appr_Date__c,State_Prog_App_Sub_Date__c,System_Size__c,
        Telemarketer__c,Utility__c,Utility_Final_Appr_Com_Date__c,Utility_Final_Appr_Req_Date__c,Utility_Init_Appr_Rec_Date__c,
        Utility_Init_Appr_Sub_Date__c,Work_Scope_Approved__c,Work_Scope_Submitted__c from PM_Tool_V2__c where id =: pmToolId];
        
        
        
        System.debug('pmStage========='+pmStage);
        system.debug('Stage==='+stage);
        //system.debug('match id=== pmtool'+pmToolId+'  PM_Stage__c='+stage+' PM_Steps__c='+step);
        
        try{
            
            string json_str = string.escapeSingleQuotes(JSON.serialize(pmtool));
            string toEval = 'PM_Tool_V2__c pmtool = (PM_Tool_V2__c)JSON.deserialize(\''+json_str+'\',PM_Tool_V2__c.class);';
        
            if(stage != null){

                system.debug('stage---------'+stage);
                system.debug('previousStage---------'+previousStage);
                
                json_str = string.escapeSingleQuotes(JSON.serialize(stage));
                toEval += 'PM_Stage__c stage = (PM_Stage__c)JSON.deserialize(\''+json_str+'\',PM_Stage__c.class);';
                
                if(previousStage != null){
                    json_str = string.escapeSingleQuotes(JSON.serialize(previousStage));
                    toEval += 'PM_Stage__c previousStage = (PM_Stage__c)JSON.deserialize(\''+json_str+'\',PM_Stage__c.class);';
                }
            }
            
            if(pmStage != null && pmStage != ''){

                toEval += pmStage;
            }
            
            if(step != null){
                json_str = string.escapeSingleQuotes(JSON.serialize(step));
                toEval += 'PM_Steps__c step= (PM_Steps__c)JSON.deserialize(\''+json_str+'\',PM_Steps__c.class);';
            }
            
            if(pmStep != null && pmStep != ''){

                toEval += pmStep;
            }
            
            
           system.debug('formula ======================'+formula);

           toEval += 'Integer result = null;'+formula;
           
           system.debug('pmStage.id as random fromula===='+random);
           toEval += 'Formula_Result__c fr = new Formula_Result__c();fr.Random_No__c = \''+random+'\';fr.Result__c = result;fr.PM_Tool_V2__c=pmtool.id;insert fr;';

           
           if(!Test.isRunningTest() && formula != '' && formula != null){

               FormulaExecuter.evalInteger(toEval,sessionId);
           }
           else{
               Formula_Result__c fr = new Formula_Result__c();
               fr.Random_No__c = random;
               fr.Result__c = -1;
               fr.PM_Tool_V2__c=pmtool.id;
               insert fr;
           }
          
               
        }
        catch(Exception e){
            system.debug('PMTool v2 Error : '+e.getMessage()+' '+e.getStackTraceString());
            
        }

    }
    
    public static String generateRandomString(Integer len) {
        final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz1234567890';
        String randStr = '';
        while (randStr.length() < len) {
           Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
           randStr += chars.substring(idx, idx+1);
        }
        return randStr; 
    }
    
    public static void calculateCompletionAverage(Set<Id> pmToolSet){
       try{ 
       
            Map<Id, List<PM_Steps__c>> pmStepsMap = new Map<Id, List<PM_Steps__c>>();
            for(PM_Steps__c pmStep : [select id, name, Business_Installation_Step__r.Name, Business_Status__c,Business_Status__r.Score__c, PM_Tool_V2__c from PM_Steps__c where PM_Tool_V2__c in : pmtoolSet]){
                
                if(!pmStepsMap.containsKey(pmStep.PM_Tool_V2__c)){
                    pmStepsMap.put(pmStep.PM_Tool_V2__c, new List<PM_Steps__c>());
                }
                pmStepsMap.get(pmStep.PM_Tool_V2__c).add(pmStep);
             }
             
             List<PM_Tool_V2__c> pmToolList = new List<PM_Tool_V2__c>(); 
             for(PM_Tool_V2__c pmtool: [select id, Completion_Average__c from PM_Tool_V2__c where id in : pmStepsMap.keySet()]){
                 
                 Decimal completionAvg = 0;
                 Decimal totalCompletionAvg = 0;
                 Integer noOfSteps = 0;
                 
                 for(PM_Steps__c pmSt : pmStepsMap.get(pmtool.Id)){
                     if(pmSt.Business_Status__r.Score__c != null && pmSt.Business_Status__r.Score__c != -1){
                     
                         completionAvg = completionAvg + Integer.valueOf(pmSt.Business_Status__r.Score__c);
                         noOfSteps++;
                     }
                 }
                 
                  Decimal avg = 0;
                  if(noOfSteps>0){
               
                       Integer nos = 3*noOfSteps;
                       avg = completionAvg / nos;
                       avg = avg*100;

                  }
                  
                  avg = avg.setScale(2, RoundingMode.HALF_UP);
                  
                  pmtool.Completion_Average__c = avg;
                  pmToolList.add(pmtool);
             }   
               
             PMToolV2.updateStagesFirstRun = false;  
             update pmToolList;      
                  
                   
                           
       }
       catch(Exception e){
           system.debug('PMTool v2 Error : '+e.getMessage()+' '+e.getStackTraceString());
       }
   
    }
        
    public class PMWrapper {
        public PM_Tool_V2__c pmtool{get;set;}
        public Decimal avg{get;set;}
        public List<PMStageWrapper> pmStageWrapper{get;set;}
        public String name{get;set;}
        
        public PMWrapper(PM_Tool_V2__c pmtool, Decimal avg, List<PMStageWrapper> pmStageWrapper) {
            this.pmtool = pmtool;
            this.avg = avg;
            this.pmStageWrapper = pmStageWrapper;
            this.name = pmtool.project_manager__c;
        }
    }
    
    public class PMStageWrapper {
        
        public PM_Stage__c pmStage{get;set;}
        public List<PM_Steps__c> pmStepsList{get;set;}
        
        public PMStageWrapper(PM_Stage__c pmStage, List<PM_Steps__c> pmStepsList) {
            this.pmStage = pmStage;
            this.pmStepsList = pmStepsList;
        }
    }
    
    public class BusinessStageWrapper {
        
        public Business_Stage__c bStage{get;set;}
        public List<Business_Installation_Step__c> bStepsList{get;set;}
        public Integer size{get;set;}
        public BusinessStageWrapper(Business_Stage__c bStage, List<Business_Installation_Step__c> bStepsList) {
            this.bStage = bStage;
            this.bStepsList = bStepsList;
        }
    }
    
    
    public class FilterWrapper{
        public cls_data[] data;

    }
    
    public class cls_data {
        public Integer id;  //0
        public String step; //EA State Application Approval
        public String status;   //Not Started
    }
}