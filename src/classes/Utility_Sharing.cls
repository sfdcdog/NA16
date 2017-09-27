/***************************************************************************************************
Class Name: Utility_Sharing
Class Type: Utility Class 
Version     : 1.0 
Created Date: 05 July 2016
Function    : This class helps to create or remove Share Records 
Input Parameters: None 
Output Parameters: None
Description:   Contains methods that share and revoke access to records for the related users. 
Used in     : Creating share records or removing sehare records
Modification Log :
* Developer                   Date                   Description
* ----------------------------------------------------------------------------                 
* JRK                        07/05/2016              Created
****************************************************************************************************/   

public class Utility_Sharing{

    /***************************************************************************************************
    Method Name:  provideAccess
    Method Type: Utility_Sharing Method 
    Version     : 1.0 
    Created Date: 05 July 2016
    Function    : This method creates share records based on the Map containing set of users and respective records passed as parameters
    Input Parameters: objectName String, shareTableName String, recordAccessLevel String, Record and Users Map
    Output Parameters:  None
    Description:   Used as a generic method to create share Records for any type of sObject
    Used in: sharign of records to Users
    Number of Queries Within this Method: 0
    Number of Queries in Loop: 0
    Number of Queries from Called methods:  0
    Modification Log :
    * Developer        Date                   Description
    * ----------------------------------------------------------------------------                 
    * JRK              07/05/2016              Created
    ****************************************************************************************************/     

    public static void provideAccess(String objectName, String shareTableName, String recordAccessLevel, Map<id,Set<id>> record_UserList){
        List<SObject> shareRecords = new List<SObject>();
        Map<String, Schema.SObjectType> tokens = Schema.getGlobalDescribe();
        if(tokens.containsKey(shareTableName)){
            for(Id recId: record_UserList.keyset()){
                if(record_UserList.get(recId) <> null){
                    for(Id userId: record_UserList.get(recId)){
                        SObject share = tokens.get(shareTableName).newSObject();
                        if(objectName == 'Asset'){
                            share.put('AssetId',recId);
                            share.put('AssetAccessLevel',recordAccessLevel);
                        }else if(objectName == 'Case'){
                            share.put('CaseId',recId);
                            share.put('CaseAccessLevel',recordAccessLevel);
                        }else if(objectName == 'Account'){
                            share.put('AccountId',recId);
                            share.put('AccountAccessLevel',recordAccessLevel);
                        }else if(objectName == 'Opportunity'){
                            share.put('OpportunityId',recId);
                            share.put('OpportunityAccessLevel',recordAccessLevel);
                        }else if(objectName == 'Lead'){
                            share.put('LeadId',recId);
                            share.put('LeadAccessLevel',recordAccessLevel);
                        }else if(objectName == 'Contact'){
                            share.put('ContactId',recId);
                            share.put('ContactAccessLevel',recordAccessLevel);
                        }else if(objectName == 'Campaign'){
                            share.put('CampaignId',recId);
                            share.put('CampaignAccessLevel',recordAccessLevel);
                        }else if(objectName == 'Forecast'){
                            share.put('ForecastId',recId);
                            share.put('ForecastAccessLevel',recordAccessLevel);
                        }else if(objectName == 'Macro'){
                            share.put('MacroId',recId);
                            share.put('MacroAccessLevel',recordAccessLevel);
                        }else if(objectName == 'Order'){
                            share.put('OrderId',recId);
                            share.put('OrderAccessLevel',recordAccessLevel);
                        }else{
                            share.put('ParentId', recId);
                            share.put('AccessLevel', recordAccessLevel);
                        }
                        share.put('UserorGroupId',userId);
                        share.put('RowCause', 'Manual');
                        shareRecords.add(share);
                    }
                }                
            }
            try{
                Database.SaveResult[] shareInsertResult =  Database.insert(shareRecords,false);
                for(Database.SaveResult saveResult: shareInsertResult){
                    if(saveResult.isSuccess()){
                        system.debug('@@@ SaveResult ### - '+saveResult);
                    }else{
                        for(Database.Error err: saveResult.getErrors()) {                  
                            System.debug('@@@ ErrorResult ### - '+err.getStatusCode() + ': ' + err.getMessage());
                        }
                    }
                }
            }catch(Exception e){
                /*SI_Exception_Class.InsertException('NA','Utility_Sharing','NA', 'provideAccess',e);
                System.debug('@@@ Exception ### - '+e.getMessage());*/
            }
        }
    }

    /***************************************************************************************************
    Method Name:  provideAccess
    Method Type: Utility_Sharing Method 
    Version     : 1.0 
    Created Date: 08 Aug 2016
    Function    : This method creates share records based on the Map containing users and respective records passed as parameters
    Input Parameters: objectName String, shareTableName String, recordAccessLevel String, Record and Users Map
    Output Parameters:  None
    Description:   Used as a generic method to create share Records for any type of sObject
    Used in: sharing of records to Users
    Number of Queries Within this Method: 0
    Number of Queries from Called methods:  0
    Modification Log :
    * Developer        Date                   Description
    * ----------------------------------------------------------------------------                 
    * JRK              08/08/2016              Created
    ****************************************************************************************************/     

    public static void provideAccess(String objectName, String shareTableName, String recordAccessLevel, Map<id,id> record_UserList){
        List<SObject> shareRecords = new List<SObject>();
        Map<String, Schema.SObjectType> tokens = Schema.getGlobalDescribe();
        if(tokens.containsKey(shareTableName)){
            for(Id recId: record_UserList.keyset()){
                if(record_UserList.get(recId) <> null){
                    SObject share = tokens.get(shareTableName).newSObject();
                    if(objectName == 'Asset'){
                        share.put('AssetId',recId);
                        share.put('AssetAccessLevel',recordAccessLevel);
                    }else if(objectName == 'Case'){
                        share.put('CaseId',recId);
                        share.put('CaseAccessLevel',recordAccessLevel);
                    }else if(objectName == 'Account'){
                        share.put('AccountId',recId);
                        share.put('AccountAccessLevel',recordAccessLevel);
                    }else if(objectName == 'Opportunity'){
                        share.put('OpportunityId',recId);
                        share.put('OpportunityAccessLevel',recordAccessLevel);
                    }else if(objectName == 'Lead'){
                        share.put('LeadId',recId);
                        share.put('LeadAccessLevel',recordAccessLevel);
                    }else if(objectName == 'Contact'){
                        share.put('ContactId',recId);
                        share.put('ContactAccessLevel',recordAccessLevel);
                    }else if(objectName == 'Campaign'){
                        share.put('CampaignId',recId);
                        share.put('CampaignAccessLevel',recordAccessLevel);
                    }else if(objectName == 'Forecast'){
                        share.put('ForecastId',recId);
                        share.put('ForecastAccessLevel',recordAccessLevel);
                    }else if(objectName == 'Macro'){
                        share.put('MacroId',recId);
                        share.put('MacroAccessLevel',recordAccessLevel);
                    }else if(objectName == 'Order'){
                        share.put('OrderId',recId);
                        share.put('OrderAccessLevel',recordAccessLevel);
                    }else{
                        share.put('ParentId', recId);
                        share.put('AccessLevel', recordAccessLevel);
                    }
                    share.put('UserorGroupId', record_UserList.get(recId));
                    share.put('RowCause', 'Manual');
                    shareRecords.add(share);
                }                
            }
            try{
                Database.SaveResult[] shareInsertResult =  Database.insert(shareRecords,false);
                for(Database.SaveResult saveResult: shareInsertResult){
                    if(saveResult.isSuccess()){
                        system.debug('@@@ SaveResult ### - '+saveResult);
                    }else{
                        for(Database.Error err: saveResult.getErrors()) {                  
                            System.debug('@@@ ErrorResult ### - '+err.getStatusCode() + ': ' + err.getMessage());
                        }
                    }
                }
            }catch(Exception e){
                /*SI_Exception_Class.InsertException('NA','Utility_Sharing','NA', 'provideAccess',e);
                System.debug('@@@ Exception ### - '+e.getMessage());*/
            }
        }
    }
    
    /***************************************************************************************************
    Method Name:  removeAccess
    Method Type: Utility_Sharing Method 
    Version     : 1.0 
    Created Date: 08 August 2016
    Function    : This method removes share records based on the Map containing set of users and respective records passed as parameters
    Input Parameters: objectName String, shareTableName String, recordAccessLevel String, Record and Users Map
    Output Parameters:  None
    Description:   Used as a generic method to remove share Records for any type of sObject
    Used in: Unsharing of records to Users
    Number of Queries Within this Method: 0
    Number of Queries in Loop: 0
    Number of Queries from Called methods:  0
    Modification Log :
    * Developer        Date                   Description
    * ----------------------------------------------------------------------------                 
    * JRK              08/08/2016              Created
    ****************************************************************************************************/     

    public static void removeAccess(String objectName, String shareTableName, String recordAccessLevel, Map<id,Set<id>> record_UserList){
        List<SObject> shareRecords = new List<SObject>();
        
        //gets the map of objectnames to objectAPINames.
        Map<String, Schema.SObjectType> tokens = Schema.getGlobalDescribe();
        
        //check to prevent unnecessary processing.
        if(tokens.containsKey(shareTableName)){
            
            //loop through the list of records from which sharing has to be removed.
            for(Id recId: record_UserList.keyset()){
                if(record_UserList.get(recId) <> null){
                    
                    //loop through the list of users under the current record
                    for(Id userId: record_UserList.get(recId)){
                        SObject share = tokens.get(shareTableName).newSObject();
                        if(objectName == 'Asset'){
                            share.put('AssetId',recId);
                            share.put('AssetAccessLevel',recordAccessLevel);
                        }else if(objectName == 'Case'){
                            share.put('CaseId',recId);
                            share.put('CaseAccessLevel',recordAccessLevel);
                        }else if(objectName == 'Account'){
                            share.put('AccountId',recId);
                            share.put('AccountAccessLevel',recordAccessLevel);
                        }else if(objectName == 'Opportunity'){
                            share.put('OpportunityId',recId);
                            share.put('OpportunityAccessLevel',recordAccessLevel);
                        }else if(objectName == 'Lead'){
                            share.put('LeadId',recId);
                            share.put('LeadAccessLevel',recordAccessLevel);
                        }else if(objectName == 'Contact'){
                            share.put('ContactId',recId);
                            share.put('ContactAccessLevel',recordAccessLevel);
                        }else if(objectName == 'Campaign'){
                            share.put('CampaignId',recId);
                            share.put('CampaignAccessLevel',recordAccessLevel);
                        }else if(objectName == 'Forecast'){
                            share.put('ForecastId',recId);
                            share.put('ForecastAccessLevel',recordAccessLevel);
                        }else if(objectName == 'Macro'){
                            share.put('MacroId',recId);
                            share.put('MacroAccessLevel',recordAccessLevel);
                        }else if(objectName == 'Order'){
                            share.put('OrderId',recId);
                            share.put('OrderAccessLevel',recordAccessLevel);
                        }else{
                            share.put('ParentId', recId);
                            share.put('AccessLevel', recordAccessLevel);
                        }
                        share.put('UserorGroupId',userId);
                        share.put('RowCause', 'Manual');
                        shareRecords.add(share);
                    }
                }                
            }
            try{
                Database.deleteResult[] shareDeleteResult =  Database.delete(shareRecords,false);
                for(Database.deleteResult deleteResult: shareDeleteResult){
                    if(deleteResult.isSuccess()){
                        system.debug('@@@ deleteResult ### - '+deleteResult);
                    }else{
                        for(Database.Error err: deleteResult.getErrors()) {                  
                            System.debug('@@@ ErrorResult ### - '+err.getStatusCode() + ': ' + err.getMessage());
                        }
                    }
                }
            }catch(Exception e){
                /*SI_Exception_Class.InsertException('NA','Utility_Sharing','NA', 'provideAccess',e);
                System.debug('@@@ Exception ### - '+e.getMessage());*/
            }
        }
    }
    
    /***************************************************************************************************
    Method Name:  removeAccess
    Method Type: Utility_Sharing Method 
    Version     : 1.0 
    Created Date: 08 August 2016
    Function    : This method removes share records based on the Map containing users and respective records passed as parameters
    Input Parameters: objectName String, shareTableName String, recordAccessLevel String, Record and Users Map
    Output Parameters:  None
    Description:   Used as a generic method to remove share Records for any type of sObject
    Used in: Unsharing of records to Users
    Number of Queries Within this Method: 0
    Number of Queries in Loop: 0
    Number of Queries from Called methods:  0
    Modification Log :
    * Developer        Date                   Description
    * ----------------------------------------------------------------------------                 
    * JRK              08/08/2016              Created
    ****************************************************************************************************/     

    public static void removeAccess(String objectName, String shareTableName, String recordAccessLevel, Map<id,id> record_UserList){
        List<SObject> shareRecords = new List<SObject>();
        Map<String, Schema.SObjectType> tokens = Schema.getGlobalDescribe();
        if(tokens.containsKey(shareTableName)){
            for(Id recId: record_UserList.keyset()){
                if(record_UserList.get(recId) <> null){
                    SObject share = tokens.get(shareTableName).newSObject();
                    if(objectName == 'Asset'){
                        share.put('AssetId',recId);
                        share.put('AssetAccessLevel',recordAccessLevel);
                    }else if(objectName == 'Case'){
                        share.put('CaseId',recId);
                        share.put('CaseAccessLevel',recordAccessLevel);
                    }else if(objectName == 'Account'){
                        share.put('AccountId',recId);
                        share.put('AccountAccessLevel',recordAccessLevel);
                    }else if(objectName == 'Opportunity'){
                        share.put('OpportunityId',recId);
                        share.put('OpportunityAccessLevel',recordAccessLevel);
                    }else if(objectName == 'Lead'){
                        share.put('LeadId',recId);
                        share.put('LeadAccessLevel',recordAccessLevel);
                    }else if(objectName == 'Contact'){
                        share.put('ContactId',recId);
                        share.put('ContactAccessLevel',recordAccessLevel);
                    }else if(objectName == 'Campaign'){
                        share.put('CampaignId',recId);
                        share.put('CampaignAccessLevel',recordAccessLevel);
                    }else if(objectName == 'Forecast'){
                        share.put('ForecastId',recId);
                        share.put('ForecastAccessLevel',recordAccessLevel);
                    }else if(objectName == 'Macro'){
                        share.put('MacroId',recId);
                        share.put('MacroAccessLevel',recordAccessLevel);
                    }else if(objectName == 'Order'){
                        share.put('OrderId',recId);
                        share.put('OrderAccessLevel',recordAccessLevel);
                    }else{
                        share.put('ParentId', recId);
                        share.put('AccessLevel', recordAccessLevel);
                    }
                    share.put('UserorGroupId', record_UserList.get(recId));
                    share.put('RowCause', 'Manual');
                    shareRecords.add(share);
                }                
            }
            try{
                Database.deleteResult[] shareDeleteResult =  Database.delete(shareRecords,false);
                for(Database.deleteResult deleteResult: shareDeleteResult){
                    if(deleteResult.isSuccess()){
                        system.debug('@@@ deleteResult ### - '+deleteResult);
                    }else{
                        for(Database.Error err: deleteResult.getErrors()) {                  
                            System.debug('@@@ ErrorResult ### - '+err.getStatusCode() + ': ' + err.getMessage());
                        }
                    }
                }
            }catch(Exception e){
                /*SI_Exception_Class.InsertException('NA','Utility_Sharing','NA', 'provideAccess',e);
                System.debug('@@@ Exception ### - '+e.getMessage());*/
            }
        }
    }
}