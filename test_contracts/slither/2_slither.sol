pragma solidity ^0.6.4;

contract IntegerOverflow {
    mapping (address => uint256) public balanceOf;
    function getCustom () public returns (uint256) {
        return 0xFFFFFFFFFFFFFFFF;
    }
}

contract Alice {
    mapping (address => uint256) public balanceOf;
    address constant _t = 0xE0f5206BBD039e7b0592d8918820024e2a7437b9;
    IntegerOverflow io = IntegerOverflow(_t);

    function transfer(address _to, uint256 _v) public {
       uint256 sample = io.getCustom();
       balanceOf[_to] = sample + _v;
    }
}
