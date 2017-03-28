@isTest
public class Seasonal_Address_Batch_Test{

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

        
    }

    public static testMethod void testBatch() {
        getRecords();
        
        //Inserting Line Item records
        lItemsList = seasaddrTestUtilities.getlItems(2);
        Integer i = 0;
        for(Seasonal_Address_Line_Item__c lItemRec: lItemsList){
            lItemRec.Seasonal_Address__c = parentRecList.get(0).id;
            lItemRec.Start_Date__c = Date.today();
            i++;
        }
        insert lItemsList;

        Test.StartTest();
        Seasonal_Address_BatchClass batch = new Seasonal_Address_BatchClass();
        ID batchprocessid = Database.executeBatch(batch);
        Test.StopTest();

    }

}