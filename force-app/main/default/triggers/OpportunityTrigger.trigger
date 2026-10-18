trigger OpportunityTrigger on Opportunity (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
	if(trigger.isBefore && trigger.isUpdate)
    {
        OpportunityTriggerHandler.restrictOppStageChange(trigger.new, trigger.oldMap);
    }
    
    if(trigger.isBefore && trigger.isUpdate)
    {
        OpportunityTriggerHandler.updateCommissionAmount(trigger.new, trigger.oldMap);
    }
}