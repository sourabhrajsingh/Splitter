pragma solidity ^0.4.21;

contract B9Splitter {
    address public alice;
    address public bob;
    address public carol;
    mapping(address => uint) public balances;
    
    event logSplitFunds(address splitter, uint aliceHas, uint bobHas, uint carolHas);
    event logWithdrawnFunds(address withdrawer, uint amountWithdrawn);

    
    constructor(address _address1, address _address2) public {
        alice = msg.sender;
        bob = _address1;
        carol = _address2;
    }
    
    modifier onlyAlice {
         require( msg.sender == alice);
         _;
     }
     
    function split () public payable onlyAlice returns(bool success) {
        require(msg.value > 0);
        if (msg.value % 2 == 0) {
            balances[bob] += (msg.value)/2;
            balances[carol] += (msg.value)/2;
            return true;
         }
        if (msg.value % 2 == 1) {
            balances[bob] += (msg.value - 1)/2;
            balances[carol] += (msg.value - 1)/2;
            balances[alice] += 1;
            return true;
        }
        emit logSplitFunds(msg.sender, balances[alice], balances[bob], balances[carol]);
    }
    
    function withdrawFunds () public returns(bool success) {
        uint amount = balances[msg.sender];
        if(amount > 0) {
            balances[msg.sender] = 0;
            msg.sender.transfer(amount);
            return true;
        }
        emit logWithdrawnFunds(msg.sender, amount);
        
    }
}

