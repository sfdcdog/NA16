/* 
*TrailHead Class	
*Module: Apex Triggers 
*Unit: Bulk Apex Triggers
*Status: Completed 
*/
trigger ClosedOpportunityTrigger on Opportunity (before insert, before update, before delete, after insert, after update, after delete) {
    if(trigger.isBefore){
        ClosedOpportunity_Dispatcher.beforeMethod(trigger.old, trigger.new, trigger.oldMap, trigger.newMap);
    }
    if(trigger.isAfter){
        ClosedOpportunity_Dispatcher.afterMethod(trigger.old, trigger.new, trigger.oldMap, trigger.newMap);
    }

}