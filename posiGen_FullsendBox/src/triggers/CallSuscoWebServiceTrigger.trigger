trigger CallSuscoWebServiceTrigger on Opportunity (before insert)  
{
        for(Opportunity opp: trigger.new)
        {
            String userName = 'HellRaZor';
            String parm1 = opp.Id;
            String parm2 = 'Ahhahhh';
            String procName='usp_test';
            
            HttpRequest req = new HttpRequest();
            HttpResponse res = new HttpResponse();
            Http http = new Http();

            
        
            String parmArray = '{"user":"mhousey","procName":"SF_CreatePropertyFromNewOpp","@newOppurtunityID":"' + parm1 + '"}';
    
            req.setEndpoint('http://dev.susco.net:88/SuscoSalesForceSQLAPI/ExecuteSproc');
            req.setMethod('POST');
            req.setBody(EncodingUtil.urlEncode(parmArray, 'UTF-8'));
            req.setCompressed(true); // otherwise we hit a limit of 32000
        
            try 
            {
                res = http.send(req);
            } 
            catch(System.CalloutException e) 
            {
                System.debug('Callout error: '+ e);
                System.debug(res.toString());
            }        
                   
        }
    
}