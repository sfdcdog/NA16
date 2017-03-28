global with sharing class AngularDemoController{
    static List<Account> accList = new List<Account>();
    
    public AngularDemoController(){
        for(Account acc: [Select name, billingstreet,
           billingcity, billingstate, billingpostalcode
           from account order by name]){
            accList.add(acc);
        }
    }
    
    global static String getAccounts(){
        return JSON.serialize(accList);
    }

    global static String getContacts(){
        return JSON.serialize([select id, name, email from Contact where accountId IN: accList]);
    }
    
}