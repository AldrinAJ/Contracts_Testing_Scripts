contract DAO
{
    mapping (address => uint) private userBalances;
    bool success = true;

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
            }
    }

    function someFunc() private
    {
        require (success);
    }
}
