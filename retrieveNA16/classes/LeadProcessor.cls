/*
*TrailHead Class	
*Module: Asynchronous Apex
*Unit: Using Batch Apex
*Status: Completed
*/

global class LeadProcessor implements 
    Database.Batchable<sObject> {
    
    // instance member to retain state across transactions
    //global Integer recordsProcessed = 0;

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id,Address,City,Company,CreatedById,CreatedDate, ' +
            'Email,LeadSource,Name FROM Lead '
        );
    }

    global void execute(Database.BatchableContext bc, List<Lead> scope){
        // process each batch of records
        List<Lead> leadList = new List<Lead>();
		for (Lead leadRec : scope) {
			leadRec.LeadSource = 'Dreamforce';
			// add contact to list to be updated
			leadList.add(leadRec);
		}
        update leadList;
    }    

    global void finish(Database.BatchableContext bc){
        // System.debug(recordsProcessed + ' records processed. Shazam!');
        // AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, 
            // JobItemsProcessed,
            // TotalJobItems, CreatedBy.Email
            // FROM AsyncApexJob
            // WHERE Id = :bc.getJobId()];
        // // call some utility to send email
        // EmailUtils.sendMessage(a, recordsProcessed);
    }    

}