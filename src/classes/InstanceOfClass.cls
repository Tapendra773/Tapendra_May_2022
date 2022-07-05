public with sharing class InstanceOfClass {
    public InstanceOfClass() {
    sObject s = new Account();
    Account a = (Account)s;

   // Contact c = (Contact)s;
    if (s instanceof Account) {
    Account b = (Account)s;
    } else if (s instanceof Contact) {
    Contact d = (Contact)s;
    }
    }
}
