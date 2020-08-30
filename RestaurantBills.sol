pragma solidity 0.4.18 <= 0.6.12;

contract restaurantBills {
    string customerName;
    int amountOfBill;
    string dishes;
    string restaurantName;
    string Date;
    string customerAddrs;
    string invoiceNumber;
    
    function restaurantBills (string newCustomerName, int newAmountOfBill, string newDishes, string newRestaurantName, 
    string newDate, string newCustomerAddrs, string newInvoiceNumber) public {
        customerName = newCustomerName;
        amountOfBill = newAmountOfBill;
        dishes = newDishes;
        restaurantName = newRestaurantName;
        Date = newDate;
        customerAddrs = newCustomerAddrs;
        invoiceNumber = newInvoiceNumber;
    }
    
    function getRestaurantBills () public view returns (string, int, string, string, string, string, string) {
        return(customerName, amountOfBill, dishes, restaurantName, Date, customerAddrs, invoiceNumber);
    }
    
    function setRestaurantBills (string newCustomerName, int newAmountOfBill, string newDishes, string newRestaurantName, 
    string newDate, string newCustomerAddrs, string newInvoiceNumber) public {
        customerName = newCustomerName;
        amountOfBill = newAmountOfBill;
        dishes = newDishes;
        restaurantName = newRestaurantName;
        Date = newDate;
        customerAddrs = newCustomerAddrs;
        invoiceNumber = newInvoiceNumber;
    }
}
