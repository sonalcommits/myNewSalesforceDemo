@isTest
public class ContactTriggerHandlerTest {
    @isTest
    static void generatePortalUsernameTest()
    {
        Contact recOfContact = new Contact(Email = 'test@test.com',Suffix__c = '.velocity',LeadSource = 'Web',MobilePhone = '2341567854', LastName = 'Test');
        insert recOfContact;
        
        Contact recOfCreatedContact = [SELECT Id, Portal_Username__c FROM Contact WHERE Id =: recOfContact.Id];
        Assert.areEqual('test@test.com.velocity',recOfCreatedContact.Portal_Username__c);
    }
    

}