contract DAO
{
    mapping (address => uint) private userBalances;
    bool success = true;

    function withdrawBalance() public 
    {
        int256 i = 0;
        do {
            if (true)
                someFunc();
            else
                withdrawBalance();
            i++;
        } while (i < 5);
    }

    function someFunc() private
    {
        require (success);
    }
}
