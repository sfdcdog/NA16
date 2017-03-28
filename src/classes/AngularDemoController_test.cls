global with sharing class AngularDemoController_test{
	//Test for Git.
    static List<Account> accList = new List<Account>();
    
    public AngularDemoController_test(){
        for(Account acc: [Select name, billingstreet,
           billingcity, billingstate, billingpostalcode
           from account order by name]){
            accList.add(acc);
        }
    }
    
    global static String getAccounts(){
        List<wrapAccount> wrpAccList = new List<wrapAccount>();
         
        for(Account acc: accList){
            wrapAccount wrpAcc = new wrapAccount();
            wrpAcc.wrapAcc = acc;
            wrpAcc.selectedAcc = true;
            wrpAccList.add(wrpAcc);
        } 
        return JSON.serialize(wrpAccList);
    }

    global static String getContacts(){
        return JSON.serialize([select id, name, email from Contact where accountId IN: accList]);
    }
    
    global class wrapAccount{
        public Account wrapAcc{get;set;}
        public boolean selectedAcc{get;set;}
    }
}