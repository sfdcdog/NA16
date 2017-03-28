trigger routingTest on Case (before insert,before update) {
    
    
    List<Id> productOrgIds = new List<Id>();
    List<Id> ProductIds = new List<Id>();
    List<Id> assetIds = new List<Id>();
    
    for(Case c : trigger.new){   
      assetIds.add(c.assetId);
    }
    map<Id,Asset> assetMap = new Map<Id,Asset>([select id,Product1__c,Product_Org1__c,AccountId from Asset where id In: assetIds]); 
    Set<Id> QIds = new Set<Id>();
    
    List<QueueSobject> listofQueues = [select id,QueueId,Queue.Name from QueueSObject];
    Map<String,Id> mapQNameWithIds = new Map<String , Id>();
    for(QueueSobject so : listOfQueues){
        mapQNameWithIds.put(so.queue.name,so.queueId);
    }
    List<Routing_Attribute__c> listofnulls = [select Product_Org__c,Has_Null_Attributes__c from Routing_Attribute__c];
    Map<String,Boolean> mapnulls = new Map<String,Boolean>();
    for(Routing_Attribute__c rnull : listofnulls){
        mapnulls.put(rnull.Product_Org__c,rnull.Has_Null_Attributes__c);
    }
    
    List<Routing_Attribute__c> attriblist=[select id,Product_Org__c,Products__c,Queue_Name__c,Account__c,Queue_ID__c,UserName__c,Assign_To_User__c,Has_Null_Attributes__c from Routing_Attribute__c ];//new 
         Map<Id,Product_Org__c> mapProductOrgs = new Map<Id,Product_Org__c>([select id,name from Product_Org__c ]);
         Map<Id,Product2> mapProducts = new Map<Id,Product2>([select id,name from Product2 ]);
         Map<Id,Account> mapAccounts = new Map<Id,Account>([select id,name from Account]);
    //System.debug('mapnulls.get(assetMap.get(cs.AssetId).Product_Org1__c)========='+mapnulls.get(assetMap.get(cs.AssetId).Product_Org1__c));
   for(Case cs : Trigger.New){
        for(Routing_Attribute__c rat : attriblist){
            if((assetMap.get(cs.AssetId).Product_Org1__c==rat.Product_Org__c)  && (((rat.products__c !=null ) && rat.Products__c.contains( mapProducts.get(assetMap.get(cs.AssetId).Product1__c).name)) || (rat.Products__c==null))  && ((rat.Account__c!=null && rat.Account__c.contains( mapAccounts.get(assetMap.get(cs.AssetId).AccountId).name)) || (rat.Account__c==null)) && (rat.Has_Null_Attributes__c==mapnulls.get(assetMap.get(cs.AssetId).Product_Org1__c)) )
                {
                if(rat.Assign_To_User__c==true && rat.UserName__c!=null)
                {
                    cs.ownerId=rat.UserName__c;
                }
                    
                    
                    else {
                        if(mapQNameWithIds.get(rat.Queue_Name__c)!=null)
                        cs.ownerId=mapQNameWithIds.get(rat.Queue_Name__c);
                    }
                    
               }
            
        }
        
    }
    /*
     &&(rat.Has_Null_Attributes__c==false || rat.Has_Null_Attributes__c==true)
       for(Case cs : Trigger.New){
        for(Routing_Attribute__c rat1 : attriblist1){
            if(assetMap.get(cs.AssetId).Product_Org1__c==rat1.Product_Org__c && rat1.Products__c==null &&  rat1.Account__c.contains( mapAccounts.get(assetMap.get(cs.AssetId).AccountId).name))  
                {
                if(rat1.Assign_To_User__c==true && rat1.UserName__c!=null)
                {
                
                    cs.ownerId=rat1.UserName__c;
                }
                else{
                    if(mapQNameWithIds.get(rat1.Queue_Name__c)!=null)
                        cs.ownerId=mapQNameWithIds.get(rat1.Queue_Name__c);
                    }
                
                
            }
            
        }
        
    }
    */
    
   /* List<Id> ProductIds = new List<Id>();
    for(Case c1: trigger.new){
        ProductIds.add(c1.Product1__c);//Product1__c is a lookup field on case; 
    }
    Map<Id,Product2> mapProducts = new Map<Id,Product2>([select id,name from Product2 where id IN: ProductIds]);
    for(Case cs : Trigger.New){
        for(Routing_Attribute__c rat : attriblist){
            if(cs.Product_Org1__c==rat.Product_Org__c && mapProducts.get(cs.Product1__c).name == rat.Products__c ){
                cs.ownerId=rat.Queue_ID__C;*/
   /* System.debug('assetMap value is *********'+assetMap.get(cs.assetId));
            System.debug('assetMap.get(cs.AssetId).Product_Org1__c==========='+assetMap.get(cs.AssetId).Product_Org1__c);
            System.debug('assetMap.get(cs.AssetId).Product1__c========'+assetMap.get(cs.AssetId).Product1__c);
            System.debug('mapProducts ======'+mapProducts);
            System.debug(' mapProducts.get(assetMap.get(cs.AssetId).Product1__c)========'+ mapProducts.get(assetMap.get(cs.AssetId).Product1__c));*/
           
/*

 List<Routing_Attribute__c> prodlist= [select id, Products__c from Routing_Attribute__c WHERE Products__c!=null];
 List<Routing_Attribute__c> acclist= [select id, Account__c from Routing_Attribute__c WHERE Account__c!=null];
 List<Routing_Attribute__c> attriblist=[select id,Product_Org__c,Products__c,Queue_Name__c,Account__c,Queue_ID__c,UserName__c,Assign_To_User__c from Routing_Attribute__c where Products__c=:prodlist OR Products__c=null and Account__c=:acclist OR Account__c=null]; 
   if(assetMap.get(cs.AssetId).Product_Org1__c==rat.Product_Org__c && (rat.Products__c.contains( mapProducts.get(assetMap.get(cs.AssetId).Product1__c).name) || rat.Products__c.contains(null)) )  
               
asset.product- this gives the look up field which holds the id for the product record.
List<Id> AssetIds= new List<Id>();
for(Case c2:trigger.new)
{
  AssetIds.add(c2.Asset);
}

Map<Id,Product2> mapAssettoProducts = new Map<Id,Product2>([select id,name(select id,name from Asset) from asset where id IN: ProductIds]);
    for(Case cs : Trigger.New){
        for(Routing_Attribute__c rat : attriblist){
            if(cs.Product_Org1__c==rat.Product_Org__c && rat.Products__c.contains( mapAssettoProducts.get(cs.Asset.product2).name) ){
List<Id> AssetIds= new List<Id>();
for(Case c2:trigger.new)
{
  AssetIds.add(c2.Asset);
}            

map<id,asset> mapassetrecord=new map<id,asset>([select id,assetname,product2 from Asset where id IN: AssetIds]);
mapassetrecord(cs.asset.Product)
*/
    

    
    
    
/*    
    Set<Id> QIds = new Set<Id>();//stores the queue ids in set
        
    Map<Id,QueueSobject> mapq = new Map<Id,QueueSobject>([select Id,QueueId,Queue.Name from QueueSObject]);
              //this map stores the id,queueid and queue name values  
    public void qmethod()
{
        Qids= mapq.keySet();// queue ids from the map key are passed to Qids variable
        for(Id qid : Qids)//this for loop contains the queue ids
{
            Set<QueueSobject> qrecord = new Set<QueueSobject>();
            qrecord = mapq.get(qid);
for(case c1: trigger.new)
{
              if(qrecord.(queue.name)==rat.Queue_name__c)
              {
               cs.ownerId=qrecord.QueueId;
              }
}
            
          
        }
        
    }   


/*
                if(mapq.get(QueueSobject).name==attriblist.Queue_name__c)
                //queueid=mapqueue.get(QueueSobject).id;*/
               
    
    /*
    
    if(caseattrib[0].Product_Org__c=='DCPAE'&& attriblist.Product_Org__c=='DCPAE'&& caseattrib[0].Products__c==attriblist.Products__c&&caseattrib[0].Account__c==attriblist.Account__c)
    {
       List<Routing_Attribute__c> attribq1=[Select id, Queue_ID__c from Routing_Attribute__c]
        caseattrib[0].ownerid=='attribq1[0].Queue_ID__c'; //the attribq must hold the queue--i.e the queue must be different for each product org. 
         
        
    }
    else if(caseattrib[0].Product_Org__c=='EMBSOFT'&& attriblist.Product_Org__c=='EMBSOFT'&& caseattrib[0].Products__c==attriblist.Products__c&&caseattrib[0].Account__c==attriblist.Account__c)
     {
        List<Routing_Attribute__c> attribq2=[Select id, Queue_ID__c from Routing_Attribute__c]
        caseattrib[0].ownerid=attribq2[0].Queue_ID__c; //the attribq must hold the queue 
        insert caseattrib[0];
    }
    else if(caseattrib[0].Product_Org__c=='EMBSOFTIRC'&& attriblist.Product_Org__c=='EMBSOFTIRC'&& caseattrib[0].Products__c==attriblist.Products__c&&caseattrib[0].Account__c==attriblist.Account__c)
    {
        List<Routing_Attribute__c> attribq3=[Select id, Queue_ID__c from Routing_Attribute__c]
        caseattrib[0].ownerid=attribq3[0].Queue_ID__c; //the attribq must hold the queue 
        insert caseattrib[0];
    }
    else if(caseattrib[0].Product_Org__c=='IOTG'&& attriblist.Product_Org__c=='IOTG'&& caseattrib[0].Products__c==attriblist.Products__c&&caseattrib[0].Account__c==attriblist.Account__c)
    {
        List<Routing_Attribute__c> attribq4=[Select id, Queue_ID__c from Routing_Attribute__c]
        caseattrib[0].ownerid=attribq4[0].Queue_ID__c; //the attribq must hold the queue 
        insert caseattrib[0]; 
    }
    else if(caseattrib[0].Product_Org__c=='ISD'&& attriblist.Product_Org__c=='ISD'&& caseattrib[0].Products__c==attriblist.Products__c&&caseattrib[0].Account__c==attriblist.Account__c)
    {
        List<Routing_Attribute__c> attribq5=[Select id, Queue_ID__c from Routing_Attribute__c]
        caseattrib[0].ownerid=attribq5[0].Queue_ID__c; //the attribq must hold the queue 
        insert caseattrib[0];
    }
Account__c=Sony, Queue_ID__c=00Gj0000001HRAlEAO, Product_Org__c=a0Fj0000002Kh9vEAC, Id=a0Ej0000002xwjDEAQ, Queue_Name__c=Case Routing 1, Assign_To_User__c=false, UserName__c=005j000000AvWW9AAN

List<Routing_Attribute__c> listofnulls = [select id,Has_Null_Attributes__c from Routing_Attribute__c];
    Map<Id,Boolean> mapnulls = new Map<Id,Boolean>();
    for(Routing_Attribute__c rnull : listofnulls){
        mapnulls.put(rnull.id,rnull.Has_Null_Attributes__c);
    }
&&(rat.Has_Null_Attributes__c.contains(mapnulls.get(rat.id))
*/
    }