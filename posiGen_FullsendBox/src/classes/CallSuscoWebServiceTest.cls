@isTest
private class CallSuscoWebServiceTest 
{
    static testMethod void testWebService(){
        //First, build the http request
        HttpRequest req = CallSuscoWebService.buildWebServiceRequest('006d000000JUp88');
        
        
        //NOTE - WE DO NOT EXECUTE THE METHOD, invokeWebService. 
        
        //Now, since we can't execute the actual web service, 
        //write apex code to build a sample HttpResponse object
        HttpResponse res = new HttpResponse();
        //Apply test data and attributes to the HttpResponse object as needed
        CallSuscoWebService.handleWebServiceResponse(res);
    }
}