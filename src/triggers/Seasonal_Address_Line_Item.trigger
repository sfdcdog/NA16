trigger Seasonal_Address_Line_Item on Seasonal_Address_Line_Item__c (before insert, before update, before delete, after insert, after update, after delete) {
    if(trigger.isBefore){
        Seasonal_Address_Line_Item_Dispatcher.beforeMethod(trigger.old, trigger.new, trigger.oldMap, trigger.newMap);
    }
    if(trigger.isAfter){
        Seasonal_Address_Line_Item_Dispatcher.afterMethod(trigger.old, trigger.new, trigger.oldMap, trigger.newMap);
    }

}