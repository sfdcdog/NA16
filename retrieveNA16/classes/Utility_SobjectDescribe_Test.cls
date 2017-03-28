@isTest

public class Utility_SobjectDescribe_Test{

    public static testmethod void getRecords(){
        Account acc = TestUtilities.getAccountRecord();
        insert acc;

        Contact con = TestUtilities.getContact();
        insert con;
    }

    public static testmethod void getStringData_posTest(){
        getRecords();
        List<String> objects = new List<String>{'Account', 'Contact'};
        List<Integer> values = new List<Integer>{1,2,3,4};
        //Integer i = 0;
        for(Integer i: values){
            Utility_SobjectDescribe.getStringData(objects,i);
        }  
    }

    public static testmethod void getStringData_integerValueNegTest(){
        getRecords();
        List<String> objects = new List<String>{'Account', 'Contact'};
        List<Integer> values = new List<Integer>{8,9};
        //Integer i = 0;
        for(Integer i: values){
            Utility_SobjectDescribe.getStringData(objects,i);
        }  
    }

    public static testmethod void getStringData_objectValueNegTest(){
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
    }

}