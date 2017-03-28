@isTest
public class SeasonalAddressPageController_Test{

    public static SeasonalAddressPageController saController{get;set;}
    public static List<SeasonalAddressPageController.wrapHouseHold> wrpHouseHoldList{get;set;}
    public static List<SeasonalAddressPageController.wrapContact> wrpContactList{get;set;}    
    public static List<Household__c> hHolds;
    public static String searchText;
    
    
    public static void getRecords(){
        hHolds = seasaddrTestUtilities.gethHolds(1);
        insert hHolds;
        system.debug('HouseHolds Inserted: '+hHolds);
        PageReference pageref = Page.seasonalAddress;
        Test.setCurrentPage(pageRef);
        //ApexPages.currentPage().getParameters().put('id',hHolds.[0].id);
        saController = new SeasonalAddressPageController();
        searchText= 'Straw';    
    }
    

    static testMethod void allMethods_Test(){
        getRecords();
        saController.searchHouseHolds();
        wrpHouseHoldList = saController.getpaginated();

        saController.searchContacts();
        wrpContactList = saController.getContactspaginated();
        saController.contactsPage();
        saController.createSeasonalAddresses();
    }

}