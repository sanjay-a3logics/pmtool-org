@isTest
public with sharing class BoxApiController_mock1 implements HttpCalloutMock{
    public HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        String Body='{"type": "folder","id": "11446498","name": "Pictures"}';
        res.setBody(Body);
        res.setStatusCode(429);
        
        

        return res;
    }
}