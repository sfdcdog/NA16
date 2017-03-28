trigger CaseRouting on Case (after insert,after update)
{
Map<Id,List<Case_Routing_Rules__c>> CaseRoutingMap = new Map<Id,List<Case_Routing_Rules__c>>();
Map<id,id> Case_ProductMap = new Map<id,id>();
List<Case> caseList;
System.debug('Utility Flag:'+utility.routingFlag);
if(!utility.routingFlag){
caseList = [select asset.name, Asset.Product_Org1__c,Case_Routing_Rule__c, Asset.Product_Org1__r.Name, priority, status, casenumber, id, accountId, account.Name,assetId from Case where id in :trigger.new];
for(Case cs:caseList)
{
    Case_ProductMap.put(cs.id,cs.asset.Product_Org1__c);
}
System.debug('Case_ProductMap:'+Case_ProductMap);
System.debug('caseList'+caseList);
List<Case_Routing_Rules__c> caseRoutingrecords = [select id,Product_Organization__c,OwnerId__c,Routing_Rule_Aggregate__c,Product__c,Priority__c,Queue_Name__c,UserName__c,Assign_To_User__c,Account__c from Case_Routing_Rules__c where Product_Organization__c IN: Case_ProductMap.values() Order By FieldCount__c Desc];
for(Case_Routing_Rules__c cr:caseRoutingrecords){
    List<Case_Routing_Rules__c> crrecords = new List<Case_Routing_Rules__c>();
    if(CaseRoutingMap.containskey(cr.Product_Organization__c))
    {
        crrecords = CaseRoutingMap.get(cr.Product_Organization__c);
        crrecords.add(cr);
    }
    else{
        crrecords.add(cr);
    }
    CaseRoutingMap.put(cr.Product_Organization__c,crrecords);   
}
System.debug('CaseRoutingMap:'+CaseRoutingMap);
for(Case cs:caseList){
    boolean ownermatch =false;
        System.debug('cs.asset.Product_Org1__c:'+cs.asset.Product_Org1__c);
        if(CaseRoutingMap.containskey(cs.asset.Product_Org1__c)){
        for(Case_Routing_Rules__c cr : CaseRoutingMap.get(cs.asset.Product_Org1__c)){
            boolean match = true;
            List<string> routingvalues = cr.Routing_Rule_Aggregate__c.split('~');
            Map<string,string> crvalues = new Map<string,string>();
            for(String str: routingvalues){
                List<string> fieldvalues = str.split('=');
                if(fieldvalues.size()==2)    
                crvalues.put(fieldvalues[0],fieldvalues[1]);
            }
            system.debug('@@@@@'+crvalues);
            for(string str:crvalues.keyset()){
                System.debug('String Entry:'+str);
                if(str.contains('.')){
                    List<String> strSplit = new List<String>();
                    strSplit=str.split('\\.');
                    List<String> rValues = new List<String>();
                    if(crValues.get(str).contains(';')){
                        rValues = crValues.get(str).split('\\;');
                    }else{
                        rValues.add(crValues.get(str));
                    }
                    Integer count=rValues.size();
                    for(String r:rValues){
                        if(!String.valueof(cs.getSobject(strSplit[0]).get(strSplit[1])).equalsignorecase(r)){
                            count--;
                            continue;
                        }
                    }
                    if(count==0){
                        match=false;
                        break;
                    }        
                }else if(cs.get(str)!=null){
                    List<String> rValues = new List<String>();
                    if(crValues.get(str).contains(';')){
                        rValues = crValues.get(str).split('\\;');
                    }else{
                        rValues.add(crValues.get(str));
                    }
                    Integer count=rValues.size();
                    for(String r:rValues){
                        if(!String.valueof(cs.get(str)).equalsignorecase(r)){
                            count--;
                            continue;  
                        }
                    }
                    if(count==0){
                        match=false;
                        break;
                    }  
                }
                else{
                    match = false;
                    break;
                }
            }
                System.debug('Match:'+match);
            List<QueueSobject> listofQueues = [select id, QueueId, Queue.Name from QueueSObject];
            Map<String,Id> mapQNameWithIds = new Map<String,Id>();
            for(QueueSObject so: listofQueues){
               mapQNameWithIds.put(so.Queue.Name, so.QueueId); 
            }
            if(match==true){
                if(cr.Assign_To_User__c==true & cr.UserName__c!=null){
                    cs.ownerId=cr.UserName__c;
                }
                else{
                    if(mapQNameWithIds.get(cr.Queue_Name__c)!=null)
                        cs.OwnerId=mapQNameWithIds.get(cr.Queue_Name__c);
                }
                System.debug('Owner Id:'+mapQNameWithIds.get(cr.Queue_Name__c));
                cs.Case_Routing_Rule__c = cr.id;
                ownermatch = true;
                break;
            }
        }
    }
    //if(!ownermatch)
        //cs.OwnerId = '00590000000k49m';
    }
     utility.routingFlag=true;
    update caselist;   
    
    }
     
   
}