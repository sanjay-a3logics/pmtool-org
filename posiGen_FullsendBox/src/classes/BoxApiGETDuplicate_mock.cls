@isTest
public with sharing class BoxApiGETDuplicate_mock implements HttpCalloutMock{
    public HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        String Body='{"type": "folder","id": "11446498","name": "Pictures"}';
        res.setBody(Body);
        res.setStatusCode(200);
        return res;
    }
}