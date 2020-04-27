contract GuessTheRandomNumberChallenge {
    uint8 answer;
    uint random = 10;
uint compareNumber;

    constructor() public {
    compareNumber = 10;
}

    function setAnswer() public view returns (bool) {
        if (random != compareNumber){
            {
                answer = uint8(keccak256(block.blockhash(block.number - 1), now));
            }

        }
    }

}