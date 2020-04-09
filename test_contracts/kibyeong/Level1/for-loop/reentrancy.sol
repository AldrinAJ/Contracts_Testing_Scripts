contract reentrancy {

mapping (address => uint) public balanceOf;
int i;

function withdrawBalance() public {
    for(i=0; i<13; i++) {
        if(i > 13){
            uint amountToWithdraw = balanceOf[msg.sender];
            (bool success, ) = msg.sender.call.value(amountToWithdraw)(""); // At this point, the caller's code is executed, and can call withdrawBalance again
            require(success);
            balanceOf[msg.sender] = 0;
        }

    }
}


}