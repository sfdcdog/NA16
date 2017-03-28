public class Seasonal_Address_Line_Item_Dispatcher{
    public static void beforeMethod(List<Seasonal_Address_Line_Item__c> oldList, List<Seasonal_Address_Line_Item__c> newList, 
                    Map<Id,Seasonal_Address_Line_Item__c> oldMap,Map<Id,Seasonal_Address_Line_Item__c> newMap){
        if(trigger.isInsert){
           //use Seasonal_Address_Line_Item_Handler class for your business logic for specific code
           Seasonal_Address_Line_Item_Handler.preventDateOverlap(newList);
        }
        if(trigger.isUpdate){
           //use Seasonal_Address_Line_Item_Handler class for your business logic for specific code
           Seasonal_Address_Line_Item_Handler.preventDateOverlap(newList);
        }
        if(trigger.isDelete){
           //use Seasonal_Address_Line_Item_Handler class for your business logic for specific code
        }
    }  
    
    public static void afterMethod(List<Seasonal_Address_Line_Item__c> oldList, List<Seasonal_Address_Line_Item__c> newList, 
                            Map<Id,Seasonal_Address_Line_Item__c> oldMap,Map<Id,Seasonal_Address_Line_Item__c> newMap){
        if(trigger.isInsert){
            //use Seasonal_Address_Line_Item_Handler class for your business logic for specific code
        }
        if(trigger.isUpdate){
            //use Seasonal_Address_Line_Item_Handler class for your business logic for specific code
            Seasonal_Address_Line_Item_Handler.onaddressinvalid(newList);
            Seasonal_Address_Line_Item_Handler.onDateChange(newList, oldMap);
        }
        if(trigger.isDelete){
            //use Seasonal_Address_Line_Item_Handler class for your business logic for specific code 
        }
    }
}