public with sharing class AppExcRTFConverter_Dispatcher{
    public static boolean isUpdated=false;
    public static void beforeMethod(List<App_Exc_RTP_Convertor__c> oldList, List<App_Exc_RTP_Convertor__c> newList, 
                    Map<Id,App_Exc_RTP_Convertor__c> oldMap,Map<Id,App_Exc_RTP_Convertor__c> newMap){
        if(trigger.isInsert){
            AppExcRTFConverter_Handler.replaceFormatting(newList);
        }
        if(trigger.isUpdate){
            system.debug('<<<<<<<<<<<<<<<<<<<<');
            if(!isUpdated)
                AppExcRTFConverter_Handler.replaceFormatting(newList);
        }
        if(trigger.isDelete){
         //use AppExcRTFConverter_Handler class for your business logic for IPS specific code, others can use their own handler
        }
    }  
    
    public static void afterMethod(List<App_Exc_RTP_Convertor__c> oldList, List<App_Exc_RTP_Convertor__c> newList, 
                            Map<Id,App_Exc_RTP_Convertor__c> oldMap,Map<Id,App_Exc_RTP_Convertor__c> newMap){
        /*isLoggeInUserMigrationUser = Core_IPS_CaseTriggerHandler.isMigrationUser(string.valueof(userinfo.getuserId()));
        isLoggeInUserIntegrationUser = AppExcRTFConverter_Handler.isIntegrationUser(string.valueof(userinfo.getuserId())); */
        if(trigger.isInsert){
            /*if(isLoggeInUserMigrationUser || isLoggeInUserIntegrationUser)*/
            AppExcRTFConverter_Handler.rerenderRTF(newList);
        }
        if(trigger.isUpdate){
            //use AppExcRTFConverter_Handler class for your business logic for IPS specific code, others can use their own handler    
            if(!isUpdated /*&& (isLoggeInUserMigrationUser || isLoggeInUserIntegrationUser)*/)
            AppExcRTFConverter_Handler.rerenderRTF(newList);       
        }
        if(trigger.isDelete){
         //use AppExcRTFConverter_Handler class for your business logic for IPS specific code, others can use their own handler
        }
    }
}