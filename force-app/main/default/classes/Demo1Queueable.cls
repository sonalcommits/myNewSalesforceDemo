public class Demo1Queueable implements Queueable{
    public List<Account> lstOfAcc = new List<Account>();
    public Demo1Queueable(List<Account> lstOfAcc)
    {
        this.lstOfAcc=lstOfAcc;
    }
    public void execute(QueueableContext context)
    {
      List<Account> lstOfAccToUpdate = new List<Account>();
      for(Account recOfAcc : lstOfAcc)
      {   
          Account acc = new Account();
          acc.Id = recOfAcc.Id;
          acc.Test_Executed__c = true;
         lstOfAccToUpdate.add(acc);
      }
        if(!lstOfAccToUpdate.isEmpty())
       {
           update lstOfAccToUpdate;
       }
    }

}