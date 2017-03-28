public class surveycontroller {
Case caserecord;//this is an instance variable

    public surveycontroller(ApexPages.StandardController controller) {
      caserecord = (case) controller.getrecord(); //apexpages.stdcontroller-both are std classes and getrecord is a methd within it
    }
    
    public pagereference changestatus()
    {
       //caserecord.status='Closed';
       //update caserecord;
       pageReference pg = new pageReference('/'+caserecord.id+'/s?retURL='+caserecord.id);
        pg.setRedirect(true);
        return pg;
    }

}