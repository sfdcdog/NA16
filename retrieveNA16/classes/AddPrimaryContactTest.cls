@isTest
public class AddPrimaryContactTest {

    @testSetup 
    static void setup() {
        List<Account> accountsNY = new List<Account>();
        // add 50 accountsNY
        for (Integer i = 0; i < 50; i++) {
            accountsNY.add(new Account(
                name='Test AccountNY'+i,
				BillingState='NY'
            ));
        }
        insert accountsNY;
		
		List<Account> accountsCA = new List<Account>();
        // add 50 accountsCA
        for (Integer i = 0; i < 50; i++) {
            accountsCA.add(new Account(
                name='Test AccountCA'+i,
				BillingState='CA'
            ));
        }
        insert accountsCA;
		
    }
    
    static testmethod void testQueueablePositive() {
        //adding a contact
		Contact conRec = new Contact(
            Lastname = 'Dell',
            Email = 'Contact1Dell@gmail.com'
        );
		insert conRec;
		// query for test data to pass to queueable class
        List<Account> accounts = [select id, name, BillingState from account where BillingState like '%CA%'];
        // Create our Queueable instance
        AddPrimaryContact updateJob = new AddPrimaryContact(conRec, 'CA');
        // startTest/stopTest block to force async processes to run
        Test.startTest();        
        System.enqueueJob(updateJob);     
        Test.stopTest();        
        // Validate the job ran. Check if record have correct parentId now
        System.assertEquals(50, [select count() from Contact where account.BillingState = 'CA']);
    }
    
        /*static testmethod void testQueueableNegative() {
        //adding a contact
		Contact conRec = new Contact(
            Lastname = 'Dell',
            Email = 'Contact1Dell@gmail.com'
        );
		insert conRec;
		// query for test data to pass to queueable class
        List<Account> accounts = [select id, name, BillingState from account where BillingState like '%CA%'];
        
        // Create our Queueable instance 
        AddPrimaryContact updateJob1 = new AddPrimaryContact(conRec, 'AA');
        // startTest/stopTest block to force async processes to run
        Test.startTest();           
        System.enqueueJob(updateJob1);
        Test.stopTest();        
        // Validate the job ran. Check if record have correct parentId now
        System.assertEquals(0, [select count() from Contact where account.BillingState = 'CA']);
    }*/
    
}