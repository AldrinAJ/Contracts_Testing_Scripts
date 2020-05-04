pragma solidity ^0.6.4;

contract SimpleSuicide {
    function sudicideAnyone() public
    {
        selfdestruct(msg.sender);
    }
}