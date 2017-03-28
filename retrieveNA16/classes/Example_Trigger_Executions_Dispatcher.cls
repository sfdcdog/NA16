public class Example_Trigger_Executions_Dispatcher{
    
    public static void beforeMethod(List<Example_Trigger_Executions__c> oldList, List<Example_Trigger_Executions__c> newList, Map<Id,Example_Trigger_Executions__c> oldMap,Map<Id,Example_Trigger_Executions__c> newMap){
        if(trigger.isInsert){
            // Fetching "Custom Setting" containing details to trigger switch on/off
            Map <String, SI_Trigger_Executions__c> triggerExecutionsMap = SI_Trigger_Executions__c.getAll();
            if (!triggerExecutionsMap.isEmpty()){
                if (triggerExecutionsMap.containsKey('BeforeInsertTriggerExecutions') && triggerExecutionsMap.get('BeforeInsertTriggerExecutions').SI_Active__c){ 
                    Example_Trigger_Executions_Handler.Example_Method(newList);
                    
                }
            }
            
        }
        if(trigger.isUpdate){

        }
        if(trigger.isDelete){
            
        }
    } 

    public static void afterMethod(List<Example_Trigger_Executions__c> oldList, List<Example_Trigger_Executions__c> newList, Map<Id,Example_Trigger_Executions__c> oldMap,Map<Id,Example_Trigger_Executions__c> newMap){
        if(trigger.isInsert){
            // Fetching "Custom Setting" containing details to trigger switch on/off
            Map <String, SI_Trigger_Executions__c> triggerExecutionsMap = SI_Trigger_Executions__c.getAll();
            if (!triggerExecutionsMap.isEmpty()){
                if (triggerExecutionsMap.containsKey('AfterInsertTriggerExecutions') && triggerExecutionsMap.get('AfterInsertTriggerExecutions').SI_Active__c){ 
                    Example_Trigger_Executions_Handler.Example_Method2(newList);
                    
                }
            }
            
        }
        if(trigger.isUpdate){

        }
        if(trigger.isDelete){
            
        }
    }
    
    
    
}