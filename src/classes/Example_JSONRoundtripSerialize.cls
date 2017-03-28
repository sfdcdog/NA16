public class Example_JSONRoundtripSerialize{
     
    public static String actListStr;
     
    public static void SerializeJSON(){
        List<Account> accList = [Select id, Name from Account limit 10];
        actListStr = JSON.Serialize(accList);
        Example_JSONRoundtripDeSerialize.DeserializeJSON(actListStr);    
    }

}