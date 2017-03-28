/*@isTest
public class Example_Trigger_Executions_Test{

    public static testmethod void Example_Method(){
        //Create Custom Settings
        SI_Trigger_Executions__c TriggerExecution = new SI_Trigger_Executions__c ();
        TriggerExecution.Name = 'BeforeInsertTriggerExecutions';
        TriggerExecution.SI_Active__c = true;
        TriggerExecution.SI_Class_Name__c ='Example_Trigger_Executions_Handler';
        TriggerExecution.SI_Description__c = 'MethodDescription';
        TriggerExecution.SI_Object__c = 'Trigger Executions Example';
        TriggerExecution.SI_Trigger_Events__c = 'Before Insert';
        insert TriggerExecution;
        System.assert(TriggerExecution.id!= null, 'Record not created');
        List<Example_Trigger_Executions__c> TrgExecList =  new List<Example_Trigger_Executions__c>();
        TrgExecList = TestUtilities.getTriggerExecutions(3);
        insert TrgExecList; 
    }
    
    public static testmethod void Example_Method2(){
        //Create Custom Settings
        SI_Trigger_Executions__c TriggerExecution = new SI_Trigger_Executions__c();
        TriggerExecution.Name = 'AfterInsertTriggerExecutions';
        TriggerExecution.SI_Active__c = true;
        TriggerExecution.SI_Class_Name__c ='Example_Trigger_Executions_Handler';
        TriggerExecution.SI_Description__c = 'MethodDescription';
        TriggerExecution.SI_Object__c = 'Trigger Executions Example';
        TriggerExecution.SI_Trigger_Events__c = 'After Insert';
        insert TriggerExecution;
        List<Example_Trigger_Executions__c> TrgExecList =  new List<Example_Trigger_Executions__c>();
        TrgExecList = TestUtilities.getTriggerExecutions(3);
        insert TrgExecList; 
    
    }
}*/

@isTest
public class Example_Trigger_Executions_Test{

    public static testmethod void Example_Method(){

        //Create Custom Settings
        SI_Trigger_Executions__c TriggerExecution = new SI_Trigger_Executions__c (
            Name = 'BeforeInsertTriggerExecutions',
            SI_Active__c = true,
            SI_Class_Name__c = 'Example_Trigger_Executions_Handler',
            SI_Description__c = 'MethodDescription',
            SI_Object__c  ='Trigger Executions Example',
            SI_Trigger_Events__c = 'Before Insert'
        );
        insert TriggerExecution;
        System.assert(TriggerExecution.id!= null, 'Record not created');
        
        List<Example_Trigger_Executions__c> TrgExecList =  new List<Example_Trigger_Executions__c>();
            TrgExecList = TestUtilities.getTriggerExecutions(3);
            insert TrgExecList; 
    }
    
    public static testmethod void Example_Method2(){
        //Create Custom Settings
        SI_Trigger_Executions__c TriggerExecution = new SI_Trigger_Executions__c (
            Name = 'AfterInsertTriggerExecutions',
            SI_Active__c = true,
            SI_Class_Name__c = 'Example_Trigger_Executions_Handler',
            SI_Description__c = 'MethodDescription',
            SI_Object__c  ='Trigger Executions Example',
            SI_Trigger_Events__c = 'After Insert'
        );
        insert TriggerExecution;
        
        List<Example_Trigger_Executions__c> TrgExecList =  new List<Example_Trigger_Executions__c>();
        TrgExecList = TestUtilities.getTriggerExecutions(3);
        insert TrgExecList; 
    
    }
}