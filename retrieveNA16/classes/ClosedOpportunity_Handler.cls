/* 
*TrailHead Class	
*Module: Apex Triggers 
*Unit: Bulk Apex Triggers 
*Status: Completed 
*/
/***************************************************************************************************
Class Name:  ClosedOpportunity_Handler
Class Type: Handler Class 
Version     : 1.0 
Created Date: 09 Aug 2016
Function    : This class contains all methods that are handled for the related Trigger
Modification Log :
* Developer                  Date                   Description
* ----------------------------------------------------------------------------                 
* JRK                        09/27/2016             Created
****************************************************************************************************/   
public class ClosedOpportunity_Handler{    
    /***************************************************************************************************
    Method Name:  addTaskonClosedWon
    Method Type: Opportunity Handler Method 
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
    public static void addTaskonClosedWon(List<Opportunity> newList){
      if(newList <> null && newList.size()>0){
        List<Opportunity> oppsList = [SELECT Id,Name, StageName FROM Opportunity where id in: newList];
        List<Task> tskList = new List<Task>();
        for(Opportunity oppsRec: oppsList){
        	system.debug('Opportunity Record Name and Id'+oppsRec.Name+'&'+oppsRec.Id);
        	system.debug('Opportunity StageName'+oppsRec.StageName);
            if(oppsRec.StageName <> null && oppsRec.StageName == 'Closed Won'){
				Task tskRec = new Task();
                tskRec.Subject = 'Follow Up Test Task';
				tskRec.WhatId = oppsRec.id;
                tskList.add(tskRec);
			}
			system.debug('Final task List'+tskList);
        }
        insert tskList;
      }
    }
}