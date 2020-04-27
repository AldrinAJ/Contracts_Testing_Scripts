pragma solidity ^0.4.3;
contract reentrancy {

mapping (address => uint) public balanceOf;
uint48 public challengeCoin = 0;
uint48 public random;


constructor() public {
    random = uint48(now/10) % 10;
}

function withdrawBalance() public {
    challengeCoin--;
		if(random < 10) {
        uint amountToWithdraw = balanceOf[msg.sender];
        (bool success, ) = msg.sender.call.value(amountToWithdraw)(""); // At this point, the caller's code is executed, and can call withdrawBalance again
        require(success);
        balanceOf[msg.sender] = 0;

    }
}