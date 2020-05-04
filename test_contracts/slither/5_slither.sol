pragma solidity ^0.6.4;

contract AnswerCreator {
    function getSeed (bytes32 seed) public returns (bytes32) {
        return seed;
    }
}

contract GuessTheRandomNumberChallenge {
    address _t;
    AnswerCreator ac = AnswerCreator(_t);

    function setAnswer() public returns (bytes32)
    {
        bytes32 seed = ac.getSeed(blockhash(block.number - 1));
        bytes32 answer = bytes32(keccak256(abi.encodePacked(seed)));
        return answer;
    }
}