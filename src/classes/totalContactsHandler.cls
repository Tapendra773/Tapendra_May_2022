/*
    *Created By   :  Tapendra Singh Kalvi
    *Purpose      :  Helper Class For Contact Trigger
    Created Date  :  26/7/2022
    Revision      :  V_1.0  
*/
public class totalContactsHandler {
    
    //Method for getting total count of contacts related to Account.
    public static void countContacts(List<Contact> newList, List<Contact> oldList)
    {
        Set<Id> accountIDs = new Set<Id>();
        
        if(newList!=null)
        {
            for(Contact c : newList){
                if(c.accountId != null){
                    accountIds.add(c.accountId);
                }
            }
        }
        
        if(oldList!=null)
        {
            for(Contact c : oldList)
            {
                if(c.accountId != null){
                    accountIds.add(c.accountId);
                }
            }
        }
        
        
        List<Account> accounts = [Select Id, Number_of_Contacts__c,(Select Id From Contacts) From Account Where Id IN : accountIds];
        if(!accounts.isEmpty())
        {
            for(Account acc : accounts)
            {
                acc.Number_of_Contacts__c = acc.contacts.size();
            }
        }
        
        update accounts;
    }
}