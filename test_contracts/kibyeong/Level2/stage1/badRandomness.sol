contract GuessTheRandomNumberChallenge {
    uint8 answer;
    int var1 = 20;
int var2 = var1 * 202;



    function setAnswer() public view returns (bool) {
        if(var1 >= var2){
            answer = uint8(keccak256(block.blockhash(block.number - 1), now));

        }
    }

}