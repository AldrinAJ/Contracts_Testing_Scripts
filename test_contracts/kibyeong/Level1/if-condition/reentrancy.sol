contract reentrancy {

mapping (address => uint) public balanceOf;
uint random = 19;
uint compareNumber;


constructor() public {
    compareNumber = 19;
}

function withdrawBalance() public {
    if (random != compareNumber) {
        {
            uint amountToWithdraw = balanceOf[msg.sender];
            (bool success, ) = msg.sender.call.value(amountToWithdraw)(""); // At this point, the caller's code is executed, and can call withdrawBalance again
            require(success);
            balanceOf[msg.sender] = 0;
        }

    }
}


}