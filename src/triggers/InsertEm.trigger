trigger InsertEm on Case(before Update){

 EmailMessage EM = new EmailMessage();
 
 String emailAddr = [select Email from User where Id = :Userinfo.getUserId()].Email;
 
 EM.FromAddress = emailAddr;
 EM.ToAddress = 'roshan.sfdcdev@gmail.com';
 EM.Subject= 'Kallu Mama';
 EM.HtmlBody= 'Satya';
 EM.Incoming= false;
 EM.ParentId= Trigger.New[0].id;
 //EM.MessageDate= System.today();
 
 insert EM;
 }