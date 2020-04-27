pragma solidity ^0.4.24;
contract reentrancy {

mapping (address => uint) public balanceOf;

function f() public pure returns(uint8 x) {
        uint8 y = uint8(2) ** uint8(8);
        return 0 ** y;
}

function withdrawBalance() public {
    if (f() != 0) {
        uint amountToWithdraw = balanceOf[msg.sender];
        (bool success, ) = msg.sender.call.value(amountToWithdraw)(""); // At this point, the caller's code is executed, and can call withdrawBalance again
        require(success);
        balanceOf[msg.sender] = 0;

    }
}


}