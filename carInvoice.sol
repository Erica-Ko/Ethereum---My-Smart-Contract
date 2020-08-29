pragma solidity 0.4.18 <= 0.6.12;

contract carInvoice {
    string customerName;
    int amountOfInvoice;
    string carMakeAndModel;
    string companyAndDealerName;
    string Date;
    string customerAddrs;
    string invoiceNumber;
    
    function carInvoice (string newCustomerName, int newamountOfInvoice, string newCarMakeAndModel, string newCompanyAndDealerName, 
    string newDate, string newCustomerAddrs, string newInvoiceNumber) public {
        customerName = newCustomerName;
        amountOfInvoice = newamountOfInvoice;
        carMakeAndModel = newCarMakeAndModel;
        companyAndDealerName = newCompanyAndDealerName;
        Date = newDate;
        customerAddrs = newCustomerAddrs;
        invoiceNumber = newInvoiceNumber;
    }
    
    function getCarInvoice () public view returns (string, int, string, string, string, string, string) {
        return(customerName, amountOfInvoice, carMakeAndModel, companyAndDealerName, Date, customerAddrs, invoiceNumber);
    }
}
