contract DAO
{
    mapping (address => uint) private userBalances;

    function withdrawBalance() public {
            if (true)
            {
                (bool success, ) = msg.sender.call.value(amountToWithdraw)(""); // The user's balance is already 0, so future invocations won't withdraw anything
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
