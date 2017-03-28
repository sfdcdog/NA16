@isTest

public class Utility_Sharing_Test{
    /*****************************************START OF Test Data Set up*********************************************************/   
    
    static User sysAdmin = [Select id, Profileid from User where profile.Name like '%System Administrator%'];
    //static object datatype variables
    public static Account acc;
    public static Contact con;
    public static Asset asset;
    public static Case cs;
    //public static List<Opportunity> oppty;
    
    //create object test data. insert all related objects
    public static testmethod void getObjRecords(){ 
	    System.runAs(sysAdmin){
	        //inserting account record
	        acc = TestUtilities.getAccountRecord();
	        insert acc;
	        //inserting contact record
	        con = TestUtilities.getContact();
	        //insert con;
	        //inserting asset record
	        asset = TestUtilities.getAssetRecord();
	        asset.accountid = acc.id;
	        insert asset;
	        //inserting case record
	        cs = TestUtilities.getCase();
	        insert cs;
	        /*//inserting opportunity record
	        oppty = TestUtilities.getListOfOpportunities(1);
	        insert oppty;*/
	        //inserting lead record
	        
	    }     
    }
    
    
    //static user variable
    public static User usr;
    //returns a user record
    public static testmethod void getUserRecords(){
        System.runAs(sysAdmin){
	        usr = TestUtilities.getUser();
	        insert usr;
        }

    }
    //static list variable for Users 
    public static List<User> usrList;
    //returns a list of User Records
    public static testmethod void getUserListRecords(){
        System.runAs(sysAdmin){
	        usrList = TestUtilities.getListOfUser(2);
	        insert usrList;
        }     
    }
    
    //static variables
    public static List<String> objectNames;
    public static List<String> shareTableNames;
    public static String recordAccessLevel;
    public static Map<Id,Set<Id>> record_UserList;
    public static Map<Id,Id> record_User;
    public static Map<String, String> objToshrTblName;
    public static Set<Id> userIdSet;
    
    //setting the parameters for Utility Sharing class methods with sharing to a UserSet
    public static testmethod void genericTestData_UserSet(){
        System.runAs(sysAdmin){
	        getObjRecords();
	        getUserListRecords();
	        objectNames = new List<String>{'Account',/*'Contact',*/ 'Asset', 'Case' /*, 'Opportunity'*/};
	        shareTableNames = new List<String>{'AccountShare',/*'ContactShare', */'AssetShare', 'CaseShare' /*, 'OpportunityShare'*/};
	        recordAccessLevel = 'Read';
	        record_UserList = new Map<Id,Set<Id>>();
	        objToshrTblName = new Map<String, String>();
	       
	        userIdSet = new Set<Id>();
	        for(User user: usrList){
	            userIdSet.add(user.Id);
	        }
	
	        for(String objName: objectNames){
	            for(String shrTblName: shareTableNames){
	                if(objName.substring(0,3) == shrTblName.substring(0,3)){
	                    objToshrTblName.put(objName,shrTblName);    
	                }               
	            }
	        }
	
	        record_UserList.put(acc.id,userIdSet);
	        record_UserList.put(con.id,userIdSet);
        }
    }
    
    //setting the parameters for Utility Sharing class methods with sharing to User
    public static testmethod void genericTestData_User(){
        System.runAs(sysAdmin){
	        getObjRecords();
	        getUserRecords();
	        objectNames = new List<String>{'Account',/*'Contact',*/ 'Asset', 'Case' /*, 'Opportunity'*/};
	        shareTableNames = new List<String>{'AccountShare',/*'ContactShare',*/  'AssetShare', 'CaseShare' /*, 'OpportunityShare'*/};
	        recordAccessLevel = 'Read';
	        record_User = new Map<Id,Id>();
	        objToshrTblName = new Map<String, String>();
	
	        for(String objName: objectNames){
	            for(String shrTblName: shareTableNames){
	                if(objName.substring(0,3) == shrTblName.substring(0,3)){
	                    objToshrTblName.put(objName,shrTblName);    
	                }               
	            }
	        }
	
	        record_User.put(acc.id,usr.id);
	        record_User.put(con.id,usr.id);
        }
    }
    
    /*****************************************END OF Test Data Set up*********************************************************/
    
    /******************************************START OF Method calling********************************************************/
    //Positive Test for UserSet parameter Access Methods
    public static testmethod void provideAccess_userSet_posTest(){
        System.runAs(sysAdmin){
	        genericTestData_UserSet();
	        for(String objectName: objectNames){
	            Utility_SHaring.provideAccess(objectName, objToshrTblName.get(objectName), recordAccessLevel, record_UserList);
	        }
        }
 
    }
    //Negative Test for UserSet parameter Access Methods 
    public static testmethod void provideAccess_userSet_negTest(){
        System.runAs(sysAdmin){
	        getObjRecords();
	        getUserListRecords();
	        String objectName = 'silly__c';
	        String shareTableName = 'silly__share';
	        String recordAccessLevel_Neg = 'Read';
	        Map<Id,Set<Id>> record_UserList_Neg = new Map<Id,Set<Id>>();
	
	        Set<Id> userIdSet_Neg = new Set<Id>();
	
	        for(User usr_Neg: usrList){
	            userIdSet_Neg.add(usr_Neg.Id);
	        }
	
	        record_UserList_Neg.put(acc.id,userIdSet_Neg);
	        record_UserList_Neg.put(con.id,userIdSet_Neg);
	        record_UserList_Neg.put(asset.id,userIdSet_Neg);
	        record_UserList_Neg.put(cs.id,userIdSet_Neg);
	        //record_UserList_Neg.put(oppty.id,userIdSet_Neg);
	
	        Utility_SHaring.provideAccess(objectName, shareTableName, recordAccessLevel_Neg, record_UserList_Neg);
        }
 
    }
    
    //Positive Test for UserSet parameter Remove Methods
    public static testmethod void revokeAccess_userSet_posTest(){
        System.runAs(sysAdmin){
	        genericTestData_UserSet();
	        for(String objectName: objectNames){
	            Utility_SHaring.removeAccess(objectName, objToshrTblName.get(objectName), recordAccessLevel, record_UserList);
	        }
        }
 
    }
    //Negative Test for UserSet parameter Remove Methods 
    public static testmethod void revokeAccess_userSet_negTest(){
        System.runAs(sysAdmin){
	        getObjRecords();
	        getUserListRecords();
	        String objectName = 'silly__c';
	        String shareTableName = 'silly__share';
	        String recordAccessLevel_Neg = 'Read';
	        Map<Id,Set<Id>> record_UserList_Neg = new Map<Id,Set<Id>>();
	
	        Set<Id> userIdSet_Neg = new Set<Id>();
	
	        for(User usr_Neg: usrList){
	            userIdSet_Neg.add(usr_Neg.Id);
	        }
	
	        record_UserList_Neg.put(acc.id,userIdSet_Neg);
	        record_UserList_Neg.put(con.id,userIdSet_Neg);
	        record_UserList_Neg.put(asset.id,userIdSet_Neg);
	        record_UserList_Neg.put(cs.id,userIdSet_Neg);
	        //record_UserList_Neg.put(oppty.id,userIdSet_Neg);
	
	        Utility_SHaring.removeAccess(objectName, shareTableName, recordAccessLevel_Neg, record_UserList_Neg);
        }
    }
    
    //Positive Test for User parameter Access Methods
    public static testmethod void provideAccess_user_posTest(){
        System.runAs(sysAdmin){
	        genericTestData_User();
	        for(String objectName: objectNames){
	            Utility_SHaring.provideAccess(objectName, objToshrTblName.get(objectName), recordAccessLevel, record_User);
	        }
        }
 
    }
    
    //Negative Test for User parameter Access Methods 
    public static testmethod void provideAccess_user_negTest(){
        System.runAs(sysAdmin){
	        getObjRecords();
	        getUserRecords();
	        String objectName = 'silly__c';
	        String shareTableName = 'silly__share';
	        String recordAccessLevel_Neg = 'Read';
	        Map<Id,Id> record_User_Neg = new Map<Id,Id>();
	
	        record_User_Neg.put(acc.id,usr.id);
	        record_User_Neg.put(con.id,usr.id);
	        record_User_Neg.put(asset.id,usr.id);
	        record_User_Neg.put(cs.id,usr.id);
	        //record_User_Neg.put(oppty.id,usr);
	
	        Utility_SHaring.provideAccess(objectName, shareTableName, recordAccessLevel_Neg, record_User_Neg);
        }
 
    }
    
    
    //Positive Test for User parameter Remove Methods
    public static testmethod void revokeAccess_user_posTest(){
        System.runAs(sysAdmin){
	        genericTestData_User();
	        for(String objectName: objectNames){
	            Utility_SHaring.removeAccess(objectName, objToshrTblName.get(objectName), recordAccessLevel, record_User);
	        }
        }
 
    }
    
    //Negative Test for User parameter Access Methods 
    public static testmethod void revokeAccess_user_negTest(){
        System.runAs(sysAdmin){
	        getObjRecords();
	        getUserRecords();
	        String objectName = 'silly__c';
	        String shareTableName = 'silly__share';
	        String recordAccessLevel_Neg = 'Read';
	        Map<Id,Id> record_User_Neg = new Map<Id,Id>();
	
	        record_User_Neg.put(acc.id,usr.id);
	        record_User_Neg.put(con.id,usr.id);
	        record_User_Neg.put(asset.id,usr.id);
	        record_User_Neg.put(cs.id,usr.id);
	        //record_User_Neg.put(oppty.id,usr);
	
	        Utility_SHaring.removeAccess(objectName, shareTableName, recordAccessLevel_Neg, record_User_Neg);
        }  
    }
    
     
     /******************************************END OF Method calling********************************************************/
     
     
     
     
    /*public static testmethod void provideAccess_objectValueNegTest(){
        getRecords();
        List<String> objects = new List<String>{'Tes__c', 'silly__c'};
        List<Integer> values = new List<Integer>{1,5};
        //Integer i = 0;
        for(Integer i: values){
            Utility_SobjectDescribe.getStringData(objects,i);
        }  
    }
    
    public static testmethod void getBooleanData_posTest(){
        getRecords();
        List<String> objects = new List<String>{'Account', 'Contact'};
        List<Integer> values = new List<Integer>{1,2,3,4,5,6,7,8,9,10,11,12};
        //Integer i = 0;
        for(Integer i: values){
            Utility_SobjectDescribe.getBooleanData(objects,i);
        }  
    }

    public static testmethod void getBooleanData_integerValueNegTest(){
        getRecords();
        List<String> objects = new List<String>{'Account', 'Contact'};
        List<Integer> values = new List<Integer>{13,15};
        //Integer i = 0;
        for(Integer i: values){
            Utility_SobjectDescribe.getBooleanData(objects,i);
        }  
    }

    public static testmethod void getBooleanData_objectValueNegTest(){
        getRecords();
        List<String> objects = new List<String>{'TES__c', 'silly__c'};
        List<Integer> values = new List<Integer>{1,15};
        //Integer i = 0;
        for(Integer i: values){
            Utility_SobjectDescribe.getBooleanData(objects,i);
        }  
    }*/

}