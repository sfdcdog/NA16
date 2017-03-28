trigger updateEmployees on Account (before insert, before update) {
List<Account> currentrec= Trigger.New;
for(Account acc: currentrec){
 if(acc.Industry=='Agriculture'){
     acc.NumberOfEmployees=10;
 
 } 
 }
}