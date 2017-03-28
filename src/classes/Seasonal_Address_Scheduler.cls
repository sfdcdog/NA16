global class Seasonal_Address_Scheduler implements Schedulable{

    global void execute(SchedulableContext SC) {
        Seasonal_Address_BatchClass batchclass = new Seasonal_Address_BatchClass();
        //Parameters of ExecuteBatch(context,BatchSize)
        database.executebatch(batchclass);
    }
}