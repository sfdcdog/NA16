/***************************************************************************************************
Class Name: Example_csvFileReaderController
Class Type: VF Page Controller
Version     : 1.0 
Created Date: 17 June 2016
Function    : This class acts as a Controller for the associated VF Page 
Input Parameters: None 
Output Parameters: None
Description:   Reads CSV File
Used in     : Data import from csv using Visualforce page
Modification Log :
* Developer                   Date                   Description
* ----------------------------------------------------------------------------                 
* JRK                        06/17/2016              Created
****************************************************************************************************/  
public with sharing class Example_csvFileReaderController {
    public Blob csvFileBody {
        get;
        set;
    }
    public string csvAsString {
        get;
        set;
    }
    public String[] csvfilelines {
        get;
        set;
    }
    public String[] inputvalues {
        get;
        set;
    }
    public List < string > fieldList {
        get;
        set;
    }
    public List < account > sObjectList {
        get;
        set;
    }
    public Boolean fileError {
        get;
        set;
    }
    
    /***************************************************************************************************
    Method Name:  Example_csvFileReaderController
    Method Type: Constructor
    Version     : 1.0 
    Created Date: 17 June 2016
    Function    : This method is the constructor which is called on instantiation of the class or when the page is loaded
    Input Parameters: None
    Output Parameters: None
    Description:   This method is the constructor, All variables inside are initialized on page load
    Used in: N/A
    Number of Queries Within this Method: 0
    Number of Queries in Loop: 0
    Number of Queries from Called methods:  0
    Modification Log :
    * Developer        Date                   Description
    * ----------------------------------------------------------------------------                 
    * JRK              06/17/2016              Created
    ****************************************************************************************************/  
    public Example_csvFileReaderController() {
        csvfilelines = new String[] {};
        fieldList = New List < string > ();
        sObjectList = New List < sObject > ();
    }
    
    /***************************************************************************************************
    Method Name:  readcsvFile
    Method Type: Example_csvFileReaderController Method 
    Version     : 1.0 
    Created Date: 17 June 2016
    Function    : This method helps to read the CSV File inputted
    Input Parameters: None
    Output Parameters: None
    Description:   
    Used in: N/A
    Number of Queries Within this Method: 0
    Number of Queries in Loop: 0
    Number of Queries from Called methods:  0
    Modification Log :
    * Developer        Date                   Description
    * ----------------------------------------------------------------------------                 
    * JRK              06/17/2016              Created
    ****************************************************************************************************/  
    public void readcsvFile() {
        if(csvFileBody == null){
            fileError = true;
            try {
                throw new customException('No File Attached');
            } catch(customException ex) {
                SI_Exception_Class.InsertException('NA','Example_csvFileReaderController ','NA', 'readcsvFile',ex);
                System.debug('ERROR'+ex.getMessage());
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'No File Attached - Attach file and click'));             
            }
        }else{
            fileError = false;
            csvAsString = csvFileBody.toString();
            csvfilelines = csvAsString.split('\n');
            inputvalues = new String[] {};
            for (string st: csvfilelines[0].split(','))
                fieldList.add(st);

            for (Integer i = 1; i < csvfilelines.size(); i++) {
                Account accRec = new Account();
                string[] csvRecordData = csvfilelines[i].split(',');
                accRec.name = csvRecordData[0];
                accRec.accountnumber = csvRecordData[1];
                accRec.Type = csvRecordData[2];
                accRec.website = csvRecordData[3];
                accRec.AccountSource = csvRecordData[4];
                sObjectList.add(accRec);
            }
        }
    }
}