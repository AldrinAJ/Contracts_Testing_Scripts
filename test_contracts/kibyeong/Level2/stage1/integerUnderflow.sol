contract integerOverflow {

    mapping (address => uint256) public balanceOf;
    int var1 = 19;
int var2 = var1 / 192;




    function transfer(address _to, uint256 _value) public {
        if(var1 < var2){
            require(balanceOf[msg.sender] - _value >= 0);
            balanceOf[msg.sender] -= _value;
            balanceOf[_to] += _value;
        }
    }



}