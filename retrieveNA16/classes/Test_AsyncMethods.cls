@isTest
public class Test_AsyncMethods
{
public static TestMethod void testmy_performNonSetUpAction(){

User u = [select id,name from User where Id=:Userinfo.getUserId() ];

System.runAs(u){
Account acc=new Account();
acc.name='Testcoverage';
Test.startTest();
insert acc;
Test.stopTest();
}
}
}