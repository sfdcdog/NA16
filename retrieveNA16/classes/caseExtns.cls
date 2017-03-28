public with sharing class caseExtns {

public Case newcase{get;set;}
//public String userComment{get;set;}

    public caseExtns(ApexPages.StandardController controller) {
        newCase=(Case)controller.getRecord();
        //newCOmment.comment__c='test5';
    }
public List<Case_Comments__c> getcaseComments(){
//String caseId = ApexPages.currentPage().getParameters().get('caseid');
Profile p =[select id,name from Profile where id=:userInfo.getProfileId()];
if(p.name!='community portal user clone')
return [select id,name,Comment__c,Rich_Comment__c,CreatedBy.name,CreatedDate from Case_Comments__c where case__c=:newCase.id ];
else
return [select id,name,Comment__c,Rich_Comment__c,CreatedBy.name,CreatedDate from Case_Comments__c where case__c=:newCase.id and public__c=true];
}

public void saveComment(){
    //System.debug('value is ************'+userComment);
    //String caseId = ApexPages.currentPage().getParameters().get('caseid');
    Case_Comments__c newComment = new Case_Comments__c();
    newComment.case__c=newCase.id;
    newComment.Rich_Comment__c=newCase.Comment__c;
    newComment.comment__c = newCase.Comment__c;
    insert newCOmment;
}
}
//
//