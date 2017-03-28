public class Utility_Schema {


    /***************************************************************************************************
    Method Name:  Describe_Function
    Method Type: WFS_Schema_Utility Method 
    Version     : 1.0 
    Created Date: 22 May 2016
    Function    : This method helps in dynamically querying field label, api name, id and formula of any Object inputted as a label
    Input Parameters: None
    Output Parameters: None
    Description:   Utility class to describe object fields
    Used in: creating wrapper class based on the object label given
    Number of Queries Within this Method: 0
    Number of Queries in Loop: 0
    Number of Queries from Called methods:  0
    Modification Log :
    * Developer        Date                   Description
    * ----------------------------------------------------------------------------                 
    * JRK              05/22/2016              Created
    * JRK              05/23/2016              Made modifications for showing Field Ids using Regex Hack and dynamically 
                                               creating Object related HTML field and object setup pages
    ****************************************************************************************************/
    public string obj {
        get;
        set;
    }
    public List < wrpClass > wrpList {
        get;
        set;
    }
    public Boolean errorFound {
        get;
        set;
    }
    public Boolean errorNotFound {
        get;
        set;
    }

    //Constructor
    public Utility_Schema(){
        errorFound = false;
        errorNotFound = true;
    }

    public pagereference Describe_Function() {
        try {

            //Variables
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
                //system.debug('###'+pr);
                string html;
                Blob pageContent = pr.getContent();
                if (pageContent != null) {
                    html = pageContent.toString();
                }
                Matcher macher = Pattern.compile('<a href="/(\\w*)\\?setupid=CustomObjects">(.+?)</a>').matcher(html);
                Matcher macher_DataType = Pattern.compile('<td class=" dataCell  ">L(.+?)</td>').matcher(html);                
                system.debug('!!!!!!'+macher);
                while (macher.find()) {
                    system.debug('###'+macher.group(1)+':'+macher.group(2));
                    String label = macher.group(2);
                    String fldId = macher.group(1);
                    fIdtoLabel.put(label, fldId);
                }
                system.debug('!!!!!!'+macher_DataType);
                while (macher_DataType.find()) {
                    system.debug('$$$$$'+macher_DataType.group(1));//+':'+macher_DataType.group(2)
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
                wrpList.add(new wrpClass(FF.getLabel(), FF.getName(), FF.getType(), FF.getRelationshipName(), FF.getCalculatedFormula(), fIdtoLabel.get(FF.getLabel())));
            }
        } catch (Exception e) {
            errorFound = true;
            errorNotFound = false;
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please input the proper API Name for the object you want to search'));
            return null;
        }
        errorFound = false;
        errorNotFound = true;
        return null;
    }

    //Wrapper class 
    public class wrpClass {
        public string label {
            get;
            set;
        }
        public string apiname {
            get;
            set;
        }
        public Schema.DisplayType type {
            get;
            set;
        }
        public string relationshipname {
            get;
            set;
        }
        public string formula {
            get;
            set;
        }
        public string fieldId {
            get;
            set;
        }

        public wrpClass(string la, string ap, Schema.DisplayType ty, string rn, string fo, string fId) {
            label = la;
            apiname = ap;
            type = ty;
            relationshipname = rn;
            formula = fo;
            fieldId = fId;
        }
    }
}