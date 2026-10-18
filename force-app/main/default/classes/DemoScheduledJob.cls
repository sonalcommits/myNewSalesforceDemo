public class DemoScheduledJob implements schedulable{
    public void execute(SchedulableContext sc)
    {
        //Seconds Minutes Hours Day Month Day_of_Week Year
        	
         Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

        // Recipient email address
        mail.setToAddresses(new String[] {'hagawanesonal111@gmail.com'});

        // Email subject
        mail.setSubject('Scheduled Apex Email');

        // Email body
        mail.setPlainTextBody('Hello This email was sent from Scheduled Apex.Thank you.');

        // Send email
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }

}