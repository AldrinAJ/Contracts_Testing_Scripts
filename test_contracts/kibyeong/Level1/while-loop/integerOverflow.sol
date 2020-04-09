contract integerOverflow {

    mapping (address => uint256) public balanceOf;
    int i;



    function transfer(address _to, uint256 _value) public {
        while(i < 8)
{
            if(i > 8){
                require(balanceOf[msg.sender] >= _value);
                balanceOf[msg.sender] -= _value;
                balanceOf[_to] += _value;
            }
            i++;
        }
    }



