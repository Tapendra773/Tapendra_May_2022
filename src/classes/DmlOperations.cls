/*
    *Created By   :  Tapendra Singh Kalvi
    *Purpose      :  All Important DML Operations
    Created Date  :  11/7/2022  
*/
public class DmlOperations {
	public void BulkInsert(){
	list<Account> accList = new list<Account>();
    Account acc1 = new Account(Name ='Tapendra', Phone='12345');
    Account acc2 = new Account(Name ='Kalvi', Phone='90244');
    accList.add(acc1);
 	accList.add(acc2);
        insert accList;
}
    public void InsertRelatedRecord(){
        Account acc = new Account(Name ='Test1', Phone='12345');
        Insert acc;
        
        Contact con = New Contact(FirstName='Jhon', LastName='Gupta', AccountId=acc.id);
        Insert con;
    }
    public void UpdateRecord(){
        Account acc1 = [Select id,Name,Phone from Account where Name='Tapendra'];
        
        System.debug('acc=>' + acc1);
        
        acc1.Phone = '988784';
        update acc1;
        
        Account UpdatedAcc1 = [Select id,Name,Phone from Account where Name='Tapendra'];
        system.assertEquals(UpdatedAcc1.Phone, acc1.phone,'unEqual');
    }
    public void UpdateRelatedRecord(){
        Contact con = [Select id, FirstName,LastName,Phone,Account.Phone
                      from Contact Where FirstName = 'Jhon' AND LastName = 'Gupta'
                      AND AccountId != null];
        con.Phone = '123456';
        con.Account.phone = '1111';
        
        update con;
        update con.Account;    
    }
    public void UpsertRecord(){
        list<Account> accList = new list<Account>();
   		Account acc1 = new Account(Name ='Vishal', Phone='99345');
        Account Acc2 = [Select id,Name,Phone from Account 
                        where Name='Tapendra'];
        acc2.Phone = '121212';
        accList.add(acc1);
 		accList.add(acc2);
        Upsert accList;
    }
    public void MergeRecord(){
        Account masterAcc = [Select id,Name,Phone from Account 
                        where Name='Kalvi'];
        Account MergeAcc = [Select id,Name,Phone from Account 
                        where Name='Test1'];
        
        merge masterAcc MergeAcc;
    }
    public void ExceptionHandling(){
        try{
            Account acc = new Account();
            insert acc;
        }
        catch(DMLException e){
            system.debug('Error =>' + e.getMessage());
        }
    }
}