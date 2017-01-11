@isTest
public with sharing class TestFolderInfoMock implements HttpCalloutMock{
   public HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        String body='{"total_count": 1,"entries": [{"type": "file","id": "192429928","sequence_id": "1","etag": "1","name": "Stephen Curry Three Pointers"}],"offset": 0,"limit": 2}';
        res.setBody(body);
        res.setStatusCode(200);
        return res;
    }
}