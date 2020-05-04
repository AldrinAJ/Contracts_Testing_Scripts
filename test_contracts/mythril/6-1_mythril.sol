contract SimpleSuicide {
    function sudicideAnyone() public
    {
        selfdestruct(msg.sender);
    }
}

contract Owner {
    address suicider = 0xE0f5206BBD039e7b0592d8918820024e2a7437b9;
    function die () public
    {
        suicider.delegatecall(abi.encodeWithSignature("suicideAnyone()"));
    }
}