contract IntegerUnderflow {
    mapping (address => uint256) public balanceOf;
    function getCustom () public returns (uint256) {
        return 0xFFFFFFFFFFFFFFFF;
    }
}

contract Alice {
    mapping (address => uint256) public balanceOf;
    address _t;
    IntegerUnderflow io = IntegerUnderflow(_t);

    function transfer(address _to, uint256 _value) public {
       require(balanceOf[msg.sender] - _value >= 0);
       uint256 sample = io.getCustom();
       balanceOf[_to] = sample - _value;
    }
}
