public with sharing class ExplicitLogin {

    private static final String NS_SOAP = 'http://schemas.xmlsoap.org/soap/envelope/';
    private static final String NS_SF = 'urn:partner.soap.sforce.com';
    private static final String POST_METHOD = 'POST';
    private static String EndPointUrl = null;
    
    public static String login(){
        try{
            Login_access__c mts = [select Username__c,Password__c,EndPointUrl__c,security_token__c from Login_access__c][0];
            string user ;//='your username';
            string password ;//= 'password';
            user = mts.Username__c;
            password = mts.Password__c + mts.security_token__c ;
            EndPointUrl = 'https://test.salesforce.com/services/Soap/u/29.0';
            
            // As per http://wiki.developerforce.com/page/Enterprise_Login
            HttpRequest req = new HttpRequest();
            req.setMethod(POST_METHOD);   
            req.setTimeout(60000);
            req.setEndpoint(EndPointUrl);
            req.setHeader('Content-Type', 'text/xml;charset=UTF-8');        
            req.setHeader('SOAPAction', '""');
            req.setBody('<Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/"><Header/><Body><login xmlns="urn:partner.soap.sforce.com"><username>' +user+ '</username><password>' + password + '</password></login></Body></Envelope>');        
               
            HttpResponse res =  new Http().send(req);   
            
            //system.assert(false, res.getStatusCode()+'----'+ res.getBody());             

            /*
            system.debug('@@@Request:' + req + '#### Response status:' + res.getStatusCode());
            if(res.getStatusCode() != 200){
                Dom.Document responseDocument = res.getBodyDocument();
                Dom.Xmlnode rootElm = responseDocument.getRootElement(); // soapenv:Envelope
                Dom.Xmlnode bodyElm = rootElm.getChildElement('Body', NS_SOAP); // soapenv:Body 
                Dom.Xmlnode faultElm = bodyElm.getChildElement('Fault', NS_SOAP); // soapenv:Fault
                Dom.Xmlnode faultStringElm = faultElm.getChildElement('faultstring', null); // faultstring          
                throw new LoginException(faultStringElm.getText()); 
            }  
            */
                          
            Dom.Document responseDocument = res.getBodyDocument();
            Dom.Xmlnode rootElm = responseDocument.getRootElement(); // soapenv:Envelope
            Dom.Xmlnode bodyElm = rootElm.getChildElement('Body', NS_SOAP); // soapenv:Body 
            Dom.Xmlnode loginResponseElm = bodyElm.getChildElement('loginResponse', NS_SF); // loginResponse
            Dom.Xmlnode resultElm = loginResponseElm.getChildElement('result', NS_SF); // result
            Dom.Xmlnode sessionIdElm = resultElm.getChildElement('sessionId', NS_SF); // sessionId
            return sessionIdElm.getText();     
        }
        catch(exception e){
            system.debug('***'+e.getMessage()+'**'+e.getLineNumber());
            return null ;
        }
    }

    public class LoginException extends Exception {}
}