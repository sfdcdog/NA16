public class testasset {

List<Id> AssetIds= new List<Id>();
    
 public void assetmethod(){
/*for(Case c2:trigger.new)
{
  AssetIds.add(c2.Asset);
}  */          

//map<id,asset> mapassetrecord=new map<id,asset>([select id,Name from Asset where id IN: AssetIds]);

     
     List<Asset> assetlist=[Select id,Name,Product2Id from Asset];
     map<id,product2> mapasset2prod=new map<id,product2>();
     for(asset a:assetlist){
         mapasset2prod.put(a.id,a.product2);
        // mapasset2prod.get(cs.Asset).name;
     }
 }
}