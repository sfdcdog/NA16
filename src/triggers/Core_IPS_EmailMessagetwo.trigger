trigger Core_IPS_EmailMessagetwo on EmailMessage ( after insert) {
    
    system.debug('coming here');
    /*EmailMessage data = [SELECT ActivityId,BccAddress,CcAddress,CreatedById,
                        CreatedDate,FromAddress,FromName,HasAttachment,Headers,HtmlBody,Id,Incoming,
                        IsDeleted,IsExternallyVisible,LastModifiedById,LastModifiedDate,MessageDate,
                        ParentId,ReplyToEmailMessageId,Status,Subject,SystemModstamp,TextBody,ToAddress
                         FROM EmailMessage  where id IN: Trigger.New ];
        System.debug('Email Message data'+data);*/
    
List<EmailMessage> EMList = new List<EmailMessage>();
    
    for(EmailMessage EM: Trigger.New){
        EMList.add(EM);
    }
    
    System.debug('List***'+EMList);
}