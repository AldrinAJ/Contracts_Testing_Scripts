contract DAO
{
    mapping (address => uint) private userBalances;
    bool success = true;
    Someone so;

    function withdrawBalance() public {
            if (true)
            {
                someFunc();
                require(success);
                uint amountToWithdraw = userBalances[msg.sender];
                userBalances[msg.sender] = 0;
            }
            else
            {
                userBalances[msg.sender] = 100;
                so.SomeoneFunc()
            }
    }

    function someFunc() private
    {
        require (success);
    }
}

contract Someone
{
    function SomeoneFunc() public returns (int256)
    {
        return 1;
    }
}
