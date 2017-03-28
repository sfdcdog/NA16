public class AccountProcessor{

    @future
    public static void countContacts(List<String> accIds){
        List<Account> accList = new List<Account>();
        Map<Id,Account> accMap = new Map<Id,Account>([Select id,(Select id,accountId from Contacts),Number_of_Contacts__c from Account where id IN: accIds]); 
        for(Account acc: accMap.values()){
            integer count = 1;
            for(Contact con: accMap.get(acc.id).Contacts){
                if(con.accountid == acc.id){
                    acc.Number_of_Contacts__c = count++;
                    
                }
            }
            accList.add(acc);
        }
        system.debug('@@@@@@@@@@@'+accList);
        update accList;
    }
}