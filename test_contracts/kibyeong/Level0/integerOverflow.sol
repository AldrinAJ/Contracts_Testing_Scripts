contract IntegerOverflow {

    mapping (address => uint256) public balanceOf;
        
    function transfer(address _to, uint256 _value) public {
        require(balanceOf[msg.sender] >= _value);
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
    }

}