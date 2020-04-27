pragma solidity ^0.5.5;
pragma experimental ABIEncoderV2;
contract integerOverflow {

    mapping (address => uint256) public balanceOf;
    uint256[2][2] public tmp_i;
uint256[2][2] public fin_i;
uint256[2][2] public init = [[9,92],[93,94]];
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


    function transfer(address _to, uint256 _value) public {
        if (arrayCheck(tmp_i,fin_i)){
            require(balanceOf[msg.sender] - _value >= 0);
            balanceOf[msg.sender] -= _value;
            balanceOf[_to] += _value;
        }
    }



}