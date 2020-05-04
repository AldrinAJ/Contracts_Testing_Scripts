contract AnswerCreator {
    function getSeed (bytes32 seed) public returns (bytes32) {
        return seed;
    }
}

contract GuessTheRandomNumberChallenge {
    address _t;
    AnswerCreator ac = AnswerCreator(_t);

    function setAnswer() public view returns (bytes32)
    {
        bytes32 seed = ac.getSeed(block.blockhash(block.number - 1));
        bytes32 answer = bytes32(keccak256(seed, now));
        return answer;
    }
}

