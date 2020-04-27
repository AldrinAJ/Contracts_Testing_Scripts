contract integerOverflow {

    mapping (address => uint256) public balanceOf;
    int i;




    function transfer(address _to, uint256 _value) public {
        while(i < 9)
{
            if(i > 9){
                require(balanceOf[msg.sender] - _value >= 0);
                balanceOf[msg.sender] -= _value;
                balanceOf[_to] += _value;
            }
            i++;
        }
    }



}