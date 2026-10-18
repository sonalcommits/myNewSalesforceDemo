@isTest
public class LeadTriggerHandlerTest {
    @isTest
    static void updateBankingIndustryLeadsTest()
    {
        Lead recOfCreatedLead = [SELECT Id, LeadSource, Rating FROM Lead];
        //In Query we can only see test data which is creatde in test method
        System.debug('size of leads: '+[SELECT Id, LeadSource, Rating FROM Lead].size());
        Assert.areEqual('Hot', recOfCreatedLead.Rating, 'The Rating of the Lead should be Hot' );
        Assert.areEqual('Partner Referral', recOfCreatedLead.LeadSource, 'The LeadSource of the Lead should be Partner Referral' );

    }

    @isTest
    static void formatPhoneTest()
    {
        //code outside Test.startTest() and  Test.stopTest()
        
        Test.startTest();
        Lead recOfCreatedLead = [SELECT Id, Phone FROM Lead];
        Assert.areEqual('9866890543',recOfCreatedLead.Phone);
        Test.stopTest();

 	 }
    
    @isTest
    static void UpdateLeadFollowUpDeadlineDateWebTest()
    {
        Lead recOfLeadPC = new Lead();
        recOfLeadPC.LastName = 'Test';
        recOfLeadPC.Company = 'Velocity';
        recOfLeadPC.LeadSource = 'Web';
        insert recOfLeadPC;
        Lead recOfCreatedLead = [SELECT Id, Follow_Up_Deadline_Date__c FROM Lead WHERE Id =:recOfLeadPC.Id];
        Assert.areEqual(Date.today().addDays(2), recOfCreatedLead.Follow_Up_Deadline_Date__c);
        
    }
    
    @isTest
    static void UpdateLeadFollowUpDeadlineDateTradeShowTest()
    {
        Lead recOfLeadPC = new Lead();
        recOfLeadPC.LastName = 'Test';
        recOfLeadPC.Company = 'Velocity';
        recOfLeadPC.LeadSource = 'Trade Show';
        insert recOfLeadPC;
        Lead recOfCreatedLead = [SELECT Id, Follow_Up_Deadline_Date__c FROM Lead WHERE Id =:recOfLeadPC.Id];
        Assert.areEqual(Date.today().addDays(5), recOfCreatedLead.Follow_Up_Deadline_Date__c);
        
    }
    
    @TestSetup // the code written inside this is automatically executed one time for entire class
    static void createData()
    {
        System.debug('As Test');
        Lead recOfLeadPC = new Lead();
        recOfLeadPC.LastName = 'Test';
        recOfLeadPC.Company = 'Velocity';
        recOfLeadPC.Industry = 'Banking';
        recOfLeadPC.Phone = '986fhj689j0543';
        insert recOfLeadPC;
    }
    
    @isTest
    static void myNewTest()
    {
        TestDataFactory.createMultipelAccData(3);
    }
}