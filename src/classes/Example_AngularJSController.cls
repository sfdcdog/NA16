global with sharing class Example_AngularJSController {

    // hardcode an account id for demo purposes
    static String accountId = '001j000000kGrlU';

    global static String getAccount() {
        return JSON.serialize([select name, billingstreet,
            billingcity, billingstate, billingpostalcode
            from account where id =: accountId
        ][0]);
    }

    global static String getContacts() {
        return JSON.serialize([select id, name, email
            from contact where accountId =: accountId
        ]);
    }

}