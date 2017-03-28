global class Example_SchedulerClassforBatch implements Schedulable{

    global void execute(SchedulableContext SC) {
        Example_BatchClass ebc = new Example_BatchClass('AccountNumber','10026');
        //Parameters of ExecuteBatch(context,BatchSize)
        database.executebatch(ebc,10);
    }
}