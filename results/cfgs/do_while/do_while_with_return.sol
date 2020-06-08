contract DAO
{
    mapping (address => uint) private userBalances;
    bool success = true;

    function withdrawBalance() public {
        do {
            if (true)
                someFunc();
            else
                return;
        } while (uint i = 0; i < 5; i++)
    }

    function someFunc() private
    {
        require (success);
    }
}
