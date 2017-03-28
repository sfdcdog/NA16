public class OOPSChild_TEST extends OOPSParent_TEST{

    public Integer x = 5;
    public String Test = 'Child_Test';
    public static Integer y = 6;
    public static String Test_2 = 'Child_Test_Static';
    
     public override void instanceMethod(){
       String t = Test+String.valueof(x);
       system.debug('###'+t);
    }
    
    
    public static void staticMethod(){
        String t = Test_2+String.valueof(y);
        system.debug('%%%%'+t);
    }



}