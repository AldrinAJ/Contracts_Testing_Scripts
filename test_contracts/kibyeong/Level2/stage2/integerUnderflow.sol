contract integerOverflow {

    mapping (address => uint256) public balanceOf;
    int var1 = 8;
int var2 = var1 + 82;
int var3 = var1 + var2;




    function transfer(address _to, uint256 _value) public {
        if(var1 == var3){
            require(balanceOf[msg.sender] - _value >= 0);
            balanceOf[msg.sender] -= _value;
            balanceOf[_to] += _value;
        }
    }



}