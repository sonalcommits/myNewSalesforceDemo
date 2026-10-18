public class ContactTriggerHandler {
    public static void generatePortalUsername(List<Contact> lstOfNewContacts)
    {
        for(Contact recOfContact : lstOfNewContacts)
        {
            if(recOfContact.Email != null && recOfContact.Suffix__c != null)
            {
                recOfContact.Portal_Username__c = recOfContact.Email + recOfContact.Suffix__c;
            }
        }
    }
    
    public static void restrictDupeContacts(List<Contact> lstOfNewContacts, Map<Id, Contact> mapOfOldContact)
    {
        Set<String> setOfEmails = new Set<String>();
        Set<String> setOfExistingEmails = new Set<String>();

        for(Contact recOfCon : lstOfNewContacts)
        {
           setOfEmails.add(recOfCon.Email); 
        }
        
        for(Contact recOfExistingCon : [SELECT Id, Email FROM Contact WHERE Email IN :setOfEmails])
        {
            setOfExistingEmails.add(recOfExistingCon.Email);
        }
        
        for(Contact recOfNewCon : lstOfNewContacts)
        {
            Contact oldContact;
            if(mapOfOldContact != null)
            {
                oldContact = mapOfOldContact.get(recOfNewCon.Id);
            }
            
            if(recOfNewCon.Email != null && (mapOfOldContact == null || recOfNewCon.Email != oldContact.Email) && setOfExistingEmails.contains(recOfNewCon.Email))
            {
                recOfNewCon.addError('A Contact with this email already exists');
            }
        }
}

public static void rollupCountOfContactsOnAcc(List<Contact> lstOfContact, Map<Id, Contact> mapOfOldCon)
{
    Set<Id> setOfAccId = new Set<Id>();
    
    for(Contact recOfContact : lstOfContact)
    {
        Contact recOfOldContact = mapOfOldCon != null  && mapOfOldCon.containsKey(recOfContact.Id) ? mapOfOldCon.get(recOfContact.Id) : null;
    
    if(recOfOldContact  == null && recOfContact.AccountId != null)
    {
        setOfAccId.add(recOfContact.AccountId);
    }
    if(recOfOldContact  != null && recOfOldContact.AccountId != recOfContact.AccountId)
    {
        setOfAccId.add(recOfContact.AccountId);
        setOfAccId.add(recOfOldContact.AccountId);
    }
    }
    if(!setOfAccId.isEmpty())
    {
        List<Account> lstOfAcc = [SELECT Id, No_of_Contacts__c, (SELECT Id FROM Contacts) FROM Account WHERE Id IN : setOfAccId];
        List<Account> lstOfAccToUpdate = new List<Account>();
        if(!lstOfAcc.isEmpty())
        {
            for(Account recOfAccount : lstOfAcc)
            {
                recOfAccount.No_of_Contacts__c = recOfAccount.Contacts.size();
                lstOfAccToUpdate.add(recOfAccount);
            }
            if(!lstOfAccToUpdate.isEmpty())
            {
                update lstOfAccToUpdate;
            }
        }
        
    }
}

    
    public static void updateAccDescriptionAsPerContact(List<Contact> lstOfCon, Map<Id, Contact> mapOfOldContact)
    {
         Set<Id> setOfAccId = new Set<Id>();
        Map<Id, Contact> mapOfCon = new Map<Id, Contact>(); 
        List<Account> lstOfAccToUpdate = new List<Account>();
        
        for(Contact reOfNewCon : lstOfCon)
        {
            Contact recOfOldContact = mapOfOldContact != null && mapOfOldContact.containsKey(reOfNewCon.Id) ? mapOfOldContact.get(reOfNewCon.Id) : null;
            if(reOfNewCon.AccountId != null && (recOfOldContact == null || recOfOldContact.Description != reOfNewCon.Description))
            {
                setOfAccId.add(reOfNewCon.AccountId);
                mapOfCon.put(reOfNewCon.AccountId, reOfNewCon);
			}
            
        }
        for(Account recOfRelatedAcc : [SELECT Id, Description FROM Account WHERE Id IN : setOfAccId])
        {
            Contact relatedCon = mapOfCon.get(recOfRelatedAcc.Id);
            if(relatedCon != null)
            {
            recOfRelatedAcc.Description = relatedCon.Description;
            lstOfAccToUpdate.add(recOfRelatedAcc);
            }
        }
        if(!lstOfAccToUpdate.isEmpty())
        {
            update lstOfAccToUpdate;
        }
    }
}