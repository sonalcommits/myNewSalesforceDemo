public class CandidateTriggerHandler {
    public static void validateExpectedSalary(List<Candidate__c> lstOfNewCandidate)
    {
        for(Candidate__c recOfCandidate : lstOfNewCandidate)
        {
            if(recOfCandidate.Expected_Salary__c == null)
            {
                recOfCandidate.Expected_Salary__c .addError('Expected Salary field is missing');
            }
        }
    }
    
     public static void checkJobStatus(List<Candidate__c> lstOfNewCandidate, Map<Id, Candidate__c> mapOfOldCandidates)
    {
        Set<Id> setOfJobIds = new Set<Id>();
        for(Candidate__c recOfNewCandidate : lstOfNewCandidate)
        {
            if(recOfNewCandidate.Job__c != null) {
                setOfJobIds.add(recOfNewCandidate.Job__c);            
            }}
        Map<Id, Job__c> mapOfJob = new Map<Id, Job__c>([SELECT Id, Active__c FROM Job__c WHERE Id IN : setOfJobIds]);
        
       for(Candidate__c recOfNewCandidate : lstOfNewCandidate)
        {
            Candidate__c recOfOldCandidate = mapOfOldCandidates != null && mapOfOldCandidates.containsKey(recOfNewCandidate.Id) ? mapOfOldCandidates.get(recOfNewCandidate.Id) : null;
            
            if(mapOfJob.ContainsKey(recOfNewCandidate.Job__c) && mapOfJob.get(recOfNewCandidate.Job__c).Active__c == false && (recOfOldCandidate == null || recOfOldCandidate.Job__c != recOfNewCandidate.Job__c))
            {
                recOfNewCandidate.addError('This Job is not active. You cannot apply for this job');
            }
    }
   }
    
    public static void checkDateOfApplicationDate(List<Candidate__c> lstOfNewCandidate)
    {
        List<Candidate__c> lstOfCandidateToUpdate= new List<Candidate__c>();
        for(Candidate__c recOfCandidate : lstOfNewCandidate)
        {
            Candidate__c candidateRecord = new Candidate__c();// after insert thats why new object created
			candidateRecord.Id = recOfCandidate.Id;
            candidateRecord.Application_Date__c = recOfCandidate.CreatedDate.date();
            lstOfCandidateToUpdate.add(candidateRecord);
        }	
         if(!lstOfCandidateToUpdate.isEmpty())
    {
    		update lstOfCandidateToUpdate;
    }
    }
}