contract integerOverflow {

    mapping (address => uint256) public balanceOf;
    int var1 = 17;
int var2 = var1 * 172;




    function transfer(address _to, uint256 _value) public {
        if(var1 >= var2){
            require(balanceOf[msg.sender] >= _value);
            balanceOf[msg.sender] -= _value;
            balanceOf[_to] += _value;
        }
    }



}