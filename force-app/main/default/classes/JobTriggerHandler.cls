public class JobTriggerHandler {
    public static void updateActiveStatusField(List<Job__c> lstOfNewJob, Map<Id, Job__c> mapOfOldJob)
    {
        for(Job__c recOfNewJob : lstOfNewJob)
        {
            Job__c recOfOldJob = mapOfOldJob != null && mapOfOldJob.containsKey(recOfNewJob.Id) ? mapOfOldJob.get(recOfNewJob.Id) : null;
           
            if(recOfNewJob.Active__c == false && recOfOldJob != null && recOfNewJob.Total_positions__c != recOfOldJob.Total_positions__c && recOfNewJob.Total_positions__c > recOfNewJob.Hired_Applicant__c)
            {
                recOfNewJob.Active__c = true;
            }
             }     
        }
    
    public static void deactivateStatusFieldAndSendEmailToManager(List<Job__c> lstOfNewJob, Map<Id, Job__c> mapOfOldJob)
    {
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
        for(Job__c recOfNewJob : lstOfNewJob)
        {
            Job__c recOfOldJob = mapOfOldJob != null && mapOfOldJob.containsKey(recOfNewJob.Id) ? mapOfOldJob.get(recOfNewJob.Id) : null;
           if(recOfNewJob.Active__c == true && recOfOldJob != null && recOfNewJob.Total_positions__c == recOfNewJob.Hired_Applicant__c)
            {
                recOfNewJob.Active__c = false;
                
                if (recOfNewJob.Manager__c != null) {

                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

                // Manager__c should be a Lookup(Contact)
                mail.setTargetObjectId(recOfNewJob.Manager__c);

                mail.setSaveAsActivity(false);

                mail.setSubject('Job Hiring Completed');

                mail.setPlainTextBody(
                    'All required candidate has been hired for this job on '
                    + String.valueOf(recOfNewJob.LastModifiedDate));

                emailList.add(mail);
            }
            }
        }
        if (!emailList.isEmpty()) {
        Messaging.sendEmail(emailList);
    }
    }
    
    public static void preventActiveJobDeletion(List<Job__c> lstOfOldJob)
    {
        for(Job__c recOfOldJob : lstOfOldJob )
            
        {
            if(recOfOldJob.Active__c == true)
            {
                recOfOldJob.Active__c.addError('This Job is active and cannot be deleted');
            }
        }
    }
}