@isTest
public class AccountProcessorTest{

    public static testmethod void accProcessor(){
        Test.starttest();
        List<Account> accList = TestUtilities.getAccountsList(5);
        system.debug('%%%%%%%%%'+accList);
        insert accList;
        List<Contact> conList = new List<Contact>();
        List<String> accIds = new List<String>();
        for(Account acc: accList){
            accIds.add(acc.id);   
            integer i = 0;
            Contact con = new Contact();
            con.LastName = 'test'+i;
            con.accountid = acc.id;
            i++;
            conList.add(con); 
            
        }
        insert conList;
        system.debug('#########'+conList);
        system.debug('$$$$$$$$$'+accIds);
        AccountProcessor.countContacts(accIds);
        Test.stoptest();
    }

}