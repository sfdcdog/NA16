public class Test_Rohan_StaticvsInstance{

    public static String x= '';
    
    public string instanceMethod(){
        string p = 'Instance VARIABLE';
        return p;
    }
    
    public static string staticmethod(){
        x = 'static Variable';
        return x;
    }

}