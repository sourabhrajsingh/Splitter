pragma solidity ^0.4.21;

contract B9Splitter {
    address public owner;
    mapping(address => uint) public balances;

    event logSplitFunds(address splitter, uint splitterHas, uint receiver_1_Has, uint receiver_2_Has);
    event logWithdrawnFunds(address withdrawer, uint amountWithdrawn);


    constructor() public {
         owner = msg.sender;
       }

    function split (address _address1, address _address2) public payable returns(bool success) {
        require(msg.value > 0 );
        if (msg.value % 2 > 0)  balances[msg.sender] += 1;
            balances[_address1] += (msg.value)/2;
            balances[_address2] += (msg.value)/2;
            return true;
        emit logSplitFunds(msg.sender, balances[msg.sender], balances[_address1], balances[_address2]);
    }

    function withdrawFunds (uint amount) public returns(bool success) {
        require(amount <= balances[msg.sender]);
            balances[msg.sender] -= amount;
            msg.sender.transfer(amount);
            return true;
        emit logWithdrawnFunds(msg.sender, amount);

    }
}
