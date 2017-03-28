public class ApprovalUtility {
    public static void submitApprovalRequestForPAR(List<Map__c> parListForApproval) {
        
        Map<Id, Set<Id>> approverIdsByMap = new Map<id, Set<id>>();
        Set<Id> prodOrgIds = new Set<Id>();
        for(Map__c parRecord:parListForApproval){
            prodOrgIds.add(parRecord.MAPProdOrg__c);
        }
        System.debug('product Orgs:'+prodOrgIds);
        List<Product_Organization_Admin__c> orgAdminList = [select id, name, Product_Organization__c, Admin__c from Product_Organization_Admin__c where Product_Organization__c in :prodOrgIds]; 
        System.debug('Org Admins:'+orgAdminList);
        for(Map__c m:parListForApproval){
            Set<Id> userIdList = new Set<Id>();
            for(Product_Organization_Admin__c poa:orgAdminList){
                if(poa.Product_Organization__c == m.MAPProdOrg__c){
                    userIdList.add(poa.admin__c);
                }
            }
            approverIdsByMap.put(m.id, userIdList);
        }   
          System.debug('Approver Ids By Map:'+approverIdsByMap);     
        for(Map__c parRecord:parListForApproval){
            Approval.ProcessSubmitRequest req1 = 
            new Approval.ProcessSubmitRequest();
            req1.setComments('Submitting request for approval.');
            req1.setObjectId(parRecord.id);
            
            //approverids.addAll(approverIdsByMap.get(parRecord.id));
            if(approverIdsByMap.get(parRecord.id)!=null){
                String apIds='';
                List<Id> approverIds= new List<Id>();
                for(Id ap:approverIdsByMap.get(parRecord.id)){
                    approverIds.add(ap);
                    apIds=apIds+'\''+ap+'\',';
                }
                //approverIds.addAll(approverIdsByMap.get(parRecord.id));
                System.debug(approverIds);
                req1.setNextApproverIds(approverIds);
                }
            // Submit on behalf of a specific submitter
            //req1.setSubmitterId(user1.Id); 
            
            // Submit the record to specific process and skip the criteria evaluation
            req1.setProcessDefinitionNameOrId('Par_Request');
            req1.setSkipEntryCriteria(true);
            
            // Submit the approval request
            if(approverIdsByMap.get(parRecord.id)!=null)
                Approval.ProcessResult result = Approval.process(req1);
        }
            
        // Create an approval request for the account
        
        
        // Verify the result
        /*System.assert(result.isSuccess());
        
        System.assertEquals(
            'Pending', result.getInstanceStatus(), 
            'Instance Status'+result.getInstanceStatus());
        
        // Approve the submitted request
        // First, get the ID of the newly created item
        List<Id> newWorkItemIds = result.getNewWorkitemIds();
        
        // Instantiate the new ProcessWorkitemRequest object and populate it
        Approval.ProcessWorkitemRequest req2 = 
            new Approval.ProcessWorkitemRequest();
        req2.setComments('Approving request.');
        req2.setAction('Approve');
        req2.setNextApproverIds(new Id[] {UserInfo.getUserId()});
        
        // Use the ID from the newly created item to specify the item to be worked
        req2.setWorkitemId(newWorkItemIds.get(0));
        
        // Submit the request for approval
        Approval.ProcessResult result2 =  Approval.process(req2);
        
        // Verify the results
        System.assert(result2.isSuccess(), 'Result Status:'+result2.isSuccess());
        
        System.assertEquals(
            'Approved', result2.getInstanceStatus(), 
            'Instance Status'+result2.getInstanceStatus());*/
    }
}