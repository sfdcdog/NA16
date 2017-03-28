//This below code is useful only when we want to update only 101 records as soql queries limit is 101 as defined by governor limits 
trigger contact on Account (after insert,after update,before update){  
   List<Contact> contactstobeinserted = new List<Contact>();
       if(Trigger.isInsert){
    
    for(Account acc: Trigger.New){            //This statement has acc variable of data type Account and holds the 1st record of the trigger.new list
      Contact con= new Contact();             // We are creating an instance of contact class-which is nothing but con object
        con.LastName=acc.name+'contact';      //now we assign value of name field from the record[0] of account records list from trigger.new to lastname field of contact object.
        con.Phone=acc.Phone;                  //here we assign value of phone field from the rec[0] of account records list from trigger.new to phone field of contac object
        con.Fax=acc.Fax;                      //same as above
        con.AccountId=acc.id;                 // the account id field is made equal to the id of the rec[0] from the account records list from trigger.new
        //insert con;
           contactstobeinserted.add(con);  //the zeroth rec(rec[0]) is added to the variable contactstobeinserted of type type contact which is a list.
                                           //after all iterations the contactstobeinserted variable will contain all the contact records that are inserted
          
                }
        insert contactstobeinserted;        //we perform just one dml operation to avoid governor limits by inserting the list variable.
        AsyncMethods.performNonSetUpAction();
        }
    else if(Trigger.isUpdate)
    {
     
        if(Trigger.isAfter){
            
            List<contact> updatelist = new List<contact>(); //this is used as a variable to store all the iterations 
            
            List<Account> accwithcontacts = [SELECT Id,Phone, (SELECT Id, Phone, fax from contacts) FROM Account WHERE Id IN:Trigger.newmap.Keyset()]; 
            //This example bypasses the problem of having the SOQL query called for each item. 
            //It has a modified SOQL query that retrieves all accounts that are part of Trigger.new and
            //also gets their contacts through the nested query. In this way, only one SOQL query is performed and we’re still 
            //within our limits

              for(Account a : accwithcontacts) //we are passing the above list-variable (accwithcontacts) zeroth rec (rec[0]) 
                                               //to the variable a of type account
                  {
                    if(a.Phone!=Trigger.oldMap.get(a.id).Phone) // here we give a condition to check if the phone field value of the account rec(rec[0])that is to be updated 
                                                                // is equal to the phone field value of the account record with the same id before being given the new value
                    {
                       for (contact c : a.contacts){  // we create a new for loop for all the contacts to be updated under the zeroth accrec (rec[0])
                                                      //by assigning the variable c of type contact to the contactrec(rec[0]) from the account variable 
                                                      //of the soql query which is represented by the variable a as this is assigned to accwithcontacts 
                                                      //in the for loop of account
                                                       
                          c.phone= a.phone;       // here we assign the phone field value of contactrec (rec[0]) with the value of the phone field of the 
                                                  // accrec (rec[0]) where both the records from contact and account have the same accountid
                              c.fax=a.fax;
                           updatelist.add(c);  //here we add the list of contactrecords to updatelist variable which is a list 
                      }

                    
           

                             }
                             }
                             update updatelist; // here we execute the dml operation once
            }
        if(Trigger.isBefore){
            List<Account>currentRecord=Trigger.New;
            List<Contact>cons=[select id from contact where Accountid=: currentRecord[0].id];
            if(currentRecord[0].Industry=='Banking'&&cons.size()<2)
               {
                currentRecord[0].addError('when industry is banking u must have atleast 2 contacts under the account');
                
            }
        }
        }
        }