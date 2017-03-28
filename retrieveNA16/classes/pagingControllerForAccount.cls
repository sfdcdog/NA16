public class pagingControllerForAccount
{
    public List<Account> AllSearchAccounts
    {
        get
        {
            if(con != null)
                return (List<Account>)con.getRecords();
            else
                return null ;
        }
        set;}
    
    public Account acc {get; set;}
    
    //Controller
    public pagingControllerForAccount()
    {
        AllSearchAccounts = new List<Account>() ;
        acc = new Account() ;
    }
    
     public PageReference Search()
    {   
        if(acc.Name != null)
        {
            con = new ApexPages.StandardSetController(Database.getQueryLocator([select Id , name  from Account where name = :acc.Name]));
 
            // sets the number of records in each page set
            con.setPageSize(5);
        }
        else
        {
            con = new ApexPages.StandardSetController(Database.getQueryLocator([select Id , name  from Account]));
            con.setPageSize(5);
        }
        return null ;
    }
    
        
        
    //Instantiate the StandardSetController
    public ApexPages.StandardSetController con{get; set;}
    
    //Boolean to check if there are more records after the present displaying records
    public Boolean hasNext
    {
        get
        {
            return con.getHasNext();
        }
        set;
    }
 
    //Boolean to check if there are more records before the present displaying records
    public Boolean hasPrevious
    {
        get
        {
            return con.getHasPrevious();
        }
        set;
    }
 
    //Page number of the current displaying records
    public Integer pageNumber
    {
        get
        {
            return con.getPageNumber();
        }
        set;
    }

    //Returns the previous page of records
    public void previous()
    {
        con.previous();
    }
 
    //Returns the next page of records
    public void next()
    {
        con.next();
    }
}