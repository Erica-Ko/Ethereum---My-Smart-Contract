pragma solidity >=0.5.0 < 0.7.0 ;

contract BankAccount {
    
    address public owner;
    bool public isPaused;
    
    struct Depositor { 
    string name;
    uint amount;
    }
    
    mapping(address => Depositor) public address_to_Depositor;
    
    constructor() public {
        owner = msg.sender;
    }
    
    modifier onlyOwner {
        require(msg.sender == owner, "Only owner can call this function.");
        _;
    }
    
    modifier isItPaused {
        require(!isPaused, "This contract is paused");
        _;
    }
    
    function receiveEthers(string memory _name) public isItPaused payable{
        Depositor memory depositor = Depositor(_name, msg.value);
        address_to_Depositor[msg.sender] = depositor;
        
    }
    
    function withdrawAllEthers() public onlyOwner isItPaused payable returns (string memory){
        address payable to = msg.sender;
        to.transfer(address(this).balance);
        return "The withdrawal is completed";
    }
    
    function transferEthers(address payable _to) public onlyOwner isItPaused payable returns (uint , string memory, address) {
        _to.transfer(msg.value);
        return (msg.value, " is transfered to account: ", _to);
    }
    
    function getBalance() public view returns(uint balance) {
        return address(this).balance;
    }
    
    function setPaused() public onlyOwner {
        isPaused = true;
    }
    
    function resume() public onlyOwner {
        isPaused = false;
    }
    
    function terminateThisContract() public onlyOwner isItPaused {
        address payable to = msg.sender;
        selfdestruct(to);
    }
    
}
