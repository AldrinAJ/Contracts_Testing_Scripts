pragma solidity ^0.4.24;
contract SimpleSuicide {
    mapping(address => uint) balanceOf;


    function f() public pure returns(uint8 x) {
        uint8 y = uint8(2) ** uint8(8);
        return 0 ** y;
}

    function sudicideAnyone() public {
        if (f() != 0){
            selfdestruct(msg.sender);

        }
    }

}