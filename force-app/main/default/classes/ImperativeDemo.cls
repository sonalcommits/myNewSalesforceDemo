public  class ImperativeDemo {
    @AuraEnabled
    public static List<Account> getAccountData(){
        return [SELECT Id, Name, Phone FROM Account LIMIT 20];       
    }
  }