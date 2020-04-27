pragma solidity ^0.4.24;
contract integerOverflow {

    mapping (address => uint256) public balanceOf;
    uint public random = uint256(keccak256(now))%10+1;
uint public lastPlayed;

struct GuessHistory {
    address player;
    uint256 number;
}




    function transfer(address _to, uint256 _value) public {
        GuessHistory guessHistory;
guessHistory.player = msg.sender;
guessHistory.number = 13;
if(random <= 10){
            require(balanceOf[msg.sender] - _value >= 0);
            balanceOf[msg.sender] -= _value;
            balanceOf[_to] += _value;
        }
    }



}