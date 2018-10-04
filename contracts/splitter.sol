pragma solidity ^0.4.21;

import"./Pausable.sol";

contract B9Splitter is Pausable{

    mapping(address => uint) public balances;

    event LogSplitFunds(address splitter, address receiver_1, address receiver_2, uint amountSplit);
    event LogWithdrawnFunds(address withdrawer, uint amountWithdrawn);


    function splitFunds (address _address1, address _address2) public payable isActive returns(bool success) {
        require(msg.value > 0 );
        if (msg.value % 2 > 0) {
          balances[msg.sender] += 1;
        }
          balances[_address1] += (msg.value)/2;
          balances[_address2] += (msg.value)/2;
          emit LogSplitFunds(msg.sender, _address1, _address2, msg.value);
          return true;

    }

    function withdrawFunds (uint amount) public isActive returns(bool success) {
        require(amount <= balances[msg.sender]);
        balances[msg.sender] -= amount;
        emit LogWithdrawnFunds(msg.sender, amount);
        msg.sender.transfer(amount);
        return true;
    }
}
