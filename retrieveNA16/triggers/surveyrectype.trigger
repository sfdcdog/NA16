trigger surveyrectype on Case (before update){

RecordType rt = [select Id from RecordType where Name= 'Cases(Survey)' and SobjectType = 'Case' limit 1];
RecordType rs = [select Id from RecordType where Name= 'Cases(NonSurvey)' and SobjectType = 'Case' limit 1];
    for (Case c: Trigger.new) {
    if(c.Created_Date__c<System.today()-30)
    {
    c.RecordTypeId = rt.Id;
        }
        else{
            c.RecordTypeId = rs.id;
        }
    }
}




//trigger surveylink on Case (before update ) 




    //String fieldURL = trigger.new[0].id; //URL.getSalesforceBaseUrl().toExternalForm()+'/apex/Survey?id='+
   // List<case> caserecords = trigger.new;//takes the current record
    
   //if(caserecords[0].status=='Closed')
    //{
    //caserecords[0].Survey__c=fieldURL;
    //}
    //else{
    //caserecords[0].Survey__c=null;
    //}
    
    
   
 
    
    //}