@isTest
public class OpportunityTriggerHandlerTest {
    @isTest
    static void updateCommissionAmountTest()
    {
        Opportunity recOfOpportunity = new Opportunity(Name = 'Test Opportunity',StageName = 'Prospecting',
                                           CloseDate = Date.today(),Amount = 10000);
        
        insert recOfOpportunity;
        
        recOfOpportunity.StageName = 'Closed Won';
        recOfOpportunity.Description = 'Closed successfully';
        update recOfOpportunity;
        
        Opportunity recOfCreatedOpp = [SELECT Amount, Commission_Amount__c FROM Opportunity WHERE Id = :recOfOpportunity.Id];
        Decimal expected = recOfCreatedOpp.Amount * Decimal.valueOf(System.label.Commission_Value);
        Assert.areEqual(expected, recOfCreatedOpp.Commission_Amount__c);
     
    }

}