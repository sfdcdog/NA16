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
    
    /*
    public static List<String> convertHourstoMinutes(){
    
    }
    */

}