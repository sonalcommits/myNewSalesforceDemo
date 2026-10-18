trigger CandidateTrigger on Candidate__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
 	if(trigger.isBefore && trigger.isInsert)
   		{
            CandidateTriggerHandler.validateExpectedSalary(trigger.new);
        }
    
    
    if(trigger.isBefore){
        if(trigger.isInsert || trigger.isUpdate)
   		{
            CandidateTriggerHandler.checkJobStatus(trigger.new, trigger.oldMap);
        }
    }
    
    if(trigger.isAfter && trigger.isInsert)
   		{
            CandidateTriggerHandler.checkDateOfApplicationDate(trigger.new);
        }
    
}