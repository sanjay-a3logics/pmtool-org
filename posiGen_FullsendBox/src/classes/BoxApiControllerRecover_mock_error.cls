@isTest
public with sharing class BoxApiControllerRecover_mock_error implements HttpCalloutMock{
  public HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        String Body='{"type": "error","id": "11446498","name": "Pictures"}';
        res.setBody(Body);
        res.setStatusCode(201);
        return res;
    }
}