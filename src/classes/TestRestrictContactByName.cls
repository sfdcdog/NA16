@isTest
/*
*TrailHead Class	
*Module: Apex Testing
*Unit: Testing Apex Triggers
*Status: Completed
*/
public class TestRestrictContactByName {
    
    static Contact con1 = TestUtilities.getContact();
    static Contact con2 = new Contact(
    	LastName = 'INVALIDNAME', 
    	Email = 'Contact1Dell@gmail.com'
	);	
    
    static testMethod void insertValidContact_Test(){
    	Test.startTest();
    	Database.SaveResult saveResult = Database.insert(con1, false);
    	System.assert(saveResult.getErrors().size() == 0);
    	Test.stopTest();
    }
    
    static testMethod void insertInvalidContact_Test(){
    	Test.startTest();
    	Database.SaveResult saveResult = Database.insert(con2, false);
    	System.assert(saveResult.getErrors().size() > 0);
    	Test.stopTest();
    }
    
    static testMethod void updateInvalidContact_Test(){
    	Test.startTest();
    	con2.Email = 'Test.Con@gmail.com';
    	Database.SaveResult saveResult = Database.update(con2, false);
    	System.assert(saveResult.getErrors().size() > 0);
    	Test.stopTest();
    }
    
    
}