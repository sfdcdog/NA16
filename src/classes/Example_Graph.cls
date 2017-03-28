public with sharing class Example_Graph {
    public List < PieWedgeData > getPieData() {
        List < PieWedgeData > data = new List < PieWedgeData > ();
        List < Opportunity > memb = new List < Opportunity > ();

        String sql = 'SELECT Name, TotalOpportunityQuantity FROM Opportunity where TotalOpportunityQuantity <> null limit 10';
        memb = Database.Query(sql);
        for(Opportunity temp: memb){
            data.add(new PieWedgeData(temp.Name, temp.TotalOpportunityQuantity));
        }
        system.debug('@@@@@@@@' + data);
        return data;
    }

    // Wrapper class  
    public class PieWedgeData {
        public String name {get;set;}
        public Decimal data {get;set;}

        public PieWedgeData(String name, Decimal data) {
            this.name = name;
            this.data = data;
        }
    }
}