public class forEachLoopDemoClass {
   
    @AuraEnabled(Cacheable = true)
    public static List<Contact> getContactNames() {
        return [SELECT Id, Name FROM Contact];

    }
}