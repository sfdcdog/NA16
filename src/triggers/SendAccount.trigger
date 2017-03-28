trigger SendAccount on Account (after insert){
    for(Account a : Trigger.new){
        SendAccountUsingRESTAPI.callcreateAcc(a.Name, a.Id);
    }
}