/***************************************************************************************************
Class Name: Utility_SobjDescribe
Class Type: Example Class 
Version     : 1.0 
Created Date: 23 May 2016
Function    : This class helps to return the metadata of the given Object or List of Objects passed to its methods 
Input Parameters: None 
Output Parameters: None
Description:   Describes metadata (field list and object properties) for the specified sObject or array of sObjects.
Used in     : Obtaining Metadata
Modification Log :
* Developer                   Date                   Description
* ----------------------------------------------------------------------------                 
* JRK                        05/23/2016              Created
****************************************************************************************************/   
public class Utility_SobjectDescribe{

    /***************************************************************************************************
    Method Name:  getKeyPrefix
    Method Type: Utility_SobjDescribe Method 
    Version     : 1.0 
    Created Date: 23 May 2016
    Function    : This class helps to return the metadata of the given Object or List of Objects
    Input Parameters: List of sObjects
    Output Parameters: List of Strings depending on what is requested
    Description:   This method takes in two parameters, one is a list of sObjects(String Format results only) and a numeral
                which tells what will be returned
    Used in: Obtaining sObjectDescribe call Results individually
    Number of Queries Within this Method: 0
    Number of Queries in Loop: 0
    Number of Queries from Called methods:  0
    Modification Log :
    * Developer        Date                   Description
    * ----------------------------------------------------------------------------                 
    * JRK              05/23/2016              Created
    ****************************************************************************************************/  
    public static List<String> getStringData(List<String> objectApiList, Integer resultType){
        /*Schema.DescribeSObjectResult[] descResult = Schema.describeSObjects(objectApiList);
        system.debug('###'+descResult);*/
        List<String> y = new List<String>();
        String x = '';
        if(resultType > 4 || resultType < 1){
            try {
                throw new customException('Cannot Use Integers less than 1 or greater than 0');
            } catch(customException ex) {
                SI_Exception_Class.InsertException('NA','Utility_SobjectDescribe','NA', 'getStringData',ex);
                System.debug('ERROR'+ex.getMessage());        
            }
        }else{
            try{            
                for(Schema.DescribeSObjectResult descR: Schema.describeSObjects(objectApiList)){    
                    if(resultType == 1){
                        x = descR.getKeyPrefix();
                    }else if (resultType == 2) {
                        x = descR.getLabel();
                    }else if (resultType == 3) {
                        x = descR.getName();
                    }else if (resultType == 4) {
                        x = descR.getLabelPlural();
                    }
                    y.add(x);    
                }            
            }catch(Exception e){
                SI_Exception_Class.InsertException('NA','Utility_SobjectDescribe','NA', 'getStringData',e);
                System.debug('ERROR' + e.getMessage());
            }
        }
        system.debug('$$$'+y);
        return y;        
    }
    /***************************************************************************************************
    Method Name:  getBooleanData
    Method Type: Utility_SobjDescribe Method 
    Version     : 1.0 
    Created Date: 23 May 2016
    Function    : This class helps to return the metadata of the given Object or List of Objects
    Input Parameters: List of sObjects
    Output Parameters: List of Strings depending on what is requested
    Description:   This method takes in two parameters, one is a list of sObjects(Boolean Format results only) and a numeral
                which tells what will be returned
    Used in: Obtaining sObjectDescribe call Results individually
    Number of Queries Within this Method: 0
    Number of Queries in Loop: 0
    Number of Queries from Called methods:  0
    Modification Log :
    * Developer        Date                   Description
    * ----------------------------------------------------------------------------                 
    * JRK              05/23/2016              Created
    ****************************************************************************************************/  
    public static List<Boolean> getBooleanData(List<String> objectApiList, Integer resultType){
        /*Schema.DescribeSObjectResult[] descResult = Schema.describeSObjects(objectApiList);
        system.debug('###'+descResult);*/
        List<Boolean> y = new List<Boolean>();
        Boolean x;
        if(resultType > 12 || resultType < 1){
            try {
                throw new customException('Cannot Use Integers less than 1 or greater than 12');
            } catch(customException ex) {
                SI_Exception_Class.InsertException('NA','Utility_SobjectDescribe','NA', 'getBooleanData',ex);
                System.debug('ERROR'+ex.getMessage());        
            }
        }else{
            try{
                for(Schema.DescribeSObjectResult descR: Schema.describeSObjects(objectApiList)){    
                    if(resultType == 1){
                        x = descR.isAccessible();
                    }else if (resultType == 2) {
                        x = descR.isCreateable();
                    }else if (resultType == 3) {
                        x = descR.isCustom();
                    }else if (resultType == 4) {
                        x = descR.isCustomSetting();
                    }else if (resultType == 5) {
                        x = descR.isDeletable();
                    }else if (resultType == 6) {
                        x = descR.isDeprecatedAndHidden();
                    }else if (resultType == 7) {
                        x = descR.isFeedEnabled();
                    }else if (resultType == 8) {
                        x = descR.isMergeable();
                    }else if (resultType == 9) {
                        x = descR.isQueryable();
                    }else if (resultType == 10) {
                        x = descR.isSearchable();
                    }else if (resultType == 11) {
                        x = descR.isUndeletable();
                    }else if (resultType == 12) {
                        x = descR.isUpdateable();
                    }
                    y.add(x);
                }
            }catch(Exception E){
                SI_Exception_Class.InsertException('NA','Utility_SobjectDescribe','NA', 'getBooleanData',E);
                System.debug('ERROR'+e.getMessage());
            }
        }
        system.debug('$$$'+y);
        return y;
    }
}