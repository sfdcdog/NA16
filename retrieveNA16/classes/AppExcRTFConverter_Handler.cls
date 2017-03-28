/***************************************************************************************************
Class Name:  AppExcRTFConverter_Handler
Class Type: Handler Class 
Version     : 1.0 
Created Date: 17 Nov 2015
Function    : This class contains utility 
Input Parameters: None 
Output Parameters: None
Description:   Used in AppExcRTFConverter(Comments) creation
Used in     : AppExcRTFConverter Creation
Modification Log :
* Developer                   Date                   Description
* ----------------------------------------------------------------------------                 
* JRK                        11/17/2015              Created
****************************************************************************************************/   
public class AppExcRTFConverter_Handler{    
    /***************************************************************************************************
    Method Name:  replaceFormatting
    Method Type: AppExcRTFConverter Handler Method 
    Version     : 1.0 
    Created Date: 14 May 2016
    Function    : This method is used to populate the Plain Text field by removing 
                  formatting and replacing the same with Plain text.
    Input Parameters: Trigger.New List
    Output Parameters: None
    Description:   This method takes a list of records in Trigger.New and each records Plain Text field 
                   and is updated by passing the rich Text data to Helper Utility methods
    Used in: AppExcRTFConverter Rich to Plain Text Conversion
    Number of Queries Within this Method: 0
    Number of Queries in Loop: 0
    Number of Queries from Called methods:  0
    Modification Log :
    * Developer      Date                   Description
    * ----------------------------------------------------------------------------                 
    * JRK            05/14/2015             Created
    ****************************************************************************************************/  
    public static void replaceFormatting(List<App_Exc_RTP_Convertor__c> newList){
      if(newList <> null && newList.size()>0){
        for(App_Exc_RTP_Convertor__c RTP: newList){
          if(RTP.RTP_Rich_Comment__c <> null){
            system.debug('Rich Desc*****'+RTP.RTP_Rich_Comment__c );
            RTP.RTP_Comment__c = AppExc_Utility.substituteHTMLTags(RTP.RTP_Rich_Comment__c);//replaceHtmlTags
            if(RTP.RTP_Comment__c <> null)
            RTP.RTP_Comment__c = AppExc_Utility.stripandunescapeHtmlTags(RTP.RTP_Comment__c);//replaceSpecialChar
            system.debug('Plain Desc*****'+RTP.RTP_Comment__c);
          }
        }
      }
    }
    
        
    /***************************************************************************************************
    Method Name:  rerenderRTF
    Method Type: AppExcRTFConverter Handler Method 
    Version     : 1.0 
    Created Date: 17 Nov 2015
    Function    : This method is used to populate the Plain Text field by removing 
                  formatting and replacing the same with Plain text.
    Input Parameters: Trigger.New List
    Output Parameters: None
    Description:   This method takes a list of records in Trigger.New and each records Plain Text field 
                   and is updated by passing the rich Text data to Helper Utility methods
    Used in: AppExcRTFConverter Rich to Plain Text Conversion

    Number of Queries Within this Method: 0
    Number of Queries in Loop: 0
    Number of Queries from Called methods:  0Modification Log :
    * Developer      Date                   Description
    * ----------------------------------------------------------------------------                 
    * JRK            05/14/2015             Created
    ****************************************************************************************************/  
    public static void rerenderRTF(List<App_Exc_RTP_Convertor__c> newList){
      if(newList <> null && newList.size()>0){
        List<App_Exc_RTP_Convertor__c> RTPs = new List<App_Exc_RTP_Convertor__c>();
        List<App_Exc_RTP_Convertor__c> RTPList = [Select id,RTP_Rich_Comment__c from App_Exc_RTP_Convertor__c where id IN: newList];
        for(App_Exc_RTP_Convertor__c RTP: RTPList){
          if(RTP.RTP_Rich_Comment__c <> null){
            RTP.RTP_Rich_Comment__c = AppExc_Utility.addBreaktags(RTP.RTP_Rich_Comment__c);
            RTPs.add(RTP);
          }
        }
        if(RTPs <> null && RTPs.size()>0)
        AppExcRTFConverter_Dispatcher.isUpdated = true;
        update RTPs;
      }       
    }
}