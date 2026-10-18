public class LeadTriggerHandler {
    public static void updateBankingIndustryLeads(List<Lead> lstOfNewLeads)
    {
        for(Lead newRecOfLead : lstOfNewLeads)
        {
            if(newRecOfLead.Industry == 'Banking')
            {
                newRecOfLead.Rating = 'Hot';
                newRecOfLead.LeadSource = 'Partner Referral';
            }
        }
    }
    
    public static void formatPhone(List<Lead> lstOfNewLeads)
    {
        for(Lead newRecOfLead : lstOfNewLeads)
        {
            if(newRecOfLead.Phone != null)
            {
                newRecOfLead.Phone = newRecOfLead.Phone.replaceAll('[^0-9]', '');
                //"Remove every character from the phone number that is not a digit."
                //[0-9] → Any digit from 0 to 9.
				//	^ inside [] means NOT.
                //string.replaceAll(pattern, replacement)
            }
        }
    }
    
     public static void UpdateLeadFollowUpDeadlineDate(List<Lead> lstOfNewLeads)
    {
        for(Lead newRecOfLead : lstOfNewLeads)
        {
            if(newRecOfLead.LeadSource == 'Web')
            {
                newRecOfLead.Follow_Up_Deadline_Date__c = Date.today().addDays(2);
            }
            else if(newRecOfLead.LeadSource == 'Trade Show')
            {
               newRecOfLead.Follow_Up_Deadline_Date__c = Date.today().addDays(5);

            }
        }
    }

}