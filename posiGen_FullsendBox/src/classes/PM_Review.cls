public class PM_Review{

    public String pmToolId;
    public static Boolean pmReviewed = false;
    public List<PM_Stage__c> pmStageList{get;set;}

    public PM_Review(ApexPages.StandardController controller) {
        
        pmStageList = new List<PM_Stage__c>();
    }

    
    public void loadPmReview(){
        
        try{
        
            pmToolId = ApexPages.currentPage().getParameters().get('id');
            if(pmToolId != null && pmToolId != ''){
                
                pmStageList = [select id, Business_Installation_Stage__r.Name, Business_Status__r.Name, Business_Status__r.Score__c, PM_Review__c, PM_Tool_V2__c from PM_Stage__c where PM_Tool_V2__c =: pmToolId and (Business_Status__r.Score__c = 3 or Business_Status__r.Score__c = 4)];
            }
            else{
            
               ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'PM Tool id is not provided');
               ApexPages.addMessage(errMsg);
            }
        }
        catch(Exception e){
           ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()+', '+e.getStackTraceString());
           ApexPages.addMessage(errMsg);
        }
        
    }
    
    public PageReference saveStages(){
        
        try{
            pmReviewed = true;
            update pmStageList;
            return new PageReference('/'+pmToolId);
        }
        catch(Exception e){
           ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()+', '+e.getStackTraceString());
           ApexPages.addMessage(errMsg);
           
           return null;
        }
    }
}