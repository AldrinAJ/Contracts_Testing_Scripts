contract integerOverflow {

    mapping (address => uint256) public balanceOf;
    int var1 = 9;
    int var2 = var1 * 92;
    int var3 = var1 * var2;
    int var4 = var2 + var3;




    function transfer(address _to, uint256 _value) public {
        if(var1 > var4){
            require(balanceOf[msg.sender] >= _value);
            balanceOf[msg.sender] -= _value;
            balanceOf[_to] += _value;
        }
    }



}