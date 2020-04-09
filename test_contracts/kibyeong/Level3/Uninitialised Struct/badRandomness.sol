pragma solidity ^0.4.24;
contract GuessTheRandomNumberChallenge {
    uint8 answer;
    mapping(address => uint256) balanceOf;
    uint public random = uint256(keccak256(now))%10+1;
uint public lastPlayed;

struct GuessHistory {
    address player;
    uint256 number;
}



    function setAnswer() public view returns (bool) {
        GuessHistory guessHistory;
guessHistory.player = msg.sender;
guessHistory.number = 11;
if(random <= 10){
            answer = uint8(keccak256(block.blockhash(block.number - 1), now));
            lastPlayed = now;
        }
    }

}