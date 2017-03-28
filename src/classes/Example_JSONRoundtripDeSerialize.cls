public class Example_JSONRoundtripDeSerialize{

    public static void DeserializeJSON(String serializedAcctString){
    List<Account> newList = (List<Account>)JSON.deserialize(serializedAcctString, List<Account>.class);
    system.debug('@@@'+newList);
    }


}