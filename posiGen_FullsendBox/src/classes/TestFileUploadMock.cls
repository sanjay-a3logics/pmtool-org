@isTest
public with sharing class TestFileUploadMock implements HttpCalloutMock{
   public HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        String body='{"total_count":1,"entries":[{"type":"file","id":"5000948880","sequence_id":"3","etag":"3","sha1":"134b65991ed521fcfe4724b7d814ab8ded5185d","name": "tigers.jpeg","description": "a picture of tigers","size": 629644,"created_at": "2012-12-12T10:55:30-08:00","modified_at":"2012-12-12T11:04:26-08:00","trashed_at": null,"purged_at": null,"content_created_at": "2013-02-04T16:57:52-08:00","parent": {"type": "folder","id": "890384","name": "Pictures"},"item_status": "active"}]}';
        res.setBody(body);
        res.setStatusCode(201);
        return res;
    }
}