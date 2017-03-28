/*
*TrailHead Class    
*Module: Asynchronous Apex
*Unit: Controlling processes using Queueable Apex
*Status: Completed
*/
public class AddPrimaryContact implements Queueable {
    
    private Contact con;
    private string state;
    
    public AddPrimaryContact(Contact conRec, string state) {
        this.con = conRec;
        this.state = state;
    }

    public void execute(QueueableContext context) {
        List<Account> accList = [Select id, Name, BillingState from Account WHERE BillingState =: state LIMIT 200];
        system.debug('Account List'+accList);
        system.debug('Queueable Context : '+context);system.debug('Contact Rec: '+con);
        List<Contact> conCloneList = new List<Contact>();
        for(Account acc: accList){
            Contact conClone = con.clone(false);
            conClone.accountid = acc.id;
            conCloneList.add(conClone);
        }
        insert conCloneList;
        system.debug('######'+conCloneList);
    }
    
}