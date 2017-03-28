public class Example_ToolingApi_CreateTriggers {

    public static void createTriggers() {
        //CONSTRUCT THE TRIGGER BODY
        String objName = 'Case';
        String vernumber = '37';
        String ver = 'v'+vernumber+'.0';
        String json = '{"Name": "Tooling'+objName+'Trigger","TableEnumOrId": "'+objName+'","Body": " trigger Tooling'+objName+'Trigger on '+objName+' (before insert) {/*Trigger creation using Tooling API*/}"}';
        Httprequest req = new Httprequest();
        
        //Call the Tooling API
        req.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/'+ver+'/tooling/sobjects/ApexTrigger'); 
        req.setMethod('POST'); 
        req.setHeader('Content-Type', 'application/json'); 
        req.setHeader('Authorization', 'OAuth ' + UserInfo.getSessionId()); 
        req.setBody(json); 

        //Creating a HTTP Request. 
        Http httpReq = new Http(); 
        HttpResponse res = httpReq.send(req); 
        System.debug(res.getBody());

    }

}