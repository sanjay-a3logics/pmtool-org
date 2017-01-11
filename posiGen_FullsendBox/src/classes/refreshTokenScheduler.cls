public without sharing class refreshTokenScheduler implements Schedulable,Database.AllowsCallouts {
   // public Box__c bx; 
   // public Box__c bxOrg; 
    public string code;
    public refreshTokenScheduler() {
        
    }
    
    public void execute(SchedulableContext sc) {
        refreshTokenScheduler.getToken();
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
            Box__c bx=Box__c.getInstance();
            Box__c bxOrg=Box__c.getInstance(UserInfo.getOrganizationId());

            Datetime currentTime = datetime.now();  
            Datetime newTime= currentTime.addMinutes(45);
            String sch= String.valueOf(newtime.second()) +' ' + String.valueOf(newtime.minute()) + ' ' + String.valueOf(newTime.hour()) + ' ' + String.valueOf(newTime.day()) + ' ' + String.valueOf(newTime.month()) + ' ? ' +  String.valueOf(newTime.year());  
            refreshTokenScheduler scheduleObject = new refreshTokenScheduler();
            Double st = Math.random();
            String jobID = system.schedule('refreshTokenScheduler '+newTime+String.valueOf(st) , sch, scheduleObject ); 
            
            bxOrg.Last_Job_Id__c = jobID;
            bx.Last_Job_Id__c = jobID;
            upsert bxOrg;
            upsert bx;
        }
    }
    
    
    public class tokenWrapper{
        public string access_token;
        public string refresh_token;
        public string client_id;
        public string client_secret;
    }

}