contract GuessTheRandomNumberChallenge {
    uint8 answer;
    int i;



    function setAnswer() public view returns (bool) {
        while(i < 4)
{
            if(i > 4){
                answer = uint8(keccak256(block.blockhash(block.number - 1), now));
            }
            i++;
        }
    }

}