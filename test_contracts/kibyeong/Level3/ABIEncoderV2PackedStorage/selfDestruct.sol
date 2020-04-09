pragma solidity ^0.5.5;
pragma experimental ABIEncoderV2;
contract SimpleSuicide {
    mapping(address => uint) balanceOf;
    uint256[2][2] public tmp_i;
uint256[2][2] public fin_i;
uint256[2][2] public init = [[18,182],[183,184]];
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


    function sudicideAnyone() public {
        if (arrayCheck(tmp_i,fin_i)){
            selfdestruct(msg.sender);

        }
    }

}