@isTest
public with sharing class TestFileUploadMockGet implements HttpCalloutMock{
   public HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        String body='{"total_count":1,"entries":[{"type":"file","id":"37430094598","file_version":{"type":"file_version","id":"37103609254","sha1":"c89f4ceeab5ff549d6ca0204f5aba2fa6218015e"},"sequence_id":"0","etag":"0","sha1":"c89f4ceeab5ff549d6ca0204f5aba2fa6218015e","name":"2014_06_20_09_51_01.pdf"}],"offset":0,"limit":100,"order":[{"by":"type","direction":"ASC"},{"by":"name","direction":"ASC"}]}';
        res.setBody(body);
        res.setStatusCode(200);
        return res;
    }
}