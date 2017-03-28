@isTest
public class seasaddrTestUtilities{

    public static List<Contact> getContacts(integer noOfContacts){

        List<Contact> conRecList = new List<Contact>();
        for(Integer i=1; i<=noOfContacts; i++){
            Contact conRec = new Contact(
                LastName='FC3S'+i,
                Email = 'ryo@redsuns.com'
            );
            conRecList.add(conRec);
        }
        return conRecList;
    }

    public static List<Household__c> gethHolds(integer noOfhHolds){

        List<Household__c> hHoldRecList = new List<Household__c>();
        for(Integer i=1; i<=noOfhHolds; i++){
            Household__c hHoldRec = new Household__c(
                Name='Straw Hat'+i
            );
            hHoldRecList.add(hHoldRec);
        }
        return hHoldRecList;
    }

    public static List<Seasonal_Address_Line_Item__c> getlItems(integer noOflItems){

        List<Seasonal_Address_Line_Item__c> lItemRecList = new List<Seasonal_Address_Line_Item__c>();
        for(Integer i=1; i<=noOflItems; i++){
            Integer j = i+3;
            Seasonal_Address_Line_Item__c lItemRec = new Seasonal_Address_Line_Item__c(
                isValid_Address__c=false,
                End_Date__c = Date.today().addDays(+j),
                Start_Date__c = Date.today().addDays(+i),
                Mailing_Street__c = 'test'+i,
                Mailing_State__c = 'test'+i,
                Mailing_Postal_Code__c = '94501',
                Mailing_Country__c = 'test'+i,
                Mailing_City__c = 'test'+i
            );
            lItemRecList.add(lItemRec);
        }
        return lItemRecList;
    }

    public static List<Seasonal_Address__c> getSeasAddrRecs(integer noOfSeasAdresses){

        List<Seasonal_Address__c> seasAddrRecList = new List<Seasonal_Address__c>();
        for(Integer i=1; i<=noOfSeasAdresses; i++){
            Seasonal_Address__c seasAddrRec = new Seasonal_Address__c(
                
            );
            seasAddrRecList.add(seasAddrRec);
        }
        return seasAddrRecList;
    }

}