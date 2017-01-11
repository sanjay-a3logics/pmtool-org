public class FormulaBuilder{

    public List<SelectOption> bStageList{get;set;}
    public List<SelectOption> bStepList{get;set;}
    public List<Business_Status__c> resultList{get;set;}
    public String selectedStage{get;set;}
    public String selectedStep{get;set;}
    public String selectedMarket{get;set;}
    public string pmToolFields;
    public string formulaString{get;set;}
    public List<SelectOption> mainFilterList{get;set;}
    public List<PmToolFilterWrapper> PmToolFilterWrapperList{get;set;}
    public Map<String, String> operatorMap;
    public Map<String, String> conditionMap;
    public Map<String, String> inputMap;
    public String filterDataJson{get;set;}
    
    Set<String> pmtoolFieldsDataSet;
    Set<String> stageDataSet;
    Set<String> stepDataSet;
    
    Map<String, String> stageFormulaMap;
    Map<String, String> stepFormulaMap;
    
    public FormulaBuilder(){
    
        selectedMarket = '';
        mainFilterList = new List<SelectOption>();
        
        pmtoolFieldsDataSet = new Set<String>();
        stageDataSet = new Set<String>();
        stepDataSet = new Set<String>();
        
        stageFormulaMap = new Map<String, String>();
        stepFormulaMap = new Map<String, String>();
        
        PmToolFilterWrapperList = new List<PmToolFilterWrapper>();
    
        resultList = new List<Business_Status__c>();
        operatorMap = new Map<String, String>();
        operatorMap.put('equal',' == ');
        operatorMap.put('is_not_null',' != ');
        operatorMap.put('is_not_empty',' != ');
        operatorMap.put('not_equal',' != ');
        operatorMap.put('is_null',' == ');
        operatorMap.put('is_empty',' == ');
        operatorMap.put('less',' < ');
        operatorMap.put('less_or_equal',' <= ');
        operatorMap.put('greater',' > ');
        operatorMap.put('greater_or_equal',' >= ');
        
        //operatorMap.put('in','  ');
        //operatorMap.put('not_in',' == ');
        
        conditionMap = new Map<String, String>();
        conditionMap.put('AND', ' && ');
        conditionMap.put('OR', ' || ');
        
        inputMap = new Map<String, String>();
        inputMap.put('string', '');
        inputMap.put('boolean', 'radio');
        
        for(Business_Status__c bStatus: [select Name, Score__c from Business_Status__c]){
            resultList.add(bStatus);
        }
      
    }
    
    public void saveFormulaForStep(){
    
           try{
             //String original_formulaString = formulaString;
             
             //formulaString =  '[{"condition":"AND","rules":[{"id":"a4zm000000027nOAAQ","field":"a4zm000000027nOAAQ","type":"string","input":"text","operator":"equal","value":"4"}],"score":"1"},{"condition":"OR","rules":[{"id":"qc_requested_date__c","field":"qc_requested_date__c","type":"date","input":"text","operator":"is_not_null","value":null},{"id":"inspection_requested_date__c","field":"inspection_requested_date__c","type":"date","input":"text","operator":"is_not_null","value":null}],"score":"2"},{"condition":"AND","rules":[{"id":"a50m00000001HS7AAM","field":"a50m00000001HS7AAM","type":"string","input":"text","operator":"equal","value":"3"},{"id":"a50m00000001HXEAA2","field":"a50m00000001HXEAA2","type":"string","input":"text","operator":"equal","value":"3"}],"score":"3"},{"condition":"AND","rules":[{"id":"a50m00000001HS7AAM","field":"a50m00000001HS7AAM","type":"string","input":"text","operator":"in","value":"3,4,5,dd"},{"id":"a50m00000001HXEAA2","field":"a50m00000001HXEAA2","type":"string","input":"text","operator":"not_equal","value":"3,4,5,dd"},{"id":"PM_Review__c","field":"PM_Review__c","type":"boolean","input":"text","operator":"equal","value":"true"},{"id":"name","field":"name","type":"string","input":"text","operator":"begins_with","value":"aaa"},{"id":"name","field":"name","type":"string","input":"text","operator":"contains","value":"asdf"},{"id":"name","field":"name","type":"string","input":"text","operator":"not_contains","value":"zxcv"},{"id":"name","field":"name","type":"string","input":"text","operator":"ends_with","value":"xxxxxx"},{"id":"name","field":"name","type":"string","input":"text","operator":"not_ends_with","value":"yyyyyy"}],"score":"4"}]';
             //system.assert(false, formulaString);
             formulaString =  '{"formula":'+formulaString+'}';
             String formula = 'if(';
             FormulaWrapper fW = new FormulaWrapper();
             fW = (FormulaWrapper) System.JSON.deserialize(formulaString, FormulaWrapper.class);
             
             integer i = 0;
             integer formula_size = fW.formula.size();
             
             Integer scoreIndex = 0;
             Boolean scoreIndexCheck = false;
             
             for(cls_formula formulaObj: fW.formula){
                 scoreIndex++;
                 
                 if(formulaObj.score == -1 && scoreIndex != 1){
                     scoreIndexCheck = true;
                 }
             }
             
             if(scoreIndexCheck){
                 
                  ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Please move the formula for "Not Applicable" status at last');
                  ApexPages.addMessage(errMsg);
             }
             else{
             
             fW.formula.sort();
             
             //system.assert(false, fW.formula);

             for(cls_formula formulaObj: fW.formula){
                 i++;
                 
                 integer j = 0;
                 integer rule_size = formulaObj.rules.size();
                 for(cls_rules rule: formulaObj.rules){
                     j++;
                     
                     integer k = 0;
                     system.debug('rule.rules =='+rule.rules);
                     if(rule.rules != null){
                     
                      
                         integer rule_inner_size = rule.rules.size();
                         system.debug('rule.rules =='+rule.rules);
      
                         formula += '(';
                         for(cls_rules rule_in: rule.rules){
                             k++;
                             Boolean addOperator_in = true;
                             
                             if(rule_in.operator == 'not_begins_with' || rule_in.operator == 'not_contains' || rule_in.operator == 'not_ends_with'){
                                 formula += '!';
                             }
                             
                             if(stageDataSet.contains(rule_in.id)){
                             
                                 formula += 'pmStage.'+stageFormulaMap.get(rule_in.id);
                                 
                                 rule_in.type = 'integer';
        
                             }
                             else if(stepDataSet.contains(rule_in.id)){
                             
                                 formula += 'pmStep.'+stepFormulaMap.get(rule_in.id);
                                 
                                 rule_in.type = 'integer';
        
                             }
                             else if(rule_in.id == 'PM_Review__c'){
                                 formula += 'stage.'+rule_in.id;
                             }
                             else if(rule_in.id == 'Manual_Bypass__c'){
                                 formula += 'step.'+rule_in.id;
                             }
                             else{
                                 formula += 'pmtool.'+rule_in.id;
                             }
                             
                             if(addOperator_in){
                             
                                 if(rule_in.operator == 'contains' || rule_in.operator == 'not_contains'){
                                 
                                     formula += '.contains(\''+rule_in.value+'\')';
                                 }
                                 else if(rule_in.operator == 'begins_with' || rule_in.operator == 'not_begins_with'){
                                 
                                     formula += '.startswith(\''+rule_in.value+'\')';
                                 }
                                 else if(rule_in.operator == 'ends_with' || rule_in.operator == 'not_ends_with'){
                                 
                                     formula += '.endsWith(\''+rule_in.value+'\')';
                                 }
                                 else{
                                     formula += operatorMap.get(rule_in.operator);
                                     
                                     if(rule_in.type == 'string' && rule_in.value != null){
                                         formula += '\''+rule_in.value+'\'';
                                     }
                                     else{
                                         formula += rule_in.value;
                                     }
                                 }
                             }
                                              
                             if(k != rule_inner_size){
                                 formula += conditionMap.get(rule.condition);
                             }
                             
                         }
                         if(k == rule_inner_size){
                             formula += ')';
                             //formula += conditionMap.get(formulaObj.condition);
                         }
                         
                          if(j != rule_size){
                             //formula += ')';
                             formula += conditionMap.get(formulaObj.condition);
                         }
                         
                         
                     }
                     else{
                         Boolean addOperator = true;
                         
                         if(rule.operator == 'not_begins_with' || rule.operator == 'not_contains' || rule.operator == 'not_ends_with'){
                             formula += '!';
                         }
                         
                         if(stageDataSet.contains(rule.id)){
                         
                             formula += 'pmStage.'+stageFormulaMap.get(rule.id);
                             
                             rule.type = 'integer';
    
                         }
                         else if(stepDataSet.contains(rule.id)){
                         
                             formula += 'pmStep.'+stepFormulaMap.get(rule.id);
                             
                             rule.type = 'integer';
    
                         }
                         else if(rule.id == 'PM_Review__c'){
                             formula += 'stage.'+rule.id;
                         }
                         else if(rule.id == 'Manual_Bypass__c'){
                                 formula += 'step.'+rule.id;
                         }
                         else{
                             formula += 'pmtool.'+rule.id;
                         }
                         
                         if(addOperator){
                         
                             if(rule.operator == 'contains' || rule.operator == 'not_contains'){
                                 
                                 formula += '.contains(\''+rule.value+'\')';
                             }
                             else if(rule.operator == 'begins_with' || rule.operator == 'not_begins_with'){
                             
                                 formula += '.startswith(\''+rule.value+'\')';
                             }
                             else if(rule.operator == 'ends_with' || rule.operator == 'not_ends_with'){
                             
                                 formula += '.endsWith(\''+rule.value+'\')';
                             }
                             else{
                                 formula += operatorMap.get(rule.operator);
                                 
                                 if(rule.type == 'string' && rule.value != null){
                                     formula += '\''+rule.value+'\'';
                                 }
                                 else{
                                     formula += rule.value;
                                 }
                             }
                             
                         }
                                          
                         if(j != rule_size){
                             formula += conditionMap.get(formulaObj.condition);
                         }
                     }
                     

                     
                     
                 }
                 
                 if(i == formula_size){
                     formula += '){result = '+formulaObj.score+';}';
                 }
                 else{
                     formula += '){result = '+formulaObj.score+';}else if(';
                 }
                 
                 

             }
             formula += 'else{result = 0;}';
             //original_formulaString = original_formulaString.removeStart('[');
             //original_formulaString = original_formulaString.removeEnd(']');
             
             //system.assert(false,formula);
             Business_Installation_Step__c bStepObj = [select id, Formula__c from Business_Installation_Step__c where id =: selectedStep];
             bStepObj.Formula__c = formula;
             bStepObj.Formula_Json__c = formulaString;
             
             
             update bStepObj ;
             
           ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.INFO, 'Formula Saved Successfully');
           ApexPages.addMessage(errMsg);
           
           }
           
         
         }
         catch(Exception e){
             //system.assert(false, e.getMessage()+' '+e.getStackTraceString());
             ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()+' '+e.getStackTraceString());
             ApexPages.addMessage(errMsg);
           
         }  
    }
    
     public void saveFormulaForStage(){
    
           try{
        
            
            
             //String original_formulaString = formulaString;
             //system.assert(false, formulaString);
             //formulaString =  '[{ "condition": "OR", "rules": [{ "condition": "AND", "rules": [{ "id": "hoa_approval_required__c", "field": "hoa_approval_required__c", "type": "boolean", "input": "text", "operator": "equal", "value": "true" }, { "id": "hoa_appr_comp_date__c", "field": "hoa_appr_comp_date__c", "type": "date", "input": "text", "operator": "is_not_null", "value": null }] }, { "condition": "AND", "rules": [{ "id": "hdlc_approval__c", "field": "hdlc_approval__c", "type": "boolean", "input": "text", "operator": "equal", "value": "true" }, { "id": "hdlc_appr_comp_date__c", "field": "hdlc_appr_comp_date__c", "type": "date", "input": "text", "operator": "is_not_null", "value": null }] }], "score": "2" }]';
             formulaString =  '{"formula":'+formulaString+'}';
             String formula = 'if(';
             FormulaWrapper fW = new FormulaWrapper();
             fW = (FormulaWrapper) System.JSON.deserialize(formulaString, FormulaWrapper.class);
             
             integer i = 0;
             integer formula_size = fW.formula.size();
             
             fW.formula.sort();

             for(cls_formula formulaObj: fW.formula){
                 i++;
                 
                 integer j = 0;
                 integer rule_size = formulaObj.rules.size();
                 for(cls_rules rule: formulaObj.rules){
                     j++;
                     
                     integer k = 0;
                     system.debug('rule.rules =='+rule.rules);
                     if(rule.rules != null){
                     
                      
                         integer rule_inner_size = rule.rules.size();
                         system.debug('rule.rules =='+rule.rules);
      
                         formula += '(';
                         for(cls_rules rule_in: rule.rules){
                             k++;
                             Boolean addOperator_in = true;
                             
                             if(rule_in.operator == 'not_begins_with' || rule_in.operator == 'not_contains' || rule_in.operator == 'not_ends_with'){
                                 formula += '!';
                             }
                             
                             if(stageDataSet.contains(rule_in.id)){
                             
                                 formula += 'pmStage.'+stageFormulaMap.get(rule_in.id);
                                 
                                 rule_in.type = 'integer';
        
                             }
                             else if(stepDataSet.contains(rule_in.id)){
                             
                                 formula += 'pmStep.'+stepFormulaMap.get(rule_in.id);
                                 
                                 rule_in.type = 'integer';
        
                             }
                             else if(rule_in.id == 'PM_Review__c'){
                                 formula += 'stage.'+rule_in.id;
                             }
                             else{
                                 formula += 'pmtool.'+rule_in.id;
                             }
                             
                             if(addOperator_in){
                                 if(rule_in.operator == 'contains' || rule_in.operator == 'not_contains'){
                                 
                                     formula += '.contains(\''+rule_in.value+'\')';
                                 }
                                 else if(rule_in.operator == 'begins_with' || rule_in.operator == 'not_begins_with'){
                                 
                                     formula += '.startswith(\''+rule_in.value+'\')';
                                 }
                                 else if(rule_in.operator == 'ends_with' || rule_in.operator == 'not_ends_with'){
                                 
                                     formula += '.endsWith(\''+rule_in.value+'\')';
                                 }
                                 else{
                                     formula += operatorMap.get(rule_in.operator);
                                     
                                     if(rule_in.type == 'string' && rule_in.value != null){
                                         formula += '\''+rule_in.value+'\'';
                                     }
                                     else{
                                         formula += rule_in.value;
                                     }
                                 }
                             }
                                              
                             if(k != rule_inner_size){
                                 formula += conditionMap.get(rule.condition);
                             }
                             
                         }
                         if(k == rule_inner_size){
                             formula += ')';
                             //formula += conditionMap.get(formulaObj.condition);
                         }
                         
                          if(j != rule_size){
                             //formula += ')';
                             formula += conditionMap.get(formulaObj.condition);
                         }
                         
                         
                     }
                     else{
                         Boolean addOperator = true;
                         
                         if(rule.operator == 'not_begins_with' || rule.operator == 'not_contains' || rule.operator == 'not_ends_with'){
                             formula += '!';
                         }
                         
                         if(stageDataSet.contains(rule.id)){
                         
                             formula += 'pmStage.'+stageFormulaMap.get(rule.id);
                             
                             rule.type = 'integer';
    
                         }
                         else if(stepDataSet.contains(rule.id)){
                         
                             formula += 'pmStep.'+stepFormulaMap.get(rule.id);
                             
                             rule.type = 'integer';
    
                         }
                         else if(rule.id == 'PM_Review__c'){
                             formula += 'stage.'+rule.id;
                         }
                         else{
                             formula += 'pmtool.'+rule.id;
                         }
                         
                         if(addOperator){
                         
                             if(rule.operator == 'contains' || rule.operator == 'not_contains'){
                                 
                                 formula += '.contains(\''+rule.value+'\')';
                             }
                             else if(rule.operator == 'begins_with' || rule.operator == 'not_begins_with'){
                             
                                 formula += '.startswith(\''+rule.value+'\')';
                             }
                             else if(rule.operator == 'ends_with' || rule.operator == 'not_ends_with'){
                             
                                 formula += '.endsWith(\''+rule.value+'\')';
                             }
                             else{
                                 formula += operatorMap.get(rule.operator);
                                 
                                 if(rule.type == 'string' && rule.value != null){
                                     formula += '\''+rule.value+'\'';
                                 }
                                 else{
                                     formula += rule.value;
                                 }
                             }
                             
                         }
                                          
                         if(j != rule_size){
                             formula += conditionMap.get(formulaObj.condition);
                         }
                     }
                     

                     
                     
                 }
                 
                 if(i == formula_size){
                     formula += '){result = '+formulaObj.score+';}';
                 }
                 else{
                     formula += '){result = '+formulaObj.score+';}else if(';
                 }
                 
                 

             }
             formula += 'else{result = 0;}';
             //original_formulaString = original_formulaString.removeStart('[');
             //original_formulaString = original_formulaString.removeEnd(']');
             
             //system.assert(false,formula);
             Business_Stage__c bStageObj = [select id, Formula__c from Business_Stage__c where id =: selectedStage];
             bStageObj.Formula__c = formula;
             bStageObj.Formula_Json__c = formulaString;
             update bStageObj;
             
             
           ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.INFO, 'Formula Saved Successfully');
           ApexPages.addMessage(errMsg);
           
         
         }
         catch(Exception e){
             //system.assert(false, e.getMessage()+' '+e.getStackTraceString());
             ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()+' '+e.getStackTraceString());
             ApexPages.addMessage(errMsg);
           
         }  
    }
    //string formula ='';
    string condition = '';
    string innercondition = '';
    Boolean isChild = false;
    
    
    public String calculateSubstring(String formula, Integer score, String condition){
    
        score++; 
        //system.assert(false,formula);
        Integer pos = formula.lastIndexOf('{result = '+score+';}');
        String temp = formula.substring(0,pos);
        
        String res = formula.replace(temp,'');
        
        score--;
        Integer pos1 = res.lastIndexOf('{result = '+score+';}');
        Integer pos_last = res.lastIndexOf('{result = 0;}');

        String res1 = res.substring(pos1,pos_last);
        String final_res = res.replace(res1,'');
        score++;
        final_res = final_res.replace('{result = '+score+';}else if(','');
        final_res = final_res.replace('){result = 0;}','');
        
        score--;
        final_res = final_res.replace('{result = '+score+';}else if',' '+condition+' ');
        
        
        
        return res;
    }
    
    
    public List<SelectOption> getBusinessStages(){
        bStageList = new List<SelectOption>();
        
        bStageList.add(new SelectOption('', '-------------Select-------------'));
        for(Business_Stage__c bStage: [select id, Name from Business_Stage__c order by name]){
            bStageList.add(new SelectOption(bStage.id, bStage.Name));
        }
        
        return bStageList;
    }
    
    public List<SelectOption> getBusinessSteps(){
        bStepList = new List<SelectOption>();
        
        bStepList.add(new SelectOption('', '-------------Select-------------'));
        for(Business_Installation_Step__c bStep: [select id, Name, Business_stage__r.Business_Market__r.Name from Business_Installation_Step__c order by name]){
            bStepList.add(new SelectOption(bStep.id, bStep.Name+'-'+bStep.Business_stage__r.Business_market__r.Name));
        }
        
        return bStepList;
    }
    
    public List<SelectOption> getMainFilter(){
        mainFilterList = new List<SelectOption>();
        
        mainFilterList.add(new SelectOption('pm_tool_v2', 'PM Tool'));
        mainFilterList.add(new SelectOption('stages', 'Stages'));
        mainFilterList.add(new SelectOption('steps', 'Steps'));
        
        
        return mainFilterList;
    }
    
    public String getBasicRulesForStep() {
        //List<SelectOption> options = new List<SelectOption>();
        try{
      
            String BasicRules = '{condition: \'AND\',rules: [{id: \'name\'}]}';
            if(selectedStep!='' && selectedStep!= null){
               Business_Installation_Step__c bstageFj = [select Formula_Json__c from Business_Installation_Step__c where id =: selectedStep]; 
               if(bstageFj != null && bstageFj.Formula_Json__c != '' && bstageFj.Formula_Json__c != null){
                   BasicRules = bstageFj.Formula_Json__c;
               }
            }
           
            return BasicRules;
        }
        catch(Exception e){
           ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()+' '+e.getStackTraceString());
           ApexPages.addMessage(errMsg);
           return pmToolFields;
       }
    }
    
    public String getBasicRulesForStage() {
        //List<SelectOption> options = new List<SelectOption>();
        try{
      
            String BasicRules = '{condition: \'AND\',rules: [{id: \'name\'}]}';
            if(selectedStage!='' && selectedStage!= null){
               Business_Stage__c bstageFj = [select Formula_Json__c from Business_Stage__c where id =: selectedStage]; 
               if(bstageFj != null && bstageFj.Formula_Json__c != '' && bstageFj.Formula_Json__c != null){
                   BasicRules = bstageFj.Formula_Json__c;
               }
            }
          
            return BasicRules;
        }
        catch(Exception e){
           ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()+' '+e.getStackTraceString());
           ApexPages.addMessage(errMsg);
           return pmToolFields;
       }
    }
    
    
    public void populateSelectedMarketForStage(){
        
        
        for(Business_stage__c bStage : [select id, Business_Market__r.Name from Business_stage__c where id = : selectedStage]){
        
            selectedMarket = bStage.Business_Market__r.Name;
        }
        
        
    }
    
    public void populateSelectedMarketForStep(){
        
        
        for(Business_installation_step__c  bStep : [select id, Business_stage__r.Business_Market__r.Name from Business_installation_step__c where id = : selectedStep]){
        
            selectedMarket = bStep.Business_stage__r.Business_Market__r.Name;
        }
       
        
    }
    
    public string getPmToolFilterData() {
        //List<SelectOption> options = new List<SelectOption>();
        try{
        
            Business_Market__c bm;
           
           if(selectedMarket == ''){
              bm = [select id, Name from Business_Market__c where name = 'CT'];
              selectedMarket = String.valueOf(bm.id);
           }
           else{
              bm = [select id, Name from Business_Market__c where Name =: selectedMarket];
           }
            
            Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get('PM_Tool_V2__c').getDescribe().fields.getMap();
            PmToolFilterWrapperList = new List<PmToolFilterWrapper>();
            for (String fieldName: fieldMap.keySet()) {
                
                String id = fieldName; 
                String label = fieldMap.get(fieldName).getDescribe().getLabel();
                String type = '';
                String input = ''; 
                String values = ''; 

                Schema.DisplayType fielddataType = fieldMap.get(fieldName).getDescribe().getType();
                if(fielddataType == Schema.DisplayType.Id){
                    type = 'string';
                }
                else if(fielddataType == Schema.DisplayType.REFERENCE){
                    type = 'string';
                }
                else if(fielddataType == Schema.DisplayType.currency){
                    type = 'double';
                }
                else if(fielddataType == Schema.DisplayType.picklist){
                    type = 'string';
                }
                else{
                    type = String.valueOf(fielddataType).toLowerCase();
                }
                
                /*if(inputMap.containsKey(type)){
                    input = inputMap.get(type);
                    if(input == 'radio'){
                        values = '{true: \'True\',false: \'False\'}';
                    }
                    
                }*/
                PmToolFilterWrapperList.add(new PmToolFilterWrapper(id, label, type, input, values));
                pmtoolFieldsDataSet.add(id); 
            }
            
            //PmToolFilterWrapperList.add(new PmToolFilterWrapper('name', 'name', 'string', '', ''));
            
            PmToolFilterWrapperList.add(new PmToolFilterWrapper('blank1', '------------Stages-------------', 'string', '', ''));
            
            for(Business_stage__c stage : [select id, name, formula__c from Business_stage__c where business_market__c =: bm.id]){
                system.debug('blank1== bmid========'+bm.id);
                system.debug('blank1== stage========'+stage);
                PmToolFilterWrapperList.add(new PmToolFilterWrapper(stage.id, stage.Name, 'string', '', ''));
                stageDataSet.add(stage.id);
                stageFormulaMap.put(stage.id, stage.Name); 
            }
            
            PmToolFilterWrapperList.add(new PmToolFilterWrapper('blank2', '------------Steps-------------', 'string', '', ''));
            
            for(Business_installation_step__c step : [select id, name, formula__c from Business_installation_step__c where business_stage__r.business_market__c = : bm.id]){
                PmToolFilterWrapperList.add(new PmToolFilterWrapper(step.id, step.Name, 'string', '', ''));
                stepDataSet.add(step.id); 
                stepFormulaMap.put(step.id, step.Name); 
            }
            
            PmToolFilterWrapperList.add(new PmToolFilterWrapper('blank3', '-----------PM Review------------', 'string', '', ''));
            PmToolFilterWrapperList.add(new PmToolFilterWrapper('PM_Review__c', 'PM Review', 'boolean', '', ''));
            
            PmToolFilterWrapperList.add(new PmToolFilterWrapper('blank4', '-----------Manual Bypass------------', 'string', '', ''));
            PmToolFilterWrapperList.add(new PmToolFilterWrapper('Manual_Bypass__c', 'Manual Bypass', 'boolean', '', ''));
            
            //pmToolFilters = '[{id: \'NA_Override\',label: \'NA Override\',type: \'boolean\'},{id: \'Aging\',label: \'Aging\',type: \'integer\'}]';
            
            return JSON.serialize(PmToolFilterWrapperList);
            
        }
        catch(Exception e){
           ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()+' '+e.getStackTraceString());
           ApexPages.addMessage(errMsg);
           return null;
       }
    }
    
    public class PmToolFieldWrapper{
        public String id{get;set;}
        public PmToolFieldWrapper(String id){
            this.id = id;
        }
    }
    
    public class PmToolFilterWrapper{
        public String id{get;set;}
        public String label{get;set;}
        public String type{get;set;}
        public String input{get;set;}
        public String values{get;set;}
        public PmToolFilterWrapper(String id, String label, String type, String input, String values){
            this.id = id;
            this.label = label;
            this.type = type;
            this.input = input;
            this.values = values;
        }
    }
    
    public class FormulaWrapper{
        public cls_formula[] formula;
    }
    
    public class cls_formula implements Comparable{
        public String condition;
        public Integer score;
        public cls_rules[] rules;
        
        public Integer compareTo(Object compareTo) 
        {
            cls_formula cformula = (cls_formula) compareTo;
            
            //Integer scorei = Integer.valueOf(score);
            //Integer scoreci = Integer.valueOf(cformula.score);
            
            if (score == -1) return -1;
            if (score == cformula.score) return 0;
            if (score < cformula.score) return 1;
            return -1;        
        }
        
    }
    
    public class cls_rules {
        public cls_rules[] rules;
        public String id;   //intro_call__c
        public String field;    //intro_call__c
        public String type; //boolean
        public String input;    //text
        public String operator; //equal
        public String value; 
        public String condition;   //true
    }
}