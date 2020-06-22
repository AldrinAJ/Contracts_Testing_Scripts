pragma solidity ^0.5.11;
contract Vulnerability {

    mapping (address => uint) private userBalances;
    mapping (address => bool) private claimedBonus;
    mapping (address => uint) private rewardsForA;

    function withdrawReward(address recipient) public {
        uint amountToWithdraw = rewardsForA[recipient];
        rewardsForA[recipient] = 0;
        recipient.call.value(amountToWithdraw)("");
    }

    function getFirstWithdrawalBonus(address recipient) public {
        require(!claimedBonus[recipient]); // Each recipient should only be able to claim the bonus once

        rewardsForA[recipient] += 100;
        withdrawReward(recipient); // At this point, the caller will be able to execute getFirstWithdrawalBonus again.
        claimedBonus[recipient] = true;
    }
}
