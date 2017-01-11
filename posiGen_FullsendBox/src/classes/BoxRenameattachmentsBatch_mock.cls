@isTest
public with sharing class BoxRenameattachmentsBatch_mock implements HttpCalloutMock{
   public HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        String body='{"total_count":1,"entries":[{"type":"file","id":"37840084894","etag":"0","name":"Panel Photo"}]}';
        res.setBody(body);
        res.setStatusCode(200);
        return res;
    }
}