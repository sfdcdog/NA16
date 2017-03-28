trigger OOTBComments on Case_Comments__c (before Update, after insert) {

    if(Trigger.IsAfter){
    if(Staticvariables.jsoncasecomments == false){
        String jsonformat = string.valueof(Json.serializepretty([select Case__c,Comment__c from case_comments__c where id =:Trigger.New[0].id]));
        system.debug('json ***'+jsonformat);
        case_comments__c RecinContext = [select Case__c,Comment__c,JSON_FORMAT_FOR_TEST__c from case_comments__c where id =:Trigger.New[0].id];
        system.debug('rec***'+RecinContext);
        
        case_comments__c casecomment = [select Case__c,Comment__c from case_comments__c where id =:Trigger.New[0].id]; 
        JSONGenerator gen = JSON.createGenerator(true);     

            gen.writeStartObject();     
            gen.writeStringField('case', casecomment.Case__c);
            //gen.writeStringField('comment', casecomment.Comment__c);
            gen.writeEndObject();
        
        String jsonString = gen.getAsString();
        system.debug('json file'+jsonString);
        
        RecinContext.JSON_FORMAT_FOR_TEST__c = jsonString;
        
        
        update RecinContext;
        Staticvariables.jsoncasecomments= true;
        
        }
        /*case_comments__c RecinContext = [select id,JSON_FORMAT_FOR_TEST__c ,Comment__c from case_comments__c where id IN: Trigger.new];
        RecinContext.JSON_FORMAT_FOR_TEST__c = jsonformat;
        update RecinContext;*/
    }
    
    if(Trigger.IsBefore){
    CaseComment CCOOTB = new CaseComment();
    List<CaseComment> CCOOTBList = new List<CaseComment>();
    List<CaseComment> CCOOTBList1 = new List<CaseComment>();    
    List<Case_Comments__c> CCRecList = new List<Case_Comments__c>();
    List<Case_Comments__c> CCRecList1 = new List<Case_Comments__c>();
    List<Case_Comments__c> CCRecList2 = new List<Case_Comments__c>();
    CaseComment CCOOTBRecord =  new CaseComment();
    for(Case_Comments__c CCRec: Trigger.New){
        if(CCRec.IsUpdated__c == false){
           CCRec.IsUpdated__c = true;
           CCOOTB.CommentBody = CCRec.Comment__c;
           CCOOTB.ParentId = CCRec.Case__c;
           if(CCRec.Public__c == true)
               CCOOTB.IsPublished = true;
           else
               CCOOTB.IsPublished = false;
           CCOOTBList.add(CCOOTB);
           CCRecList.add(CCRec);    
        }
    }
    if(CCOOTBList.size()>0 && CCOOTBList!=null)
    insert CCOOTBList;
    //update CCRecList;
    
    
    
    for(Case_Comments__c CCRec1: Trigger.New){
        if(CCRec1.IsUpdated__c == true && CCRec1.Case_Comment_ID__c == null){
            CCRec1.Case_Comment_ID__c = CCOOTBList[0].id;
            CCRecList1.add(CCRec1);
            system.debug('Custom Rec on adding id***'+CCRecList1);
        }
    }
    
    if(Trigger.New[0].Case_Comment_ID__c!=null && Trigger.New[0].IsUpdated__c == true){
        CCOOTBRecord  = [Select id,CommentBody, Parentid,Parent.CaseNumber, IsPublished from CaseComment where id=: Trigger.New[0].Case_Comment_ID__c] ;
        system.debug('OOTB Record***'+CCOOTBRecord);
    }
        
    for(Case_Comments__c CCRec2: Trigger.New){
        if(CCRec2.IsUpdated__c == true && CCRec2.Case_Comment_ID__c != null && CCOOTBRecord!=null){
        system.debug('Entering this loop*****');
           CCOOTBRecord.CommentBody = CCRec2.Comment__c;
           //CCOOTBRecord.ParentId = CCRec1.Case__c;
           if(CCRec2.Public__c == true)
               CCOOTBRecord.IsPublished = true;
           else
               CCOOTBRecord.IsPublished = false;
           CCOOTBList1.add(CCOOTBRecord);
           system.debug('OOTB UPDATED***'+CCOOTBList1);
           //CCRecList2.add(CCRec); 
        }
    }
    //update CCRecList1;
    Update CCOOTBList1;
    }
}