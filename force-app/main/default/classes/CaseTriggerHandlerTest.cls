@isTest
public class CaseTriggerHandlerTest {
    @TestSetup 
    static void createData()
    {
        List<Account> accList = new List<Account>();
         Account acc1 = new Account(Name = 'Premier Account',Support_Tier__c = 'Premier',Fax = '9064156789');
		 accList.add(acc1);
		 Account acc2 = new Account(Name = 'Standard Account',Support_Tier__c = 'Standard',Fax = '9064156776');
		 accList.add(acc2);
         Account acc3 = new Account(Name = 'Basic Account',Support_Tier__c = 'Basic',Fax = '9069874776');
		 accList.add(acc3);
         insert accList;
    }
    
    @isTest
    static void setCasePriorityBasedOnSupportTierPremierTest()
    {
         Account recOfCreatdeAcc = [SELECT Id FROM Account  WHERE Support_Tier__c = 'Premier'];
                
         Case recOfCase = new Case(AccountId = recOfCreatdeAcc.Id);
         insert recOfCase;
         
         recOfCase = [SELECT Priority, Status FROM Case WHERE Id = :recOfCase.Id];
         Assert.areEqual('High', recOfCase.Priority);
 		 Assert.areEqual('Working', recOfCase.Status);
    }

    @isTest
    static void setCasePriorityBasedOnSupportTierStandardTest()
    {
         Account recOfCreatdeAcc = [SELECT Id FROM Account  WHERE Support_Tier__c = 'Standard'];
                
         Case recOfCase = new Case(AccountId = recOfCreatdeAcc.Id);
         insert recOfCase;
         
         recOfCase = [SELECT Priority, Status FROM Case WHERE Id = :recOfCase.Id];
         Assert.areEqual('Medium', recOfCase.Priority);
    }
    
    @isTest
    static void setCasePriorityBasedOnSupportTierBasicTest()
    {
         Account recOfCreatdeAcc = [SELECT Id FROM Account  WHERE Support_Tier__c = 'Basic'];
                
         Case recOfCase = new Case(AccountId = recOfCreatdeAcc.Id);
         insert recOfCase;
         
         recOfCase = [SELECT Priority, Status FROM Case WHERE Id = :recOfCase.Id];
         Assert.areEqual('Low', recOfCase.Priority);
    }
    
    @isTest
    static void updateRelatedTasksStatusTest()
    {
         Account recOfAcc = new Account(Name='Test', Fax = '2365798112');
   		 insert recOfAcc;
        
        Case recOfCase = new Case(AccountId = recOfAcc.Id, Status='New');
        insert recOfCase;
        
        Task recOfTask = new Task(Status='Not Started',Priority='Normal', WhatId=recOfCase.Id);
        insert recOfTask;
        
         recOfCase.Status='Working';
  		 update recOfCase;
        
         recOfTask = [SELECT Status FROM Task WHERE Id=:recOfTask.Id];
         Assert.areEqual('In Progress', recOfTask.Status);
    }
      @isTest
      static void updateAccountDescriptionTest()
      {
         Account recOfAcc = new Account(Name='Test', Fax = '2365798112');
   		 insert recOfAcc;
          
        Case recOfCase = new Case(AccountId = recOfAcc.Id, Status='New');
        insert recOfCase;
          
         recOfCase.Status = 'Working';
         update recOfCase;
          
          recOfAcc = [SELECT Description FROM Account WHERE Id =: recOfAcc.Id];
          recOfCase = [SELECT CaseNumber, Status FROM Case WHERE Id =:recOfCase.Id];
          Assert.areEqual('Case Number : ' + recOfCase.CaseNumber +' Status : ' + recOfCase.Status, recOfAcc.Description);
      }

}