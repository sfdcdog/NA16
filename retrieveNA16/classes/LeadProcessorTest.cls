@isTest
/*
*TrailHead Class	
*Module: Asynchronous Apex
*Unit: Using Batch Apex
*Status: Completed
*/
public class LeadProcessorTest {

    @testSetup 
    static void setup() {
        List<Lead> leadRecs = new List<Lead>();
        // insert 200 leadRecs
        for (Integer i=0;i<200;i++) {
            leadRecs.add(new Lead(FirstName='Lead '+i,LastName = 'Name'+i, 
                LeadSource='dfr'));
        }
        insert leadRecs;
        
    }

    static testmethod void test() {        
		Test.startTest();
		System.assertEquals(200, [select count() from contact where LeadSource = 'Dreamforce']);
        LeadProcessor lp = new LeadProcessor();
        Id batchId = Database.executeBatch(lp);
        Test.stopTest();

        // after the testing stops, assert records were updated properly
        System.assertEquals(200, [select count() from contact where LeadSource = 'Dreamforce']);
    }
    
}