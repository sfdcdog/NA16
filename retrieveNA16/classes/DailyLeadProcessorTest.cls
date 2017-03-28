@isTest
/*
*TrailHead Class	
*Module: Asynchronous Apex
*Unit: Scheduling Jobs Using the Apex Scheduler
*Status: Completed
*/
private class DailyLeadProcessorTest {

    // Dummy CRON expression: midnight on March 15.
    // Because this is a test, job executes
    // immediately after Test.stopTest().
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';

    static testmethod void testScheduledJob() {

        // Create some out of date Opportunity records
        List<Lead> leads = new List<Lead>();
        for (Integer i=0; i<200; i++) {
            Lead ldRec = new Lead(
                LeadSource  = '',
                Company = 'Tahi',
                LastName = 'Latname'+i
            );
            leads.add(ldRec);
        }
        insert leads;
        
        // Get the IDs of the opportunities we just inserted
        Map<Id, Lead> leadMap = new Map<Id, Lead>(leads);
        List<Id> leadIds = new List<Id>(leadMap.keySet());

        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP, 
            new DailyLeadProcessor());         
        
        // Stopping the test will run the job synchronously
        Test.stopTest();


    }
}