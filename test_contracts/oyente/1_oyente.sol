contract IntegerOverflow {
    mapping (address => uint256) public balanceOf;
    function getCustom () public returns (uint256) {
        return 444;
    }
    function transfer(address _to, uint256 _value) public {
        require(balanceOf[msg.sender] >= _value);
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
    }
}

contract Alice {
    mapping (address => uint256) public balanceOf;
    address _t;
    IntegerOverflow io = IntegerOverflow(_t);

    function transfer(address _to, uint256 _value) public {
       uint256 sample = io.getCustom();
       balanceOf[_to] += sample + 1;
       //balanceOf[_to] += sample + value;
    }
}
