pragma solidity ^0.4.21;

contract b9Splitter {
    address public Alice;
    address public Bob;
    address public Carol;

    
    constructor(address _address1, address _address2) public {
        Alice = msg.sender;
        Bob = _address1;
        Carol = _address2;
    }
    
    modifier onlyBy {
         require( msg.sender == Alice);
         _;
     }
     
    function split () public payable onlyBy {
        if(msg.value == 0) return;
        Carol.transfer((msg.value)/2);
        Bob.transfer((msg.value)/2);
        
    } 
}
