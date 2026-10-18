@isTest
global class AnimalsHttpCalloutMock implements HttpCalloutMock{
    // implements this interface methods
    global HttpResponse respond(HttpRequest request)
    {
        // create a fake responce
         HttpResponse response = new  HttpResponse();
         response.setHeader('Content-Type', 'application/JSON');
         response.setBody('{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}');
         response.setStatusCode(200);
        return response;
    }

}