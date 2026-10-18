@isTest
public class AccountTriggerHandlerTest {
    @isTest
    static void updateNotesOnOppTest()
    {
        Account recOfAcc = new Account(Name = 'Test Acc', Fax = '1234567891',AccountNumber = '09876545678', Notes__c = 'Acc Old Notes');
        insert recOfAcc;
       
         Opportunity recOfOpp = new Opportunity(Name = 'Test Opportunity',StageName = 'Prospecting',
                                           CloseDate = Date.today().addDays(30),AccountId = recOfAcc.Id);
        
        insert recOfOpp;
        
         recOfAcc.Notes__c = 'Acc New Notes';
         update recOfAcc;
        
         Opportunity recOfUpdatedOpp = [SELECT Notes__c FROM Opportunity  WHERE Id = :recOfOpp.Id];
         Assert.areEqual('Acc New Notes', recOfUpdatedOpp.Notes__c);   
            
           
    }
	@isTest
    static void checkFaxFieldTest()
    {
         Account recOfAcc = new Account(Name = 'Test Account', AccountNumber = '09876545678',Phone = '4535687654');
        try{
         insert recOfAcc;
        }
        Catch(DMLException de)
        {
            Assert.isTrue(de.getMessage().contains('Fax is a required field at the time of creation and you cannot leave it blank'));
        }
    }
    
    @isTest
    static void checkAccountNumberTest()
    {
        Account recOfAcc = new Account(Name = 'Test Account', Phone = '4535687654', AccountNumber = '09876545678',Fax = '2345898912');
        try{
         insert recOfAcc;
        }
        Catch(DMLException de)
        {
            Assert.isTrue(de.getMessage().contains('Account Number is a required field at the time of creation & updation and you cannot leave it blank'));
        }
    }
    
    @isTest
    static void restrictAccDeletionTest()
    {
        Profile recOfCreatedSystemAdminProfile = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1];
        Profile recOfCreatedCustomeSalesProfile = [SELECT Id FROM Profile WHERE Name = 'Custom: Sales Profile' LIMIT 1];
     
        User recOfSystemAdminUser = new User(Username = 'systemadmin123@test.com',LastName = 'System Administrator',Email = 'tes23@test.com', Alias = 'SA',TimeZoneSidKey = 'America/Los_Angeles',
                                             LocaleSidKey = 'en_US',EmailEncodingKey = 'UTF-8',LanguageLocaleKey = 'en_US',
                                             ProfileId = recOfCreatedSystemAdminProfile.Id);
        
        User recOfCustomeSalesUser = new User(Username = 'customesales123@test.com',LastName =' Custom: Sales Profile', Email = 'tes43@test.com', Alias = 'CS',TimeZoneSidKey = 'America/Los_Angeles',
                                             LocaleSidKey = 'en_US',EmailEncodingKey = 'UTF-8',LanguageLocaleKey = 'en_US',
                                             ProfileId = recOfCreatedCustomeSalesProfile.Id);
        
      
        insert recOfSystemAdminUser;
        insert recOfCustomeSalesUser;
        
        System.runAs(recOfCustomeSalesUser)
        {
        Account recOfCSAcc = new Account(Name = 'Test Acc', Fax = '1234567891',AccountNumber = '09876545678', Active__c = 'Yes');
        insert recOfCSAcc;
        
        
        try
        {
            System.debug('Current Profile Id: ' + UserInfo.getProfileId());
    		System.debug('Sales Profile Id: ' + recOfCreatedCustomeSalesProfile.Id);
            System.debug('Account Id whic we want to delete: ' + recOfCSAcc.Id);
            delete recOfCSAcc;
        }
        Catch(DMLException de)
        {
           System.debug('Delete Error: ' + de.getMessage());
           Assert.isTrue(de.getMessage().contains('You are not allowed to delete the record if it is Active'));

        }
        }
        
        System.runAs(recOfSystemAdminUser)
        {
        Account recOfSAAcc = new Account(Name = 'Test systemAdmin Acc', Fax = '1234747891',AccountNumber = '0983445678', Active__c = 'Yes');
        insert recOfSAAcc;
            
        delete recOfSAAcc;
         
        System.debug('Account Deleted Id: ' + recOfSAAcc.Id);
            
        Account deletedAcc = [SELECT Id, Name, IsDeleted FROM Account WHERE Id = :recOfSAAcc.Id ALL ROWS];   
        System.debug('Deleted Account Details: ' + deletedAcc);
        System.debug('Is Account Deleted: ' + deletedAcc.IsDeleted);

        System.assertEquals(true, deletedAcc.IsDeleted);
             
        }
        
    }
}