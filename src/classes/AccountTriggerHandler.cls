/*
    *Created By   :  Tapendra Singh Kalvi
    *Purpose      :  Helper Class For Account Trigger
    Created Date  :  26/7/2022
    Revision      :  V_1.0  
*/
public class AccountTriggerHandler {
    
    // Method for Before Insert Event for Rating field
    public static void beforeInsert(list<Account> newlist){
        for(Account acc : newlist){
            //validation rule
            if(acc.Industry == null){
                acc.addError('Please populate Industry');
            } 
            else if(acc.Industry != null && acc.Industry == 'Media'){
                acc.Rating = 'Hot';
            }else{
                acc.Rating = 'Cold';
            }
        }
    }
    
    //Method For creating related Opportunity
    public static void createRelatedOpp(list<Account> newlist){
        
        list<Opportunity> ooplist = new list<Opportunity>();
        
        for(Account acc : newlist)
        {
            Opportunity opp = new Opportunity();
            opp.Name = acc.Name;
            opp.AccountId = acc.Id;
            opp.StageName = 'Prospecting';
            opp.CloseDate = System.today();
            ooplist.add(opp);
        }
        if(!ooplist.isEmpty()){
            insert ooplist;
        }
    }
      
    //Method for Deleting related Opportunity
    public static void deleteRelatedOpp(list<Account> newlist, Map<Id,Account> oldMap){
        
        map<Id,Account> accIdtoAccountMap = new map<Id,Account>();
        List<Opportunity> oppToDeleted = new List <Opportunity>();
        for(Account acc : newlist){
            if(oldMap != null ){
                accIdtoAccountMap.put(acc.Id,acc);
            }
        }
        
        for(Opportunity opp : [Select Id, AccountId From Opportunity Where AccountId IN : accIdtoAccountMap.keySet()])
        {
            Opportunity oppr = new Opportunity();
            if(accIdtoAccountMap.containsKey(opp.AccountId)){
                oppr.Id = opp.Id;
                oppToDeleted.add(oppr);
            }
        }
        
        if(!oppToDeleted.isEmpty()){
            delete oppToDeleted;
        }
    }     
}