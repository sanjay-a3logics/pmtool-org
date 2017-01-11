/*
*  This is the controller for the visualforce page PMTool
*/
public class PMToolV2Controller{

    //public variables
    public static integer fresult;
    public List<BusinessStageWrapper> businessInstallationStepList{get;set;}
    public CustomerDetailWrapper customerDetailWrapperObj{get;set;}
    public transient List<PMWrapper> lstPMWrapper{get;set;}
    public String selectedMarket{get;set;}
    public Decimal averageCompletion {get;set;}
    public Integer activeProjects{get;set;}
    public String selectedProjectManager{get;set;}
    public String customerId{get;set;}
    public List<SelectOption> projectManagerList{get;set;}
    public Boolean stateChanged{get;set;}
    public List<SelectOption> filterStepList{get;set;}
    public List<Business_Installation_Step__c> bisFilterList{get;set;}
    public List<Business_Status__c> bStatusFilterList{get;set;}
    public String filterText{get;set;}
    public String filterConditions{get;set;}
    public List<String> temList{get;set;}
    public static Boolean updateStagesFirstRun = true;
    public Set<Id> pmToolIdSet;
    //public Paginate paginater {get;set;}
    public transient List<PMWrapper> genericList{get;set;} 
    public transient List<List<PMWrapper>> fullGenericList{get;set;}

    
    //class constructor
    public PMToolV2Controller(){
    
       try{
           selectedMarket = '';
           averageCompletion = 0;
           activeProjects = 0;
           customerId = '';
           stateChanged = false;
           selectedProjectManager = '';
           businessInstallationStepList = new List<BusinessStageWrapper>();
           customerDetailWrapperObj = new CustomerDetailWrapper(new PM_Tool_V2__c(), 0.00, new List<CustomerDetailFieldWrapper>());
           filterStepList = new List<SelectOption>();
           bisFilterList = new List<Business_Installation_Step__c>();
           bStatusFilterList = new List<Business_Status__c>();
           temList = new List<String>();
           temList.add('1');
           for(Business_Status__c bStatus: [select id, name, score__c from Business_Status__c where name != 'Confirmed Completed']){
               bStatusFilterList.add(bStatus);
           }

           loadData(); 
           
    
       }
       catch(Exception e){
           system.debug(e.getMessage()+' '+e.getStackTraceString());
       }
    }
    
    /*public PageReference previousPage(){ 
        this.paginater.decrement(); 
        return changeData(); 
    } 
    
    public PageReference nextPage(){ 
        this.paginater.increment(); 
        return changeData(); 
    } 
    
    public PageReference updatePage(){ 
        this.paginater.updateNumbers(); 
        return changeData(); 
    } 
    
    public PageReference changeData(){ 
        this.genericList = this.fullGenericList.get(this.paginater.index); 
        return null; 
    }*/
    
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
    
    public void populateProjectManagersList(String market) {
        projectManagerList = new List<SelectOption>();
        try{
            Set<SelectOption> innerSet = new Set<SelectOption>();
            projectManagerList.add(new SelectOption('', '--Select--'));
            for(PM_Tool_V2__c pm : [select Project_Manager__c from PM_Tool_V2__c where Project_Manager__c != null and Project_Manager__c != ' ' and State__c =:market and Project_Status__c = 'Active']){
                innerSet.add(new SelectOption(pm.Project_Manager__c, pm.Project_Manager__c));
            }
            for(SelectOption so : innerSet){
                projectManagerList.add(so);
            }
        }
        catch(Exception e){
           ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()+'-- In PopulateManager() --'+e.getStackTraceString());
           ApexPages.addMessage(errMsg);
       }
    }
    
    public void populateFilterList(List<Business_Installation_Step__c> bisFilterList) {
        filterStepList = new List<SelectOption>();
        try{

            filterStepList.add(new SelectOption('', '--Select--'));
            for(Business_Installation_Step__c bis : bisFilterList){
                filterStepList.add(new SelectOption(bis.id, bis.Name));
            }

        }
        catch(Exception e){
           ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()+'-- In PopulateManager() --'+e.getStackTraceString());
           ApexPages.addMessage(errMsg);
       }
    }
    
    public void loadData(){
       try{ 
           //system.assert(false, '---------------'+filterText); 
           lstPMWrapper = new List<PMWrapper>();
           businessInstallationStepList = new List<BusinessStageWrapper>();        
           Business_Market__c bm;
           
           if(selectedMarket == ''){
              bm = [select id, Name from Business_Market__c where name = 'CT'];
              selectedMarket = String.valueOf(bm.id);
           }
           else{
              bm = [select id, Name from Business_Market__c where id =: selectedMarket];
           }
           
           populateProjectManagersList(bm.Name);
           
           Map<Id, List<Business_Installation_Step__c>> bisMap = new Map<Id, List<Business_Installation_Step__c>>();
           for(Business_Stage__c stage : [select id, name from Business_Stage__c where Business_Market__c =: bm.id and Display_In_Tracker__c = true order by Sequence__c]){
               bisMap.put(stage.id,new List<Business_Installation_Step__c>());
           }
          
           bisFilterList = new List<Business_Installation_Step__c>();
           for(Business_Installation_Step__c bis : [select id,name,Business_Stage__r.name,Sequence__c from Business_Installation_Step__c where Business_Stage__r.Business_Market__c =: bm.id and Display_In_Tracker__c = true order by Sequence__c]){
               
               if(bisMap.containsKey(bis.Business_Stage__c)){
                  bisMap.get(bis.Business_Stage__c).add(bis);
                  bisFilterList.add(bis);
               }
           }
           
           for(Business_Stage__c stage : [select id, name from Business_Stage__c where Business_Market__c =: bm.id and Display_In_Tracker__c = true order by Sequence__c]){
               if(bisMap.containsKey(stage.id)){

                   //bisMap.get(stage.id).sort();
                   BusinessStageWrapper pmw = new BusinessStageWrapper(stage, bisMap.get(stage.id));
                   
                   pmw.size=bisMap.get(stage.id).size();
                   
                   businessInstallationStepList.add(pmw);
               }
           }
           
           for(BusinessStageWrapper bsw :  businessInstallationStepList){
               if(bsw.bStepsList.size() == 0){
                   bsw.bStepsList.add(new Business_Installation_Step__c());
               }
           }
           
           //system.assert(false, businessInstallationStepList.size());

           String query = 'select id,';
           query += 'Completion_Average__c,Project_Manager__c, Customer_Name__c, State__c, Address__c,Opportunity_Numeric_ID__c, Opportunity__c, Contract_Signed_Date__c, Contract_Approved_Date__c, System_Size__c,Aging_since_Contract_Signed__c,Aging_Since_Contract_Approved__c'; 
           query += ' from PM_Tool_V2__c where Project_Status__c = \'Active\'';
           
           Set<String> stateSet = new Set<String>();
           if(bm.Name == 'CT'){
               query += ' and (State__c = \'CT\' or State__c = \'Connecticut\')';
               stateSet.add('CT');
               stateSet.add('Connecticut');
           }
           else if(bm.Name == 'NY'){
               query += ' and (State__c = \'NY\' or State__c = \'New York\')';
               stateSet.add('NY');
               stateSet.add('New York');
           }
           else if(bm.Name == 'LA'){
               query += ' and (State__c = \'LA\' or State__c = \'LOUISIANA\')';
               stateSet.add('LA');
               stateSet.add('LOUISIANA');
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
           
           //System.debug('---------'+query );
           //System.debug('---------'+stateSet );
           
           if(filterText != null && filterText != ''){
               //system.assert(false, filterText);
               FilterWrapper filterWr = (FilterWrapper) System.JSON.deserialize(filterText, FilterWrapper.class);
               String f_query = 'select count(id), PM_Tool_V2__c from PM_Steps__c where id != null';
               Set<String> status = new Set<String>();
               Set<String> BST = new Set<String>();
               
               integer i = 1;
               if(filterWr.data.size() > 1){
                   f_query +=' and ('; 
                   for(cls_data dwr : filterWr.data){
                       
                       if(i == 1){
                           f_query +='(Business_Installation_Step__r.Name = \''+dwr.step+'\' and Business_Status__r.Name = \''+dwr.status+'\' )';
                       }
                       else{
                           f_query +=' or (Business_Installation_Step__r.Name = \''+dwr.step+'\' and Business_Status__r.Name = \''+dwr.status+'\')';
                       }
                       i++;    
                       status.add(dwr.status);
                       BST.add(dwr.step);
                   }
                   
                   f_query +=')';
                   
                   f_query +=' group by PM_Tool_V2__c having count(id) = '+(i-1);
               }
               else{
                   for(cls_data dwr : filterWr.data){
                       f_query +=' and Business_Installation_Step__r.Name = \''+dwr.step+'\' and Business_Status__r.Name = \''+dwr.status+'\' group by PM_Tool_V2__c';
                   }
               }
               
               //system.assert(false,f_query );
               
               pmToolIdSet = new Set<Id>();
               for(AggregateResult ar : Database.query(f_query)){
                   pmToolIdSet.add((Id)ar.get('PM_Tool_V2__c'));
               }
               
               query += ' and id in :pmToolIdSet';

               
           }
           
           List<String> ordered_keys = new List<String>();
           Map<id,List<PM_Steps__c>> pmStepsMap = new Map<id,List<PM_Steps__c>>();
           for(PM_Steps__c step : [select id, PM_Stage__c, Aging__c, Business_Status__r.Name, PM_Review_Aging_Exception__c, Business_Status__r.Score__c, End_Date__c, In_Process_Aging__c, In_Process_Aging_Exception__c, In_Process_End_Date__c, In_Process_Start_Date__c, NA_Override__c, Start_Date__c, Business_Installation_Step__r.Name from PM_Steps__c where PM_Stage__r.PM_Tool_V2__r.State__c in :stateSet and Business_Installation_Step__r.Display_In_Tracker__c = true order by Business_Installation_Step__r.Sequence__c]){
               if(!pmStepsMap.containsKey(step.PM_Stage__c)){
                   pmStepsMap.put(step.PM_Stage__c,new List<PM_Steps__c>());
                   ordered_keys.add(step.PM_Stage__c);
               }
               pmStepsMap.get(step.PM_Stage__c).add(step);
               
           }
           
           Map<id,List<PM_Stage__c>> pmStagesMap = new Map<id,List<PM_Stage__c>>();
           for(PM_Stage__c stage : [select id, PM_Tool_V2__c, name, Business_Status__c, Business_Status__r.Score__c, Business_Installation_Stage__r.Name from PM_Stage__c where PM_Tool_V2__r.State__c in :stateSet and Business_Installation_Stage__r.Display_In_Tracker__c = true order by Business_Installation_Stage__r.Sequence__c]){
               if(!pmStagesMap.containsKey(stage.PM_Tool_V2__c)){
                   pmStagesMap.put(stage.PM_Tool_V2__c,new List<PM_Stage__c>());
               }
               pmStagesMap.get(stage.PM_Tool_V2__c).add(stage);
           }
           
           
    
           Decimal totalCompletionAvg = 0;
           for(PM_Tool_V2__c pmtool : Database.query(query)){
               
               List<PMStageWrapper> pmStageWrapper = new List<PMStageWrapper>();
               if(pmStagesMap.containsKey(pmtool.id)){
                   for(PM_Stage__c stage : pmStagesMap.get(pmtool.id)){
                       
                       List<PM_Steps__c> pmStepsList = new List<PM_Steps__c>();
                       if(pmStepsMap.containsKey(stage.id)){
                           //pmStepsMap.get(stage.id).sort();
                           for(PM_Steps__c step : pmStepsMap.get(stage.id)){
                               pmStepsList.add(step);
                           }
                       }
                       pmStageWrapper.add(new PMStageWrapper(stage, pmStepsList));
                   } 
               }
               
               if(pmStageWrapper.size() > 0){
                   Decimal avg = 0;
               
                   if(pmtool.Completion_Average__c!=null){
                       avg = pmtool.Completion_Average__c.setScale(2, RoundingMode.HALF_UP);
                       //avg = pmtool.Completion_Average__c;
                   }
               
                   totalCompletionAvg = totalCompletionAvg + avg;

                   lstPMWrapper.add(new PMWrapper(pmtool,pmtool.Completion_Average__c,pmStageWrapper));
               
               }
           }
           
           // pagination
           /*Integer pageSize = 10;
           
           this.paginater = new Paginate(lstPMWrapper.size(), pageSize);
           
           this.fullGenericList = new List<List<PMWrapper>>(); 
           this.genericList = new List<PMWrapper>();
           
           if(lstPMWrapper.size() > 0){ 
                List<PMWrapper> tempCC = new List<PMWrapper>(); 
                
                Integer i = 0; 
                for(PMWrapper cc : lstPMWrapper){ 
                    tempCC.add(cc); 
                    i++; 
                    
                    if(i == pageSize){ 
                        this.fullGenericList.add(tempCC); 
                        tempCC = new List<PMWrapper>(); 
                        i = 0; 
                    } 
                } 
                
                if(!tempCC.isEmpty()){ 
                    this.fullGenericList.add(tempCC); 
                } 
                
                this.genericList = this.fullGenericList.get(this.paginater.index); 
           } */
           
          // system.debug('this.genericList.size()==='+this.genericList.size());
           // -----------------------------------------------------------------
           activeProjects = lstPMWrapper.size();
           
           if(lstPMWrapper.size()>0){
               averageCompletion = totalCompletionAvg / lstPMWrapper.size();
               averageCompletion = averageCompletion.setScale(0, RoundingMode.HALF_UP); 
           }
           else{
               averageCompletion = 0;
           }
           //system.assert(false, businessInstallationStepList.size());
       }
        catch(Exception e){
           ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()+' '+e.getStackTraceString());
           ApexPages.addMessage(errMsg);
       }
   
    }
    
    public String getEvalConditions() {
        String span1 = '';
        String span2 = '</span>';
        Integer num = 0;
        if(filterConditions != null) {
            while(filterConditions.contains('<span id="dtext_')) {
                span1 = '<span id="dtext_'+num+'">';
                filterConditions = filterConditions.replace(span1,'');
                filterConditions = filterConditions.replace(span2,'');
                num++;
            }
        }
        if(filterConditions!=null)
        filterConditions.replaceAll('amp;','');
        //system.assert(false,filterConditions);    
        return filterConditions;
    }    
  
    
    
    
    //sanjay
     public void viewCustomerDetail(){
     
    
       //PageReference customerPage = new PageReference('/apex/PM_Customer_Detail_V2');
       try{
              customerId = ApexPages.currentPage().getParameters().get('customerId');
              
              
              
              List<CustomerDetailFieldWrapper> CustomerDetailFieldWrapperList = new List<CustomerDetailFieldWrapper>();
               
               String query = 'select id,';
             
               query += 'Completion_Average__c, Project_Manager__c, Actual_System_Size__c, Email__c, Primary_Phone__c, Secondary_Phone__c, Lease_Type__c, EE_Accepted__c, PV_Lease_Payment__c, EE_Lease_Payment__c, Sales_Person__c, Telemarketer__c, Referring_Customer__c, opportunity__r.Numeric_ID__c, Customer_Name__c, State__c, Address__c, Opportunity_Numeric_ID__c, Opportunity__c, Contract_Signed_Date__c, Contract_Approved_Date__c, System_Size__c from PM_Tool_V2__c where Project_Status__c = \'Active\' and id = \''+customerId+'\'';
               //system.assert(false,customerId);      
               PM_Tool_V2__c pmtool = Database.query(query);
               
               List<PM_Steps__c> pmStepsList = new List<PM_Steps__c>();
               for(PM_Steps__c pms : [select id, name, Aging__c, Business_Installation_Step__r.Name, Business_Installation_Step__c, Business_Status__c,Business_Status__r.score__c, End_Date__c, In_Process_Aging__c, In_Process_Aging_Exception__c, In_Process_End_Date__c, In_Process_Start_Date__c, NA_Override__c, PM_Review_Aging__c, PM_Review_Aging_Exception__c, PM_Review_End_Date__c, PM_Review_Start_Date__c, PM_Stage__c, PM_Tool_V2__c, Start_Date__c from PM_Steps__c where PM_Tool_V2__c= :customerId order by Business_Installation_Step__r.Sequence__c]){
                  CustomerDetailFieldWrapper cdfw= new CustomerDetailFieldWrapper(pms);
                  CustomerDetailFieldWrapperList.add(cdfw);                 
               }
             
               customerDetailWrapperObj = new CustomerDetailWrapper(pmtool, pmtool.Completion_Average__c, CustomerDetailFieldWrapperList);
               
               //return customerPage; 
           }    
          catch(Exception e){
            
               ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()+' '+e.getStackTraceString());
               ApexPages.addMessage(errMsg);
               //return customerPage;
          } 
     }
    public class CustomerDetailWrapper {
        
        public PM_Tool_V2__c pmTool{get;set;}
        public Decimal avg{get;set;}
        public List<CustomerDetailFieldWrapper> cdFieldWrapperList{get;set;}
        
        public CustomerDetailWrapper(PM_Tool_V2__c pmTool, Decimal avg, List<CustomerDetailFieldWrapper> cdFieldWrapperList) {
            this.pmTool = pmTool;
            this.avg = avg;
            this.cdFieldWrapperList = cdFieldWrapperList;
        }
    }
    
   /* public class CustomerDetailFieldWrapper {
        
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
    */
    
    //sanjay
    public class CustomerDetailFieldWrapper {
        public string step{get;set;}
        public Boolean na{get;set;}
        public Decimal score{get;set;}
        public Decimal aging{get;set;}
        public Date startDate{get;set;}
        public Date endDate{get;set;}
            
        public CustomerDetailFieldWrapper(PM_Steps__c sObjLst){
        this.step = sObjLst.Business_Installation_Step__r.Name;
        this.na = sObjLst.NA_Override__c;
        this.score = sObjLst.Business_Status__r.score__c;
        this.aging = sObjLst.Aging__c;
        this.startDate = sObjLst.Start_Date__c ;
        this.endDate = sObjLst.End_Date__c;
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