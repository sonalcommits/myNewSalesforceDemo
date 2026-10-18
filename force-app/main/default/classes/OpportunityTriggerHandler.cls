public class OpportunityTriggerHandler {
	public static void restrictOppStageChange(List<Opportunity> lstOfNewOpps, Map<Id,Opportunity> mapOfOldOpps)
    {
        Id currentUserId = UserInfo.getUserId();
        Integer countOfAssignment = [SELECT COUNT() FROM PermissionSetAssignment WHERE AssigneeId = :currentUserID AND PermissionSEt.Name = 'Bypass_Opportunity_Validation'];
        for(Opportunity newOpp : lstOfNewOpps)
            {
                Opportunity oldOpp = mapOfOldOpps.get(newOpp.Id);
                if(newOpp.StageName == 'Closed Won' && oldOpp.StageName != newOpp.StageName && String.isBlank(newOpp.Description) && countOfAssignment <=0)
                {
                    newOpp.addError('Description cannot be left empty if Opportunity stage is getting changed to Closed Won');
                }
            }
    }
    public static void updateCommissionAmount(List<Opportunity> lstOfNewOpps, Map<Id,Opportunity> mapOfOldOpps){
        for(Opportunity recOfNewOpp : lstOfNewOpps)
        {
            if(recOfNewOpp.StageName == 'Closed Won' && recOfNewOpp.Amount != null)
            {
                recOfNewOpp.Commission_Amount__c = recOfNewOpp.Amount * Decimal.valueOf(System.label.Commission_Value);
            }
        }
        }
       
}