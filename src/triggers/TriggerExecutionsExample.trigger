trigger TriggerExecutionsExample on Example_Trigger_Executions__c (after insert, after update, after delete, before insert, before update, before delete){
     if(trigger.isBefore){
        Example_Trigger_Executions_Dispatcher.beforeMethod(trigger.old, trigger.new, trigger.oldMap, trigger.newMap);
    }
    if(trigger.isAfter){
        Example_Trigger_Executions_Dispatcher.afterMethod(trigger.old, trigger.new, trigger.oldMap, trigger.newMap);
    }

}