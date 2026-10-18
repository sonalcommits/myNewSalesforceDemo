trigger ContactTrigger on Contact (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    if(trigger.isBefore && trigger.isInsert)
    {
        ContactTriggerHandler.generatePortalUsername(trigger.new);
    }
    
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate))
    {
        ContactTriggerHandler.restrictDupeContacts(trigger.new, trigger.oldMap);
    }
    
    if(trigger.isAfter && trigger.isInsert)
    {
        ContactTriggerHandler.rollupCountOfContactsOnAcc(trigger.new, null);
    }
     if(trigger.isAfter && trigger.isUpdate)
    {
        ContactTriggerHandler.rollupCountOfContactsOnAcc(trigger.new, trigger.oldMap);
    }
     if(trigger.isAfter && trigger.isDelete)
    {
        ContactTriggerHandler.rollupCountOfContactsOnAcc(trigger.old, null);
    }
    
     if(trigger.isAfter && trigger.isUpdate)
    {
        ContactTriggerHandler.updateAccDescriptionAsPerContact(trigger.new, trigger.oldMap);
    }

}