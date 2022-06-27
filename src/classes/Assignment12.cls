public with sharing class Assignment12 {
public static void Assignment12() {     
//Expressions
Account[] aa = [SELECT Id, Name FROM Account WHERE Name ='Acme'];
Integer i = [SELECT COUNT() FROM Contact WHERE LastName ='Singh'];
List<List<SObject>> searchList = [FIND 'map*' IN ALL FIELDS RETURNING Account (Id, Name), Contact, Opportunity, Lead];
system.debug(i);
}
//Safe Navigation operator
public static void getAccountNameWithSafeNavigation(){
    String accountName = [SELECT
                                    Id,
                                    Name
                                    FROM Account
                                    WHERE AccountNumber = '123456' ]?.Name;
    
    System.debug('Account Name:' + accountName);
    }
//Rules of conversion
public static void TypeCasting(){
     Decimal value1 = 45.115;
    Integer value2 = (Integer) value1;
    System.debug('The decimal is: '+ value1 + '. The integer is: ' + value2);
}    
}
