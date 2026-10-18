trigger LeadTrigger on Lead (before insert) {
    if(trigger.isBefore && trigger.isInsert)
    {
        LeadTriggerHandler.updateBankingIndustryLeads(trigger.new);
        LeadTriggerHandler.formatPhone(trigger.new);
        LeadTriggerHandler.UpdateLeadFollowUpDeadlineDate(trigger.new);
    }

}