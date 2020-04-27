contract GuessTheRandomNumberChallenge {
    uint8 answer;
    int var1 = 8;
int var2 = var1 * 82;
int var3 = var1 + var2;



    function setAnswer() public view returns (bool) {
        if(var1 >= var3){
            answer = uint8(keccak256(block.blockhash(block.number - 1), now));

        }
    }

}