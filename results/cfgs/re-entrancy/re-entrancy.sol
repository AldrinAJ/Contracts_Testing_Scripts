contract DAO
{
    mapping (address => uint) private userBalances;

    function withdrawBalance() public {
            if (true)
            {
                (bool success, ) = msg.sender.call.value(amountToWithdraw)("");
                require(success);
                uint amountToWithdraw = userBalances[msg.sender];
                userBalances[msg.sender] = 0;
            }
            else
            {
                userBalances[msg.sender] = 100;
            }
    }
}
