trigger BankAccount_Trigger on Bank__c (before insert, after insert,before update,after update, before delete,after delete) {
	
    if(Trigger.isInsert && Trigger.isBefore){
            BankTriggerHandler.creatingAccountNumber(Trigger.new);
        }
    
    if(Trigger.isInsert && Trigger.isAfter)
        {
            BankTriggerHandler.sendEmailNotification(Trigger.new);
        }
    
    if(Trigger.isUpdate){
        if(Trigger.isBefore){
            BankTriggerHandler.updatePhoneDescription(Trigger.new, Trigger.oldMap);
        }else if(Trigger.isAfter)
        {
           BankTriggerHandler.updateRelatedOppPhone(Trigger.new, Trigger.oldMap);
        }
    }
    
    if(Trigger.isBefore && Trigger.isDelete)
    {
        BankTriggerHandler.checkBankStatus(Trigger.old);
    }
    
    if(Trigger.isAfter && Trigger.isDelete)
    {
        BankTriggerHandler.deleteEmailNotification(Trigger.old);
    }
}