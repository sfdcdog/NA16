/***************************************************************************************************
Class Name: Enterprise_ServiceLayer_CaseHandling
Class Type: Enterprise Model Service Layer Class
Version     : 1.0
Created Date: 29 March 2017
Function    : Serves as a gateway for common functionality shared across clients like VF Controller, APEX Rest, EmailHandler,
							JS Remoting, Web Services, Batch and Scheduler Apex
Input Parameters: TBD
Output Parameters: TBD
Description:   This class is handles all functionality associated with Case object.
Modification Log :
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* JRK                        03/29/2016              Created
****************************************************************************************************/
global class Enterprise_ServiceLayer_CaseHandling{

		global static void checkandupdateContact(List<Case> caseList){
			Account genericAcc = [SELECT id, Name FROM Account WHERE Name like '%Case Handler%'];
			List<Case> updateCaseLst = new List<Case>();

			for(Case cs: caseList){
				if(cs.Contact <> null){
					cs.Account = genericAcc; 
				}
				updateCaseLst.add(cs);
			}

			database.update(updateCaseLst, true);

		}

		global static void createCaseComment(List<Case> caseList){
			List<CaseComment> newCaseComment = new List<CaseComment>();
			CaseComment comment;

			for(Case cs: caseList){
				comment = new CaseComment();
				comment.ParentId = cs.Id;
				comment.CommentBody = cs.CaseNumber+' - from '+cs.Contact.Name+' under '+cs.Account+' is created. ';
				newCaseComment.add(comment);				
			}

			database.insert(newCaseComment, true);
		}

}