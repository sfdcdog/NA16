public class Example_EnumClassCalling{
    public static void sendmonthandGetSeason(Integer x){
        String result = Example_EnumClassCalled.returnSeason(Example_EnumClassCalled.Seasons.Summer, x);
        system.debug('@@@@@@@@@@@@@'+result); 
    }
}