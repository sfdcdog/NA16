/*
*TrailHead Class	
*Module: Asynchronous Apex
*Unit: Scheduling Jobs Using the Apex Scheduler
*Status: Completed
*/
global class DailyLeadProcessor implements Schedulable {

    global void execute(SchedulableContext SC) {
        List<Lead> leadRecs =  new List<Lead>();
		List<Lead> leadList = [SELECT Id, LeadSource 
            FROM Lead 
            WHERE LeadSource = '' LIMIT 200];
		for(Lead ldRec: leadList){
			ldRec.LeadSource = 'Dreamforce';
			leadRecs.add(ldRec);
		}
		update leadRecs;
    }
    
}