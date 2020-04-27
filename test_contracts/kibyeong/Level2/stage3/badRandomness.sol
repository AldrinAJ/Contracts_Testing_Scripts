contract GuessTheRandomNumberChallenge {
    uint8 answer;
    int var1 = 13;
int var2 = var1 * 132;
int var3 = var1 + var2;
int var4 = var2 + var3;



    function setAnswer() public view returns (bool) {
        if(var1 > var4){
            answer = uint8(keccak256(block.blockhash(block.number - 1), now));

        }
    }

}