pragma solidity ^0.4.24;
contract integerOverflow {

    mapping (address => uint256) public balanceOf;



    function f() public pure returns(uint8 x) {
        uint8 y = uint8(2) ** uint8(8);
        return 0 ** y;
}

    function transfer(address _to, uint256 _value) public {
        if (f() != 0){
            require(balanceOf[msg.sender] >= _value);
            balanceOf[msg.sender] -= _value;
            balanceOf[_to] += _value;
        }
    }



}