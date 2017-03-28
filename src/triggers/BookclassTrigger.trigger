trigger BookclassTrigger on Book__c (before insert) {

   Book__c[] books = Trigger.new;

   Bookclass.applyDiscount(books);
}