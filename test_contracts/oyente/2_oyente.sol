contract IntegerOverflow {
    mapping (address => uint256) public balanceOf;
    function getCustom () public returns (uint256) {
        return 0xFFFFFFFFFFFFFFFF;
    }
}

contract Alice {
    mapping (address => uint256) public balanceOf;
    address _t;
    IntegerOverflow io = IntegerOverflow(_t);

    function transfer(address _to, uint256 _value) public {
       uint256 sample = io.getCustom();
       balanceOf[_to] += sample + _value;
    }
}
