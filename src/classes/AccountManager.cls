@RestResource(urlMapping='/Accounts/*/contacts')
/*
*TrailHead Class	
*Module: Apex Integration Services
*Unit: Apex Web Services
*Status: Completed
*/
global class AccountManager {
    @HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
        SYSTEM.DEBUG('##############'+request);
        String AccId = request.requestURI.substringBetween('/Accounts/' , '/contacts');
        //SYSTEM.DEBUG('@@@@@@@@@@@@@@@@'+AccId);
        Account result =  [SELECT Id, Name, (Select Id, Name from Contacts) FROM Account WHERE Id = :AccId];
        system.debug('$$$$$$$$$$$$$$$$$'+result);
        return result;
    }
}
/*@RestResource(urlMapping='/Accounts/001j000000roetH/contacts')
global class AccountManager {
    
    @HttpGet
    global static Map<Map<Id,String>,Map<List<Id>,List<String>>> getAccount() {
        RestRequest request = RestContext.request;
        List<Account> result = [SELECT Name, Id, (SELECT Id, Name, accountid,account.name from Contacts)
                        FROM Account
                        WHERE Id = '001j000000roetH'];
        
        return result;
    }
    
}*/

 /*@HttpGet
    global static Map<Map<Id,String>,Map<List<Id>,List<String>>> getAccount() {
    	Map<Map<Id, String>, Map<List<Id>, List<String>>> resultMap = new Map<Map<Id,String>,Map<List<Id>,List<String>>>(); 
        Map<Id, String> accMap = new Map<Id, String>();
        Map<List<Id>, List<String>> conMap = new Map<List<Id>, List<String>>();
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        /*String accId = request.requestURI.substring(
          request.requestURI.lastIndexOf('/')+1);
        List<Account> result = [SELECT Name, Id, (SELECT Id, Name, accountid,account.name from Contacts)
                        FROM Account
                        WHERE Id = '001j000000roetH'];
        for(Account acc: result){
        	List<Id> conIdList = new List<Id>();
        	List<String> conNameList =  new List<String>();
        	for(Contact con: acc.Contacts){
        		if(conMap.containsKey(con.Id)){
        			resultMap.put(accMap.put(acc.Id, acc.Name), conMap.put(conIdList.add(con.Id), conNameList.add(con.Name)));
        		}else{
        		
        		}
        	}
        }
        return result;
    }
Map<Id, List<Id>> userRoleToUsers = new Map<Id, List<Id>>();

for(User newUser : [SELECT UserRoleId FROM User LIMIT 50000]) {
	if(userRoleToUsers.containsKey(newUser.UserRoleId)) {
		List<Id> usersId = userRoleToUsers.get(newUser.UserRoleId);
		usersId.add(newUser.Id);
		userRoleToUsers.put(newUser.UserRoleId, usersId);
	} else {
		userRoleToUsers.put(newUser.UserRoleId, new List<Id> { newUser.Id });
	}
}*/