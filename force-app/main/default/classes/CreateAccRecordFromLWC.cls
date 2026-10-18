public class CreateAccRecordFromLWC {
    @AuraEnabled
    public static List<Account> CreateAccRecord(String accName, String accFax) {
        System.debug('AS Test '+ accFax);
        Account recOfAccount = new Account(Name = accName, Fax = accFax);
        List<Account> lstOfAccount = new List<Account>{recOfAccount};
        insert lstOfAccount;
        return lstOfAccount;

    }
}