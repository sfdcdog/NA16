global class Example_VFRemotingController{
    
    public List<Account> accList{get;set;}
    public Example_VFRemotingController(ApexPages.StandardController controller){
        
    } 
    
    @RemoteAction
    global static List<Account> getAccounts(){
        return [select Name,Id from Account Limit 100];
    }   
}