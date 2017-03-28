/* 
*TrailHead Class	
*Module: Apex Triggers 
*Unit: Bulk Apex Triggers  
*Status: Completed 
*/
public class ClosedOpportunity_Dispatcher{
    public static void beforeMethod(List<Opportunity> oldList, List<Opportunity> newList, 
                    Map<Id,Opportunity> oldMap,Map<Id,Opportunity> newMap){
        if(trigger.isInsert){
           
        }
        if(trigger.isUpdate){
           
        }
        if(trigger.isDelete){
           
        }
    }  
    
    public static void afterMethod(List<Opportunity> oldList, List<Opportunity> newList, 
                            Map<Id,Opportunity> oldMap,Map<Id,Opportunity> newMap){
        if(trigger.isInsert){
            ClosedOpportunity_Handler.addTaskonClosedWon(newList);
        }
        if(trigger.isUpdate){
            ClosedOpportunity_Handler.addTaskonClosedWon(newList);
        }
        if(trigger.isDelete){

        }
    }
}