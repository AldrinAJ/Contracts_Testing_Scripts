contract DAO
{
    mapping (address => uint) private userBalances;
    bool success = true;

    function withdrawBalance() public {
        int256 i = 0;
        do {
            i++;
            if (true)
                someFunc();
            else
                return;
        } while (i < 5);
    }

    function someFunc() private
    {
        require (success);
    }
}