public class casePagination{

public List<Contact> accLst {get; set;}
public List<Contact> accLst_size {get; set;}
public integer counter = 0;
public integer recNum = 0;
public integer limits = 5;
public set<id> contactID {get; set;}

public casePagination(){
    accLst = new List<Contact> ();
    accLst_size = new List<Contact> ();
    contactID = new set<id>();
    Result();
}

public void Result(){
    accLst_size = [SELECT Name, Id FROM Contact WHERE name != null];
    recNum = accLst_size.size();

}
public void searchresult(){


    //getResult();
    SYSTEM.DEBUG('Number of records ' + recNum ); 
    accLst = [SELECT Name, Id FROM Contact WHERE id in: contactID and name != null LIMIT :limits OFFSET: counter  ];

}

public void nextbtn(){
    counter += limits ;
    searchresult();
}

public void prvbtn(){
    counter -= limits ;
    searchresult();
}

public void fstbtn(){
    counter = 0;
    searchresult();
}

public void endbtn(){
    counter = recNum - math.mod(recNum,limits);
    searchresult();
}

public boolean getprv(){
    if(counter == 0)
        return true;
    else
        return false;
}

public boolean getnxt(){
    if((counter + limits) > recNum)
        return true;
    else
        return false;
}
}