@isTest
global with sharing class TestUploadAttachmentMockup implements HttpCalloutMock{
   global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        String body='{"total_count": 1,"entries":[{"type": "file","id": "5000948880","sequence_id": "3","etag": "3","name": "tigers.jpeg","description": "a picture of tigers","size": 629644,"parent": {"id": "11446498","sequence_id": "1","etag": "1","name": "Pictures"}}]}';
        res.setStatus('Created');
        res.setStatusCode(201);
        res.setBody(body);
        return res;
    }
}