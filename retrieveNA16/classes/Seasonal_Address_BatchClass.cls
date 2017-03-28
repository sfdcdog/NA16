global class Seasonal_Address_BatchClass implements Database.batchable<sObject>{

    global Database.QueryLocator start(Database.BatchableContext BC){
        try{
           return Database.getQueryLocator([SELECT End_Date__c,Seasonal_Address__c,Id,isValid_Address__c,Mailing_City__c,Mailing_Country__c,Mailing_Postal_Code__c,Mailing_State__c,Mailing_Street__c,Name,Start_Date__c FROM Seasonal_Address_Line_Item__c where Start_Date__c =:system.today()]);   
        }catch(Exception ex){
            system.debug('Error in Querying data' + ex.getMessage());
            return null;
        }
    }
   
    global void execute(Database.BatchableContext BC,List<Seasonal_Address_Line_Item__c> scope){
        List<Id> parentIds = new List<Id>();
        system.debug('Context variable'+ BC);system.debug('Scope Data'+scope);
        try{ 
            for(Seasonal_Address_Line_Item__c lItem: scope){
                parentIds.add(lItem.Seasonal_Address__c);
            }
            system.debug('$$$$$'+parentIds);
            Map<Id, Seasonal_Address__c> parentMap = new Map<Id, Seasonal_Address__c>([Select id,Contact__c from Seasonal_Address__c where id IN: parentIds]);
            system.debug('!!!!!'+parentMap);
            List<Id> conIdList = new List<Id>();
            system.debug('*****'+scope);
            for(Seasonal_Address_Line_Item__c lItem: scope){
                if(!lItem.isValid_Address__c){
                    system.debug('line item in loop'+lItem);
                    for(Seasonal_Address__c parentRec: parentMap.values()){
                        system.debug('parent rec: '+parentRec+', line item parent: '+lItem.Seasonal_Address__c);

                        if(lItem.Seasonal_Address__c == parentRec.id){

                            conIdList.add(parentRec.Contact__c);
                        }
                    }
                }
            }
            system.debug('%%%%%'+conIdList);
            if(conIdList.size()>0 && conIdList <> null){
                List<Contact> contacts = new List<Contact>();
                List<Seasonal_Address_Line_Item__c> lItems = new List<Seasonal_Address_Line_Item__c>();
                List<Contact> conList = [Select id, mailingcity, mailingstate, mailingpostalcode, mailingstreet, mailingcountry from Contact where id IN: conIdList];
                system.debug('&&&&&'+conList);
                system.debug('^^^^^'+scope);
                for(Seasonal_Address_Line_Item__c lItem: scope){
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
                    if(!lItem.isValid_Address__c){
                        lItem.isValid_Address__c = true;
                        lItems.add(lItem);
                    }                    
                }
                system.debug('#####'+lItems);
                system.debug('@@@@@1'+contacts);
                if(contacts.size()>0 && contacts <> null){  
                    database.update(contacts);
                    system.debug('@@@@@2'+contacts);
                }
                if(lItems.size()>0 && lItems <> null){
                    database.update(lItems);
                    system.debug('#####'+lItems);    
                }
                
            }
        }catch(exception ex){
            system.debug('Error Message' + ex.getmessage());
        }
        
    
    }   
    
    global void finish(Database.BatchableContext BC){
    }
   
}