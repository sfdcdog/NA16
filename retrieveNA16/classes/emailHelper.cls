// In a separate class so that it can be used elsewhere
Global class emailHelper {

    public static void sendEmail(ID recipient, ID candidate) {

    //New instance of a single email message
     Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
     
    // Who you are sending the email to
    mail.setTargetObjectId(recipient);
    // The email template ID used for the email
    mail.setTemplateId('00Xj0000000ICXD');         
    mail.setWhatId(candidate);    
    mail.setBccSender(false);
    mail.setUseSignature(false);
    mail.setReplyTo('recruiting@acme.com');
    mail.setSenderDisplayName('HR Recruiting');
    mail.setSaveAsActivity(false);  
     
    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    } 
    
    /*============================================================
	Namespace
	A container which lets developers bundle all functionality under a unique, application-specific name.
	
	Class
	Defines the object's characteristics. A class is a template definition of an object's properties and methods.
	
	Object
	An instance of a class.
	
	Property
	An object characteristic, such as color.
	
	Method
	An object capability, such as walk. It is a subroutine or function associated with a class.
	
	Constructor
	A method called at the moment an object is instantiated. It usually has the same name as the class containing it.
	
	Inheritance
	A class can inherit characteristics and capabilities from another class.
	
	Encapsulation
	A technique which involves bundling the data and the methods that use the data together.
	
	Abstraction
	The conjunction of an object's complex inheritance, methods, and properties to adequately reflect a reality model.
	
	Polymorphism
	Poly means "many" and morphism means "forms". Different classes might define the same method or property.
	    
    =============================================================*/
    /*===========================================================
    *Class Syntax:  var Person = function () {};
    
    *Object Syntax: var person1 = new Person();
					var person2 = new Person();
					
    *Class Constructor Syntax: var Person = function (firstName) {
								  this.firstName = firstName;
								  console.log('Person instantiated');
								};
								var person1 = new Person('Alice');
								var person2 = new Person('Bob');
								
								// Show the firstName properties of the objects
								console.log('person1 is ' + person1.firstName); // logs "person1 is Alice"
								console.log('person2 is ' + person2.firstName); // logs "person2 is Bob"
    *Class Methods Syntax: Person.prototype.sayHello = function() {
							  console.log("Hello, I'm " + this.firstName);
							};
    
    *
    *
    *
    *
    *
    *
    *
    *
    *
    *
    *
    *
    *
    *
    *
    *
    *
    *
    *
    *
    *
    *
    *
    *
    ==============================================================*/ 
}