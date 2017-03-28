public class Example_VisualForce_Component_Controller {

    public Example_VisualForce_Component_Controller() {

    }


    public Example_VisualForce_Component_Controller(ApexPages.StandardController controller) {

    }

   
   
   public String caseid{get;set;}



   // public id caseId{get;set;}
    public List<CaseHistory> getRecentHistory(){
        return [Select field, oldValue, newValue from CaseHistory where caseId=: caseid and field='Priority' order By Id Desc limit 1];
    }
    public List<case_comments__c> getRecentComments()
    {
        return [Select Comment__c from case_comments__c where case__c =: caseId and Public__c=false order By Id Desc limit 5 ];
    }
    
    public List<case_comments__c> getPublicComments()
    {
        return [Select Comment__c from case_comments__c where case__c =: caseId and Public__c=true order By Id Desc limit 5 ];
    }
    
    /*
    public Example_VisualForce_Component_Controller() {
        //if(currcaseId!=null){
        List<Case> c = [select id,casenumber,(Select field, oldValue, newValue from Histories order By Id Desc limit 1),(Select Comment__c from case_comments__r order By Id Desc limit 5) from case where id=:caseid];
        if(c.size()>0)
        {
            if(c[0].case_comments__r!=null)
                recentComments =c[0].case_comments__r;
        }
        
        if(c.size()>0)
        {
            if(c[0].histories!=null)
                recentHistoy = c[0].histories;
        }
        
        //}
    //ALSO WE MUST DISTINGUISH BOTH THE INTERNAL AND EXTERNAL COMMENTS WHEN SENDING AN EMAIL
        
        //List<CaseHistory> ch=[Select oldValue, newValue from CaseHistory where caseid=:currcaseID order by id DESC limit 2];
        //recentHistoy = ch;
    }
    

    
    //values=[Select Id,(Select oldValue, newValue from Histories limit 1) from Case  ]--this query works to get old,new value but how are we to get the most recent change
    //notes=[Select Id,(Select Rich_Comment__c, Comment__c from case_comments__r limit 5) from Case}--this query works to get all the comments from the communication log 
                                                                                                     //but we want the latest five
//Select Id,casenumber,(Select Rich_Comment__c, Comment__c from case_comments__r limit 5) from Case ORDER BY Id DESC limit 3

//Select oldValue, newValue from CaseHistory where caseid='500j0000002eqijAAA' order by id DESC limit 1-----NEW QUERY

    //Case fielddata;
    
     // public Example_VisualForce_Component_Controller(){
    
    //}
    */
}