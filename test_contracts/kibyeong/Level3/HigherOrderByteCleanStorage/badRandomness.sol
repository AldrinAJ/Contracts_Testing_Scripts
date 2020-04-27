pragma solidity ^0.4.3;
contract GuessTheRandomNumberChallenge {
    uint8 answer;
    mapping(address => uint256) balanceOf;
    uint48 public challengeCoin = 0;
uint48 public random;

    constructor() public {
    random = uint48(now/10) % 10;
}

    function setAnswer() public view returns (bool) {
        challengeCoin--;
if(random < 10){
            answer = uint8(keccak256(block.blockhash(block.number - 1), now));

        }
    }

}