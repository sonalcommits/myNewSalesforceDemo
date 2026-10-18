public class BirthdayEmail implements Schedulable{
    public void execute(SchedulableContext sc)
    {
        Date today = Date.today();
        List<Contact> lstOfContact = [SELECT FirstName, LastName, Birthdate, Email FROM Contact];
        for(Contact recOfContact : lstOfContact) 
        {
            System.debug('Today: ' + today);
    		System.debug('Contact: ' + recOfContact.FirstName);
    		System.debug('Birthdate: ' + recOfContact.Birthdate);
    		System.debug('Email: ' + recOfContact.Email);
            if(recOfContact.Email != null && recOfContact.Birthdate != null && 
               recOfContact.Birthdate.day() == today.day() && recOfContact.Birthdate.month() == today.month())
            {
                 System.debug('Birthday matched');
                 Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
       			 mail.setToAddresses(new List<String> {recOfContact.Email});
       			 mail.setSubject('This is Birthday Wish Email');
       			 mail.setPlainTextBody('Wish you many many happy returns of the day ' +  recOfContact.FirstName +' enjoy your special day.Thank you.');
       			 Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            }
        }
       
    }
}