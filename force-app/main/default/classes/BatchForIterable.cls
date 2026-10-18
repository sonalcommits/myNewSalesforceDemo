public class BatchForIterable implements Database.Batchable<sObject>{
    List<Account> lstOfAcc = new List<Account>();
    public BatchForIterable(List<Account> lstOfAcc)
    {
        this.lstOfAcc = lstOfAcc;
    }
    public Iterable<Account> start(Database.BatchableContext bc)
    {
        return lstOfAcc;
    }

    public void execute(Database.BatchableContext bc, List<Account> lstOfAcc)
    {
        List<Account> lstOfAccToUpdate = new List<Account>();

        for(Account recOfAcc : lstOfAcc)
        {
            if(!recOfAcc.Phone.startsWith('91'))
            {
                recOfAcc.Phone = '+91'+recOfAcc.Phone;
                lstOfAccToUpdate.add(recOfAcc);
            }
        }
        if(!lstOfAccToUpdate.isEmpty())
        {
            update lstOfAccToUpdate;
        }
    }
    
    public void finish(Database.BatchableContext bc)
    {
        
    }
}