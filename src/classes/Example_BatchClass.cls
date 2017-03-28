global class Example_BatchClass implements Database.batchable<sObject>{

    String query,field,value;
   
    global Example_BatchClass(String f, String v){
        field = f;
        value = v;
        query = 'Select ' + field + ' FROM Account limit 1 where AccountNumber!= 10026';
    }

    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }
   
    global void execute(Database.BatchableContext BC, List<Account> scope){
         system.debug('@@@@@@'+scope);
         for(Account s: scope){
             s.put(Field,Value);
         }
         system.debug('>>>>>>>>>'+scope);
         try{
             update scope;
             system.debug('after update######'+scope);
         }catch(exception e){
            //SI_Exception_Class Exce =  new SI_Exception_Class();
            string  Str = SI_Exception_Class.InsertException('','Example_BatchClass','Batch','execute',e);
            system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>' + Str);
        }
    }
   
    global void finish(Database.BatchableContext BC){
    }
   
}