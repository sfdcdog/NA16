@isTest
public class Seasonal_Address_Line_Item_Test{

    static List<Household__c> hHoldsList = new List<Household__c>();
    static List<Contact> contactsList = new List<Contact>();
    static List<Seasonal_Address_Line_Item__c> lItemsList = new List<Seasonal_Address_Line_Item__c>();
    static List<Seasonal_Address__c> parentRecList = new List<Seasonal_Address__c>();
    
    public static TestMethod void getRecords(){
        //Inserting Households
        hHoldsList = seasaddrTestUtilities.gethHolds(1);
        insert hHoldsList;

        //Inserting Contacts
        contactsList = seasaddrTestUtilities.getContacts(1);
        Integer j = 0;
        for(Contact conRec: contactsList){
            conRec.Household__c = hHoldsList.get(0).id;
            j++;
        }
        insert contactsList;

        //Inserting Parent(Seasonal Address) Records
        parentRecList = seasaddrTestUtilities.getSeasAddrRecs(1);
        for(Seasonal_Address__c parentRec: parentRecList){
            parentRec.Household__c = hHoldsList.get(0).id;
            parentRec.Contact__c = contactsList.get(0).id;
        }
        insert parentRecList;

        //Inserting Line Item records
        lItemsList = seasaddrTestUtilities.getlItems(2);
        Integer i = 0;
        for(Seasonal_Address_Line_Item__c lItemRec: lItemsList){
            lItemRec.Seasonal_Address__c = parentRecList.get(0).id;
            i++;
        }
        insert lItemsList;
    }

    public static TestMethod void TestDateOverLaponInsert(){
        getRecords();
        Test.startTest();
            //inserting new Line Items
            List<Seasonal_Address_Line_Item__c> lItemsListNew = seasaddrTestUtilities.getlItems(1);
            Integer i = 0;
            for(Seasonal_Address_Line_Item__c lItemRec: lItemsListNew){
                lItemRec.Seasonal_Address__c = parentRecList.get(0).id;
                lItemRec.Start_Date__c = Date.today().addDays(-i);
                i++;
            }
            try{
                insert lItemsListNew;
            }catch(exception e){}
        Test.stopTest();
    }

    public static TestMethod void TestDateOverLaponInsertforEnddate(){
        getRecords();
        Test.startTest();
            //inserting new Line Items
            List<Seasonal_Address_Line_Item__c> lItemsListNew = seasaddrTestUtilities.getlItems(1);
            Integer i = 0;
            for(Seasonal_Address_Line_Item__c lItemRec: lItemsListNew){
                lItemRec.Seasonal_Address__c = parentRecList.get(0).id;
                lItemRec.End_Date__c = Date.today().addDays(-i);
                i++;
            }
            try{
                insert lItemsListNew;
            }catch(exception e){}
        Test.stopTest();
    }

    public static TestMethod void Testonaddressinvalid(){
        getRecords();
        Test.startTest();
            /*//inserting new Line Items
            List<Seasonal_Address_Line_Item__c> lItemsListNew = seasaddrTestUtilities.getlItems(1);
            Integer i = 0;
            for(Seasonal_Address_Line_Item__c lItemRec: lItemsListNew){
                lItemRec.isValid_Address__c = true;
                lItemRec.Seasonal_Address__c = parentRecList.get(0).id;
                lItemRec.Start_Date__c = Date.today().addDays(3);
                lItemRec.End_Date__c = Date.today().addDays(4);
                i++;
            }
            try{
                insert lItemsListNew;
            }catch(Exception e){}
            */
            List<Seasonal_Address_Line_Item__c> lItemsListUpdate = new List<Seasonal_Address_Line_Item__c>();
            for(Seasonal_Address_Line_Item__c lItemRec: lItemsList){
                lItemRec.isValid_Address__c = false;
                lItemsListUpdate.add(lItemRec);
            }
                update lItemsListUpdate;

        Test.stopTest();
    }

    public static TestMethod void TestonDateChange(){
        getRecords();
        Test.startTest();
            //inserting new Line Items
            List<Seasonal_Address_Line_Item__c> lItemsListNew = seasaddrTestUtilities.getlItems(1);
            Integer i = 0;
            for(Seasonal_Address_Line_Item__c lItemRec: lItemsListNew){
                lItemRec.isValid_Address__c = true;
                lItemRec.Seasonal_Address__c = parentRecList.get(0).id;
                lItemRec.Start_Date__c = Date.today().addDays(10);
                lItemRec.End_Date__c = Date.today().addDays(15);
                i++;
            }
            insert lItemsListNew;
            
            List<Seasonal_Address_Line_Item__c> lItemsListUpdate = new List<Seasonal_Address_Line_Item__c>();
            for(Seasonal_Address_Line_Item__c lItemRec: lItemsListNew){
                lItemRec.Start_Date__c = Date.today().addDays(12);
                lItemRec.End_Date__c = Date.today().addDays(17);
                lItemsListUpdate.add(lItemRec);
            }
            update lItemsListUpdate;

        Test.stopTest();
    }    

}