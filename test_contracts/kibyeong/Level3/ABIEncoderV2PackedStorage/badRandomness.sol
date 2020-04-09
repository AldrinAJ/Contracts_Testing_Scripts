pragma solidity ^0.5.5;
pragma experimental ABIEncoderV2;
contract GuessTheRandomNumberChallenge {
    uint8 answer;
    mapping(address => uint256) balanceOf;
    uint256[2][2] public tmp_i;
uint256[2][2] public fin_i;
uint256[2][2] public init = [[14,142],[143,144]];
bytes temp;

        constructor() public {
        balanceOf[msg.sender] = 100000000;
        initialized(init);
    }

    function arrayCheck(uint256[2][2] memory a, uint256[2][2] memory b) internal returns (bool) {
        for (uint i=0; i<2; i++){
            for (uint j=0; j<2; j++){
                if (a[i][j] != b[i][j]) {
                    return false;
                }
            }
        }
        return true;
    }

    function initialized(uint256[2][2] memory s) public {
        tmp_i = s;
        temp = abi.encode(tmp_i);
        fin_i = abi.decode(temp, (uint256[2][2]));
    }


    function setAnswer() public view returns (bool) {
        if (arrayCheck(tmp_i,fin_i)){
            answer = uint8(keccak256(block.blockhash(block.number - 1), now));

        }
    }

}