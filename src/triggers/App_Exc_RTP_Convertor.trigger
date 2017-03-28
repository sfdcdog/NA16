trigger App_Exc_RTP_Convertor on App_Exc_RTP_Convertor__c (before insert, before update, before delete, after insert, after update, after delete) {
    if(trigger.isBefore){
        AppExcRTFConverter_Dispatcher.beforeMethod(trigger.old, trigger.new, trigger.oldMap, trigger.newMap);
    }
    if(trigger.isAfter){
        AppExcRTFConverter_Dispatcher.afterMethod(trigger.old, trigger.new, trigger.oldMap, trigger.newMap);
    }

}