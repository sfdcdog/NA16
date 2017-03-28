public  class AddCommentController{

    public AddCommentController() {

    }


    public Case newcase{get;set;}
    public id urlid;
    public String ProfileName = System.Label.Profile_Name;
    public String selectedVisibilityOption{get;set;}
    public List<SelectOption> VisibilityOptions{get;set;}
    public Boolean InternalOnlyOptions{get;set;}
    
    public AddCommentController(ApexPages.StandardController controller) {
        
        urlid = apexpages.currentpage().getparameters().get('id');
        system.debug('urlid***'+urlid);
        newCase=[select id,Comment__c from Case where id =:urlid ];
        
    }
  

    
    public PageReference saveComment(){
        User u = [select id, name, CommunityNickName from User where id=:UserInfo.getUserId() ];
        Profile p =[select id,name from Profile where id=:userInfo.getProfileId()];
        Case_Comments__c newComment = new Case_Comments__c();
        newComment.case__c=newCase.id;
        newComment.Rich_Comment__c=newCase.Comment__c;
        newComment.BgColor__c = 'background-color: #E6E6E6'; //
        newComment.Notetype__c = 'Note To Customer';
        

        insert newComment;
        return new PageReference('/'+newCase.id);
        

}
}