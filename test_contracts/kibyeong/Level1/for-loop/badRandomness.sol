contract GuessTheRandomNumberChallenge {
    uint8 answer;
    int i;



    function setAnswer() public view returns (bool) {
        for(i=0; i<2; i++){
            if(i > 2){
                answer = uint8(keccak256(block.blockhash(block.number - 1), now));
            }

        }
    }

}