public with sharing class seasonalAddressPageController {

    public Boolean showHouseHoldFlag {get;set;}
    public Boolean showContactFlag {get;set;}
    public String searchTxt;
    public String hHoldListQuery;
    public List < wrapHouseHold > wrapHouseHoldList {get;set;}
    public List < wrapContact > wrapContactList {get;set;}
    public Integer hHoldRecords {get;set;}
    public Integer conRecords {get;set;}
    public Integer size {get;set;}
    public transient String searchText {get;set;}
    public Set < Household__c > selectedHouseHolds {get;set;}
    public Set < Contact > selectedContacts {get;set;}
    public List < SelectOption > hHoldPaginationSizeOptions {get;set;}
    public List < SelectOption > conPaginationSizeOptions {get;set;}
    public String searchTextcon {get;set;}
    public String conListQuery {get;set;}
    public List < Contact > conQueryList;
    public String hHoldId = '';



    public seasonalAddressPageController() {
        showHouseHoldFlag = true;
        showContactFlag = false;
        wrapHouseHoldList = new List < wrapHouseHold > ();
        wrapContactList = new List < wrapContact > ();
        hHoldPaginationSizeOptions = new List < SelectOption > ();
        conPaginationSizeOptions = new List < SelectOption > ();
        size = 5;
        List < String > listofSizes = System.Label.pagesizes.split(';');
        for (String s: listofSizes) {
            hHoldPaginationSizeOptions.add(new SelectOption(s, s));
        }
        for (String s1: listofSizes) {
            conPaginationSizeOptions.add(new SelectOption(s1, s1));
        }
        selectedHouseHolds = new Set < Household__c > ();
        selectedContacts = new Set < Contact > ();
        hHoldId = ApexPages.currentPage().getParameters().get('id');

    }

    /******************HouseHolds Section**********************/

    //Get HouseHolds 
    // The standard set controller property is called from here and set to null and executed.
    // And on rerndering of the household section the paginated property is called, which now has the standard set controller data
    public void searchHouseHolds() {
        searchTxt = '%' + searchText + '%';
        system.debug('search Text: '+searchTxt);
        hHoldListQuery = 'Select id,Name from Household__c where name like \'' + searchTxt + '\' ORDER BY Name ASC NULLS LAST  limit 9999';
        standardSetCon = null;
    }
    // paginating HouseHolds 
    public List < wrapHouseHold > getpaginated() {
        wrapHouseHoldList = new List < wrapHouseHold > ();
        if (standardsetcon <> null) {
            system.debug('standardset con Hhold: '+standardsetcon.getrecords());
            for (Household__c hHold: (List < Household__c > ) standardsetcon.getrecords()) {
                system.debug('HouseHold Rec: '+hHold);
                wrapHouseHold whHold = new wrapHouseHold();
                whHold.selected = false;
                whHold.hHold = hHold;
                wrapHouseHoldList.add(whHold);
            }
        }
        if (wrapHouseHoldList.size() > 0) {
            return wrapHouseHoldList;
        } else {
            return null;
        }
    }
    //Using standard set controller property
    public ApexPages.StandardSetController standardSetCon {
        get {         
            if (standardSetCon == null && hHoldListQuery <> null) {
                system.debug('Query Name: '+hHoldListQuery);
                system.debug('HHold List: '+new ApexPages.StandardSetController(Database.getQueryLocator(hHoldListQuery)));   
                standardSetCon = new ApexPages.StandardSetController(Database.getQueryLocator(hHoldListQuery));
                standardSetCon.setPageSize(size);
                hHoldRecords = standardSetCon.getResultSize();
            }
            system.debug('Record Size: '+hHoldRecords);
            return standardSetCon;
        }
        set;
    }
    //getting the list of selected Households
    public void processSelected() {
        if (wrapHouseHoldList <> null && wrapHouseHoldList.size() > 0) {
            for (wrapHouseHold wrapHouseHold: wrapHouseHoldList) {
                system.debug('@@@@@' + wrapHouseHold);
                if (wrapHouseHold.selected == true) {
                    system.debug('before adding' + selectedHouseHolds);
                    selectedHouseHolds.add(wrapHouseHold.hHold);
                    system.debug('after adding' + selectedHouseHolds);
                } else {
                    if (selectedHouseHolds <> null && selectedHouseHolds.contains(wrapHouseHold.hHold))
                        selectedHouseHolds.remove(wrapHouseHold.hHold);
                }
            }
        }
    }
    /*************************END OF HouseHolds Section**************************************************/

    /*****************************************Contacts Section******************************************************/

    //Get Contacts 
    public void searchContacts() {
        String searchTxt = '%' + searchTextcon + '%';
        processSelected();
        List < Id > hHoldIds = new List < Id > ();
        for (Household__c selectedhHold: selectedHouseHolds) {
            hHoldIds.add(selectedhHold.id);
        }
        system.debug('@@@@@@' + hHoldIds);
        conQueryList = [Select id, Name, Household__c from Contact where Household__c IN: hHoldIds];
        system.debug(conQueryList);
        contactStandardSetCon = null;
    }
    // paginating Contacts
    public List < wrapContact > getContactspaginated() {
        system.debug('###coming i here###');
        wrapContactList = new List < wrapContact > ();
        system.debug('ppppppppppppp' + contactStandardSetCon);
        if (contactStandardSetCon <> null) {
            system.debug('xxxxxxxxxxxxxxx' + (List < Contact > ) contactStandardSetCon.getrecords());
            for (Contact con: (List < Contact > ) contactStandardSetCon.getrecords()) {
                wrapContact wcon = new wrapContact();
                wcon.selected = false;
                wcon.con = con;
                wrapContactList.add(wcon);
            }
        }
        if (wrapContactList.size() > 0) {
            return wrapContactList;
        } else {
            return null;
        }
    }
    //Using standard set controller property
    public ApexPages.StandardSetController contactStandardSetCon {
        get {
            if (contactStandardSetCon == null && conQueryList <> null) {
                system.debug('@@@comin in here@@@@');
                system.debug('!@!@!@' + conQueryList);
                system.debug('#$#$#$#$#$#$' + new ApexPages.StandardSetController(conQueryList));
                contactStandardSetCon = new ApexPages.StandardSetController(conQueryList);
                contactStandardSetCon.setPageSize(size);
                conRecords = contactStandardSetCon.getResultSize();
            }
            return contactStandardSetCon;
        }
        set;
    }

    //getting the list of selected contacts
    public void processSelectedContacts() {
        if (wrapContactList <> null && wrapContactList.size() > 0) {
            for (wrapContact wrapCon: wrapContactList) {
                if (wrapCon.selected == true) {
                    selectedContacts.add(wrapCon.con);
                } else {
                    if (selectedContacts.contains(wrapCon.con))
                        selectedContacts.remove(wrapCon.con);
                }
            }
        }
    }
    /****************************END OF Contacts Section**************************************/

    /*******************************Create Seasonal Address Records****************************/

    // Creates Seasonal Address Records
    public PageReference createSeasonalAddresses() {
        processSelected();
        processSelectedContacts();
        List < Household__c > hHoldsSelected = new List < Household__c > ();
        List < Seasonal_Address__c > saRecList = new List < Seasonal_Address__c > ();
        system.debug('new######' + selectedHouseHolds);
        system.debug('new@@@@@@' + selectedContacts);
        Map < Id, Id > hHoldToContacts = new Map < Id, Id > ();
        for (Household__c hHoldRec: selectedHouseHolds) {
            for (Contact conRec: selectedContacts) {
                if (conRec.Household__c == hHoldRec.id) {
                    hHoldToContacts.put(conRec.id, hHoldRec.id);
                }
            }
        }

        for (Contact conRec: selectedContacts) {
            Seasonal_Address__c saRec = new Seasonal_Address__c();
            saRec.Contact__c = conRec.id;
            saRec.Household__c = hHoldToContacts.get(conRec.id);
            saRecList.add(saRec);
        }

        insert saRecList;
        return new PageReference('/'+hHoldId);
    }
    /********************END OF Create Seasonal Address Records Section************************/

    //Wrapper class and page section render methods
    public void contactsPage() {
        showHouseHoldFlag = false;
        showContactFlag = true;
    }

    public class wrapHouseHold {
        public Household__c hHold {get;set;}
        public Boolean selected {get;set;}
    }

    public class wrapContact {
        public boolean selected {get;set;}
        public Contact con {set;get;}
    }

}