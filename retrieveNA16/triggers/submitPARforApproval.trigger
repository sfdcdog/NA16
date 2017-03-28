trigger submitPARforApproval on MAP__c (after insert) {
    List<Map__c> maplist= new List<Map__C>();
    for(Map__c m: trigger.new){
        if(m.isParRequest__c)
            mapList.add(m);
    }
    ApprovalUtility.submitApprovalRequestForPAR(maplist);
}