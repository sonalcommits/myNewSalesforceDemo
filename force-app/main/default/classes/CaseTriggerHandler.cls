public class CaseTriggerHandler {
    public static void checkInstallationDate(List<case> lstOfNewCase, MAP<Id,Case> mapOfOldCase){
        Case oldCase;
        System.debug('mapOfOldCase '+ mapOfOldCase);
        For (case recOfCase : lstOfNewCase)
        {
            if(mapOfOldCase != null)
            {
               oldCase = mapOfOldCase.get(recOfCase.Id);
            }
            if(recOfCase.Installation_date__c != null && recOfCase.Installation_date__c > Date.today() && (mapOfOldCase == null || oldCase.Installation_date__c != recOfCase.Installation_date__c ))
                //Checks whether the Installation Date has a value. Checks if the entered installation date is after today's date. This part determines whether this is a new record or the date has been changed.
            {
                recOfCase.Installation_date__c.addError('Installation Date cannot be in the future');
            }
        }
            
    }
    
    public static void setCasePriorityBasedOnSupportTier(List<Case> lstOfNewCase)
    {
        Set<Id> setOfAccountIds = new Set<Id>(); //Created empty Set
        
        for(Case newCase : lstOfNewCase ) //Collecting Account IDs from Cases
        {
            if(newCase.AccountId != null)
            {
                setOfAccountIds.add(newCase.AccountId); //Added Account ID to Set
            }
        }
        
        //Get Account records - Go to the Account object, get the Accounts whose IDs are in our Set, and store them in a Map
        Map<Id, Account> mapOfAccount = new Map<Id, Account>([SELECT Id, Support_Tier__c  FROM Account WHERE Id IN :setOfAccountIds]);
        
         for(Case newCase : lstOfNewCase )
        {
          Account recOfAccount = mapOfAccount.get(newCase.AccountId); //Find the Account related to this Case.
        
        if (recOfAccount != null)
        {
            if(recOfAccount.Support_Tier__c == 'Premier')
            {
                newCase.Priority = 'High';
                newCase.Status = 'Working';
            }
             
            else if(recOfAccount.Support_Tier__c == 'Standard')
            {
                newCase.Priority = 'Medium';
            }
            else if(recOfAccount.Support_Tier__c == 'Basic')
            {
                newCase.Priority = 'Low';
            }
            }
    }

    }
  
    public static void 	updateRelatedTasksStatus(List<Case> lstOfNewCase, Map<Id, Case> mapOfOldCase)        
    {
        Set<Id> setOfCaseIds = new Set<Id>();
        Map<Id, Case> mapOfCases = new Map<Id, Case>();
        List<Task> lstOfTaskToUpdate = new List<Task>();
        Map<String, String> mapStatus = new Map<String, String>{
										'New' => 'Not Started',
    									'Working' => 'In Progress',
    									'Escalated' => 'Waiting'};
       for(Case recOfNewCase : lstOfNewCase) 
       {
           Case recOfOldCase = mapOfOldCase != null && mapOfOldCase.containsKey(recOfNewCase.Id) ? mapOfOldCase.get(recOfNewCase.Id) : null;
           if(recOfNewCase.Status != null && (mapOfOldCase == null || recOfNewCase.Status != recOfOldCase.Status ))
              {
				setOfCaseIds.add(recOfNewCase.Id);
                mapOfCases.put(recOfNewCase.Id, recOfNewCase);  
              }
       }
 		for( Task recOfRelatedTask : [SELECT Id, Status, WhatId FROM TASK WHERE WhatId IN :setOfCaseIds])
        {
            Case recOfparentCase= mapOfCases.get(recOfRelatedTask.WhatId);
            recOfRelatedTask.Status = mapStatus.get(recOfparentCase.Status);
            lstOfTaskToUpdate.add(recOfRelatedTask);
        }
        if(!lstOfTaskToUpdate.isEmpty())
        {
            update lstOfTaskToUpdate;
        }
    }
    
    
    
    
        public static void 	updateAccountDescription(List<Case> lstOfNewCase, Map<Id, Case> mapOfOldCase)
        {      
                Set<Id> setOfAccountIds = new Set<Id>();
                Map<Id, Case> mapOfCases = new Map<Id, Case>();
                List<Account> lstOfAccDescriptionToUpdate = new List<Account>();
            
           for(Case recOfNewCase : lstOfNewCase) 
           {   
               Case recOfOldCase = mapOfOldCase != null && mapOfOldCase.containsKey(recOfNewCase.Id) ? mapOfOldCase.get(recOfNewCase.Id) : null;
               if(recOfNewCase.Status != null && (mapOfOldCase == null || recOfNewCase.Status != recOfOldCase.Status ))
               {
                    setOfAccountIds.add(recOfNewCase.AccountId);
                    mapOfCases.put(recOfNewCase.AccountId, recOfNewCase);  
               }
           }
            
               for( Account recOfParentAccount : [SELECT Id, Description FROM Account WHERE Id IN :setOfAccountIds])
            {
                Case recOfCase= mapOfCases.get(recOfParentAccount.Id);
                if(recOfCase != null)
                {
                     recOfParentAccount.Description ='Case Number : ' + recOfCase.CaseNumber +' Status : ' + recOfCase.Status;
                     lstOfAccDescriptionToUpdate.add(recOfParentAccount);
                }
            }
            if(!lstOfAccDescriptionToUpdate.isEmpty())
            {
                update lstOfAccDescriptionToUpdate;
            }
           } 
}