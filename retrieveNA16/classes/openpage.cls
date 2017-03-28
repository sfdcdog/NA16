public class openpage {

    public openpage(ApexPages.StandardController controller) {

    }


public pageReference openPage() 
    {
        pageReference pg = new pageReference('/apex/Survey');
        pg.setRedirect(true);
        return pg;
    }   
}