public class AccountSelectClassControllerR {
/*
public class AccountSelectClassController {

    //Our collection of the class/wrapper objects wrapAccount
    public List<wrapAccount> wrapAccountList {get; set;}
    public Set<Account> selectedAccounts{get;set;}
    public boolean showContactFlag{get;set;}
    public boolean showProductFlag{get;set;}
    public boolean showAccountFlag{get;set;}
    public List<SelectedContact> myContactList{get;set;}
    public List<Account> acctList{get;set;}
    public String searchText{get;set;}
    public String selectedOrg{get;set;}
    public String engagementType{get;set;}
    public product_organization__c prodOrg{get;set;}
    public String searchTextProd{get;set;}
    public List<SelectedProduct> productList;  
    public Map__c map1{get;set;}
    public List<String> selectetype{get;set;}
    public String searchTxt;
    public String AccountListQuery;
    public List<Contact> conList;
    public List<SelectOption> productTypes{get;set;}
    public String selectedProdType{get;set;}
    public List<SelectOption> prodOrgTypes{get;set;}
    public String selectedProdOrgType{get;set;}
    public Set<Contact> contactsSelected;
    public String selectedProductOrganization{get;set;}
    public List<SelectOption>OrgTypes{get;set;}
    public Boolean flag{get;set;}
    //public List<String> SlctdProdOrgType{get;set;}
    //public List<Product_Organization__c> prdorg{get;set;}
    
    public AccountSelectClassController(){
    
           //commentthis flag=true;
            if(productTypes=='Map'){
                flag=false;
            } comment this//
            showContactFlag=false;
            showAccountFlag=true;
        selectedAccounts = new Set<Account>();  
        contactsSelected = new Set<Contact>(); 
        
        productTypes = new List<SelectOption>();
        productTypes.add(new SelectOption('Map','Create Map'));
        productTypes.add(new SelectOption('Par','Create Par'));
       
        
        prodOrgTypes = new List<SelectOption>();        
        List<Product_Organization__c> porglist = [Select id,name  from Product_Organization__c];        
        for(Product_Organization__c prdorg: porglist){
           prodOrgTypes.add(new SelectOption(prdorg.id,prdorg.name));
        }
        engagementType = ApexPages.currentPage().getParameters().get('eType');
        String userId = UserInfo.getUserId();
        //AccountListQuery = 'select id,name from account limit 1';
        if(ApexPages.currentPage().getParameters().get('id')!=null){
            prodOrg = [select id,name from product_organization__c where id = :ApexPages.currentPage().getParameters().get('id')];
             selectedOrg= prodOrg.name;
    }
    }
   
   
    
    public void searchAccounts(){
           searchTxt = '%'+searchText+'%';
        acctList = [select id, name from Account where name like :searchTxt]; //acctList = [select id, name from Account where name like :(searchTxt and wrapAccountList) ];
        AccountListQuery ='select id, name from Account where name like \''+searchTxt+'\''; 
        standardSetCon =null; 
        
    }
    
    public List<wrapAccount> getpaginated(){
        
           wrapAccountList = new List<wrapAccount>();
            
            if(searchTxt!=null)
            {
                if(selectedAccounts!=null){
                    for(Account a : selectedAccounts){
                      wrapAccount wAct = new wrapAccount();
                      wAct.selected=true;
                      wAct.acc=a;
                      wrapAccountList.add(wAct);
                    }
                }
                for(Account a: (List<Account>)standardsetcon.getrecords())
                { 
                    if(!selectedAccounts.contains(a)){
                        wrapAccount wAct = new wrapAccount();
                      wAct.selected=false;
                      wAct.acc=a;
                      wrapAccountList.add(wAct);
                      }
                      //comment this
                      else
                      {
                          wrapAccount wAct = new wrapAccount();
                          wAct.selected=false;
                          wAct.acc=a;
                          wrapAccountList.add(wAct);
                      }
                      comment this//
                        
                }
               return wrapAccountList; 
            
           
            
        }else
            return null;
        
        
    }

    
    
    public ApexPages.StandardSetController standardSetCon {
        get {
            if(standardSetCon == null && AccountListQuery!=null) {
                standardSetCon = new ApexPages.StandardSetController(Database.getQueryLocator(AccountListQuery));
                // sets the number of records in each page set. Total of 10000 pages can be used
                standardSetCon.setPageSize(7);
               
            }
            return standardSetCon;
        }
        set;
    }
 
    public void processSelected() {
    //selectedAccounts = new set<Account>();
 
        for(wrapAccount wrapAccountObj : wrapAccountList) {
            if(wrapAccountObj.selected == true) {
                selectedAccounts.add(wrapAccountObj.acc);
            }
            else{
               if(selectedAccounts.contains(wrapAccountObj.acc))
                   selectedAccounts.remove(wrapAccountObj.acc);
               }
        }
    }
    
    public void processSelectedContacts() {
    //selectedAccounts = new set<Account>();
 
        for(SelectedContact selCon: myContactList) {
            if(selCon.selected == true) {
                contactsSelected.add(selCon.con);
            }
            else{
               if(contactsSelected.contains(selCon.con))
                   contactsSelected.remove(selCon.con);
               }
        }
    }
    public Apexpages.StandardSetController stdsetCon{
    get{
        if(stdsetCon==null){
            List<Contact> contactset=new List<Contact>();
            List<Contact> listofcontacts= [select id,name,Account.name from contact where accountid in:selectedAccounts];
            List<User> ipsUsers =[select id,contactid,contact.accountid, name from user where usertype='PowerCustomerSuccess' and userroleid!=null and contactid in:listofcontacts];
            for(Contact singlecontact: listofContacts){
               for(user ipsuser: ipsUsers){
                   if(ipsuser.contactid==singlecontact.id){
                       contactset.add(singleContact);
                   }
               }
            }
            stdSetCon = new ApexPages.StandardSetController(contactset);
            stdsetCon.setPageSize(5);
        }
       return stdsetCon;
    }
     set;
    }
    
   
    
    public String seeTest{get;set;}
    public List<SelectedContact> getMyContacts(){
    seeTest='test';
    
    if(selectedAccounts!=null){
           // conList = [select id,name, LastName,Account.Name from contact where Accountid in:selectedAccounts];
        mycontactList = new List<SelectedContact>();
        for(contact con:(List<contact>)stdsetCon.getrecords())
        {
            if(contactsSelected.contains(con)){
                SelectedContact selCon = new SelectedContact();
                selCon.selected=true;
                selCon.con=con;
                mycontactList.add(selCon);
            }
            else{
                SelectedContact selCon = new SelectedContact();
                selCon.selected=false;
                selCon.con=con;
                mycontactList.add(selCon);
            }
        }
        return mycontactList;
       } else
            return null;
        
        
    }
   public ApexPages.StandardSetController standardSetproduct {
        get {
            if(standardSetproduct  == null && prodList!=null) {
                standardSetproduct = new ApexPages.StandardSetController(prodList);
                // sets the number of records in each page set. Total of 10000 pages can be used
                standardSetproduct .setPageSize(5);
               
            }
            return standardSetproduct;
        }
        set;
    }         
    public List<Product2> prodList;  
    public List<Id> prodIdList = new List<Id>();
    public List<Supported_Product__c> supProds;
    public List<id> eProdIdList= new List<Id>();
    public Map<Id, Set<SelectOption>> prodOrgsMap; 
   public void searchProducts(){
        String searchTxt = '%'+searchTextProd+'%';
        //String searchCriteria = ApexPages.currentPage().getParameters().get('searchCriteria');
        
        
    
       if(selectedProdType=='Map')
           supProds = [select id, Product__c, Product_Organization__c,product__r.name, product__r.description, product__r.id from Supported_Product__c where product__r.name like :searchTxt and product_organization__c = :selectedProdOrgType limit 100];
       else
           supProds = [select id, Product__c, Product_Organization__c,Product_Organization__r.id, Product_Organization__r.Name,product__r.name, product__r.description, product__r.id from Supported_Product__c where product__r.name like :searchTxt order by product__r.name limit 100];                
                for(Supported_Product__c sp:supProds)
                {
                prodIdList.add(sp.product__r.id);
            }
            prodList = [select id, name,Description from product2 where id in :prodIdList];
   if(selectedProdType=='PAR'){
                prodOrgsMap = new Map<Id, Set<SelectOption>>();
                for(integer i=0;i<supProds.size();){
                    Set<SelectOption> selOptList = new Set<SelectOption>();
                    selOptList.add(new SelectOption(supProds[i].Product_Organization__r.id,supProds[i].Product_Organization__r.Name));
                    integer j = i+1;
                    for(;j<supProds.size();j++){
                        if(supProds[i].product__r.id==supProds[j].product__r.id){
                            selOptList.add(new SelectOption(supProds[j].Product_Organization__r.id,supProds[j].Product_Organization__r.Name));
                            continue;
                        }
                        break;
                   }
                   prodOrgsMap.put(supProds[i].product__r.id,selOptList);
                   i=j;
                  
                }
            }
        //comment this
        productList = new List<SelectedProduct>(); 
        
        for(product2 prod:(List<product2>)standardSetproduct.getRecords()){
            SelectedProduct selProd = new SelectedProduct();
            selProd.selected=false;
            selProd.prod=prod;
            
            if(selectedProdType=='PAR'){
                Set<SelectOption> prodOrgsSet = new Set<SelectOption>();
                prodOrgsSet= prodOrgsMap.get(prod.id);
                List<SelectOption> progOrgsList = new List<SelectOption>();
                progOrgsList.addAll(prodOrgsSet);
                selProd.prodOrgs = progOrgsList;
        }
   productList.add(selProd);
   }comment this//
   }
   public List<SelectedProduct> getProductList(){
       productList = new List<SelectedProduct>(); 
        if(standardSetproduct!=null){
        for(product2 prod:(List<product2>)standardSetproduct.getRecords()){
            SelectedProduct selProd = new SelectedProduct();
            selProd.selected=false;
            selProd.prod=prod;
            
            if(selectedProdType=='PAR' && prodOrgsMap!=null){
                Set<SelectOption> prodOrgsSet = new Set<SelectOption>();
                prodOrgsSet= prodOrgsMap.get(prod.id);
                List<SelectOption> progOrgsList = new List<SelectOption>();
                progOrgsList.addAll(prodOrgsSet);
                selProd.prodOrgs = progOrgsList;
        }
       productList.add(selProd);
       }
       }
       return productList;
   }
 public Pagereference createMap(){
        List<Account> selectedAccountList = new List<Account>();
        List<Product_to_Org_Association_Line_Item__c> mapLineItems = new List<Product_to_Org_Association_Line_Item__c>();
        if(wrapAccountList!=null && wrapAccountList.size()>0)
        {
            for(wrapAccount selAct:wrapAccountList){
                if(selAct.selected){
                    selectedAccountList.add(selAct.acc);
                }
            }
        }
        List<Product2> selectedProdList = new List<Product2>();
        if(productList!=null && productList.size()>0)
        {
            for(SelectedProduct selProd:productList){
                if(selProd.selected){
                    selectedProdList.add(selProd.prod);
                }
            }
        }
        
        List<Contact> cList = new List<Contact>();
        if(mycontactList!=null && mycontactList.size()>0)
        {
            for(SelectedContact selCon: mycontactList){
                if(selCon.selected){
                    cList.add(selCon.con);
                }
            }
        }
        if(map1==null){
            map1 = new Map__c();
            //Product_Organization__c prodOrg= [select id from Product_Organization__c where name = :selectedProdOrgType limit 1];
            map1.MAPProdOrg__c = selectedProdOrgType;
            insert map1;
        }
        Set<ID> selectedConAccIds = new Set<Id>();
        for(Contact con : contactsSelected){
            selectedConAccIds.add(con.AccountId);
        }
        for(Account acc:selectedAccountList){
            System.debug('*****coming to selectedAccountList***********');
            if(!selectedConAccIds.contains(acc.id)){
                for(SelectedProduct selProd:productList){
                    System.debug('*****coming to productList***********');
                    if(selProd.selected){
                        System.debug('*****coming to product if condition***********');
                        Product_to_Org_Association_Line_Item__c lineItem = new Product_to_Org_Association_Line_Item__c();
                        lineItem.account__c = acc.Id;
                        lineItem.OPA_Product__c = selProd.prod.Id;
                        //lineItem.isParEnabled__c = selProd.isParEnabled;
                        //lineItem.autoGrant__c= selProd.autoGrant;
                        lineItem.Map__c = map1.id;
                        mapLineItems.add(lineItem);
                    }
                }
            }
        }
        
        for(Contact con:contactsSelected){
            for(SelectedProduct selProd:productList){
                if(selProd.selected){
                    Product_to_Org_Association_Line_Item__c lineItem = new Product_to_Org_Association_Line_Item__c();
                    lineItem.contact__c = con.Id;
                    lineItem.OPA_Product__c = selProd.prod.Id;
                    //lineItem.isParEnabled__c = selProd.isParEnabled;
                    //lineItem.autoGrant__c= selProd.autoGrant;
                    lineItem.Map__c = map1.id;
                    mapLineItems.add(lineItem);
                }
            }
        }
        if(selectedProdType=='MAP'){
            insert mapLineItems;
        }else{
        }
        return new PageReference('/'+selectedProdOrgType);
    }
        
    
   public PageReference createPARRequest(){
      try{
        System.debug('Inside Create PAR');
        List<Account> selectedAccountList = new List<Account>();
        List<Product_to_Org_Association_Line_Item__c> mapLineItems = new List<Product_to_Org_Association_Line_Item__c>();
        if(wrapAccountList!=null && wrapAccountList.size()>0)
        {
            for(wrapAccount selAct:wrapAccountList){
                if(selAct.selected){
                    selectedAccountList.add(selAct.acc);
                }
            }
        }
        
        List<Contact> cList = new List<Contact>();
        if(mycontactList!=null && mycontactList.size()>0)
        {
            for(SelectedContact selCon: mycontactList){
                if(selCon.selected){
                    cList.add(selCon.con);
                }
            }
        }
        
        List<Product2> selectedProdList = new List<Product2>();
        Map<String, list<SelectedProduct>> selectedProdListByOrg = new Map<String, list<SelectedProduct>>();
        Map<String,Id> poIdByName = new Map<String,Id>();
        Map<String, id> mapIdbyPO = new Map<String,Id>();
        if(productList!=null && productList.size()>0)
        {
            Set<String> distinctProdOrgSet = new Set<String>();
            for(SelectedProduct selProd:productList){
                if(selProd.selected)
                    distinctProdOrgSet.add(selProd.selectedProductOrganization);
            }
            System.debug('Distinct Product orgs'+distinctProdOrgSet);
            List<Product_organization__c> orgList = [select id, name from product_organization__c where id in :distinctProdOrgSet];
            List<Map__c> mapList = new List<map__c>();
            System.debug('product organization by Name:'+poIdByName);
            for(Product_organization__c org:orgList){
                poIdByName.put(org.name,org.id);
                Map__c map1 = new Map__c();
                map1.MAPProdOrg__c= org.id;
                map1.isPARRequest__c= true;
                map1.type__c='PAR';
                insert map1;
                mapIdbyPO.put(org.id,map1.id);
            }
            System.debug('product organization by Name:'+poIdByName);
            System.debug('product organization by Map:'+mapIdbyPO);
            System.debug('MapIdByPO:'+mapIdbyPO);
            
            for(String po:distinctProdOrgSet){
                List<SelectedProduct> selProdList = new List<SelectedProduct>();
                for(SelectedProduct selProd2:productList){
                    if(selProd2.selectedProductOrganization == po){
                        selProdList.add(selProd2);
                    }
                }
                selectedProdListByOrg.put(po,selProdList);
            }
        }
        
        
        
        System.debug('PO Id By Name'+poIdByName+'Map Id By Name'+mapIdbyPO);
        for(Account acc:selectedAccountList){
            for(String po:selectedProdListByOrg.keySet()){
                for(SelectedProduct selProd:selectedProdListByOrg.get(po)){
                    if(selProd.selected){
                        Product_to_Org_Association_Line_Item__c lineItem = new Product_to_Org_Association_Line_Item__c();
                        lineItem.account__c = acc.Id;
                        lineItem.OPA_Product__c = selProd.prod.Id;
                        //lineItem.isParEnabled__c = selProd.isParEnabled;
                        //lineItem.autoGrant__c= selProd.autoGrant;
                        
                        System.debug('PO:'+po+'Map Id:'+mapIdbyPO.get(po));
                        lineItem.Map__c = mapIdbyPO.get(po);
                        mapLineItems.add(lineItem);
                    }
                }
            }
        }
        
        for(Contact con:cList){
            for(String po:selectedProdListByOrg.keySet()){
                
                for(SelectedProduct selProd:selectedProdListByOrg.get(po)){
                    if(selProd.selected){
                        Product_to_Org_Association_Line_Item__c lineItem = new Product_to_Org_Association_Line_Item__c();
                        lineItem.contact__c = con.Id;
                        lineItem.OPA_Product__c = selProd.prod.Id;
                        //lineItem.isParEnabled__c = selProd.isParEnabled;
                        //lineItem.autoGrant__c= selProd.autoGrant;
                        System.debug('PO:'+po+'Map Id:'+mapIdbyPO.get(po));
                        lineItem.Map__c = mapIdbyPO.get(po);
                        mapLineItems.add(lineItem);
                    }
                }
            }
        }
        System.debug('Map Line Items:'+mapLineItems);
        insert mapLineItems;
        }catch(Exception e){
           ApexPages.Message myMsg= new ApexPages.Message(ApexPages.Severity.ERROR,'error on page:'+e);//Same old drama 
            ApexPages.addMessage(myMsg);
        }
        
        return new Pagereference('/home/home.jsp');
    }    
    
    public void contactpage(){
     
     
    stdsetCon=null;
    showAccountFlag=false;
    showContactFlag=true;
    }
    
    public void productspage(){
    
        showAccountFlag=false;
        showProductFlag=true;
        showContactFlag=false;
        
    }
    // This is our wrapper/container class. In this example a wrapper class contains both the standard salesforce object Account and a Boolean value
    public class wrapAccount {
        public Account acc {get; set;}
        public Boolean selected {get; set;}
 
       
    }
    public class SelectedContact{
        public boolean selected{get;set;}
        public contact con{get;set;}
    }
    public class SelectedProduct{
        public boolean selected{get;set;}
        public product2 prod{set;get;}
       //public boolean isParEnabled{get;set;}
        //public boolean autoGrant{get;set;}
        public String selectedProductOrganization{get;set;}
        public List<SelectOption> prodOrgs{get;set;}
    }


public void backToAccountScreen(){
    showAccountFlag=true;
    showContactFlag=false;
    showProductFlag=false;
}
public void backToContactScreen(){
    showAccountFlag=false;
    showContactFlag=true;
    showProductFlag=false;
}
}
*/

}