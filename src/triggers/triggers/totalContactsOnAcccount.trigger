/*
    *Created By   :  Tapendra Singh Kalvi
    *Purpose      :  Trigger on Contact object
    Created Date  :  26/7/2022
    Revision      :  V_1.0  
*/
trigger totalContactsOnAcccount on Contact (after insert, after update, after delete, after undelete) {
	
    if(trigger.isAfter)
    {
        if(trigger.isInsert || trigger.isUpdate || trigger.isDelete || trigger.isUndelete)
        {
            totalContactsHandler.countContacts(Trigger.new,trigger.old);
        }
    }
}