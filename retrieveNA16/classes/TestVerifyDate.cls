@isTest
/*
*TrailHead Class	
*Module: Apex Testing
*Unit: Getting Started with Apex Unit Tests
*Status: Completed
*/
public class TestVerifyDate {
    
    	static Date date1 = date.today();
    	static Date date2 = date1.addDays(15);
    	static Date date3 = date1.addDays(30);
    
    static testMethod void within30Days_Test(){
    	Date d1 = VerifyDate.CheckDates(date1, date2);
    	System.assertequals(date2,d1);
    }
    
    static testMethod void endofMonth_Test(){
    	/*Integer totalDays = Date.daysInMonth(date1.year(), date1.month());
		Date lastDay = Date.newInstance(date1.year(), date1.month(), totalDays);*/
    	Date d2 = VerifyDate.CheckDates(date1, date3);
    	System.assertnotequals(date1, d2);
    }
    
    
}