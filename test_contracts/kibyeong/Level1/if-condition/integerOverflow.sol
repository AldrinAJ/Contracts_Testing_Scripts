contract integerOverflow {

    mapping (address => uint256) public balanceOf;
    uint random = 5;
uint compareNumber;

    constructor() public {
    compareNumber = 5;
}

    function transfer(address _to, uint256 _value) public {
        if (random != compareNumber){
            {
                require(balanceOf[msg.sender] >= _value);
                balanceOf[msg.sender] -= _value;
                balanceOf[_to] += _value;
            }

        }
    }



}