public without sharing class BoxREFRESHAccessTokenScheduler2 implements Schedulable {
   // public Box__c bx; 
   // public Box__c bxOrg; 
    public string code;
    public BoxREFRESHAccessTokenScheduler2() {
        
    }
    
    public void execute(SchedulableContext sc) {
        BoxREFRESHAccessTokenScheduler2.getToken();
    }
    
    @future(callout = true)
    public static void getToken(){
        try{
            Box__c bx=Box__c.getInstance();
            Box__c bxOrg=Box__c.getInstance(UserInfo.getOrganizationId());
            Http h = new Http();
            HttpRequest hrq = new HttpRequest();
            hrq.setEndPoint('https://api.box.com/oauth2/token');
            hrq.setMethod('POST');//code
            String requestBody = 'grant_type=refresh_token&refresh_token='+bxOrg.Boxrefresh_token__c+'&client_id='+bxOrg.Boxclient_Id__c+'&client_secret='+bxOrg.Boxclient_Secret__c;
            hrq.setBody(requestBody);
            HttpResponse hresp = h.send(hrq);
            //System.assert(false,hresp.getBody());
            System.debug('-----------------------------------------------------'+hresp.getBody());
            tokenWrapper tw =(tokenWrapper)JSON.deserialize(hresp.getBody(),tokenWrapper.class);
            bx.BoxAccess_Token__c = tw.access_token;
            bx.Boxrefresh_token__c = tw.refresh_token;
            bxOrg.BoxAccess_Token__c = tw.access_token;
            bxOrg.Boxrefresh_token__c = tw.refresh_token;
            update bx;
            update bxOrg;
        }
        
        catch(Exception e){}
        
        finally{
        
        
        }
        
       
    }
   
   public class tokenWrapper{
        public string access_token;
        public string refresh_token;
        public string client_id;
        public string client_secret;
    } 
    

}