/*TrailHead Challenge 
 *Apex Basics & Database
     -Getting Started with Apex
*/
public class StringArrayTest{
    public static List<String> stringList = new List<String>();
    public static List<String> generateStringArray(Integer n){
        Integer i;        
        for(i=0; i<n; i++){
             String str = 'Test'+' '+i;
             stringList.add(str);
        }
        return stringList;
    }
}