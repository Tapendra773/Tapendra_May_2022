public with sharing class Assignment13_Classes {
//class defination
public class Motorbike{

    //Class Variables
    private string manufacturer;
    private integer horsepower;

    //Construter with String and Integer input
    public Motorbike(string manufacturer, integer horsepower){
        this.manufacturer = manufacturer;
        this.horsepower = horsepower;
    }

    //Method with no input, no returns that prints the class variables
    public void printVariables(){
        system.debug('Manufacturer is :' + manufacturer);
        system.debug('The horsepower is :' + horsepower);
    }

    //Method that returns an integer
    public  integer increasedHorsepower(){ 
        integer horsepower = horsepower+10;
        return horsepower;
    }
}
}
//
public static class studentDataProvider{

public static student__c stdata{
get{
    if(stdata==null){
        stdata=[select id,name from student__c where name!=NULL];
    }return stdata;
}
set{
    stdata.Name=stdata.Name + DateTime.now();
    system.debug('check stData.Name' +stData.Name);
}
}
}
//
@AuraEnabled
public static student getStData(){
    student atLocal;
    if(stLocal == null){
        stLocal = [select id, name from student where name !=NULL];
    }
    return stLocal;
}
@AuraEnabled
public static student getStData(){
   
    if(stData == null){
        stData = [select id, name from student where name !=NULL];
    }
    return stdata;
}

//Call by Refrence Example
Account a = new Account();
a.Name = 'Tapendra';
a.Website = 'www.Google.com';
changeWebsite(a);
System.debug('Website - '+a.Website);
public void changeWebsite(Account b) {
    //Create New Object and try to replace old
    b = new Account();
    b.Website = 'www.salesforce.com';
} 

//Call by Value example
Account a = new Account();
a.Name = 'Tapendra';
a.Website = 'www.Google.com';
changeWebsite(a);
System.debug('Website - '+a.Website);
public void changeWebsite(Account b) {
    b.Website = 'www.salesforce.com';
}

//Example of method overloading with Utility class example of Email Handler
//Utility
public class EmailHandler{
    //Method Overloading

    public void sendEmail(string fromEmail , string emailBody , string toEmail){
        Messaging.sendSingleEmailMessage msg = new Messaging.sendSingleEmailMessage (toEmail , fromEmail , emailBody);
        msg.send();
    }

    public Messaging.sendSingleEmailMessage sendEmail (string fromEmail , HtmlBody emailBody , string toEmail ){
        Messaging.sendSingleEmailMessage msg = new Messaging.sendSingleEmailMessage (toEmail , fromEmail , emailBody);
        msg.send();
        return msg;
    }
}
