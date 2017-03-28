public class Example_Trigger_Executions_Handler{

    public static void Example_Method(List<Example_Trigger_Executions__c> newList){ 
        for(Example_Trigger_Executions__c TrgExec: newList){
            TrgExec.Example_TestName__c = 'Example_Account';
        }
    }
    
    public static void Example_Method2(List<Example_Trigger_Executions__c> newList){
        List<Example_Trigger_Executions__c> TrgExecList = new List<Example_Trigger_Executions__c>();
        List<Example_Trigger_Executions__c> newListQueried = [Select id,Example_TestCheckBox__c from Example_Trigger_Executions__c where id IN: newList];
        for(Example_Trigger_Executions__c TrgExec: newListQueried){
            if(TrgExec.Example_TestCheckBox__c <> true){
                TrgExec.Example_TestCheckBox__c= true;
                TrgExecList.add(TrgExec);
            }
        }
        update TrgExecList ;
    
    }
}