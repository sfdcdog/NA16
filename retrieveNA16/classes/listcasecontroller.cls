public class listcasecontroller {
Opportunity urlrecord;
public List<Case> caselst{get;set;}   

public listcasecontroller(Apexpages.standardcontroller opps)
{
   urlrecord =(opportunity) opps.getrecord();

   retrievecase();

}

public void retrievecase()
{

 caselst = [select id, casenumber, ownerid from case where Accountid =: urlrecord.Accountid or Product__c =: urlrecord.product__r.productcode];
 //(select productCode from OpportunityLineItem where id=: urlrecordid) 

}
}