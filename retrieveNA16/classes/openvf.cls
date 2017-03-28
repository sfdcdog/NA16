public class openvf {

public List<Case> csid;

    public openvf(ApexPages.StandardController controller) {
    
   //as soon as page loads constructor gets called

    }



public pageReference openPage() 
    {
        csid= [select id,status from Case WHERE id =: ApexPages.currentPage().getParameters().get('id')];
        pageReference pg = new pageReference('/apex/Survey?id='+csid[0].id);
        pg.setRedirect(true);
        return pg;
    }      
    }