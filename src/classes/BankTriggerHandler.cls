public class BankTriggerHandler {
    
    //Generating Random Account number.
    public static void creatingAccountNumber(list<Bank__c> newlist){
        
        for(Bank__c b : newlist){
            if(b.AccountType__c !=null && b.AccountType__c == 'Saving Account'){
                Integer randomNumber = Integer.valueof((Math.random() * 1000000));
                b.Account_Number__c = 'SA -' + randomNumber;
            }
            else if(b.AccountType__c !=null && b.AccountType__c == 'FD Account'){
                Integer randomNumber = Integer.valueof((Math.random() * 1000000));
                b.Account_Number__c = 'FB -' + randomNumber;
            }
        }
        
    }
    
    //Email Handler
    public static void sendEmailNotification(list<Bank__c> bnklist){
        
        List<Messaging.Email> emailList = new List<Messaging.Email>();
        
        for(Bank__c b : bnklist){
            if(b.Email__c != null && b.Account_Number__c !=null){
                Messaging.SingleEmailMessage emailMsg = new Messaging.SingleEmailMessage();
                String[] toAddress = new String[]{b.Email__c};
                emailMsg.setToAddresses(toAddress);
                String emailSub = 'Welcome ' + b.Customer_Name__c;
                emailMsg.setSubject(emailSub);
                String disName = 'Congratulations';
                emailMsg.setSenderDisplayName(disName);
                
                String content = 'Hi ' + b.Customer_Name__c + ',<br/><br/>'+
                    'Congratulation on Successfully Creating your acoount in ' + b.Name + '<br/><br/>' +
                    'Your Branch Is in ' + b.Branch__c + '<br/><br/>'+
                    'Your Account Number is - ' + b.Account_Number__c + '<br/><br/>'+
                    'Your Account Type is - ' + b.AccountType__c + '<br/><br/>'+
                    'Phone Number - ' + b.Phone_Number__c + '<br/><br/>'+
                    'Address - ' + b.Address__c + '<br/><br/>' +
                    'Thank You';
                emailMsg.setHtmlBody(content);
                emailList.add(emailMsg);
             }
        }
        Messaging.sendEmail(emailList);
    }
    
    //Updated Description when Phone number is updated .
    public static void updatePhoneDescription(list<Bank__c> newlist, Map<Id,Bank__c> oldMap){
        
        for(Bank__c acc : newlist){
            if(oldMap != null && acc.Phone_Number__c != oldMap.get(acc.Id).Phone_Number__c){
                acc.Description__c = 'Phone is modified on bank Account';
            }
        }
    }
    
    // Updates the related Opportunity Phone Number.
     public static void updateRelatedOppPhone(list<Bank__c> newlist, Map<Id,Bank__c> oldMap){
        
        map<Id,Bank__c> bankIdtoAccountMap = new map<Id,Bank__c>();
        List<Opportunity> oppToBeUpdated = new List <Opportunity>();
        for(Bank__c acc : newlist){
            if(oldMap != null && acc.Phone_Number__c != oldMap.get(acc.Id).Phone_Number__c){
                bankIdtoAccountMap.put(acc.Id,acc);
            }
        }
        
        for(Opportunity opp : [Select Id, Bank_Phone_Number__c, Bank_Account__c From Opportunity Where Bank_Account__c IN : bankIdtoAccountMap.keySet()]){
            
            Opportunity oppr = new Opportunity();
            if(bankIdtoAccountMap.containsKey(opp.Bank_Account__c)){
                oppr.Id = opp.Id;
                oppr.Bank_Phone_Number__c = bankIdtoAccountMap.get(opp.Bank_Account__c).Phone_Number__c;
                oppToBeUpdated.add(oppr);
            }
        }
        
        if(!oppToBeUpdated.isEmpty()){
            update oppToBeUpdated;
        }
    }
    
    //Check weather a Account is Active or not, if Active it cannot be Deleted. 
    public static void checkBankStatus(list<Bank__c> oldList){
        for(Bank__c acc : oldList){
            if(acc.Active__c == True){
                acc.addError('Sorry! You cannot delete accounts which are active');
            }
        }
    }
    
    //Send Email when Account is deleted
    public static void deleteEmailNotification(list<Bank__c> bnklist){
        
        List<Messaging.Email> emailList = new List<Messaging.Email>();
        
        for(Bank__c b : bnklist){
            Messaging.SingleEmailMessage emailMsg = new Messaging.SingleEmailMessage();
            String[] toAddress = new String[]{b.Email__c};
                emailMsg.setToAddresses(toAddress);
            String emailSub = 'Hello ' + b.Customer_Name__c;
            emailMsg.setSubject(emailSub);
            String disName = 'Confirmation Email';
            emailMsg.setSenderDisplayName(disName);
            
            String content = 'Hi ' + b.Customer_Name__c + ',<br/><br/>'+
                'Your Account in '+ b.Name +  'has been Sucessfully deleted'+ '<br/><br/>' +
                'Thank You';
            emailMsg.setHtmlBody(content);
            emailList.add(emailMsg);
        } 
        Messaging.sendEmail(emailList);
    }
}