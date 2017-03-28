public class Example_JqueryTableController{
    
    public List<Account> accList{get;set;}
    
    public Example_JqueryTableController(ApexPages.StandardController controller){
        accList = [select Id,Name from Account Limit 100];
        system.debug('@@@'+accList);
    }    
}