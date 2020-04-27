contract integerOverflow {

    mapping (address => uint256) public balanceOf;
    int i;



    function transfer(address _to, uint256 _value) public {
        for(i=0; i<4; i++){
            if(i > 4){
                require(balanceOf[msg.sender] >= _value);
                balanceOf[msg.sender] -= _value;
                balanceOf[_to] += _value;
            }

        }
    }



}