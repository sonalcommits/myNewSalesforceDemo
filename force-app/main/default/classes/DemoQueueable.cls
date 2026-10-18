public class DemoQueueable implements Queueable {
    public List<Account> lstOfTestAcc = new List<Account>();
    public DemoQueueable(List<Account> lstOfTestAcc)//constructor
    {
        this.lstOfTestAcc=lstOfTestAcc;
    }
    public void execute(QueueableContext context)
    {
      List<Account> lstOfAccToUpdate = new List<Account>();
      for(Account recOfAcc : lstOfTestAcc)
      {
          Account recOfAccTpUpdated = new Account();
          recOfAccTpUpdated.Id = recOfAcc.Id;
          recOfAccTpUpdated.Phone = '987654';
          lstOfAccToUpdate.add(recOfAccTpUpdated);    
      }
       if(!lstOfAccToUpdate.isEmpty())
       {
           update lstOfAccToUpdate;
           
           Demo1Queueable objOfDemo1Queueable = new Demo1Queueable(lstOfAccToUpdate);
           System.enqueueJob(objOfDemo1Queueable);        
       }
    }

}