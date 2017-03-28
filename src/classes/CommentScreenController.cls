public with sharing class CommentScreenController{

    public Case newcase{get;set;}
    public Id CaseIdvalue;
    public List<Case_Comments__c> CommentRecords;
    public String ProfileName = System.Label.Profile_Name;
    public Boolean InternalColumn{get;set;}
    public Boolean ExternalColumn{get;set;}
    public Profile p;
    
    public CommentScreenController(ApexPages.StandardController controller) {
        newCase=(Case)controller.getRecord();
        system.debug('new case value'+newCase.id);
            /*p =[select id,name from Profile where id=:userInfo.getProfileId()]; */
            InternalColumn= false;
            ExternalColumn= false;
    }
    
    public List<Case_Comments__c> getcaseComments(){
 

    
    Profile p =[select id,name from Profile where id=:userInfo.getProfileId()];
        if(p.name!= ProfileName) {//'Customer Community Plus Login User Clone'
            InternalColumn = true;
            return [select id,name,Comment__c,Rich_Comment__c,CreatedBy.name,CreatedBy.FirstName,CreatedDate,BgColor__c,Notetype__c,NickName__c,Public__c from Case_Comments__c where case__c=:newCase.id ORDER BY CreatedDate DESC NULLS LAST ];
            }
        else{
            ExternalColumn = true;
            return [select id,name,Comment__c,Rich_Comment__c,CreatedBy.name,CreatedBy.FirstName,CreatedDate,BgColor__c,Notetype__c,NickName__c,Public__c from Case_Comments__c where case__c=:newCase.id and public__c=true ORDER BY CreatedDate DESC NULLS LAST];
            }
    }
}