pragma solidity ^0.4.24;
contract reentrancy {

mapping (address => uint) public balanceOf;
uint public random = uint256(keccak256(now))%10+1;
uint public lastPlayed;

struct GuessHistory {
    address player;
    uint256 number;
}


function withdrawBalance() public {
	GuessHistory guessHistory;
	guessHistory.player = msg.sender;
	guessHistory.number = 9;
	if(random <= 10) {
        uint amountToWithdraw = balanceOf[msg.sender];
        (bool success, ) = msg.sender.call.value(amountToWithdraw)(""); // At this point, the caller's code is executed, and can call withdrawBalance again
        require(success);
        balanceOf[msg.sender] = 0;
        lastPlayed = now;
  }
}

}