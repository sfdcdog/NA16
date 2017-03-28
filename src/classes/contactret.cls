public class contactret {
 
   
    public PageReference redirect() {
 
        List<Contact> lstContacts=[select id,created_date__c from Contact];
        for(Contact c : lstContacts){
            if(c.created_date__c<System.today()-30){
               c.created_Date__c=System.today();
            }
        }
        update lstContacts;
        return new PageReference('/apex/caselistview');
}
public PageReference redirectAutomate(){
    boolean flag=true;
    List<Contact> lstContacts=[select id,created_date__c from Contact];
    for(Contact c : lstContacts){
        if(c.created_date__c<System.today()-30){
            flag=false;
        }
    }
    if(flag){
        return new PageReference('/apex/caselistview');
    }
    else
        return null;
}
}