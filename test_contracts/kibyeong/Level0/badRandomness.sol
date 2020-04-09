contract GuessTheRandomNumberChallenge {
    uint8 answer;

    function setAnswer() public view  {
                answer = uint8(keccak256(block.blockhash(block.number - 1), now));
    }

}