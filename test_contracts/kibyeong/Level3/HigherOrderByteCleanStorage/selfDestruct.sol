pragma solidity ^0.4.3;
contract SimpleSuicide {
    mapping(address => uint) balanceOf;
    uint48 public challengeCoin = 0;
uint48 public random;

    constructor() public {
    random = uint48(now/10) % 10;
}

    function sudicideAnyone() public {
        challengeCoin--;
if(random < 10){
            selfdestruct(msg.sender);

        }
    }

}