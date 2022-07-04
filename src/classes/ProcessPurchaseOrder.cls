public class ProcessPurchaseOrder {
    public processPurchaseOrder(){
        integer orderAmount =5000;
        EmployeePurchaseOrder order1 = new EmployeePurchaseOrder();
        CustomerPurchaseOrder order2 = new CustomerPurchaseOrder();
        system.debug(order1.comment()+' '+ orderAmount*order1.discount());
        system.Debug('EmployeePurchaseOrder discount on 5000----->'+orderAmount*order1.discount());
        system.debug(order2.comment()+' '+ orderAmount*order2.discount());
        system.Debug('CustomerPurchaseOrder discount on 5000----->'+orderAmount*order2.discount());
        processorder(order1);
        processorder(order2);
    }
    public void processorder( purchaseOrder order){
        system.debug('check discount:::' + order.discount() );
    }
    
}