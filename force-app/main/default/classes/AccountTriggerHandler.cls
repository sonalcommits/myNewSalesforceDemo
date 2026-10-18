public class AccountTriggerHandler {
    public static void checkFaxField(List<Account> lstOfAccs)
    {
        for(Account recOfAcc:lstOfAccs)
        {
            if(recOfAcc.Fax == null)
            {
                recOfAcc.addError('Fax is a required field at the time of creation and you cannot leave it blank');
            }
        }
    }
    
    public static void checkAccountNumber(List<Account> lstOfAccs)
    {
        for(Account recOfAcc:lstOfAccs)
        {
            if(recOfAcc.AccountNumber == null)
            {
                recOfAcc.addError('Account Number is a required field at the time of creation & updation and you cannot leave it blank');
            }
        }
    }
    
    public static void restrictAccDeletion(List<Account> lstOfAccs)
    {
        Id contextUserProfileId = UserInfo.getProfileId();
        Profile sysAdminProfile = [SELECT Id, Name FROM Profile WHERE Name = 'System Administrator'];
        for(Account recOfAcc:lstOfAccs)
        {
            if(recOfAcc.Active__c == 'Yes' && contextUserProfileId != sysAdminProfile.Id)
            {
                recOfAcc.addError('You are not allowed to delete the record if it is Active');
            }
        }
    }
    
    public static void updateNotesOnOpp(List<Account> lstOfNewAccounts, Map<Id, Account> mapOfOldAccounts)
    {
        Set<Id> setOfAccIds = new Set<Id>();
        Map<Id, Account> mapOfAccounts = new Map<Id, Account>();
        List<Opportunity> lstOfOppsToUpdate = new List<Opportunity>();
        
        for(Account recOfNewAcc : lstOfNewAccounts)
        {
            Account recOfOldAcc = mapOfOldAccounts != null && mapOfOldAccounts.containsKey(recOfNewAcc.Id) ? mapOfOldAccounts.get(recOfNewAcc.Id) : null;
 
   		   if (recOfNewAcc.Notes__c != null && (mapOfOldAccounts == null || recOfNewAcc.Notes__c != recOfOldAcc.Notes__c))
           {
            setOfAccIds.add(recOfNewAcc.Id);
            mapOfAccounts.put(recOfNewAcc.Id, recOfNewAcc);
           }
        }
        
        for( Opportunity recOfRelatedOpp : [SELECT Id, Notes__c, AccountId FROM Opportunity WHERE AccountId IN :setOfAccIds])
        {
            Account recOfparentAcc = mapOfAccounts.get(recOfRelatedOpp.AccountId);
            recOfRelatedOpp.Notes__c = recOfparentAcc.Notes__c;
            lstOfOppsToUpdate.add(recOfRelatedOpp);
        }
        if(!lstOfOppsToUpdate.isEmpty())
        {
            update lstOfOppsToUpdate;
        }
    }
    
    public static void createChildOpps(List<Account> lstOfAcc, Map<Id, Account> mapOfOldAcc)
    {
        List<Opportunity> lstOfOppsToCreate = new List<Opportunity>();
        List<Account> lstOfAccountToUpdate = new List<Account>();
        
        for(Account recOfAcc : lstOfAcc)
        {
            if(recOfAcc.Create_Opportunity__c == true && (mapOfOldAcc == null || mapOfOldAcc.containsKey(recOfAcc.Id) && mapOfOldAcc.get(recOfAcc.Id).Create_Opportunity__c != recOfAcc.Create_Opportunity__c))
            {
              Opportunity recOfOpp = new Opportunity();
              recOfOpp.AccountId = recOfAcc.Id;
              recOfOpp.CloseDate = Date.Today().addDays(10);
              recOfOpp.StageName = 'Prospecting';
              recOfOpp.Name = recOfAcc.Name + '' + String.ValueOf(Date.Today().addDays(10));
              lstOfOppsToCreate.add(recOfOpp);
            
            Account recOfAccToUpdate = new Account();
            recOfAccToUpdate.Id = recOfAcc.Id;
            recOfAccToUpdate.Create_Opportunity__c = false;
            lstOfAccountToUpdate.add(recOfAccToUpdate);
        }
        
        if(!lstOfOppsToCreate.isEmpty())
        {
            insert lstOfOppsToCreate;
        }
        
        if(!lstOfAccountToUpdate.isEmpty())
        {
            update lstOfAccountToUpdate;
        }
    }
    }
    
    public static void samePhoneNoOfContactAssociatedWithAccount(List<Account> lstOfAcc, Map<Id, Account> mapOfOldAccount)
    {
        set<Id> setOfAccId =new set<Id>();
        Map<Id, Account> mapOfAcc = new Map<Id, Account>();
        List<Contact> lstOfConToUpdate = new List<Contact>();
        
        for(Account recOfAcc : lstOfAcc )
        {
           Account recOfOldAcc = mapOfOldAccount != null && mapOfOldAccount.containsKey(recOfAcc.Id) ? mapOfOldAccount.get(recOfAcc.Id) : null;
           if(recOfOldAcc != null && recOfOldAcc.Phone != recOfAcc.Phone)
           {
               setOfAccId.Add(recOfAcc.Id);
               mapOfAcc.put(recOfAcc.Id, recOfAcc);
           }
            
        }
         if (!setOfAccId.isEmpty()) {
        for(Contact recOfRelCon : [SELECT Id, Phone, AccountId FROM Contact WHERE AccountId IN : setOfAccId])
        {
            Account recOfparentAcc = mapOfAcc.get(recOfRelCon.AccountId);//triggering record
            recOfRelCon.Phone = recOfparentAcc.Phone;
            lstOfConToUpdate.add(recOfRelCon);
        }
        if(!lstOfConToUpdate.isEmpty())
            {
                update lstOfConToUpdate;
            }
    }
    }
    
    public static void restrictDupAcc(List<Account> lstOfAcc, Map<Id, Account> mapOfOldAcc)
    {
        Set<String> setOfAccNames = new Set<String>();
        Set<String> setOfExistingAccNames = new Set<String>();

        for(Account recOfNewAcc : lstOfAcc)
        {
            if (String.isNotBlank(recOfNewAcc.Name)) 
            {
          	  setOfAccNames.add(recOfNewAcc.Name);
            }
        }
        
        for(Account recOfExistingAcc :[SELECT Id, Name FROM Account WHERE Name IN : setOfAccNames])
        {
            setOfExistingAccNames.add(recOfExistingAcc.Name);
        }
        
       
        for(Account recOfNewAcc : lstOfAcc)
        {
           
            Account recOfOldAcc = mapOfOldAcc != null && mapOfOldAcc.containsKey(recOfNewAcc.Id) ? mapOfOldAcc.get(recOfNewAcc.Id) : Null;
            
            if(recOfNewAcc.Name != null && (mapOfOldAcc == null || recOfOldAcc.Name != recOfNewAcc.Name) && setOfExistingAccNames.contains(recOfNewAcc.Name) )
            {
                recOfNewAcc.addError('A Account with this name is already exists');
            }
        }
 }

     public static void createChildContacts(List<Account> lstOfAcc, Map<Id, Account> mapOfOldAcc)
    {
        List<Contact> lstOfContToCreate = new List<Contact>();
        List<Account> lstOfAccountToUpdate = new List<Account>();
        
        for(Account recOfAcc : lstOfAcc)
        {
            if(recOfAcc.Create_Contact__c == true && (mapOfOldAcc == null || mapOfOldAcc.containsKey(recOfAcc.Id) && mapOfOldAcc.get(recOfAcc.Id).Create_Contact__c != recOfAcc.Create_Contact__c))
            {
              Contact recOfCon = new Contact();
              recOfCon.AccountId = recOfAcc.Id;
              recOfCon.Phone = recOfAcc.Phone;
           	  recOfCon.LeadSource = 'Web';
              recOfCon.MobilePhone = '986543254';
              recOfCon.Fax = '6666';
              recOfCon.FirstName = recOfAcc.Name ;
              recOfCon.LastName = ' Contact';
              lstOfContToCreate.add(recOfCon);
            
            Account recOfAccToUpdate = new Account();
            recOfAccToUpdate.Id = recOfAcc.Id;
            recOfAccToUpdate.Create_Contact__c = false;
            lstOfAccountToUpdate.add(recOfAccToUpdate);
        }
        
        if(!lstOfContToCreate.isEmpty())
        {
            insert lstOfContToCreate;
        }
        
        if(!lstOfAccountToUpdate.isEmpty())
        {
            update lstOfAccountToUpdate;
        }
    }
    }
    
}