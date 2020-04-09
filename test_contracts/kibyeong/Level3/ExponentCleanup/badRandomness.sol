pragma solidity ^0.4.24;
contract GuessTheRandomNumberChallenge {
    uint8 answer;
    mapping(address => uint256) balanceOf;


    function f() public pure returns(uint8 x) {
        uint8 y = uint8(2) ** uint8(8);
        return 0 ** y;
}

    function setAnswer() public view returns (bool) {
        if (f() != 0){
            answer = uint8(keccak256(block.blockhash(block.number - 1), now));

        }
    }

}