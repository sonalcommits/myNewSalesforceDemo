trigger JobTrigger on Job__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
     if(trigger.isBefore && trigger.isUpdate)
        {
            JobTriggerHandler.updateActiveStatusField(trigger.new, trigger.oldMap);
        }

   if(trigger.isBefore && trigger.isUpdate)
        {
            JobTriggerHandler.deactivateStatusFieldAndSendEmailToManager(trigger.new, trigger.oldMap);
        }
    
    if(trigger.isAfter && trigger.isUpdate)
        {
            JobTriggerHandler.deactivateStatusFieldAndSendEmailToManager(trigger.new, trigger.oldMap);
        }
    
    if(trigger.isBefore && trigger.isDelete)
        {
            JobTriggerHandler.preventActiveJobDeletion(trigger.old);
        }
    
}