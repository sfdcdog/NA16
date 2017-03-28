public with sharing class AccountListAuraController{

    @AuraEnabled
    public static List<Account> getAccounts(){
        return [SELECT Id, Name, Description, Website FROM Account ORDER BY Name];
    }
}
/*
var field = arguments[0],
    $ = skuid.$;

//create a Resource [Snippet] with Location set to "External" and Resource URL set to " /soap/ajax/37.0/apex.js"
var timeZoneNames = sforce.apex.execute("TimeZoneMap", "timeZoneNames", {});
console.log('###' + timeZoneNames);
var timeZoneValues = sforce.apex.execute("TimeZoneMap", "timeZonesValues", {});
console.log('###' + timeZoneValues);

var timezonemap = new Map();
var nameitem, valueitem;
for(nameitem = 0; nameitem < timeZoneNames.length; nameitem++){ 
    for(valueitem = 0; valueitem < timeZoneNames.length; valueitem++){
        if(nameitem == valueitem){
            console.log(timeZoneNames[nameitem]+' : '+timeZoneValues[valueitem]);
            timezonemap.set(timeZoneNames[nameitem], timeZoneValues[valueitem]);
        }
    }
}

//timezonemap.set('America/New_York', '05:00');
console.log('map values' + JSON.stringify(timezonemap));

var userTimezone = skuid.$M('RunningUser').data[0].TimeZoneSidKey;
console.log('%%%' + userTimezone);
var hoursubstring;
var dateSubString;
var minutesubstring;
var finalstring;

var d = new Date();
var x = skuid.time.getSFDateTime(d);
var datetype = skuid.time.makeFormattedDate(x);
var datetimetype = skuid.time.makeFormattedLongDateTime(x);
var SFdatetimetype = skuid.time.parseSFDateTime(x);


var mintoHrs = function(minutes){
    var h = Math.floor(minutes / 60);
    var m = minutes % 60;
        h = h < 10 ? '0' + h : h;
        m = m < 10 ? '0' + m : m;
        return h + ':' + m;
}
console.log(mintoHrs(487));

//check if history record is for long text area 
//If yes, render New_Value_Long_Text__c; else render New_Value__c
if (field.row.Is_Long_Text_History_Record__c) {
    console.log('comes into here');
    field.element.append(field.row.New_Value_Long_Text__c);
} else {
    console.log('comes into here 2');
    console.log('Field Row value: ' + field.row.New_Value__c);
    if(typeof(field.row.New_Value__c) !== 'undefined'){
        var newvaluefield = field.row.New_Value__c;
        var string = newvaluefield.toString();
        console.log('before Value: ' + string);
        var regexp = /[-,:00-99:]/gi;
        var matches_array = string.match(regexp);
        console.log('Type of Array Variable: '+typeof(matches_array));console.log('Array values: '+matches_array);
        if(matches_array){
            console.log('comes here&&&&&&&&&&&&&&&');
            if ((typeof(matches_array) !== "undefined") || (matches_array !== null)){
                console.log('Check for Indexof T: ' + matches_array.toString().indexOf('t'));console.log('Check for indexof 2 :' + matches_array.toString().indexOf('2'));
                var dashindex = matches_array.toString().indexOf('-');
                var semicolindex = matches_array.toString().indexOf(':');
                if (dashindex !== -1 && semicolindex !== -1) {
                    console.log('comes here');
                    if (typeof(string) !== "undefined") {
                        hoursubstring = string.substring(11, 13);
                        dateSubString = string.substring(8, 10);
                        minutesubstring = string.substring(14,16);
                        console.log('Date SubString: '+string.substring(8, 10));
                        console.log('Hour SubString Value: ' + string.substring(11, 13));
                        console.log('Minute SubString Value: ' + string.substring(14, 16));
                        if (userTimezone !== null) {
                            var toreplacedate;
                            var toreplacehour;
                            var toreplaceminute;                        
                            console.log('UserTime Zone Value: ' + userTimezone);
                            console.log('TimeZoneMap Hr Value: ' + timezonemap.get(userTimezone).substring(1,3));
                            console.log('TimeZoneMap Min Value: ' + timezonemap.get(userTimezone).substring(4,6));
                            if(timezonemap.get(userTimezone).substring(0,1) == "-"){
                                console.log('comes in -');
                                toreplacehour = hoursubstring - timezonemap.get(userTimezone).substring(1,3);
                                if(toreplacehour.toString().length < 2){
                                    toreplacehour= "0"+toreplacehour;
                                }
                                console.log('to replace hour: ' + toreplacehour);
                                toreplaceminute = minutesubstring - timezonemap.get(userTimezone).substring(4,6)
                                if(toreplaceminute.toString().length < 2){
                                    toreplaceminute= "0"+toreplaceminute;
                                }
                                console.log('to replace min: ' + toreplaceminute);
                                if(hoursubstring >= '00' && hoursubstring <= '07'){
                                    toreplacedate = dateSubString - 1;
                                    console.log('to replace date: '+toreplacedate);
                                }
                                if(toreplacedate){
                                    console.log('final string no updte:  '+finalstring);
                                    finalstring = string.replace(string.substring(11, 13), toreplacehour);
                                    console.log('final string after hr change:  '+finalstring);
                                    finalstring = finalstring.replace(finalstring.substring(8, 10), toreplacedate);
                                    console.log('final string after date change:  '+finalstring);
                                    finalstring = finalstring.replace(finalstring.substring(14, 16), toreplaceminute);
                                    console.log('final string after min and date change:  '+finalstring);
                                }else{

                                    finalstring = string.replace(string.substring(11, 13), toreplacehour);
                                    console.log('final string updte hr:  '+finalstring);
                                    if(toreplaceminute)
                                    finalstring = finalstring.replace(finalstring.substring(14, 16), toreplaceminute);
                                    console.log('final string updte min:  '+finalstring);
                                }
                            }
                            if(timezonemap.get(userTimezone).substring(0,1) == "+"){
                                console.log('comes in +');
                                toreplacehour = hoursubstring + timezonemap.get(userTimezone).substring(1,3);
                                if(toreplacehour.toString().length < 2){
                                    toreplacehour= "0"+toreplacehour;
                                }
                                console.log('to replace hour: ' + toreplacehour);
                                toreplaceminute = minutesubstring + timezonemap.get(userTimezone).substring(4,6)
                                if(toreplaceminute.toString().length < 2){
                                    toreplaceminute= "0"+toreplaceminute;
                                }
                                console.log('to replace min: ' + toreplaceminute);
                                if(hoursubstring >= '00' && hoursubstring <= '07'){
                                    toreplacedate = dateSubString - 1;
                                    console.log('to replace date: '+toreplacedate);
                                }
                                if(toreplacedate){
                                    console.log('final string no updte:  '+finalstring);
                                    finalstring = string.replace(string.substring(11, 13), toreplacehour);
                                    console.log('final string after hr change:  '+finalstring);
                                    finalstring = finalstring.replace(finalstring.substring(8, 10), toreplacedate);
                                    console.log('final string after date change:  '+finalstring);
                                    finalstring = finalstring.replace(finalstring.substring(14, 16), toreplaceminute);
                                    console.log('final string after min and date change:  '+finalstring);
                                }else{

                                    finalstring = string.replace(string.substring(11, 13), toreplacehour);
                                    console.log('final string updte hr:  '+finalstring);
                                    if(toreplaceminute)
                                    finalstring = finalstring.replace(finalstring.substring(14, 16), toreplaceminute);
                                    console.log('final string updte min:  '+finalstring);
                                }   
                            }                           
                        }
                    }
                    console.log('after value: ' + finalstring);
                    if (finalstring !== null) {
                        newvaluefield = finalstring;
                    }
                }
            }
        }
    }

    console.log('value:' +newvaluefield);
    field.element.append(newvaluefield);
    

}
*/

/*
global class TimeZoneMap{

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
    
    public static List<String> convertHourstoMinutes(){
    
    }

}
*/

/*
<apex:page >
    <script src="../../soap/ajax/39.0/connection.js" type="text/javascript"></script>
    <script src="../../soap/ajax/39.0/apex.js" type="text/javascript"></script>
    <script>
        var sId = sforce.connection.sessionId = '{!GETSESSIONID()}';
        console.log('sid' + sId);
        var timeZoneNames = JSON.stringify(sforce.apex.execute("TimeZoneMap", "timeZoneNames", {}));
        console.log('###' + timeZoneNames);
        var timeZoneValues = JSON.stringify(sforce.apex.execute("TimeZoneMap", "timeZonesValues", {}));
        console.log('###' + timeZoneValues);
    </script>


</apex:page>

}
*/