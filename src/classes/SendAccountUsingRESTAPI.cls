public class SendAccountUsingRESTAPI {
    private final String clientId = '3MVG98SW_UPr.JFiPWQqiSzi22QRBlaOpT9JFF_PzQ0QR9F7H3nj9t4oPskav_88g47Uu2NLKMwPjAb2_q2hK';
    private final String clientSecret = '6578118162871491311';
    private final String username = 'jesseroshanx.kanaparthi@intel.com';
    private final String password = 'red0525#';
    
    public class deserializeResponse{
        public String id;
        public String access_token;
    }

    public String ReturnAccessToken (SendAccountUsingRESTAPI acount){
        String reqbody = 'grant_type=password&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password;
        system.debug('!!!!!'+reqbody);
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setBody(reqbody);
        req.setMethod('POST');
        req.setEndpoint('https://na31.salesforce.com');//https://login.salesforce.com/services/oauth2/token
        HttpResponse res = h.send(req);
        system.debug('%%%%%'+res);
        system.debug('%%%%%1'+res.getbody());// ; 
          system.debug('%%%%%1'+JSON.deserialize(res.getbody(),deserializeResponse.class));    
        deserializeResponse resp1 = (deserializeResponse)JSON.deserialize(res.getbody(),deserializeResponse.class);
        return resp1.access_token;
    }

    @future(callout=true)
    public static void callcreateAcc (String accName, String accId) {
        SendAccountUsingRESTAPI acount1 = new SendAccountUsingRESTAPI();
        String accessToken = acount1.ReturnAccessToken (acount1);
        system.debug('@@@@@'+accessToken);
        if(accessToken != null){
            String endPoint = 'https://na31.salesforce.com/services/data/v32.0/sobjects/Account/';
            String jsonstr = '{"Name" : "' + accName + '"}';

            Http h2 = new Http();
            HttpRequest req1 = new HttpRequest();
            req1.setHeader('Authorization','Bearer ' + accessToken);
            req1.setHeader('Content-Type','application/json');
            req1.setHeader('accept','application/json');
            req1.setBody(jsonstr);
            req1.setMethod('POST');
            req1.setEndpoint(endPoint);
            HttpResponse res1 = h2.send(req1);
            
            system.debug('######'+res1);
            deserializeResponse resp2 = (deserializeResponse)JSON.deserialize(res1.getbody(),deserializeResponse.class);
            Account a = [SELECT Id FROM Account WHERE Id = :accId];
            a.Siebel_Id__c = resp2.id;
            update a;
        }
    }
}