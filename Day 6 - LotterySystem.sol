pragma solidity >=0.5.0 < 0.7.0;

contract LotterySystem {
    
    address public owner;
    uint256 public remainingTickets;
    bool public isPaused;
    bool public hasWinner;
    mapping(address => uint256) public adrsOfParticipants;
    address payable[] public adrsOfParticipantsList;
    
    constructor() public {
        owner = msg.sender;
        remainingTickets = 10;
    }
    
    modifier onlyOwner {
        require(msg.sender == owner, "You don't have the permission to call this function");
        _;
    }
    
    modifier isItPaused {
        require(!isPaused, "This contract is paused");
        _;
    }
    
    function buyTickets() public isItPaused payable {
        require(msg.value >= 1, "At lease one ether should be paid for participation");
        require(remainingTickets >= 1, "All tickets are sold!");
        require(adrsOfParticipants[msg.sender] == 0, "You have already participated in this lottery game!");
        adrsOfParticipants[msg.sender] = msg.value;
        adrsOfParticipantsList.push(msg.sender);
        remainingTickets -= 1;
    }
    
    function selectWinner() public onlyOwner isItPaused view returns(uint) {
        uint randomNumber = uint(keccak256(abi.encodePacked(block.difficulty,
        block.timestamp, msg.sender))) % adrsOfParticipantsList.length;
        return (randomNumber);
    }
    
    function transferEtherToWinner() public onlyOwner isItPaused payable {
        uint randomWinner = selectWinner();
        hasWinner = true;
        adrsOfParticipantsList[randomWinner].transfer(address(this).balance);
    }
    
    function setPaused() public onlyOwner {
        isPaused = true;
    }
    
    function resume() public onlyOwner {
        isPaused = false;
    }
    
    function getBalance() public view returns(uint balance) {
        return address(this).balance;
    }
    
    function terminateThisContract() public onlyOwner {
        address payable to = msg.sender;
        selfdestruct(to);
    }
    
    function newLottery() public onlyOwner isItPaused{
        require(address(this).balance == 0, "The prize haven't distributed");
        require(hasWinner, "The winner of the last game is not selected");
        owner = msg.sender;
        remainingTickets = 10;
        resume();
        hasWinner = false;
        uint arrayLength = adrsOfParticipantsList.length;
        for (uint i=0; i<arrayLength; i++) {
          delete adrsOfParticipants[adrsOfParticipantsList[i]];
        }
        delete adrsOfParticipantsList;
    }
}
