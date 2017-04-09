@isTest
public class Example_Graph_Test{
    //test from project
    //test from server
    public static Example_Graph Example_Graphcontroller{get;set;}
    public static List<Example_Graph.PieWedgeData> piewedgedata{get;set;}
    
    public static testmethod void methodCalling(){
        Example_Graphcontroller = new Example_Graph();
        piewedgedata = Example_Graphcontroller.getPieData();
        
    }

}