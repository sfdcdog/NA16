global class Example_SchedulerClassforScheduler implements Schedulable{

    global void execute(SchedulableContext SC) {
        /*Example_SchedulerClassforBatch escb = new Example_SchedulerClassforBatch();
        String sch = '30 06 12 23 3 ?';
        String jobID = system.schedule('Example_Batch_Job', sch, escb);*/
        
        
        String CRON_EXP = '0 0 * * * ?';
   Example_SchedulerClassforBatch sch = new Example_SchedulerClassforBatch();
   system.schedule('Hourly Example Batch Schedule job', CRON_EXP, sch);
    }
}