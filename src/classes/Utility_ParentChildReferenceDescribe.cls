public class Utility_ParentChildReferenceDescribe{


    //Get Parent Objects
    public static List<List<Schema.sObjectType>> getParentReferences(sObject obj){

        List<List<Schema.SObjectType>> pRefs = new List<List<Schema.SObjectType>>();
        Schema.SobjectType x = obj.getSObjectType();
        for(Schema.SobjectField strFld: x.getDescribe().fields.getMap().Values()){
            if(strFld.getDescribe().getType() == Schema.DisplayType.REFERENCE){
                pRefs.add(strFld.getDescribe().getReferenceTo());
                system.debug(strFld.getDescribe().getReferenceTo());
                }
            }
        system.debug('parent object='+pRefs);
        return pRefs;
        
    }

    //get Child Objects
    //Get Parent Objects
    public static List<Schema.SObjectType> getChildReferences(sObject obj){
        Schema.SobjectType x = obj.getSObjectType();
        List<Schema.SObjectType> cRefs = new List<Schema.SObjectType>();
        Schema.DescribeSObjectResult R = x.getDescribe();
        for (Schema.ChildRelationship cr: R.getChildRelationships()) {
            cRefs.add(cr.getChildSObject());
            system.debug('====child object==='+cr.getChildSObject());
        }
        system.debug(cRefs);
        return cRefs;
                
    }
    
}

/*
sObject acc = new Account();    
List<List<Schema.SObjectType>> t = Utility_ParentChildReferenceDescribe.getParentReferences(acc);
system.debug(t);

sObject acc = new Account();    
List<Schema.SObjectType> t = Utility_ParentChildReferenceDescribe.getChildReferences(acc);
system.debug(t);
*/