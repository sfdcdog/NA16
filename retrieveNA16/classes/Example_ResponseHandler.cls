/***************************************************************************
Name : Response Handler
Created By : Harshit Pandey (hpandey@salesforce.com)
Created Date : August 18, 2014
Description : Response Handler class handle response received on accessing API, w
the operations it supports are related to retrieval of Contacts, we will custom define what we want return through API
when a request is made to pull up contacts
***************************************************************************/
global class Example_ResponseHandler {
    
    //List of custom attributes that we want to check the status of the org
    public String Status {get; set;}
    public List<sObject> Data {get;set;}
    public String Message {get;set;}
    public String ErrorCode {get; set;}
    
    //Check if Object is NULL or Blank
    global static boolean isNotNullOrEmpty(string str){
        return str!=null || !String.isBlank(str); 
    }   
}