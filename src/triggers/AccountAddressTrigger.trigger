/* 
*TrailHead Class	
*Module: Apex Triggers 
*Unit: Getting Started with Apex Triggers 
*Status: Completed 
*/
trigger AccountAddressTrigger on Account (before insert, before update, before delete, after insert, after update, after delete) {
    if(trigger.isBefore){
        AccountAddress_Dispatcher.beforeMethod(trigger.old, trigger.new, trigger.oldMap, trigger.newMap);
    }
    if(trigger.isAfter){
        AccountAddress_Dispatcher.afterMethod(trigger.old, trigger.new, trigger.oldMap, trigger.newMap);
    }

}