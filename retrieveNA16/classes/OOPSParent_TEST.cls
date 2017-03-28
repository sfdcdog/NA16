public virtual class OOPSParent_TEST{

    public Integer x = 4;
    public String Test = 'Parent_Test';
    public static Integer y = 5;
    public static String Test_2 = 'Parent_Test_Static';
    
    
    public virtual  void instanceMethod(){
       String t = Test+String.valueof(x);
       system.debug('###'+t);
    }
    
    public static void staticMethod(){
        String t = Test_2+String.valueof(y);
        system.debug('%%%%'+t);
    }

}