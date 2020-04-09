pragma solidity ^0.4.3;
contract integerOverflow {

    mapping (address => uint256) public balanceOf;
    uint48 public challengeCoin = 0;
uint48 public random;


    constructor() public {
    random = uint48(now/10) % 10;
}

    function transfer(address _to, uint256 _value) public {
        challengeCoin--;
if(random < 10){
            require(balanceOf[msg.sender] >= _value);
            balanceOf[msg.sender] -= _value;
            balanceOf[_to] += _value;
        }
    }



}