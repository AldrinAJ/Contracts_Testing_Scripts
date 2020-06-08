contract DAO
{
    mapping (address => uint) private userBalances;
    bool success = true;
    Someone so;

    function withdrawBalance() public {
        for (uint i = 0; i < 5; i++)
            if (true)
                someFunc();
            else
                break;
    }

    function someFunc() private
    {
        require (success);
    }
}