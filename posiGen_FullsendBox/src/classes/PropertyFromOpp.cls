global class PropertyFromOpp
{
    

    webservice static void Create(string id)
    {
        Opportunity opp;
        opp = [SELECT Id,StageName FROM Opportunity WHERE Id= :id]; 
        System.Debug(opp);
        //if(opp.StageName == 'Feasibility Analysis')
        {
            
            System.Debug('Made it here');
            String userName = 'HellRaZor';
            String parm1 = opp.Id;
            String parm2 = 'Ahhahhh';
            String procName='usp_test';
            
            HttpRequest req = new HttpRequest();
            HttpResponse res = new HttpResponse();
            Http http = new Http();

        
      
            String parmArray = '{"user":"mhousey","procName":"SF_CreatePropertyFromNewOpp","@newOppurtunityID":"' + parm1 + '"}';
            System.Debug('Made it here 2');
            req.setEndpoint('http://pgsalesforce.cloudapp.net/SuscoSalesForceSQLAPI/api/ExecuteSproc');
            req.setMethod('POST');
            req.setHeader('Content-Type','application/json');
            req.setHeader('Content-Length','100');
            //req.setBody(EncodingUtil.urlEncode(parmArray, 'UTF-8'));
            
            req.setBody(parmArray);
            //req.setCompressed(true); // otherwise we hit a limit of 32000
        
            try 
            {
                System.Debug('Made it here3');
                res = http.send(req);
                System.Debug(parmArray);
                System.Debug(req);
            } 
            catch(System.CalloutException e) 
            {
                System.Debug('Callout error: '+ e);
                System.Debug(res.toString());
            }           
        }   
    }
    
    
    
}