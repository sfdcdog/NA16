public class pagingForAccount
{
    public List<Account> AllSearchAccounts
    {
        get
        {
            if(acclist!= null)
                return (List<Account>) acclist.getRecords();
            else
                return null ;
        }
        set;}
    
    public Account acc {get; set;}
    public Boolean showaccounts{get;set;}
   //Instantiate the StandardSetController
   public ApexPages.StandardSetController acclist{get; set;}
    

    public pagingForAccount()
    {
        AllSearchAccounts = new List<Account>() ;
        acc = new Account() ;
        showaccounts=false;
    }
    
     public PageReference Search()
    {   
           
  String accName = '%'+ acc.Name +'%';
        if(accName != null)
        {
            acclist = new ApexPages.StandardSetController(Database.getQueryLocator([select Id , Name  from Account where name like: accName]));
 
               showaccounts = true;

            // sets the number of records in each page set
            acclist.setPageSize(20);
        }
               else
        {
            acclist = null;
        }
       
        return null ;
   
    }
        
        
    
    
    //Boolean to check if there are more records after the present displaying records
    public Boolean hasNext
    {
        get
        {
            return acclist.getHasNext();
        }
        set;
    }
 
    //Boolean to check if there are more records before the present displaying records
    public Boolean hasPrevious
    {
        get
        {
            return acclist.getHasPrevious();
        }
        set;
    }
 
    //Page number of the current displaying records
    public Integer pageNumber
    {
        get
        {
            return acclist.getPageNumber();
        }
        set;
    }

    //Returns the previous page of records
    public void previous()
    {
               acclist.previous();
    }
 
    //Returns the next page of records
    public void next()
    {
          acclist.next();
    }
}