@isTest
public class JobTriggerHandlerTest {
    @isTest
    static void updateActiveStatusFieldTest()
    {
        Contact recOfContact = new Contact(LastName = 'Test Contact',LeadSource = 'Web',MobilePhone = '2341567854');
        insert recOfContact;
        
        Job__c recOfJob = new Job__c(Active__c = true,Job_Name__c = 'Admin',Contact__c = recOfContact.Id,Total_positions__c = 2,Expires_ON__c = Date.today().addDays(30));
        insert recOfJob;
        
        Candidate__c recOfCandidate1 = new Candidate__c(First_Name__c = 'Test', Last_Name__c = 'Candidate1', Job__c = recOfJob.Id,Expected_Salary__c = 500000,Status__c = 'Hired');
        
        Candidate__c recOfCandidate2 = new Candidate__c(First_Name__c = 'Test', Last_Name__c = 'Candidate2', Job__c = recOfJob.Id,Expected_Salary__c = 400000,Status__c = 'Hired');
        
        List<Candidate__c> lstOfCandidate = new List<Candidate__c>();
        lstOfCandidate.add(recOfCandidate1);
        lstOfCandidate.add(recOfCandidate2);
        insert lstOfCandidate;

        Job__c recOfUpdatedRollupfieldJob = [SELECT Active__c,Total_positions__c,Hired_Applicant__c FROM  Job__c WHERE Id =: recOfJob.Id];
        
        System.debug('Hired_Applicant__c '+recOfUpdatedRollupfieldJob.Hired_Applicant__c);
        recOfUpdatedRollupfieldJob.Total_positions__c = 4;
        recOfUpdatedRollupfieldJob.Active__c = false;
        update recOfUpdatedRollupfieldJob;
        
        Job__c recOfUpdatedJob = [SELECT Active__c FROM  Job__c WHERE Id =: recOfUpdatedRollupfieldJob.Id];

        Assert.areEqual(true,recOfUpdatedJob.Active__c);
        
    }
    @isTest
    static void deactivateStatusFieldTest()
    {
        Contact recOfContact = new Contact(LastName = 'Test Contact',LeadSource = 'Web',MobilePhone = '2341567854');
        insert recOfContact;
        
        Job__c recOfJob = new Job__c(Active__c = true,Job_Name__c = 'Admin',Contact__c = recOfContact.Id,Total_positions__c = 2,Expires_ON__c = Date.today().addDays(30));
        insert recOfJob;
        
        Candidate__c recOfCandidate1 = new Candidate__c(First_Name__c = 'Test', Last_Name__c = 'Candidate1', Job__c = recOfJob.Id,Expected_Salary__c = 500000,Status__c = 'Hired');
   		insert recOfCandidate1;
        
 		Candidate__c recOfCandidate2 = new Candidate__c(First_Name__c = 'Test', Last_Name__c = 'Candidate2', Job__c = recOfJob.Id,Expected_Salary__c = 400000,Status__c = 'Hired');
		insert recOfCandidate2;
        
        Job__c recOfUpdatedRollupfieldJob = [SELECT Active__c,Total_positions__c,Hired_Applicant__c FROM  Job__c WHERE Id =: recOfJob.Id];
		System.debug('Hired_Applicant__c '+recOfUpdatedRollupfieldJob.Hired_Applicant__c);
     
		recOfUpdatedRollupfieldJob = [SELECT Active__c,Total_positions__c,Hired_Applicant__c FROM  Job__c WHERE Id =: recOfJob.Id];
 
        recOfUpdatedRollupfieldJob.Job_Name__c = 'Admin Updated';
        update recOfUpdatedRollupfieldJob;
        
        Job__c recOfUpdatedJob = [SELECT Active__c FROM  Job__c WHERE Id =: recOfUpdatedRollupfieldJob.Id];
		Assert.areEqual(false,recOfUpdatedJob.Active__c);
       
        
    }
     @isTest
    static void deactivateStatusFieldAndSendEmailToManagerTest()
    {
        Contact recOfContact = new Contact(LastName = 'Test Contact',LeadSource = 'Web',MobilePhone = '2341567854',Email = 'manager@test.com');
        insert recOfContact;
        
        Job__c recOfJob = new Job__c(Active__c = true,Job_Name__c = 'Admin', Manager__c = recOfContact.Id,Contact__c = recOfContact.Id,Total_positions__c = 2,Expires_ON__c = Date.today().addDays(30));
        insert recOfJob;
        
        Candidate__c recOfCandidate1 = new Candidate__c(First_Name__c = 'Test', Last_Name__c = 'Candidate1', Job__c = recOfJob.Id,Expected_Salary__c = 500000,Status__c = 'Hired');
   		insert recOfCandidate1;
        
 		Candidate__c recOfCandidate2 = new Candidate__c(First_Name__c = 'Test', Last_Name__c = 'Candidate2', Job__c = recOfJob.Id,Expected_Salary__c = 400000,Status__c = 'Hired');
		insert recOfCandidate2;
        
        Job__c recOfUpdatedRollupfieldJob = [SELECT Active__c,Total_positions__c,Hired_Applicant__c FROM  Job__c WHERE Id =: recOfJob.Id];
		System.debug('Hired_Applicant__c '+recOfUpdatedRollupfieldJob.Hired_Applicant__c);
     
		recOfUpdatedRollupfieldJob = [SELECT Active__c,Total_positions__c,Hired_Applicant__c, Manager__c FROM  Job__c WHERE Id =: recOfJob.Id];
 		Test.startTest();
        recOfUpdatedRollupfieldJob.Job_Name__c = 'Admin Updated';
        update recOfUpdatedRollupfieldJob;
        Test.stopTest();
        
        Job__c recOfUpdatedJob = [SELECT Active__c,Total_positions__c,Hired_Applicant__c, Manager__c FROM  Job__c WHERE Id =: recOfUpdatedRollupfieldJob.Id];
		Assert.areEqual(false,recOfUpdatedJob.Active__c);
        System.debug('Active = ' + recOfUpdatedJob.Active__c);
		System.debug('Total Positions = ' + recOfUpdatedJob.Total_positions__c);
		System.debug('Hired Applicants = ' + recOfUpdatedJob.Hired_Applicant__c);
		System.debug('Manager = ' + recOfUpdatedJob.Manager__c);
        Assert.areEqual(1, Limits.getEmailInvocations());
        
    }

    
}