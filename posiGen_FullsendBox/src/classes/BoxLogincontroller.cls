public with sharing class BoxLogincontroller{
    public string refreshtoken{get;set;}
    public string token{get;set;} 
    public string Accesstoken{get;set;}
    public string clientId{get;set;}
    public string clientsecret{get;set;}
    public Boolean isLicenseUser{get;set;}

    public Boolean isLoggedIn{get;set;}
  
    /** Constructor **/
    public BoxLogincontroller(){
        List<String> lsttoken = new List<String>();
        token=ApexPages.currentPage().getParameters().get('token');
        system.debug('checkClient'+token);
       
        if(token!=null){ 
           lsttoken = token.split(',');
        
        Accesstoken = lsttoken[0];
        refreshtoken = lsttoken[1];
        clientId = lsttoken[2];
        clientsecret= lsttoken[3];
        } 
        isLicenseUser=true;
        
        Box__c bx = Box__c.getInstance();
        if(bx.BoxAccess_Token__c == null){
            isLoggedIn = false;
        }
        else{
            isLoggedIn = true;
        }
    }
    public PageReference startup(){
        
        if(Accesstoken!=null){
            try{
                Box__c bx = Box__c.getInstance();
                bx.BoxAccess_Token__c = Accesstoken;
                bx.Boxrefresh_token__c = refreshtoken ;
                bx.Boxclient_Id__c =clientId;
                bx.Boxclient_Secret__c =clientsecret;
                
                upsert bx;

                Box__c bxOrg = Box__c.getInstance(UserInfo.getOrganizationId());
                bxOrg.BoxAccess_Token__c = Accesstoken;
                bxOrg.Boxrefresh_token__c = refreshtoken ;
                bxOrg.Boxclient_Id__c =clientId;
                bxOrg.Boxclient_Secret__c =clientsecret;
                
                upsert bxOrg;
                
                /** Schedule to update AccessToken After each 45 mins **/
                 
                String sch= '0 1 * * * ?';  
                BoxREFRESHAccessTokenScheduler scheduleObject = new BoxREFRESHAccessTokenScheduler();
                String jobID = system.schedule('BoxREFRESHAccessTokenScheduler', sch, scheduleObject); 
                
                String sch1 = '0 30 * * * ?';
                BoxREFRESHAccessTokenScheduler2 scheduleObject1 = new BoxREFRESHAccessTokenScheduler2();
                system.schedule('BoxREFRESHAccessTokenScheduler2', sch1, scheduleObject1);
                
                bx.Last_Job_Id__c = jobID;
                bxOrg.Last_Job_Id__c = jobID;
                update bx;
                update bxOrg;
                
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm,' Access Token "'+bx.BoxAccess_Token__c+'" has been added successfully.'));
                return page.ConfirmPage;
                }
                catch(Exception e){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
                    return null;
                }
                
             }
           else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Invalid Token ! something went wrong,please login again.'));
                return null;
            }
            
    }
    
     public class ErrorWrapper{
        public String type;
        public Integer status;
        public String message;
    }
}