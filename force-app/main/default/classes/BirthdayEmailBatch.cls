public class BirthdayEmailBatch implements Schedulable, Database.Batchable<sObject> {
    public void execute(SchedulableContext sc)
    {
        Database.executeBatch(this, 20);
    }
    
    public Database.QueryLocator start(Database.BatchableContext BC)
    {
        String query = 'SELECT FirstName, LastName, Birthdate, Email FROM Contact';
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc, List<Contact> lstOfContact)
    {
        Date today = Date.today();
        List<Messaging.SingleEmailMessage> lstOfMail = new List<Messaging.SingleEmailMessage>();
        for(Contact recOfContact : lstOfContact) 
        {
            if(recOfContact.Email != null && recOfContact.Birthdate != null && 
               recOfContact.Birthdate.day() == today.day() && recOfContact.Birthdate.month() == today.month())
            {
                System.debug('Birthday matched');
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(new List<String> {recOfContact.Email});
                mail.setSubject('This is Birthday Wish Email');
                mail.setPlainTextBody('Wish you many many happy returns of the day ' +  recOfContact.FirstName +' enjoy your special day.Thank you. batch completed');
                lstOfMail.add(mail);
            }
            
        }
        if(!lstOfMail.isEmpty())
        {
            Messaging.sendEmail(lstOfMail);
        }
        
    }
    
    public void finish(Database.BatchableContext BC)
    {
        System.debug('Birthday Email Batch Completed');
    }
    
}