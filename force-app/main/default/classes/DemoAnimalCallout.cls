public class DemoAnimalCallout {
    public static HttpResponse makeGetCallout(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200)
        {
            System.debug('As Response '+ response.getBody());
            Map<String, Object> mapOfResult = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            System.debug('As Response Map '+ mapOfResult);
            List<Object> animalsLst = mapOfResult.containsKey('animals') ? (List<Object>) mapOfResult.get('animals') : null;
            for(Object animal : animalsLst)
            {
                System.debug('Animal is : '+ animal);
            }
        }return response;
    
    }
    
    public static HttpResponse makePostCallout()
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/JSON;charset');
        request.setBody('{"name": "dog"}');
        HttpResponse response = http.send(request);
        System.debug('Status code '+ response.getStatusCode());
        if(response.getStatusCode() == 201)
        {
            System.debug(response.getBody());
        }
        return response;
    }
    
   /* public static void makeUpdateCallout()
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/1');
        request.setMethod('PUT');
        request.setHeader('Content-Type', 'application/JSON; charset');
        request.setBody('{"name": "Tiger"}');
        HttpResponse response = http.send(request);
        System.debug('Status code '+ response.getStatusCode()); 
        System.debug(response.getBody());
 }*/
    
}