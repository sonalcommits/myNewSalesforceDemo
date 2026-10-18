@isTest
public class TestDataFactory {
    public static void createSingelAccData()
    {
        Account recOfAcc = new Account(Name = 'Test Account', Fax = '1234567892');
        insert recOfAcc;
    }
     public static void createMultipelAccData(Integer numOfAccs)
    {
        List<Account> lstOfAcctoInsert = new List<Account>();
        for(Integer i=0; i<numOfAccs; i++)
        {
        	 Account recOfAcc = new Account(Name = 'Test Account', Fax = '1234567892');
 			 lstOfAcctoInsert.add(recOfAcc);
        }
        insert lstOfAcctoInsert;
    }

    public static void createContactData()     
    {
        Contact recOfContact = new Contact(LastName = 'Test', Email = 'test@test.com');
        insert recOfContact;
    }
    
}