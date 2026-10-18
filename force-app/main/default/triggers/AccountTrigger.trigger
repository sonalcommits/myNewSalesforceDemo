trigger AccountTrigger on Account (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
	/*if(trigger.isBefore){
        if(trigger.isInsert){
            System.debug('Before Insert New '+ Trigger.new);
   		    System.debug('Before Insert Old '+ Trigger.old);
    		System.debug('Before Insert New Map '+ Trigger.newMap);
    		System.debug('Before Insert Old Map '+ Trigger.oldMap);  
        }
        else if(trigger.isUpdate){
            System.debug('Before Update New '+ Trigger.new);
   		    System.debug('Before Update Old '+ Trigger.old);
    		System.debug('Before Update New Map '+ Trigger.newMap);
    		System.debug('Before Update Old Map '+ Trigger.oldMap);  
        }
        else if(trigger.isDelete){
            System.debug('Before Delete New '+ Trigger.new);
   		    System.debug('Before Delete Old '+ Trigger.old);
    		System.debug('Before Delete New Map '+ Trigger.newMap);
    		System.debug('Before Delete Old Map '+ Trigger.oldMap);  
        }
    }
    else if(trigger.isAfter){
         if(trigger.isInsert){
            System.debug('After Insert New '+ Trigger.new);
   		    System.debug('After Insert Old '+ Trigger.old);
    		System.debug('After Insert New Map '+ Trigger.newMap);
    		System.debug('After Insert Old Map '+ Trigger.oldMap);  
        }
        else if(trigger.isUpdate){
            System.debug('After Update New '+ Trigger.new);
   		    System.debug('After Update Old '+ Trigger.old);
    		System.debug('After Update New Map '+ Trigger.newMap);
    		System.debug('After Update Old Map '+ Trigger.oldMap);  
        }
        else if(trigger.isDelete){
            System.debug('After Delete New '+ Trigger.new);
   		    System.debug('After Delete Old '+ Trigger.old);
    		System.debug('After Delete New Map '+ Trigger.newMap);
    		System.debug('After Delete Old Map '+ Trigger.oldMap);  
        }  
        else if(trigger.isUndelete){
            System.debug('After UnDelete New '+ Trigger.new);
   		    System.debug('After UnDelete Old '+ Trigger.old);
    		System.debug('After UnDelete New Map '+ Trigger.newMap);
    		System.debug('After UnDelete Old Map '+ Trigger.oldMap);  
        } 
        
    }
*/
    if(trigger.isBefore && trigger.isInsert)
    {
        AccountTriggerHandler.checkFaxField(trigger.new);
    }
    
    
  /*  if((trigger.isBefore && trigger.isInsert)||(trigger.isBefore && trigger.isUpdate))
    {
        AccountTriggerHandler.checkAccountNumber(trigger.new);
    }*/
    
    if(trigger.isBefore && trigger.isDelete)
    {
        AccountTriggerHandler.restrictAccDeletion(trigger.old);
    }
   
    
   if(trigger.isAfter && trigger.isUpdate)
    {
        AccountTriggerHandler.updateNotesOnOpp(trigger.new, trigger.oldMap);
    }
    
   if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate))// recurssion occurs thats why this code in trigger
   {
       List<Account> lstOfAcc = new List<Account>();
       for(Account recOfAcc : trigger.new)
       {
           Account oldAcc = trigger.isUpdate == true ? trigger.oldMap.get(recOfAcc.Id):null;
           if(recOfAcc.Name.containsIgnoreCase('test') && (oldAcc == null || oldAcc.Name != recOfAcc.Name) && recOfAcc.Phone == null)
           {
               lstOfAcc.add(recOfAcc);
           }
       }
       if(!lstOfAcc.isEmpty())
       {
           DemoQueueable objOfDemoQueueable = new DemoQueueable(trigger.new);
           System.enqueueJob(objOfDemoQueueable);          
       }
   }
    
    if(trigger.isAfter && trigger.isInsert)
    {
        AccountTriggerHandler.createChildOpps(trigger.new, null);
    }
    
    if(trigger.isAfter && trigger.isUpdate)
    {
        AccountTriggerHandler.createChildOpps(trigger.new, trigger.oldMap);
    }
    
     if(trigger.isAfter && trigger.isUpdate)
    {
     AccountTriggerHandler.samePhoneNoOfContactAssociatedWithAccount(trigger.new, trigger.oldMap);
    }
    
     if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate))
     {
   	 AccountTriggerHandler.restrictDupAcc(trigger.new, trigger.oldMap);
     }    
    
    if(trigger.isAfter && trigger.isUpdate)
    {
        AccountTriggerHandler.createChildContacts(trigger.new, trigger.oldMap);
    }
}