/* 
*TrailHead Class	
*Module: Apex Triggers 
*Unit: Getting Started with Apex Triggers 
*Status: Completed 
*/
public class AccountAddress_Dispatcher{
    public static void beforeMethod(List<Account> oldList, List<Account> newList, 
                    Map<Id,Account> oldMap,Map<Id,Account> newMap){
        if(trigger.isInsert){
           AccountAddress_Handler.populateShippingAddress(newList);
        }
        if(trigger.isUpdate){
           AccountAddress_Handler.populateShippingAddress(newList);
        }
        if(trigger.isDelete){
           
        }
    }  
    
    public static void afterMethod(List<Account> oldList, List<Account> newList, 
                            Map<Id,Account> oldMap,Map<Id,Account> newMap){
        if(trigger.isInsert){
            
        }
        if(trigger.isUpdate){
            
        }
        if(trigger.isDelete){

        }
    }
}