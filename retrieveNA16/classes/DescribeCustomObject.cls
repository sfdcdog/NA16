public class DescribeCustomObject {
    // Pattern to be searched
    //private static final Pattern OBJECT_PATTERN = Pattern.compile('<a href="/(\\w*)\\?setupid=CustomObjects">(.+?)</a>');
    public static Pattern OBJECT_PATTERN = Pattern.compile('<a href="/(\\w*)\\?setupid=CustomObjects">(.+?)</a>');
    //private static final String CUSTOM_OBJECT_PAGE_URL = '/p/setup/custent/CustomObjectsPage?setupid=CustomObjects';
    public static String CUSTOM_OBJECT_PAGE_URL = '/p/setup/custent/CustomObjectsPage?setupid=CustomObjects';
    
    // Method to get the Custom Object Id
    public static String getCustomObjectId(String custObjName) {
        // Check the parameter
        if(custObjName == null || custObjName == '') {
            return null;
        }
        // find out all listed custom object Ids
        map<String, String> mapCustObjectIds = findObjectIds();
        system.debug('@@@'+mapCustObjectIds);
        String customObjectId = mapCustObjectIds.get(custObjName);
        
        // Find custom object Id
        return customObjectId;
    }
    
    // Method to get the content and prepare map of Custom object with its Salesforce Id
    private static map<String, String> findObjectIds() {
        system.debug('!!!'+OBJECT_PATTERN+':'+CUSTOM_OBJECT_PAGE_URL);
        // PageReference instance. NOTE: the URL is standard and does not supposed to be change between different orgs
        Pagereference pr = new PageReference(CUSTOM_OBJECT_PAGE_URL);
        
        // Get the Page content and store as String
        String htmlContent = pr.getContent().toString();
        
        // Matcher for the defined pattern
        Matcher match = OBJECT_PATTERN.matcher(htmlContent);
        
        // Map to store Object Name with its Salesforce ID 
        map<String, String> mapObjectIds = new map<String, String>();
        // Iterate the matcher and find out the specified pattern
        while(match.find()) {
            // If matched, Add the custom object and Id to the map
            mapObjectIds.put(match.group(2), match.group(1));
        } 
        
        // Return map of Object Ids
        return mapObjectIds;
    }
}