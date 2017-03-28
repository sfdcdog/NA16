public class customSiteLoginController {
    //public user_details__c ud{get;set;}
    public String uname{get;set;}
    public String pw{get;set;}
    public customSiteLoginController(ApexPages.StandardController controller) {
        //ud=(user_details__c)controller.getRecord();
    }
    public PageReference validateLogin(){
        List<user_details__c > ud =[select id,name from user_details__c  where name=:uname and password__c=:pw];
        if(ud.size()>0)
            return new PageReference('/CustomerDisclaimer');
        else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Invalid User Name or Password'));
            return null;
        }
    }
}