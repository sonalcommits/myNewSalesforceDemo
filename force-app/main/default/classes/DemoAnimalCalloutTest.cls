@isTest
public class DemoAnimalCalloutTest {
@isTest
    static void testPostCallout() {
        // Set mock callout class
        Test.setMock(HttpCalloutMock.class, new AnimalsHttpCalloutMock());
        HttpResponse response = DemoAnimalCallout.makePostCallout();
        String contentType = response.getHeader('Content-Type');
        Assert.isTrue(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}';
        Assert.areEqual(expectedValue, actualValue);
        Assert.areEqual(200, response.getStatusCode());
    }
    
    @isTest
    static void testGetCallout() {
        // Set mock callout class
        Test.setMock(HttpCalloutMock.class, new AnimalsHttpCalloutMock());
        HttpResponse response = DemoAnimalCallout.makeGetCallout();
       // String contentType = response.getHeader('Content-Type');
        //Assert.isTrue(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}';
        Assert.areEqual(expectedValue, actualValue);
        Assert.areEqual(200, response.getStatusCode());
    }
}