trigger UpdateAssetsAndSupportedOrgs on MAP__c (after update) {
    List<MAP__c> mList = [select id, Name, MAPProdOrg__c,MAPProdOrg__r.name, isPARRequest__c from MAP__c where id in :trigger.new];
    List<id> mapList= new List<Id>();
    
    for(Map__c m: trigger.new){
        if(trigger.oldMap.get(m.id).isPARRequest__c!=trigger.newMap.get(m.id).isPARRequest__c)
            mapList.add(m.id);
    }    
    List<Product_to_Org_Association_Line_Item__c> mapLineItemsList = [select id, OPA_Product__c, account__c, OPA_Product__r.Name,contact__c,Map__c, MAP__r.MAPProdOrg__r.name from Product_to_Org_Association_Line_Item__c where map__r.id in :mapList];
    List<Asset> assetList = new List<Asset>();
    /*List<Supported_Product__c> supProdList = new List<Supported_Product__c>();
    List<Supported_Product__c> avlSupProdList = [Select id,Product__c, Product_Organization__c, product__r.id from Supported_Product__c where Product_Organization__c in :prodOrgSet];
    Map<Id,List<Id>> avlSupProdListMap = new Map<Id, List<Id>>();
    for(Id orgId: prodOrgSet){
        List<id> spList = new List<Id>();
        for(Supported_Product__c sp: avlSupProdList){
            if(sp.Product_Organization__c == orgId){
                spList.add(sp.product__c);
            }
        }
        avlSupProdListMap.put(orgId, spList);
    }*/
    for(Product_to_Org_Association_Line_Item__c m: mapLineItemsList ){
        
        //If Map record in transaction contains Account add asset at Account Level
            if(m.Account__c!=null || m.Contact__c!=null){
                Asset ast = new Asset();
                ast.Product2Id= m.OPA_Product__c;
                ast.name = m.OPA_Product__r.Name;
                ast.Product_Organization__c = m.MAP__r.MAPProdOrg__r.name;
                ast.Product_Org1__c= m.MAP__r.MAPProdOrg__c;
                if(m.account__c!=null)
                    ast.accountid = m.account__c;
                else
                    ast.contactid = m.contact__c;
                assetList.add(ast);
            }
        }
        /*if(avlSupProdListMap.get(m.MAPProdOrg__c)!=null){
            Integer count=0;
            List<Id> avlProdIdList = avlSupProdListMap.get(m.MAPProdOrg__c);
            for(id prodId: avlProdIdList){
                if(m.product__c == prodId){
                    break;
                }
                count++;
            }
            if(count==avlProdIdList.size()){
                Supported_Product__c supProd = new Supported_Product__c();
                supProd.Name = m.product__r.Name;
                supProd.product__c = m.product__c; 
                supProd.Product_Organization__c = m.MAPProdOrg__c;
                supProdList.add(supProd);           
            }
            
        }*/
     
    
    //insert supProdList;
    if(assetList.size()>0)
        insert assetList;
}