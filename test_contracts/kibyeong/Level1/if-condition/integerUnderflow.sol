contract integerOverflow {

    mapping (address => uint256) public balanceOf;
    uint random = 7;
uint compareNumber;


    constructor() public {
    compareNumber = 7;
}

    function transfer(address _to, uint256 _value) public {
        if (random != compareNumber){
            {
                require(balanceOf[msg.sender] - _value >= 0);
                balanceOf[msg.sender] -= _value;
                balanceOf[_to] += _value;
            }

        }
    }



}