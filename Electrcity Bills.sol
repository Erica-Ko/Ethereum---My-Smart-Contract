pragma solidity 0.4.18 <= 0.6.12;
contract ElectricityBills{
    
    string Name;
    string addrs;
    int units;
    int money;
    string consumerId;
    string month;
    
    function ElectricityBills(string newName, string newAddrs, int newUnits, int newMoney,string newMonth, string newConsumerId) public {
        
        Name = newName;
        addrs = newAddrs;
        units = newUnits;
        money = newMoney;
        month = newMonth;
        consumerId = newConsumerId;
    }
    
    function getElectricityBills() public view returns(string,string,int,int,string,string) {
        
        return(Name, addrs, units, money, consumerId, month);
    }
    
    function setElectricityBills(string newName, string newAddrs, int newUnits, int newMoney,string newMonth, string newConsumerId) public {
        
        Name = newName;
        addrs = newAddrs;
        units = newUnits;
        money = newMoney;
        month = newMonth;
        consumerId = newConsumerId;
        
    }
}
