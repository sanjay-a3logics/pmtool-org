@isTest
public with sharing class BoxApiController_mock implements HttpCalloutMock{
    public HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        String Body='{"type": "folder","id": "11446498","name": "Pictures - EE"}';
        res.setBody(Body);
        res.setStatusCode(201);
        return res;
    }
}