/**************************************************************************************************
* Apex Class Name   : AppExc_Utility
* Created Date      : 14 May 2016
* Description       : Utility methods to handle generic functions
* 
* Developer             Date              Description
* -------------------------------------------------------------------------------------------------                 
* JRK                   05/14/2016        Creation
**************************************************************************************************/
public class AppExc_Utility{
    
    
    /***************************************************************************************************
    Method Name:  addBreaktags
    Method Type: Helper Mehtod 
    Version     : 1.0 
    Created Date: 14 May 2016
    Function    : Returns replaced String with the BR tags replaced with BR Tags.
    Input Parameters: String
    Output Parameters: String
    Description: Returns the replaced String.
    Used in     : Rich to Plain Conversion
    Modification Log :
    * Developer      Date                   Description
    * ----------------------------------------------------------------------------                 
    * JRK            05/14/2016             Created
    ****************************************************************************************************/
    public static String addBreaktags(String str){     
        system.debug('coming in here test#####');
        str = str.replaceAll('\n','<br>');
        str = str.unescapeHTML4();
        system.debug('unescape output>>>>>>>>'+str);      
        return str;  
    }
    
    
    /***************************************************************************************************
    Method Name:  substituteHTMLTags
    Method Type: Helper Method 
    Version     : 1.0 
    Created Date: 14 May 2016
    Function    : Returns replaced String with the HTML tags replaced by BR tags.
    Input Parameters: String
    Output Parameters: String
    Description: Returns the replaced String.
    Used in     : Rich to Plain Conversion
    Modification Log :
    * Developer      Date                  Description
    * ----------------------------------------------------------------------------                 
    * JRK            05/14/2016            Created
    ****************************************************************************************************/
    public static String substituteHTMLTags(String str){     
        List<App_Exc_HTML_Tag_Replacement_Map__c> rtf2HTMLsettings = App_Exc_HTML_Tag_Replacement_Map__c.getall().values();
        for(App_Exc_HTML_Tag_Replacement_Map__c rtf2HtmlSetting: rtf2HTMLsettings){
            system.debug('entering ***');
            str = str.replaceAll(rtf2HtmlSetting.App_Exc_ReplacedTag__c,rtf2HtmlSetting.App_Exc_ReplaceWith__c);
            system.debug('1st op>>>>>>>>>>>>>>'+str);
        }
        
        return str;  
    }

    /***************************************************************************************************
    Method Name:  stripandunescapeHtmlTags
    Method Type: Helper Method 
    Version     : 1.0 
    Created Date: 14 May 2016
    Function    : Returns text without HTML BR tags and preserves the new lines(characters) on Rich to Plain Conversion.
    Input Parameters: String
    Output Parameters: String
    Description: Returns the replaced String.
    Used in     : Rich to Plain Conversion
    Modification Log :
    * Developer      Date                  Description
    * ----------------------------------------------------------------------------                 
    * JRK            05/14/2016            Created
    ****************************************************************************************************/
    /*public static boolean isLoggeInUserMigrationUser=false;*/
    public static String stripandunescapeHtmlTags(String str){     
        /*isLoggeInUserMigrationUser = Core_IPS_CaseTriggerHandler.isMigrationUser(string.valueof(userinfo.getuserId()));*/
        str = str.unescapeHTML4(); 
        /*if(!isLoggeInUserMigrationUser){*/
            str = str.striphtmlTags();//this should not be run for dm profile
        /*}*/  
        system.debug('2nd opt>>>>>>>>>>'+str);
        return str;  
    }
    
}