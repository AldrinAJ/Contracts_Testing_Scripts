pragma solidity ^0.4.24;
contract SimpleSuicide {
    mapping(address => uint) balanceOf;
    uint public random = uint256(keccak256(now))%10+1;
uint public lastPlayed;

struct GuessHistory {
    address player;
    uint256 number;
}



    function sudicideAnyone() public {
        GuessHistory guessHistory;
guessHistory.player = msg.sender;
guessHistory.number = 16;
if(random <= 10){
            selfdestruct(msg.sender);
            lastPlayed = now;
        }
    }

}