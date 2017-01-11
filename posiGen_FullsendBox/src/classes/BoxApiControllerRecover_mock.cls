@isTest
public with sharing class BoxApiControllerRecover_mock implements HttpCalloutMock{
	 public HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        String body='{"type": "error","status": 409,"code": "item_name_in_use","context_info": {"conflicts": [{"type": "folder","id": "4338794518","sequence_id": "0","etag": "0","name": "Pictures"}]}}';
        res.setBody(body);
        res.setStatusCode(409);
        return res;
    }
}