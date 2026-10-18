public class WireDemo {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountData(){
        return [SELECT Id, Name, Phone FROM Account LIMIT 20];
        
    }
   
}