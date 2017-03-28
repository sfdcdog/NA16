public without sharing class SI_Exception_Class{
    public static string InsertException(string Record_Id, string ClassName, string objectName, string MethodName, exception ex){
        try {
            system.debug('.>......................' + string.valueof(ex));
            SI_Exceptions__c Exce = new SI_Exceptions__c();
            Exce.SI_Class_Name__c = ClassName;
            Exce.SI_Login_User_Id__c = userInfo.getUserId();
            Exce.SI_Method_Name__c = MethodName;
            Exce.SI_Record_Id__c = Record_Id;
            Exce.SI_Exception__c = JSON.serialize(string.valueof(ex));
            insert Exce;
            return Exce.Id;
        } catch (exception ex1) {
            system.debug('Error' + ex1);
        }
        return '';
    }
    // Example:- ('','Core_IPS_UserTriggerHandler','User', InsertProjMemberatFuture',e)
    // SI_Exception_Class.InsertException('','Core_IPS_UserTriggerHandler','User', InsertProjMemberatFuture',e)
    
    /*
Window 1:
https://www.google.com/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=Object+type+apex
https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_methods_system_type.htm
http://salesforce.stackexchange.com/questions/48019/how-to-get-the-runtime-type-of-an-object-dynamically-for-primitive-data-types-a
http://salesforce.stackexchange.com/questions/42594/object-class-in-apex
https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_class_System_Queueable.htm
https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_methods_system_system.htm
https://developer.salesforce.com/forums/?id=906F000000099GgIAI
https://th3silverlining.com/2012/06/22/salesforce-javascript-remoting-using-apex-and-javascript-objects-to-pass-data-from-client-to-server-side-and-vice-versa/
http://stackoverflow.com/questions/18765869/accessing-http-status-code-constants
http://www.java67.com/2015/12/top-30-oops-concept-interview-questions-answers-java.html
http://www.java67.com/2014/06/why-abstract-class-is-important-in-java.html
http://javarevisited.blogspot.sg/2011/12/factory-design-pattern-java-example.html


Window 2:
http://sfdcsrini.blogspot.com/
https://www.google.com/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=sobjectmodel.account
https://gist.github.com/dcarroll/8427394
https://developer.salesforce.com/docs/atlas.en-us.pages.meta/pages/pages_controller_sosc_actions.htm
https://developer.salesforce.com/docs/atlas.en-us.pages.meta/pages/pages_remote_objects.htm
https://developer.salesforce.com/docs/atlas.en-us.pages.meta/pages/pages_remote_objects_example_simple.htm
https://developer.salesforce.com/docs/atlas.en-us.pages.meta/pages/pages_remote_objects_considerations.htm
https://developer.salesforce.com/docs/atlas.en-us.pages.meta/pages/pages_remote_objects_using_retrieve_query_object.htm
https://developer.salesforce.com/docs/atlas.en-us.pages.meta/pages/pages_compref_remoteObjectModel.htm
http://www.w3schools.com/jsref/dom_obj_all.asp
http://www.w3schools.com/jsref/dom_obj_event.asp
https://developer.salesforce.com/docs/atlas.en-us.pages.meta/pages/apex_ApexPages_StandardSetController_setFilterID.htm
https://developers.google.com/web/tools/chrome-devtools/snippets
https://developer.salesforce.com/page/An_Introduction_to_Visualforce_View_State
http://stackoverflow.com/questions/5836881/stateless-protocol-and-stateful-protocol


*/
}