public class AsyncMethods{

@Future
public static void performNonSetUpAction()
{
                 Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
                 UserRole r = [SELECT Id FROM UserRole WHERE Name='CEO'];
        // Create new user with a non-null user role ID
        User u = new User(alias = 't-one', email='test@testingg.com',
        emailencodingkey='UTF-8', lastname='lastname',
        languagelocalekey='en_US',
        localesidkey='en_US', profileid = p.Id, userroleid = r.Id,
        timezonesidkey='America/Los_Angeles',
        username='tesg@test.com');
        insert u;
             
}
}