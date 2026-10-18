public class OrderTriggerHandler {
    
    @future
    public static void calculateTotalOrders(Set<Id> setOfAccId)
    {
      Map<Id, Integer> mapOfAccIdVsTotalCountOrder = new Map<Id, Integer>();   
      List<Account> lstOfAccsToUpdate = new List<Account>();
       
      for(Order recOfOrder:[SELECT Id, AccountId FROM Order WHERE AccountId IN :setOfAccId]) 
      {
          if(!mapOfAccIdVsTotalCountOrder.containsKey(recOfOrder.AccountId))
          {
             mapOfAccIdVsTotalCountOrder.put(recOfOrder.AccountId, 1);
          }
          else
          {
              Integer existingCount = mapOfAccIdVsTotalCountOrder.get(recOfOrder.AccountId);
              mapOfAccIdVsTotalCountOrder.put(recOfOrder.AccountId, existingCount + 1);
          }
      }
        
        for(Id accId : setOfAccId)
        {
            Account recOfAccount = new Account();
            recOfAccount.Id = accId;
            recOfAccount.Total_Orders__c = mapOfAccIdVsTotalCountOrder.containsKey(accId) ? mapOfAccIdVsTotalCountOrder.get(accId) : 0;
            lstOfAccsToUpdate.add(recOfAccount);
        }
		   if(!lstOfAccsToUpdate.isEmpty())
			{
  			  update lstOfAccsToUpdate;
			}
    }    
}