trigger SendEmailOnOwnerChange on Case (before update) {

        /*Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

        String emailAddr = [select Email from User where Id = :Userinfo.getUserId()].Email;
        //String newOwnerName = [select Name from User where Id = :trigger.new[0].OwnerId].Name;

        String[] toAddresses = new String[] {emailAddr};
        mail.setToAddresses(toAddresses);
        system.debug(' to addresses*****'+toAddresses);

        mail.setSubject('Owner Changed for Account ');

        mail.setPlainTextBody('Owner of Account: ');
        mail.setHtmlBody('Owner of Account: <b>' );

        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });*/
        
        String emailAddr = [select Email from User where Id = :Userinfo.getUserId()].Email;
        
        EmailMessage EM = new EmailMessage();
        
        EM.ToAddress = 'roshan.sfdcdev@gmail.com';
        EM.FromAddress = emailAddr;
        EM.Subject = 'The K';
        EM.HtmlBody = 'I am Legend';
        EM.ParentId = Trigger.New[0].id;
        
        insert EM;
        
}