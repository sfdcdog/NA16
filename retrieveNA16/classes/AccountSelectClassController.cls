public class AccountSelectClassController {

    //Our collection of the class/wrapper objects wrapAccount
    public List<wrapAccount> wrapAccountList {get; set;}
    public Set<Account> selectedAccounts{get;set;}
    public List<SelectedContact> myContactList{get;set;}
    public List<Account> acctList{get;set;}
    public String searchText{get;set;}
    
    String searchTxt;
    String AccountListQuery;
    List<Contact> conList;
    
    public void searchAccounts(){
           searchTxt = '%'+searchText+'%';
        acctList = [select id, name from Account where name like :searchTxt];
        AccountListQuery ='select id, name from Account where name like \''+searchTxt+'\'';
        standardSetCon =null; 
        
    }
    
    public List<wrapAccount> getpaginated(){
        wrapAccountList = new List<wrapAccount>();
       
            
            if(searchTxt!=null)
            {
                for(Account a: (List<Account>)standardsetcon.getrecords())
                { 
                    if(selectedAccounts.contains(a)){
                        wrapAccount wAct = new wrapAccount();
                      wAct.selected=true;
                      wAct.acc=a;
                      wrapAccountList.add(wAct);
                      }
                      else
                      {
                          wrapAccount wAct = new wrapAccount();
                          wAct.selected=false;
                          wAct.acc=a;
                          wrapAccountList.add(wAct);
                      }
                        
                }
               return wrapAccountList; 
            
           
            
        }else
            return null;
        
        
    }

    public AccountSelectClassController(){
        selectedAccounts = new Set<Account>();    
    }
    
    public ApexPages.StandardSetController standardSetCon {
        get {
            if(standardSetCon == null && AccountListQuery!=null) {
                standardSetCon = new ApexPages.StandardSetController(Database.getQueryLocator(AccountListQuery));
                // sets the number of records in each page set. Total of 10000 records can be 
                standardSetCon.setPageSize(7);
               
            }
            return standardSetCon;
        }
        set;
    }
 
    public void processSelected() {
    //selectedAccounts = new set<Account>();
 
        for(wrapAccount wrapAccountObj : wrapAccountList) {
            if(wrapAccountObj.selected == true) {
                selectedAccounts.add(wrapAccountObj.acc);
            }
            else{
               if(selectedAccounts.contains(wrapAccountObj.acc))
                   selectedAccounts.remove(wrapAccountObj.acc);
               }
        }
    }
    
    public Apexpages.StandardSetController stdsetCon{
    get{
        if(stdsetCon==null){
            stdSetCon = new ApexPages.StandardSetController(Database.getQueryLocator([Select id,name, LastName,Account.Name from contact where Accountid in:selectedAccounts]));
            stdsetCon.setPageSize(1);
        }
       return stdsetCon;
    }
     set;
    }
    
    public String seeTest{get;set;}
    public List<SelectedContact> getMyContacts(){
    seeTest='test';
    
    if(selectedAccounts!=null){
           // conList = [select id,name, LastName,Account.Name from contact where Accountid in:selectedAccounts];
        mycontactList = new List<SelectedContact>();
        for(contact con:(List<contact>)stdsetCon.getrecords())
        {
            SelectedContact selCon = new SelectedContact();
            selCon.selected=false;
            selCon.con=con;
            mycontactList.add(selCon);
        }
        return mycontactList;
       } else
            return null;
        
        
    }
               
    
    
    
    
    
    public PageReference contactpage(){
    PageReference pageRef = new PageReference('/apex/Mapcon');
            return pageRef;
    }
    
    public PageReference productspage(){
    PageReference prodpageRef = new PageReference('/apex/Mapprod');
            return prodpageRef;
    }
    // This is our wrapper/container class. In this example a wrapper class contains both the standard salesforce object Account and a Boolean value
    public class wrapAccount {
        public Account acc {get; set;}
        public Boolean selected {get; set;}
 
       
    }
    public class SelectedContact{
        public boolean selected{get;set;}
        public contact con{get;set;}
    }
    
}