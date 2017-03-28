/* 
*TrailHead Class	
*Module: Apex Triggers 
*Unit: Getting Started with Apex Triggers 
*Status: Completed 
*/
/***************************************************************************************************
Class Name:  AccountAddress_Handler
Class Type: Handler Class 
Version     : 1.0 
Created Date: 27 Sep 2016
Function    : This class contains all methods that are handled for the related Trigger
Modification Log :
* Developer                  Date                   Description
* ----------------------------------------------------------------------------                 
* JRK                        09/27/2016             Created
****************************************************************************************************/   
public class AccountAddress_Handler{    
    /***************************************************************************************************
    Method Name:  populateShippingAddress
    Method Type: Account Handler Method 
    Version     : 1.0 
    Created Date: 27 Sep 2016
    Function    : This method is used to update shipping address based on BillingAddress and a checkbox set to true
    Input Parameters: Trigger.New List
    Output Parameters: None
    Modification Log :
    * Developer      Date                   Description
    * ----------------------------------------------------------------------------                 
    * JRK            09/27/2016             Created
    ****************************************************************************************************/  
    public static void populateShippingAddress(List<Account> newList){
      if(newList <> null && newList.size()>0){
        /*List<Account> accList = [SELECT AccountNumber,BillingAddress,BillingCity,BillingCountry,BillingPostalCode,BillingState,BillingStreet,Id,Match_Billing_Address__c,Name,
									   ShippingAddress,ShippingCity,ShippingCountry,ShippingPostalCode,ShippingState,ShippingStreet FROM Account where id in: newList];*/
        
        for(Account accRec: newList){
        	system.debug('Account Record Name and Id: '+accRec.Name+'&'+accRec.Id);
        	system.debug('Account Billing Address'+accRec.BillingAddress);
        	system.debug('Account Billing Address'+accRec.BillingCity);
        	system.debug('Account Shipping Address'+accRec.ShippingAddress);
            if((accRec.BillingCity <> null || accRec.BillingCountry <> null|| accRec.BillingPostalCode <> null|| accRec.BillingState <> null|| accRec.BillingStreet <> null) && accRec.ShippingAddress == null && accRec.Match_Billing_Address__c){
				accRec.ShippingCity = accRec.BillingCity;
				accRec.ShippingCountry = accRec.BillingCountry;
				accRec.ShippingPostalCode = accRec.BillingPostalCode;
				accRec.ShippingState = accRec.BillingState;
				accRec.ShippingStreet = accRec.BillingStreet;
				
			}
			system.debug('Final Billing Address'+accRec.BillingAddress);
			system.debug('Final Shipping Address'+accRec.ShippingAddress);
        }
      }
    }
}