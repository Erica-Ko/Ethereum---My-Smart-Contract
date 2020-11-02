pragma solidity >=0.5.0 < 0.7.0;

contract SharedWallet {
    address owner;
    
    struct User { 
    uint grade;
    uint amountLimit;
    uint remainingBal;
    }
    
    mapping(address => User) public adrsToUser;
    
    modifier onlyOwner {
        require(msg.sender == owner, "Only owner can call this function.");
        _;
    }
    
    constructor() public {
        owner = msg.sender;
    }
    
    function setUser(address _user, uint _grade) public onlyOwner {
        adrsToUser[_user].grade = _grade;
        if (_grade == 1 ) {
            adrsToUser[_user].amountLimit = 30 ether;
            adrsToUser[_user].remainingBal = 30 ether ;
        } 
        else if (_grade == 2 ) {
            adrsToUser[_user].amountLimit = 20 ether;
            adrsToUser[_user].remainingBal = 20 ether;
        } 
        else if (_grade == 3 ) {
            adrsToUser[_user].amountLimit = 10 ether;
            adrsToUser[_user].remainingBal = 10 ether;
        } 
        else if (_grade == 4 ) {
            adrsToUser[_user].amountLimit = 5 ether;
            adrsToUser[_user].remainingBal = 5 ether;
        } 
        else if (_grade == 5 ) {
            adrsToUser[_user].amountLimit = 2 ether;
            adrsToUser[_user].remainingBal = 2 ether;
        } 
        else {
            require(false,"The input type is not valid");
        }
    }
    
    function receiveEthers() public payable{
    }
    
    function transferEthers(address payable _to) public onlyOwner payable returns (uint , string memory, address) {
        require(adrsToUser[_to].remainingBal + msg.value <= adrsToUser[_to].amountLimit, "The amount of balance exceeds its balnce limit.");
        _to.transfer(msg.value);
        adrsToUser[msg.sender].remainingBal += msg.value;
        return (msg.value, " is transfered to account: ", _to);
    }
    
    function fillEthers(address payable _to) public onlyOwner payable {
        uint transAmount = adrsToUser[_to].amountLimit - adrsToUser[_to].remainingBal;
        _to.transfer(transAmount);
        adrsToUser[_to].remainingBal = adrsToUser[_to].amountLimit;
    }
    
    function getEthers(uint _amount) public payable {
        require(_amount * 1 ether <= adrsToUser[msg.sender].remainingBal, "No enough balance to withwral");
        address payable to = msg.sender;
        to.transfer(_amount * 1 ether);
        adrsToUser[msg.sender].remainingBal -= _amount * 1 ether;
    }
    
    function getBalance() public view returns(uint balance) {
        return address(this).balance;
    }
    
    function withdrawAllEthers() public onlyOwner payable{
        address payable to = msg.sender;
        to.transfer(address(this).balance);
    }
}
