@RestResource(urlMapping='/objectDescribeResult/*')
global with sharing class RESTObjectDescribe {

    global static List<wrpClass> wrpList;

    @HttpGet    
    global static List<wrpClass> getObjectDescribeResult() {
        try {
            //Variables
            String obj = RestContext.request.params.get('objectAPI');
            List < String > fieldlist = new List < String > ();
            Map < String, Schema.SObjectType > gd = Schema.getGlobalDescribe();
            Schema.SObjectType sobjType = gd.get(obj);
            Schema.DescribeSObjectResult describeResult = sobjType.getDescribe();
            String prefix = describeResult.getKeyPrefix();
            Map < String, Schema.SObjectField > fieldsMap = describeResult.fields.getMap();
            wrpList = new List < wrpClass > ();
            String customSuffix = '__c';
            String objLabel = describeResult.getLabel();
            String objId = DescribeCustomObject.getCustomObjectId(objLabel);
            Map < String, String > fIdtoLabel = new Map < String, String > ();
            String stdObjectPageUrl = '/p/setup/layout/LayoutFieldList?type=';

            //Mapping field ids to field Labels
            if (obj.contains(customSuffix)) {
                PageReference pr = new PageReference('/' + objId + '?setupid=CustomObjects');
                string html;
                Blob pageContent = pr.getContent();
                if (pageContent != null) {
                    html = pageContent.toString();
                }

                Matcher macher = Pattern.compile('<a href="/(\\w*)\\?setupid=CustomObjects">(.+?)</a>').matcher(html);

                while (macher.find()) {
                    system.debug('###' + macher.group(1) + ':' + macher.group(2));
                    String label = macher.group(2);
                    String fldId = macher.group(1);
                    fIdtoLabel.put(label, fldId);
                }

            } else {
                PageReference pr = new PageReference('/p/setup/layout/LayoutFieldList?type=' + objLabel + '&setupid=' + objLabel + 'Fields');
                system.debug('###' + pr);
                string html;
                Blob pageContent = pr.getContent();
                if (pageContent != null) {
                    html = pageContent.toString();
                }
                Matcher macher = Pattern.compile('<a href="/(\\w*)\\?setupid=' + objLabel + 'Fields">(.+?)</a>').matcher(html);
                while (macher.find()) {
                    String label = macher.group(2);
                    String fldId = macher.group(1);
                    fIdtoLabel.put(label, fldId);
                }
            }

            //new instance of wrapper for display the related column data   
            for (string SD: fieldsMap.keyset()) {
                Schema.DescribeFieldResult FF = fieldsMap.get(SD).getdescribe();
                wrpList.add(new wrpClass(FF.getLabel(), FF.getName(), string.valueof(FF.getType()), FF.getRelationshipName(), FF.getCalculatedFormula(), fIdtoLabel.get(FF.getLabel())));
            }
            system.debug('$$$$$' + wrpList);

            
        } catch (Exception e) {

        }
        system.debug('@@@@@@@'+JSON.serialize(wrpList));
        return wrpList;
        
    }

    //Wrapper class 
    global class wrpClass {
        global string label {
            get;
            set;
        }
        global string apiname {
            get;
            set;
        }
        global string type {
            get;
            set;
        }
        global string relationshipname {
            get;
            set;
        }
        global string formula {
            get;
            set;
        }
        global string fieldId {
            get;
            set;
        }

        global wrpClass(string la, string ap, string ty, string rn, string fo, string fId) {
            label = la;
            apiname = ap;
            type = ty;
            relationshipname = rn;
            formula = fo;
            fieldId = fId;
        }
    }
}