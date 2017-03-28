public class Example_EnumClassCalled{
    public Enum Seasons{Spring,Summer}
    
    public static String returnSeason(Example_EnumClassCalled.Seasons season,Integer Month){
        String presentSeason = '';
        if(Month == 5){
            if(season == Seasons.Summer){
                presentSeason = 'Summer is the season';
            }
            if(season == Seasons.Spring){
                presentSeason = 'Just a fluke';
            }
        }else{
            presentSeason = 'Spring is the season';
        }
        
        return presentSeason;
    }
}