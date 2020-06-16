pragma solidity ^0.5.11;
contract Vulnerability {

mapping (address => uint) private userBalances;

    function withdrawBalance() public {
        uint amountToWithdraw = userBalances[msg.sender];
        msg.sender.call.value(amountToWithdraw)("");
        userBalances[msg.sender] = 0;
    }
}
