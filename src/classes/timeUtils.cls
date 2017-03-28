/***************************************************************************************************
Class Name: timeUtils
Class Type: Test Class 
Version   : 1.0 
Created Date: 30 Jan 2017
Function    : This class add and subtracts time of two DateTime inputs and returns in minutes. 
Modification Log :
* Developer          Date                   Description
* ----------------------------------------------------------------------------                 
* JRK                01/30/2017             Created
****************************************************************************************************/  
public with sharing class timeUtils {
   
    /***************************************************************************************************
    Method Name: diffMinutes
    Method Type: Integer
    Version     : 1.0 
    Created Date: 30 Jan 2017
    Description:  Gives the difference between two DateTime inputs in Minutes 
    Modification Log :
    * Developer      Date                 Description
    * ----------------------------------------------------------------------------                 
    * JRK            01/30/2017           Created
    ****************************************************************************************************/   
    public static Integer diffMinutes(DateTime dt1, DateTime dt2) {
        
        //Variables Declarations and Initializations
        Integer dt1_year_int = dt1.year(); 
        Integer dt1_day_int = dt1.dayOfYear(); 
        Integer dt1_hour_int = dt1.hour(); 
        Integer dt1_minute_int = dt1.minute(); 
        Integer dt1_second_int = dt1.second(); 
        Integer dt1_in_seconds = (dt1_year_int * 31556926) + (dt1_day_int * 86400) + (dt1_hour_int * 3600) + (dt1_minute_int * 60) + (dt1_second_int * 1); 
        
        Integer dt2_year_int = dt2.year(); 
        Integer dt2_day_int = dt2.dayOfYear(); 
        Integer dt2_hour_int = dt2.hour(); 
        Integer dt2_minute_int = dt2.minute(); 
        Integer dt2_second_int = dt2.second(); 
        Integer dt2_in_seconds = (dt2_year_int * 31556926) + (dt2_day_int * 86400) + (dt2_hour_int * 3600) + (dt2_minute_int * 60) + (dt2_second_int * 1); 
        Integer total_duration_in_seconds=0;

        //Logic
        if(dt2_in_seconds>dt1_in_seconds){
            total_duration_in_seconds = dt2_in_seconds - dt1_in_seconds; 
        }
        else{
            total_duration_in_seconds = dt1_in_seconds - dt2_in_seconds;
        }

        return (total_duration_in_seconds/60) ;
    }
    
   /***************************************************************************************************
    Method Name: addMinutes
    Method Type: Integer
    Version     : 1.0 
    Created Date: 30 Jan 2017
    Description:  Adds the two DateTime inputs in Minutes 
    Modification Log :
    * Developer      Date                 Description
    * ----------------------------------------------------------------------------                 
    * JRK            01/30/2017           Created
    ****************************************************************************************************/
    public static Integer addMinutes(Datetime dt1, Integer mins){
        
        //Variable initialization and Logic
        Integer dt1_year_int = dt1.year(); 
        Integer dt1_day_int = dt1.dayOfYear(); 
        Integer dt1_hour_int = dt1.hour(); 
        Integer dt1_minute_int = dt1.minute(); 
        Integer dt1_second_int = dt1.second(); 
        Integer dt1_in_seconds = (dt1_year_int * 31556926) + (dt1_day_int * 86400) + (dt1_hour_int * 3600) + (dt1_minute_int * 60) + (dt1_second_int * 1); 
        Integer dt1_in_minutes = dt1_in_seconds/60;

        return dt1_in_minutes+mins;
    }
}