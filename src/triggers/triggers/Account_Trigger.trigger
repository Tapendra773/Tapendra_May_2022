/*
    *Created By   :  Tapendra Singh Kalvi
    *Purpose      :  Trigger on Account object
    Created Date  :  26/7/2022
    Revision      :  V_1.0  
*/
trigger Account_Trigger on Account (before insert,after insert,before update,after update,before delete) {
 
    if(Trigger.isInsert && Trigger.isBefore){
            AccountTriggerHandler.beforeInsert(Trigger.new);
        }
    if(Trigger.isInsert && Trigger.isAfter)
        {
            AccountTriggerHandler.createRelatedOpp(Trigger.new);
        }
        
        
    if(Trigger.isUpdate){
        if(Trigger.isAfter)
        {
           AccountTriggerHandler.deleteRelatedOpp(Trigger.new, Trigger.oldMap);
        }
    }
}