trigger TesforBeforeInsertIssue on Supported_Product__c (before Insert) {
    
    if(Trigger.IsBefore){
        if(Trigger.IsInsert){
            
            Set<Id> prodIds = new Set<Id>();
            Set<Id> prodOrgIds = new Set<Id>();
            
            for(Supported_Product__c supProd: Trigger.New){
                prodIds.add(supProd.Product__c);
                prodOrgIds.add(supProd.Product_Organization__c);
            }
            
            List<Supported_Product__c> existingSupProds = [SELECT id, Product__c, Product_Organization__c FROM Supported_Product__c WHERE Product__c IN: prodIds AND Product_Organization__c IN: prodOrgIds];
            
            for(Supported_Product__c supProd: Trigger.New){
                for(Supported_Product__c existingSupProd: existingSupProds){
                    system.debug('Exisitng SupProd : New SupProd = '+existingSupProd.Id+' : '+supProd.Id);
                    system.debug('Exisitng Prod : New Prod = '+existingSupProd.Product__c+' : '+supProd.Product__c);
                    system.debug('Exisitng ProdOrg : New ProdOrg = '+existingSupProd.Product_Organization__c+' : '+supProd.Product_Organization__c);
                    if(existingSupProd.Product__c == supProd.Product__c && existingSupProd.Product_Organization__c == supProd.Product_Organization__c){
                        supProd.addError('Cant add');
                    }
                }
            }
                
        }
    }
    
}