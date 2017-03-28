/**
 * Email services are automated processes that use Apex classes
 * to process the contents, headers, and attachments of inbound
 * emails.
 */ 
 //system.debug(''+);
    
global class Example_InboundEmailContactcreate implements Messaging.InboundEmailHandler{
    // Creates new candidate and job application objects     
    Contact[] myContact = new Contact[0];
    Candidate__c[] newCandidate = new Candidate__c[0];
    Job_Application__c[] newJobApplication = new Job_Application__C[0];

    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope){
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();   
        
        // Captures the sender's email address          
        String emailAddress = envelope.fromAddress; 
        
        // Retrieves the sender's first and last names          
        String fName = email.fromname.substring(0,email.fromname.indexOf(' '));
        String lName = email.fromname.substring(email.fromname.indexOf(' '));
        system.debug('@@@'+email.fromname.indexOf(' '));
        system.debug('###'+email.fromname);
        system.debug('$$$'+email);
         
        // Retrieves content from the email.        
        // Splits each line by the terminating newline character        
        // and looks for the position of the phone number and city  
        String[] emailBody = email.plainTextBody.split('\n', 0);
        String phoneNumber = emailBody[0]/*.substring(6)*/;
        String city = emailBody[1]/*.substring(5)*/;
        //When two strings are concatenated
        String assistant = emailBody[2].substringBetween('#','$');
        //When two strings are sent, with new line char between each other
        String department = emailBody[2].substringAfter('$');
        String description = emailBody[3].substringAfter('%');
         
        // Creates a new candidate from the information             
        // retrieved from the inbound email             
        /*try{
            newCandidate.add(new Candidate__c(email__c = emailAddress,first_name__c = fName,last_name__c = lName,phone__c = phoneNumber,city__c = city));
            insert newCandidate;
        }
        catch (System.DmlException e){
            System.debug('ERROR: Not able to create candidate: ' + e);
        }*/
         
        // // Looks for a job name based on the email subject               
        // // (this example assumes the email subject exactly               
        // // matches an existing job name)             
        // Position__c pos;
        // pos = [select ID from Position__c where name =:email.subject limit 1];
        // ID jobId = pos.ID;
         
        // // Associates the candidate with the job application             
        // newJobApplication.add(new Job_Application__c(Position__c = jobId,candidate__c = newCandidate[0].id));         
        // insert newJobApplication;
        
        // // Searches the email for binary attachments and             
        // // associates them with the job application   
        // if (email.binaryAttachments != null && email.binaryAttachments.size() > 0){
            // for (integer i = 0 ; i < email.binaryAttachments.size() ; i++){
                // Attachment a = new Attachment(ParentId = newJobApplication[0].Id,
                // Name = email.binaryAttachments[i].filename,
                // Body = email.binaryAttachments[i].body);
                // insert a;
            // }
        // }
        
        // Sends the email response     
        try{
        myContact.add(new Contact(FirstName = fName, LastName = lName, Email = emailAddress, Phone = phoneNumber, 
                                  Othercity = city, assistantname = assistant, Department = department, Description = description));
        insert myContact;
        }catch (System.DmlException e){
            System.debug('ERROR: Not able to create Contact: ' + e);
        }
        
        // // Sends an email notification to the applicant      
        // emailHelper.sendEmail(myContact[0].id, newCandidate[0].id); 
        
        return result;
    }   
}