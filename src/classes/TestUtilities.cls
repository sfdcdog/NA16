/*****************************************************************************
Created By : Stark Industries
Created Date : 19-August-2015
Note :
TestUtilities Class is the Factory Util class to create all Test records which are needed to test the Apex Codes
Before changing any existing methods, remember that it may impact other test classes which are using it.
Provide proper Naming convention for the Method and variables.
Provide Method level comments and Parameters for every method, so that it will help other developers to use it
******************************************************************************/
@isTest
public class TestUtilities{
    /*****************************************************************************
    Method Info : getAccountRecord Method returns Account Record
    ******************************************************************************/
    public static Account getAccountRecord(){ 
        Account accountRecord = new Account(
            // recordTypeId = schema.sobjecttype.Account.getrecordtypeinfosbyname().get('Intel Account').getRecordTypeId(),
            Name = 'Dell Products',
            Industry = 'Banking',
            BillingCity = 'Delhi',
            BillingCountry = 'USA',
            billingState = 'AK',
            billingStreet = 'Bratislava 1'
          );
        return accountRecord;
    }
    
    /*****************************************************************************
    Method Info : getContact Method returns Contact Record
    ******************************************************************************/
    public static Contact getContact(){  
        Contact contactRecord = new Contact(
            Lastname = 'Dell',
            Email = 'Contact1Dell@gmail.com'
            // recordTypeId = schema.sobjecttype.Contact.getrecordtypeinfosbyname().get('Outlook contact').getRecordTypeId(),
        );
        return contactRecord;
    }
    
    
    public static User getCustomerUser(){
        Set<String> customerUserTypes = new Set<String> {'CSPLiteUser', 'PowerPartner', 'PowerCustomerSuccess',   'CustomerSuccess'};
        Account acc = new Account (
        Name = 'newAcc1',
        BillingCity = 'folsom',
        BillingCountry = 'USA',
        BillingStreet = 'Creek Side Dr'
        );  
        insert acc;
        Contact con = new Contact (
        AccountId = acc.id,
        LastName = 'portalTestUser'
        );
        insert con;
        User thisUser = [ select Id from User where Id = :UserInfo.getUserId() ];
         User newUser;
        System.runAs ( thisUser ) {
        //UserRole ur = [Select PortalType, PortalAccountId From UserRole where PortalType =:'CustomerPortal' limit 1];
        Profile p = [select Id,name from Profile where UserType in :customerUserTypes limit 1];
         
        newUser = new User(
        //UserRoleId = ur.Id,
        profileId = p.id,
        username = 'newUser@yahoo.com',
        email = 'pb@ff.com',
        emailencodingkey = 'UTF-8',
        localesidkey = 'en_US',
        languagelocalekey = 'en_US',
        timezonesidkey = 'America/Los_Angeles',
        alias='nuser',
        lastname='lastname',
        contactId = con.id
        );
        insert newUser;  
        }
        return newUser;
    }
    
     /*****************************************************************************
    Method Info : getCustomerUser Method returns user Record with  profilID
    ******************************************************************************/
      public static User getCustomerUser(string  profileName){
      User thisUser = [ select Id from User where profile.Name = 'System Administrator' and userRoleId != null AND ISActive=true Limit 1];
        Set<String> customerUserTypes = new Set<String> {'CSPLiteUser', 'PowerPartner', 'PowerCustomerSuccess',   'CustomerSuccess'};
        Account acc = new Account (
        Name = 'newAcc1',
        BillingCity = 'folsom',
        BillingCountry = 'USA',
        BillingStreet = 'Creek Side Dr',
        Ownerid =thisUser.id
        );  
        insert acc;
        Contact con = new Contact (
        AccountId = acc.id,
        LastName = 'portalTestUser',
        email = 'pb@ff.com'
        );
        insert con;
        
         User newUser;
        System.runAs ( thisUser ) {
       // UserRole ur = [Select PortalType, PortalAccountId From UserRole where PortalType =:'CustomerPortal' limit 1];
        Profile p =   [select Id,name from Profile where Name = :profileName limit 1];
         system.debug('>>>>>>>>>>>>>>>' + p);
        newUser = new User(
        //UserRoleId = ur.Id,
        profileId = p.id,
        username = 'newUser@yahoo.com',
        email = 'pb@ff.com',
        emailencodingkey = 'UTF-8',
        localesidkey = 'en_US',
        languagelocalekey = 'en_US',
        timezonesidkey = 'America/Los_Angeles',
        alias='nuser',
        lastname='lastname',
        contactId = con.id
        );
        system.debug(newUser);
        insert newUser;  
        system.debug('?>>>>' + newUser);
        }
        return newUser;
    }

 
    /*****************************************************************************
    Method Info : getProduct Method returns Product (Product) Record
    ******************************************************************************/
    public static Product2 getProduct(){
        Product2 productRecord = new Product2(
            Name = 'Haswell EP',           
            IsActive = true
        ); 
        return productRecord;
    }

    
    /*****************************************************************************
    Method Info : getAssetRecord Method returns Asset (Standard Asset object - Intel Product) Record
    ******************************************************************************/
    public static Asset getAssetRecord(){
        Asset AssetRecord = new Asset(
            name = 'Laptop',
            Status = 'Active'
        );
        return AssetRecord;
    }
     
    
    
    /*****************************************************************************
    Method Info : getCase Method returns Case Record
    ******************************************************************************/
    public static Case getCase(){
        Case CaseRecord = new Case(
            Status = 'New',
            Origin = 'Web',
            Priority = 'High',
            Subject = 'TestSubject',
            Description = 'TestDescription'
        );
        return CaseRecord;
    }
    
    /**********************************************************************************
    Method Info : getUser Method returns User Record
    **********************************************************************************/
    // Create Standard profile User
    public static User getUser() {
        profile prof = [select id, name from Profile where name = 'System Administrator' limit 1];
        User userRecord = new User(
            Alias = 'StdUser',
            profileid = prof.id, 
            Email = 'newuser@intel.com', 
            EmailEncodingKey ='UTF-8',
            LastName = 'Testing', 
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            TimeZoneSidKey = 'America/Los_Angeles', 
            UserName = 'newuser@intel.com',
            isActive = true
        );
       return userRecord;
    }
    
    
    // /**********************************************************************************
    // Method Info : getListOfIpsErrorCodes Method returns IPS Error Codes (Core_IPS_Error_Code__c) Record - Custom Setting
    // **********************************************************************************/
    
    // public static List<Core_IPS_Error_Code__c> getListOfIpsErrorCodes(){
        // List<String> ListofIpsErrorCodeNames = new List<String> {'I100','I101','I102','I103','I104','I105','I106','I107','I108','C100','C101','C102','C103','G100','G101','G102','G103','G104','G105','G106'};
        // List<Core_IPS_Error_Code__c> ListofIpsErrorCodes = new List<Core_IPS_Error_Code__c> ();
        // for(Integer i = 0;i < ListofIpsErrorCodeNames.size(); i++){
            // Core_IPS_Error_Code__c  IpsErrorCodes = new Core_IPS_Error_Code__c();
            // IpsErrorCodes.Name = ListofIpsErrorCodeNames.get(i);
            // IpsErrorCodes.Core_Error_Message__c = 'ErrorMessage';
            // IpsErrorCodes.Language__c='EN';
            // IpsErrorCodes.Core_Locale__c = 'EN';
            // ListofIpsErrorCodes.add(IpsErrorCodes);
        // }
        // return ListofIpsErrorCodes;
    // }
    // /**********************************************************************************
    // Method Info : getIPSLabel Method returns IPS Labels (Core_IPS_Labels__c) Record - Custom Setting
    // **********************************************************************************/   
    // public static List<Core_IPS_Labels__c> getIPSLabel(){
        // String entitlementProcessId = Core_IPS_Helper_utility.getIPSLabel('IPS Standard Entitlement Process ID');
        // Map<string,string> MapofIpsLabelNames = new Map<string,string> {'IPS Standard Entitlement'=>'IPS Standard Entitlement','IPS_Case_Status_Investigating'=>'Investigating','IPS Standard Entitlement Process ID'=>'552210000004C9XAAU','AccessLevel_Edit'=>'Edit','CaseCategory'=>'Case Category','CaseCategoryObjectApi'=>'Core_IPS_Product_Issue_Category__c','CaseSubCategory'=>'Case Subcategory','CoreStatus_Active'=>'Active','CoreStatus_Inactive'=>'Inactive','CoreType_Issue_Sub_Category'=>'Issue Sub Category','CoreType_Product'=>'Product','EnvironmentalDetailMasterObjectApi'=>'Core_IPS_Environment_Variables__c','GEC_Status_Approved'=>'Approved','Rowcause_Owner'=>'Owner','RowCause_Team'=>'Team','SubStatus_Investigating'=>'Investigating','SubStatus_Waiting'=>'Waiting','SupportedProductObjectApi'=>'Core_IPS_Supported_Product__c','Assigned_Environment_Variables'=>'Core_IPS_Assigned_Environment_Variables__c','ProjectGroupPrefix'=>'ProjectGroupPrefix','AccessLevel_Read'=>'Read','TimeOfAlertMessageInSeconds'=>'30','Core_IPS_text_255'=>'Text (255)','Core_IPS_textarea_5000'=>'Text Area (5000)','Core_IPS_Picklist'=>'Picklist','Core_IPS_Multi_Select'=>'Multiselect Picklist'};
        // List<string> ListofMapKeys = new List<string>(MapofIpsLabelNames.keySet());
        // List<Core_IPS_Labels__c> ListofIpsLables = new List<Core_IPS_Labels__c> ();
        // for(Integer i = 0;i < ListofMapKeys.size(); i++){
            // Core_IPS_Labels__c  IpsLabels = new Core_IPS_Labels__c();
            // IpsLabels.Name = ListofMapKeys.get(i);
            // IpsLabels.Value__c = MapofIpsLabelNames.get(ListofMapKeys.get(i));
            // ListofIpsLables.add(IpsLabels);
        // }
        // return ListofIpsLables;
    // }
    
    
    
   
    public static Account getAccount(){ 
        Account accountRecord = new Account();
        // accountRecord.recordTypeId = [select id from Recordtype where Developername='Mastered_Account'].id;
        accountRecord.Name = 'Test Account';
        accountRecord.Industry = 'Banking';
        accountRecord.BillingCity = 'Delhi';
        accountRecord.BillingCountry = 'USA';
        accountRecord.billingState = 'AK';
        accountRecord.billingStreet = '10street';
        return accountRecord;
    }
    public static Asset getAsset(){
        Asset assetRecord = new Asset();
        assetRecord.name = 'Laptop';
        assetRecord.Status = 'Active';
    return AssetRecord;
    }
    
    // Bulk Record creation Methods
    /*****************************************************************************
    Method Info : getListOfAccounts Method returns List of Account Records
    ******************************************************************************/
    // public static List<Account> getListOfAccounts(integer NumOfRec){
        
        // List<Account> ListOfAccounts = new List<Account> ();
        // ID recordTypeId = schema.sobjecttype.Account.getrecordtypeinfosbyname().get('Intel Account').getRecordTypeId();
        // UserRole role=new UserRole();
        // role.name='CEO';
        
        // insert role;
       
        // profile prof = [select id, name from Profile where name = 'System Administrator' limit 1];
        // List<user> userList = getListofuser(1);
        // userlist[0].profileid=prof.id;
        // userList[0].userroleid=role.id;
        // userlist[0].username='portal.user@user.com';
        
        // insert userlist;
        
        // for(Integer i=1;i<=NumOfRec;i++){
            // Account accountRecord = new Account(
                // recordTypeId = recordTypeId,
                // ownerid=userlist[0].id,
                // Name = 'Dell Products '+i,
                // Core_Account_Type__c = 'Distributor',
                // Core_Sales_Segment__c = 'Compute',
                // Industry = 'Banking',
                // BillingCity = 'Delhi',
                // BillingCountry = 'USA',
                // billingState = 'AK',
                // billingStreet = 'Bratislava 1',
                // Core_IPS_Active__c = true
            // );
            // ListOfAccounts.add(accountRecord);
        // }
        // return ListOfAccounts;
    // }
    // /*****************************************************************************
    // Method Info : getListOfContact Method returns List of Contact Record
    // ******************************************************************************/
    // public static List<Contact> getListOfContact(integer NumOfRec){
        // List<Contact> ListOfContacts = new List<Contact> ();
        // ID recordTypeId = schema.sobjecttype.Contact.getrecordtypeinfosbyname().get('Outlook contact').getRecordTypeId();
        // User u = [select id from user where usertype='Standard' AND ISActive=true limit 1 ];
        // for(Integer i=1;i<=NumOfRec;i++){
            // Contact contactRecord = new Contact(
                // Lastname = 'Dell',
                // Email = 'Contact1Dell@gmail.com',
                // recordTypeId = recordTypeId,
                // // Core_IPS_Intel_Support_Owner__c=u.id,
                // // Core_IPS_Active__c = true
            // );
            // ListOfContacts.add(contactRecord);
        // }
        // return ListOfContacts;
    // }
    /**********************************************************************************
    Method Info : getListOfUser Method returns User Record
    **********************************************************************************/
    public static List<User> getListOfUser(integer NumOfRec) {
        List<User> ListOfUser = new List<User> ();
        // Commented By Syed - Below Role is inserted and not used anywhere. 
        /* UserRole role = new UserRole();
        role.name='CEO';
        insert role; */
        
        for(Integer i=1;i<=NumOfRec;i++){
            profile prof = [select id, name from Profile where name = 'System Administrator' limit 1];
            User userRecord = new User(
                Alias = 'StdUser',
                profileId = prof.Id, 
                Email = i+'newuser@intel.com', 
                EmailEncodingKey ='UTF-8',
                LastName = 'Testing'+i, 
                LanguageLocaleKey = 'en_US',
                LocaleSidKey = 'en_US',
                TimeZoneSidKey = 'America/Los_Angeles', 
                UserName = i+'newuser@intel.com',
                isActive = true
            );
            ListOfUser.add(userRecord);
        }
       return ListOfUser;
    }
    // /*****************************************************************************
    // Method Info : getListOfCases Method returns Case Record
    // ******************************************************************************/
    // public static List<Case> getListOfCases(integer NumOfRec){
        // List<Case> ListOfCase = new List<Case> ();
        // Map<string,ID> CaseRecordtype = new Map<string,ID>();
        // for(Recordtype Rt:[Select ID,Name from Recordtype where sobjectType = 'Case'])
        // {  
              // CaseRecordtype.put(Rt.Name,Rt.ID);
        // }  
        // for(Integer i=1;i<=NumOfRec;i++){
            // Case CaseRecord = new Case(
                // Status = 'New',
                // Origin = 'Web',
                // Priority = 'High',
                // Subject = 'TestSubject '+i,
                // Description = 'TestDescription',
                // RecordTypeId = CaseRecordtype.get('IPS Case Create')
            // );
            // ListOfCase.add(CaseRecord);
        // }
        // return ListOfCase;
    // }
    
    // /*****************************************************************************
    // Method Info : getAssetList Method returns List of Asset (Standard Asset object - Intel Product) Records
    // ******************************************************************************/
    // public static List<Asset> getAssetList(integer NumOfRec){
        // List<Asset> AssetList = new List<Asset>  ();
        // for(Integer i=1;i<=NumOfRec;i++){
            // Asset AssetRecord = new Asset(
                // name = 'AssetName '+i,
                // Status = 'Active'
            // );
            // AssetList.add(AssetRecord);
        // }
        // return AssetList;
    // }
    // /*****************************************************************************
    // Method Info : getListOfProduct Method returns List Of Product (Product) Records
    // ******************************************************************************/
    // public static List<Product2> getListOfProduct(integer NumOfRec){
        // List<Product2> ListOfProducts = new List<Product2> ();
        // for(Integer i=1;i<=NumOfRec;i++){
            // Product2 productRecord = new Product2(
                // Name = 'Haswell EP '+i,
                // Core_Sales_Visible_Flag__c = false,
                // Core_IPS_Visible_Flag_External__c= true,
                // Core_IPS_Visible_Flag_Internal__c= 'Yes',
                // Core_Product_Org__c = 'IPS',
                // IsActive = true,
                // Core_Unique_ID__c = 'Test'+i
            // );
            // ListOfProducts.add(productRecord);
        // }
        // return ListOfProducts;
    // }
   
    
    
    // /**********************************************************************************
    // Method Info : getListOfTriggerExecutions Method returns Trigger Executions (Core_Trigger_Executions__c) Record - Custom Setting
    // **********************************************************************************/
    // public static List<Core_Trigger_Executions__c> getListOfTriggerExecutions(){
        // List<String> ListofTriggerExecutionMethodNames = new List<String> {'executeCaseAssignmentRule','caseSLAManagement','assignCaseInformation','assignEntitlementToCase','ProvideCaseAccess','provideCaseAccessToCreatedFAE','assignContactRule'};
        // List<Core_Trigger_Executions__c> ListOfTriggerExecutions = new List<Core_Trigger_Executions__c> ();
        // for(Integer i = 0;i < ListofTriggerExecutionMethodNames.size(); i++){
            // Core_Trigger_Executions__c  TriggerExecution = new Core_Trigger_Executions__c();
            // TriggerExecution.Name = ListofTriggerExecutionMethodNames.get(i);
            // TriggerExecution.Core_Active__c = true;
            // TriggerExecution.Core_Class_Name__c ='ClassName';
            // TriggerExecution.Core_Description__c = 'MethodDescription';
            // TriggerExecution.Core_Object__c = 'Account';
            // TriggerExecution.Core_Trigger_Events__c = 'Before Insert';
            // ListOfTriggerExecutions.add(TriggerExecution);
        // }
        // return ListOfTriggerExecutions;
    // }
    
    
    /**********************************************************************************
    Method Info : getAccountsList Method returns List of Acccounts for MAP/PAR Handler Classes testing
    **********************************************************************************/
    public static List<Account> getAccountsList(integer NumOfRec){
        
        List<Account> ListOfAccounts = new List<Account> ();
        // ID recordTypeId = schema.sobjecttype.Account.getrecordtypeinfosbyname().get('Intel Account').getRecordTypeId();

        for(Integer i=1;i<=NumOfRec;i++){
            Account accountRecord = new Account(
                // recordTypeId = recordTypeId,
                Name = 'Dell Products '+i,
                Industry = 'Banking',
                BillingCity = 'Delhi',
                BillingCountry = 'USA',
                billingState = 'AK',
                billingStreet = 'Bratislava 1'
            );
            ListOfAccounts.add(accountRecord);
        }
        return ListOfAccounts;
    }
    
    /**********************************************************************************
    Method Info : getTriggerExecutions Method returns List of Trigger Execution Examples 
    **********************************************************************************/
    public static List<Example_Trigger_Executions__c> getTriggerExecutions(integer NumofRec){
        
        List<Example_Trigger_Executions__c>  TrgExecList = new List<Example_Trigger_Executions__c>();
        
        for(Integer i=1;i<=NumOfRec;i++){
            Example_Trigger_Executions__c TrgExec = new Example_Trigger_Executions__c(
                Name = 'Test'+i,
                Example_TestCheckBox__c = false,
                Example_TestName__c = 'Test'
            );
            TrgExecList.add(TrgExec);
        }
        return TrgExecList;
    }
    
    /*****************************************************************************
    Method Info : getListOfOpportunities Method returns List Of Opportunity Records
    ******************************************************************************/
    public static List<Opportunity> getListOfOpportunities(integer NumOfRec){
        List<Opportunity> ListOfOpportunities = new List<Opportunity> ();
        for(Integer i=1;i<=NumOfRec;i++){
            Opportunity oppsRec = new Opportunity(
                Name = 'Haswell EP '+i

            );
            ListOfOpportunities.add(oppsRec);
        }
        return ListOfOpportunities;
    }
    
    
    
    
    
    
}