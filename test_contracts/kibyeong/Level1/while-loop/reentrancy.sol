contract reentrancy {

mapping (address => uint) public balanceOf;
int i;

function withdrawBalance() public {
    while(i < 19){
        if(i > 19){
            uint amountToWithdraw = balanceOf[msg.sender];
            (bool success, ) = msg.sender.call.value(amountToWithdraw)(""); // At this point, the caller's code is executed, and can call withdrawBalance again
            require(success);
            balanceOf[msg.sender] = 0;
        }
        i++;
    }
}

}