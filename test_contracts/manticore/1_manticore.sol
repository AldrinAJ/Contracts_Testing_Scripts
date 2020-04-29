pragma solidity ^0.4.21;

contract Intermediary {
    // this contract just holds the funds until the owner comes along and
    // withdraws them.

    address owner;
    Bank bank;
    uint amount;

    function Intermediary (Bank _bank, address _owner, uint _amount) public {
    // for solidity 0.4.21
    /*function Intermediary(Bank _bank, address _owner, uint _amount) public {*/
        owner = _owner;
        bank = _bank;
        amount = _amount;

        // this contract wants to register itself with its new owner, so it
        // calls the new owner (i.e. the attacker). This passes control to an
        // untrusted third-party contract.
        IntermediaryCallback(_owner).registerIntermediary(address(this));
    }

    function withdraw() public {
        if (msg.sender == owner) {
            msg.sender.transfer(amount);
        }
    }
    
    function () payable external {}
}
