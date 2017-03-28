public with sharing class Example_SavePointRollBack {

/*for(Apttus__APTS_Agreement__c agreement : agreementList) {
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.setTemplateId(templtId);
            message.setWhatId(agreement.Id);
            message.setTargetObjectId(con.Id);
            message.setSaveAsActivity(false);
            message.setToAddresses(new String[]{ownerEmailMap.get(agreement.Apttus__Account__r.OwnerId).Email,ownerEmailMap.get(agreement.Apttus__Requestor__c).Email,ownerEmailMap.get(agreement.OwnerId).Email});//,'Salessupport@Dolby.com'});
            messageList.add(message);
        }
        
        Savepoint sp = Database.setSavePoint();
        Messaging.sendEmail(messageList);
        Database.rollback(sp);
        
        for(Messaging.SingleEmailMessage msg : messageList) {
            Messaging.SingleEmailMessage msgToSend = new Messaging.SingleEmailMessage();
            msgToSend.setToAddresses(msg.getToAddresses());
            msgToSend.setPlainTextBody(msg.getPlainTextBody());
            msgToSend.setHTMLBody(msg.getHTMLBody());
            msgToSend.setSubject(msg.getSubject());
            msgToSend.setSaveAsActivity(false);
            msgToSendList.add(msgToSend);
        }
        
        Messaging.sendEmail(msgToSendList);    */

}