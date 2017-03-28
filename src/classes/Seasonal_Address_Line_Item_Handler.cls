/***************************************************************************************************
Class Name:  Seasonal_Address_Line_Item_Handler
Class Type: Handler Class 
Version     : 1.0 
Created Date: 09 Aug 2016
Function    : This class contains all methods that are handled for the related Trigger
Modification Log :
* Developer                  Date                   Description
* ----------------------------------------------------------------------------                 
* JRK                        08/09/2016             Created
****************************************************************************************************/   
public class Seasonal_Address_Line_Item_Handler{    
    /***************************************************************************************************
    Method Name:  preventDateOverlap
    Method Type: Seasonal_Address_Line_Item Handler Method 
    Version     : 1.0 
    Created Date: 09 Aug 2016
    Function    : This method is used to throw an error when start dates and end dates overlap.
    Input Parameters: Trigger.New List
    Output Parameters: None
    Modification Log :
    * Developer      Date                   Description
    * ----------------------------------------------------------------------------                 
    * JRK            08/09/2016             Created
    ****************************************************************************************************/  
    public static void preventDateOverlap(List<Seasonal_Address_Line_Item__c> newList){
      if(newList <> null && newList.size()>0){
        List<Seasonal_Address_Line_Item__c> existingItems = [select id, End_Date__c, Start_Date__c from Seasonal_Address_Line_Item__c where Seasonal_Address__c =: newlist[0].Seasonal_Address__c];
        
        for(Seasonal_Address_Line_Item__c lItem: newList){
            if(lItem.End_Date__c <> null && lItem.Start_Date__c <> null){
                for(Seasonal_Address_Line_Item__c existinglItem: existingItems){
                    if(existinglItem.End_Date__c <> null && lItem.Start_Date__c <= existinglItem.End_Date__c && Trigger.isInsert){
                        //can use custom labels here, but leaving not to make it too complex.
                        lItem.adderror('Please ensure the start date is greater than End Dates of other exisitng Line Items');
                    }
                }
                if(lItem.End_Date__c <= lItem.Start_Date__c){
                    //can use custom labels here, but leaving not to make it too complex.
                    lItem.adderror('Please ensure the curent End date is greater than the current Start Date');
                }
            }
        }
      }
    }
    
        
    /***************************************************************************************************
    Method Name:  onaddressinvalid
    Method Type: Seasonal_Address_Line_Item Handler Method 
    Version     : 1.0 
    Created Date: 09 Aug 2016
    Function    : This method is used to change the Mailing address values of related contacts when
                  the Line Item checkbox is made false.
    Input Parameters: Trigger.New List
    Output Parameters: None
    Modification Log :
    * Developer      Date                   Description
    * ----------------------------------------------------------------------------                 
    * JRK            08/09/2016             Created
    ****************************************************************************************************/
    public static void onaddressinvalid(List<Seasonal_Address_Line_Item__c> newList){
        if(newList <> null && newList.size()>0){
            List<Id> parentIds = new List<Id>();
            for(Seasonal_Address_Line_Item__c lItem: newList){
                parentIds.add(lItem.Seasonal_Address__c);
            }
            //List<Seasonal_Address_Line_Item__c> RTPList = [Select id, Mailing_Street__c, Mailing_State__c, Mailing_Postal_Code__c, Mailing_Country__c, Mailing_City__c, isValid_Address__c,  from Seasonal_Address_Line_Item__c where id IN: newList];
            Map<Id, Seasonal_Address__c> parentMap = new Map<Id, Seasonal_Address__c>([Select id,Contact__c from Seasonal_Address__c where id IN: parentIds]);
            List<Id> conIdList = new List<Id>();
            //List<Id> hHoldList = new List<Id>();
            for(Seasonal_Address_Line_Item__c lItem: newList){
                if(!lItem.isValid_Address__c){
                    for(Seasonal_Address__c parentRec: parentMap.values()){
                        if(lItem.Seasonal_Address__c == parentRec.id){
                            conIdList.add(parentRec.Contact__c);
                            //hHoldList.add(parentRec.Household__c);
                        }
                    }
                }
            }
            system.debug('######contacts'+conIdList.size());//system.debug('######households'+hHoldList.size());
            if(conIdList.size()>0 && conIdList <> null){
                List<Contact> contacts = new List<Contact>();
                List<Contact> conList = [Select id, mailingcity, mailingstate, mailingpostalcode, mailingstreet, mailingcountry from Contact where id IN: conIdList];
                for(Contact con: conList){
                    con.mailingcity='';
                    con.mailingstate='';
                    con.mailingpostalcode='';
                    con.mailingstreet='';
                    con.mailingcountry='';
                    contacts.add(con);
                }
                update contacts;
            }
        }
    }

    /***************************************************************************************************
    Method Name:  onDateChange
    Method Type: Seasonal_Address_Line_Item Handler Method 
    Version     : 1.0 
    Created Date: 10 Aug 2016
    Function    : This method is used to change the associated Contact mailing address
                  value when the start date or end date is changed
    Input Parameters: Trigger.New List
    Output Parameters: None
    Modification Log :
    * Developer      Date                   Description
    * ----------------------------------------------------------------------------                 
    * JRK            08/10/2016             Created
    ****************************************************************************************************/
    public static void onDateChange(List<Seasonal_Address_Line_Item__c> newList, Map<Id, Seasonal_Address_Line_Item__c> oldMap){
        if(newList <> null && newList.size()>0){
            List<Id> parentIds = new List<Id>();
            Integer count = 0;
            for(Seasonal_Address_Line_Item__c lItem: newList){
                parentIds.add(lItem.Seasonal_Address__c);                
                List<Seasonal_Address_Line_Item__c> existingItems = [select id, End_Date__c, Start_Date__c from Seasonal_Address_Line_Item__c where Seasonal_Address__c =: newlist[0].Seasonal_Address__c];   

                if(lItem.End_Date__c <> null && lItem.Start_Date__c <> null){
                    for(Seasonal_Address_Line_Item__c existinglItem: existingItems){
                        //start date must be greater than or equals today (assuming this wont be part of the current season if an earlier date is chosen)
                        //start date must be greater than exsiting Line Item End Dates
                        //start date must be greater than End date.
                        //start date must not be equal to old value.
                        //chance that few other validations might have been missed. :-p
                        system.debug('1'+lItem.Start_Date__c+' : '+system.today());
                        system.debug('2'+existinglItem.End_Date__c+' : '+lItem.Start_Date__c);
                        system.debug('3'+lItem.Start_Date__c+' : '+lItem.End_Date__c);
                        system.debug('4'+lItem.Start_Date__c+' : '+oldMap.get(lItem.id).Start_Date__c);
                        if(existinglItem.End_Date__c <> null && lItem.Start_Date__c >= system.today() && lItem.Start_Date__c > existinglItem.End_Date__c && lItem.Start_Date__c < lItem.End_Date__c && lItem.Start_Date__c <> oldMap.get(lItem.id).Start_Date__c){
                            count++;
                        }
                    }
                }
            }

            if(count > 0){
                Map<Id, Seasonal_Address__c> parentMap = new Map<Id, Seasonal_Address__c>([Select id,Contact__c from Seasonal_Address__c where id IN: parentIds]);
                List<Id> conIdList = new List<Id>();
                for(Seasonal_Address_Line_Item__c lItem: newList){
                    for(Seasonal_Address__c parentRec: parentMap.values()){
                        if(lItem.Seasonal_Address__c == parentRec.id){
                            conIdList.add(parentRec.Contact__c);
                        }
                    }
                }
                system.debug('######contacts'+conIdList.size());
                if(conIdList.size()>0 && conIdList <> null){
                    List<Contact> contacts = new List<Contact>();
                    List<Contact> conList = [Select id, mailingcity, mailingstate, mailingpostalcode, mailingstreet, mailingcountry from Contact where id IN: conIdList];
                    for(Seasonal_Address_Line_Item__c lItem: newList){
                        for(Seasonal_Address__c seasAddr: parentMap.values()){
                            if(lItem.Seasonal_Address__c == seasAddr.id){
                                for(Contact con: conList){
                                    if(seasAddr.Contact__c == con.id){
                                        con.mailingcity = lItem.Mailing_City__c;
                                        con.mailingstate = lItem.Mailing_State__c;
                                        con.mailingpostalcode = lItem.Mailing_Postal_Code__c;
                                        con.mailingstreet = lItem.Mailing_Street__c;
                                        con.mailingcountry = lItem.Mailing_Country__c;
                                        contacts.add(con);
                                    }
                                }  
                            } 
                        }
                    }
                    update contacts;   
                }
            }
        }
    }       
}