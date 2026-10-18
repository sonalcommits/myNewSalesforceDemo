trigger CaseTrigger on Case (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    if(trigger.isBefore){
        if(trigger.isInsert || trigger.isUpdate)
        {
            CaseTriggerHandler.checkInstallationDate(trigger.new, trigger.oldMap);
        }
    }
        if(trigger.isBefore && trigger.isInsert)
        {
            CaseTriggerHandler.setCasePriorityBasedOnSupportTier(trigger.new);
        }
     if(trigger.isAfter && trigger.isUpdate)
        {
            CaseTriggerHandler.updateRelatedTasksStatus(trigger.new, trigger.oldMap);
        }
     if(trigger.isAfter && trigger.isUpdate)
        {
            CaseTriggerHandler.updateAccountDescription(trigger.new, trigger.oldMap);
        }
}