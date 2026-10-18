public class BatchDemo implements Database.Batchable<sObject>, Database.Stateful{
    List<Account> lstOfAccToUpdate = new List<Account>();
    public Integer totalRecordProcessed = 0;
    
    public Database.QueryLocator start(Database.BatchableContext BC)
    {
        //use string format only while passing in getQueryLocator
        String query='SELECT Id, Name, Phone FROM Account';
        return Database.getQueryLocator(query);
        //we have to fetch the data
    }
    
    public void execute(Database.BatchableContext BC,List<Account> lstOfRecordFetchedFromStart)
    {
        //we have to process the data
        for(Account recOfAcc : lstOfRecordFetchedFromStart)
        {
            recOfAcc.Phone = '9876543211';
            totalRecordProcessed += 1;
            lstOfAccToUpdate.add(recOfAcc);
        }
        if(!lstOfAccToUpdate.isEmpty())
        {
            update lstOfAccToUpdate;
        }
        
    }
    public void finish(Database.BatchableContext BC)
    {
        //we have to perform post processing task  
        // Iterable code below
        //Database.executeBatch(new BatchForIterable(lstOfAccToUpdate), 100);
       
        System.debug('Birthday matched' + totalRecordProcessed);
        String emailBody = 'All accounts are updated successfully. Total accounts processed are '+ totalRecordProcessed;
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new List<String> {'hagawanesonal111@gmail.com'});
        mail.setSubject('Batch Completed');
        mail.setPlainTextBody(emailBody);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
    
}