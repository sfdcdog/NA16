public class Example_JVConcepts{

    private Integer x=5;
    public void Example1(){
        Account acc1 = [select id from account limit 1];
        system.debug('@@@@@'+acc1);
        
    }
}