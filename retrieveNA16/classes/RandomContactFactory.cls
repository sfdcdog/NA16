/*
*TrailHead Class	
*Module: Apex Testing
*Unit: Creating Test Data for Apex Tests
*Status: Completed
*/
public class RandomContactFactory {
    
    public static List<Contact> generateRandomContacts(Integer numofContacts, String lstName){
    	List<Contact> conList = new List<Contact>();
    	Integer i;
    	for(i = 1; i<=numofContacts; i++){
    		Contact con = new Contact();
    		con.firstName = 'Test'+i;
    		con.lastName = lstName;
    		con.Email = 'Test.con@gmail.com';
    		conList.add(con);
    	}
    	
    	return conList;
    	
    }
}