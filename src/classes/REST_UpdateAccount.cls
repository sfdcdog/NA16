@RestResource(urlMapping='/Accounts/*/Update')

global class REST_UpdateAccount {
    @HttpPut
    global static String updateAccount() {
        List<String> accList = new List<String>();
        List<Account> updateAccList = new List<Account>();
        RestRequest request = RestContext.request;
        SYSTEM.DEBUG('##############'+request);
        String AccId = request.requestURI.substringBetween('/Accounts/' , '/Update');
        accList.add(AccId);
        SYSTEM.DEBUG('@@@@@@@@@@@@@@@@'+AccId);
        List<Account> accToUpdate =  [SELECT Id, Name, Site, Rating  FROM Account WHERE Id IN: accList];
        String result = '';
        try{
            for(Account acc: accToUpdate){
                if(acc.Site == null){
                    acc.Site = 'Ellora Caves';
                    result = string.valueOf(acc.Site);
                }
                if(acc.Site <> null){
                    acc.Rating = 'Hot';
                    result += String.valueOf(acc.Rating);
                }
                updateAccList.add(acc);
            }
            update updateAccList; 
        }catch(Exception e){
            system.debug('Error Message:'+e.getMessage());
        }
        return result;
    }
}