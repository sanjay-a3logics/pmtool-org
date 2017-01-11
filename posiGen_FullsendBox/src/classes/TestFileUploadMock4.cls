@isTest
global with sharing class TestFileUploadMock4 implements HttpCalloutMock{
   global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        String body='{"type":"collaboration","id":"177427429","created_by":{"type":"user","id":"244086113","name":"Rajesh Kakawat","login":"vishala@appcino.com"},"created_at":"2016-01-30T06:25:47-08:00","modified_at":"2016-01-30T06:25:47-08:00","expires_at":null,"status":"pending","accessible_by":null,"role":"Uploader","acknowledged_at":null,"item":{"type":"folder","id":"1144649867","sequence_id":"0","etag":"0","name":"Application"}}';
        res.setStatus('Created');
        res.setStatusCode(201);
        res.setBody(body);
        return res;
    }
}