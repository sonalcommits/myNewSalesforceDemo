@isTest
public class CandidateTriggerHandlerTest {
    @isTest
    static void checkDateOfApplicationDateTest()
    {
        Contact recOfContact = new Contact(LastName = 'Test Contact',LeadSource = 'Web',MobilePhone = '2341567854');
        insert recOfContact;
        
        Job__c recOfJob = new Job__c(Active__c = true,Job_Name__c = 'JobTest',Contact__c = recOfContact.Id,Total_positions__c = 6,Expires_ON__c = Date.today().addDays(30));
        insert recOfJob;
        
        Candidate__c recOfCandidate = new Candidate__c(First_Name__c = 'Test', Last_Name__c = 'Candidate', Job__c = recOfJob.Id,Expected_Salary__c = 500000);
        insert recOfCandidate;
        
       Candidate__c recOfCreatedCandidate = [SELECT CreatedDate, Application_Date__c FROM Candidate__c WHERE Id = :recOfCandidate.Id];
        Assert.areEqual(recOfCreatedCandidate.CreatedDate.date(), recOfCreatedCandidate.Application_Date__c);
        
        
    }

}