/***************************************************************************************************
Class Name: timeUtils_Test
Class Type: Test Class 
Version     : 1.0 
Created Date: 30 Jan 2017
Function    : This class contains test coverage for timeUtils class
Modification Log :
* Developer     Date              Description
* ----------------------------------------------------------------------------                 
* JRK           01/30/2017        Created
****************************************************************************************************/   
@isTest
public class timeUtils_Test{
    //Instance variables that are commonly used in multiple test methods
    static List<User> ListOfUser = new List<User> ();
    
    /***************************************************************************************************
    Method Name:  getRecords
    Method Type: Void Method
    Version     : 1.0 
    Created Date: 30 Jan 2017
    Description:  Common Test data used in multiple test methods 
    Modification Log :
    * Developer     Date              Description
    * ----------------------------------------------------------------------------                 
    * JRK           01/30/2017        Created
    ****************************************************************************************************/
    static void getRecords(){
        // Query Profiles
        Map<String,ID> profiles = new Map<String,ID>();
        List<Profile> ProfileList = [select id, name from Profile where name = 'System Administrator'];
        for(Profile prf : ProfileList){
            profiles.put(prf.name, prf.id);
        }
        // Create Users
        ListOfUser = TestUtilities.getListOfUser(1);
        for(User Usr : ListOfUser){
            Usr.ProfileID =  profiles.get('System Administrator');
        }
        insert ListOfUser;
        
        System.assertEquals(ListOfUser.get(0).profileid, profiles.get('System Administrator'));     
    }
    /***************************************************************************************************
    Method Name:  diffMinutes_PositiveTest
    Method Type: Test Method
    Version     : 1.0 
    Created Date: 30 Jan 2017
    Description:  Testing diffMinutes_PositiveTest(Datetime dt1, Datetime dt2) utility method.
    Scenario Type:  Positive
    Modification Log :
    * Developer     Date              Description
    * ----------------------------------------------------------------------------                 
    *  JRK           01/30/2017        Created
    ****************************************************************************************************/
    static testmethod void diffMinutes_PositiveTest(){
        getRecords();
        System.runAs(ListOfUser.get(0)){
            Test.startTest();
            timeUtils.diffMinutes(System.now(),System.now()+2);
            timeUtils.addMinutes(System.now(),2);
            //List<Schema.FieldSetMember> ListOfFieldSetMember = Core_Utility.readFieldSet(fieldSetName,ObjectApiName); 
            //System.assert(ListOfFieldSetMember != null,'readFieldSet utility method failed to fetch the fieldset'); 
            Test.stopTest();
        }
    }
}