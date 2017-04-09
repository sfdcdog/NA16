/*
//JS Snippet
var field = arguments[0],
    $ = skuid.$;

//create a Resource [Snippet] with Location set to "External" and Resource URL set to " /soap/ajax/37.0/apex.js"
var timeZoneNames = sforce.apex.execute("Utility_TimeZoneMap", "timeZoneNames", {});
var timeZoneValues = sforce.apex.execute("Utility_TimeZoneMap", "timeZonesValues", {});

//Creating TimeZone Map [Name for Key; GMT+/- for value]
var timezonemap = new Map();
var nameitem, valueitem;
for(nameitem = 0; nameitem < timeZoneNames.length; nameitem++){ 
    for(valueitem = 0; valueitem < timeZoneNames.length; valueitem++){
        if(nameitem == valueitem){
            timezonemap.set(timeZoneNames[nameitem], timeZoneValues[valueitem]);
        }
    }
}


//User Time Zone [Name]
var userTimezone = skuid.$M('RunningUser').data[0].TimeZoneSidKey;

//Variable declarations
var hoursubstring;
var dateSubString;
var minutesubstring;
var finalstring;
var GMTtype;
var hrValueTZ;
var valueinMinutes;


//Minutes to Hours Converter
var mintoHrs = function(minutes){
    //Additional logic for "GMT -" TZs with "-ve" minute values [used for date change]
    if(minutes.toString().substring(0,1) == '-'){
        //Variable assignment
        var absoluteM = Math.abs(minutes);        
        var subtractedMins = ((24*60) - absoluteM);        
        var h = Math.floor(subtractedMins / 60);        
        var m = subtractedMins % 60;

        //Hour and Min format logic
        h = h < 10 ? '0' + h : h;
        m = m < 10 ? '0' + m : m;
        return h + ':' + m;    
    }else{
        //Variable assignment
        var hrs = Math.floor(minutes / 60);
        var mins = minutes % 60;

        //Hour and Min format logic
        hrs = hrs < 10 ? '0' + hrs : hrs;
        mins = mins < 10 ? '0' + mins : mins;
        return hrs + ':' + mins;    
    }
    
}

//Hours to Minutes Converter
var hrstomins = function(hrsandmins){
    //Gather Hour and Min values seperately
    var hour = hrsandmins.toString().substring(0,2);
    var min = hrsandmins.toString().substring(3,5);

    //Convert to Mins
    var hrstomins = (parseInt(hour)*60) + parseInt(min);
    return hrstomins;
}

//Date change Function
var datechange = function(date, userTZ, timezonemap, hourminutevalue, GMTtype, hrValueTZ){
    //Minute format variables
    var hrTZinMin = parseInt(hrValueTZ)*60;
    var dbtimeInMins = hrstomins(hourminutevalue);

    //For TimeZones behind GMT
    if(GMTtype == '-'){
        if((dbtimeInMins >= 0) && (dbtimeInMins <= (hrTZinMin - 1))){
            date = date - 1;
            //Append 0 to uniform format
            if(date.toString().length < 2){
                date = "0"+date;
            }
        }else{
            date = null;
        }
    }

    //For TimeZones ahead of GMT
    if(GMTtype == '+'){
        if((dbtimeInMins <= 0) && (dbtimeInMins >= (hrTZinMin + 1))){
            date = date + 1;
            //Append 0 to uniform format
            if(date.toString().length < 2){
                date = "0"+date;
            }
        }else{
            date = null;
        }
    }
    return date;
}

//check if history record is for long text area 
//If yes, render New_Value_Long_Text__c; else render New_Value__c
if (field.row.Is_Long_Text_History_Record__c) {
    field.element.append(field.row.New_Value_Long_Text__c);
} else {
    if(typeof(field.row.New_Value__c) !== 'undefined'){
        //Date Field to be converted
        var newvaluefield = field.row.New_Value__c;
        var string = newvaluefield.toString();
        //Using Regular Expression
        var regexp = /[-,:00-99:]/gi;
        var matches_array = string.match(regexp);

        //To enter only if the "New Value" field contains  a value and is not NULL
        if(matches_array){
            if ((typeof(matches_array) !== "undefined") || (matches_array !== null)){
                //Check for "-" and ":" within the string.
                var dashindex = matches_array.toString().indexOf('-');
                var semicolindex = matches_array.toString().indexOf(':');
                // Only enter if the field holds a Date/Time value. 
                if (dashindex !== -1 && semicolindex !== -1) {
                    if (typeof(string) !== "undefined"){
                        //Create substrings of Date, Hour:Minute
                        hoursubstring = string.substring(11, 13);
                        dateSubString = string.substring(8, 10);
                        hourminutesubstring = string.substring(11, 16);
                        //Only enter if UserTZ exists.
                        if (userTimezone !== null) {
                            //Variable declarations
                            var toreplaceminhour;
                            //User TZ value substrings
                            hrValueTZ = timezonemap.get(userTimezone).substring(1,3);                       
                            // Indicates +/- GMT
                            GMTtype = timezonemap.get(userTimezone).substring(0,1);
                            //convert value stored in database to minutes
                            var dbHourtoMin = hrstomins(hourminutesubstring);
                            //convert userTZ value to minutes
                            var userTZHourtoMin = hrstomins(timezonemap.get(userTimezone).substring(1,6));
                            
                            //Process value for "GMT-" TZs
                            if(GMTtype == "-"){
                                valueinMinutes = (dbHourtoMin - userTZHourtoMin);
                            }
                            //Process value for "GMT+" TZs
                            if(GMTtype == "+"){
                                valueinMinutes = (dbHourtoMin + userTZHourtoMin);
                            }
                            //process "to be replaced by" Hour:Minute value 
                            toreplaceminhour = mintoHrs(valueinMinutes);
                            //process "to be replaced by" date value
                            var dateChangeValue = datechange(dateSubString, userTimezone, timezonemap, hourminutesubstring, GMTtype, hrValueTZ)

                            //add either date and hour:minute values to the final version of the string or just hour:minute value.
                            if(dateChangeValue){
                                finalstring = string.replace(string.substring(11, 16), toreplaceminhour);
                                finalstring = finalstring.replace(finalstring.substring(8,10), dateChangeValue);                        
                            }else{
                                finalstring = string.replace(string.substring(11, 16), toreplaceminhour);
                            }                           
                        }
                    }
                    //assign the formatted final value to the date value of the New Value field
                    if (finalstring !== null){
                        newvaluefield = finalstring;
                    }
                }
            }
        }
    }

    field.element.append(newvaluefield);
    

}
*/
global class Utility_TimeZoneMap{

    webservice static List<String> timeZoneNames(){
        Schema.DescribeSObjectResult r = User.sObjectType.getDescribe();
        Map<String,Schema.SObjectField> M = r.fields.getMap();
        Map<Integer,String> pklstvalue = new Map<Integer,String>();
        List<String> pklsts = new List<String>();
        for(String fieldName : M.keySet()){ 
            Schema.SObjectField field = M.get(fieldName);
            Schema.DescribeFieldResult F = field.getDescribe();            
            //A nillable field can have empty content. A isNillable Boolean non-nillable field must have a value for the object to be                       
            //created or saved. 
            // if F.isNillable() is false then field is mandatory
            Boolean isFieldreq  = F.isNillable() ;
            if(isFieldreq == false){
                if(F.getLabel() == 'Time Zone'){
                    integer i = 1;
                    for(Schema.PicklistEntry pklst: F.getPicklistValues()){             
                        system.debug(pklst.getvalue());
                        pklsts.add(pklst.getvalue());
                        i++;         
                    }
                    system.debug('name list'+pklsts);
                } 
            }  
        }
        return pklsts;
    }

    webservice static List<String> timeZonesValues(){
        Schema.DescribeSObjectResult r = User.sObjectType.getDescribe();
        Map<String,Schema.SObjectField> M = r.fields.getMap();
        List<String> pklstValues = new List<String>();
        for(String fieldName : M.keySet()){ 
            Schema.SObjectField field = M.get(fieldName);
            Schema.DescribeFieldResult F = field.getDescribe();            
            Boolean isFieldreq  = F.isNillable() ;
            if(isFieldreq == false){
                if(F.getLabel() == 'Time Zone'){
                    for(Schema.PicklistEntry pklst: F.getPicklistValues()){             
                        system.debug('value list'+pklst.getLabel());
                        system.debug('value list substring'+pklst.getLabel().substring(4,10));
                        pklstValues.add(pklst.getLabel().substring(4,10));      
                    }
                    
                } 
            }  
        }
        return pklstValues;
    }
    
    /*public static List<String> convertHourstoMinutes(){
    
    }*/

}