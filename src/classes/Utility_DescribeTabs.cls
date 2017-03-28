/***************************************************************************************************
Class Name: Utility_DescribeTabs
Class Type: Utility Class 
Version     : 1.0 
Created Date: 06 July 2016
Function    : This class helps to return the list of Tab Properties of a specific app for User in context.
Input Parameters: None 
Output Parameters: None
Description:   Returns information about the standard and custom apps available to the user in context.
Used in     : Finding which apps and properties of Tabs of Objects under the app available to User In Context. 
Modification Log :
* Developer                   Date                   Description
* ----------------------------------------------------------------------------                 
* JRK                        07/06/2016              Created
****************************************************************************************************/   
public class Utility_DescribeTabs{

    /***************************************************************************************************
    Method Name:  
    Method Type: Utility_DescribeTabs Method 
    Version     : 1.0 
    Created Date: 06 July 2016
    Function    : This method takes in app's name as parameter and returns the related tab properties under it.
    Input Parameters: appName as String
    Output Parameters: Tab Properties of each object available to the user in context.  
    Description:  Based on the passed app name, the related Tab properties are returned.  
    Used in: obtaining Tab properties
    Number of Queries Within this Method: 0
    Number of Queries in Loop: 0
    Number of Queries from Called methods:  0
    Modification Log :
    * Developer        Date                   Description
    * ----------------------------------------------------------------------------                 
    * JRK              07/06/2016              Created
    ****************************************************************************************************/  
    public static List<String> getTabProperties(String appName, String tabAttribute){

        // Get tab set describes for each app
        List<Schema.DescribeTabSetResult> tabSetDesc = Schema.describeTabs();
        String appLabel = '';
        Set<String> appLabelList = new Set<String>();
        Map<String,List<Schema.DescribeTabResult>> tabListToAppLabel = new Map<String,List<Schema.DescribeTabResult>>();
        String result = '';
        List<String> resultList = new List<String>();
        Boolean notValidName = false; 
        // Iterate through each tab set describe for each app and display the info
        if(tabSetDesc <> null){
            for(DescribeTabSetResult tsr: tabSetDesc){
                appLabel = tsr.getLabel();
                appLabelList.add(appLabel);
                tabListToAppLabel.put(appLabel,tsr.getTabs());                
            }

            // Display tab info for the Sales app
            if (appLabelList.contains(appName) && tabListToAppLabel <> null && tabListToAppLabel.size() > 0){
                try{
                    for(Schema.DescribeTabResult tr: tabListToAppLabel.get(appName)){                       
                        if(tabAttribute == 'Label'){
                            result = tr.getLabel();
                        }else if(tabAttribute == 'Colors'){
                            result = 'null';
                        }else if(tabAttribute == 'IconUrl'){
                            result = tr.getIconUrl();
                        }else if(tabAttribute == 'Icons'){
                            result = 'null';
                        }else if(tabAttribute == 'SobjectName'){
                            result = tr.getSobjectName();
                        }else if(tabAttribute == 'Url'){
                            result = tr.getUrl();
                        }else if(tabAttribute == 'Custom'){
                            if(tr.isCustom()){
                                result = 'True';
                            }                            
                        }else{
                            notValidName = true;
                        }
                        resultList.add(result);
                    }
                    if(notValidName){
                        try{
                            throw new customException('Please check your parameters and use only from the given list. Either of the values:  '+ tabAttribute+', '+appName+' is Invalid');
                        }catch(customException ex){
                            SI_Exception_Class.InsertException('NA','Utility_DescribeTabs','NA', 'getTabProperties',ex);
                            System.debug('ERROR'+ex.getMessage()); 
                        }
                    }
                }catch(Exception e){
                        SI_Exception_Class.InsertException('NA','Utility_DescribeTabs','NA', 'getTabProperties',e);
                }
                
            }    
        }
        return resultList;     
    }    
}

/*
what is the scope of static variables in a class in salesforce?? is it shared??? no
what is the need for record types in salesforce?? for using picklists
How can you insert records on page load?? -- using action method
*/