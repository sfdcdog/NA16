public class OpportunityClosedLostControllerExtension{
private Opportunity Oppty;
    private ApexPages.StandardController stdController;
    
    
    public OpportunityClosedLostControllerExtension (ApexPages.StandardController controller) {
        
        //pre-populate Lost notes on load
        this.Oppty = (Opportunity)controller.getRecord(); 
        Oppty.Lost_Notes__c = '* What could have been done to salvage the opportunity?' + '\n\n\n' + '* What is required within Compass Learning to correct the Loss reason? \n\n\n';
        stdcontroller=controller;
        
    }
    
    
    public PageReference saveOpportunity()
    {
        //Custom Save Code 
        Oppty.Probability=0;
        Oppty.StageName='Closed Lost';
        Oppty.Set_Closed_Lost_Info__c=true;
        PageReference pageRef=stdcontroller.save();
        return pageRef;
     }
     }