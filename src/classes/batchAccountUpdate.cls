global class batchAccountUpdate implements Database.Batchable<sObject>
{
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        String query = 'SELECT Id,Name,phone FROM Account where phone!=null';    //can be a string when using database.querylocator or normal SOQL when the type is List   
        return Database.getQueryLocator(query);//when we want to retrieve more records.
    }
   
    global void execute(Database.BatchableContext BC, List<Account> scope)//scope is a variable taken by execute method
    {
         for(Account a : scope)
         {
             a.Phone= '(650) 867-3450';            
         }
         update scope;
    }   
    global void finish(Database.BatchableContext BC)
    {
    }
}