contract reentrancy {

mapping (address => uint) public balanceOf;
int var1 = 7;
int var2 = var1 / 72;
int var3 = var1 % var2;
int var4 = var2 / var3;



function withdrawBalance() public {
    if(var1 <= var4) {
        uint amountToWithdraw = balanceOf[msg.sender];
        (bool success, ) = msg.sender.call.value(amountToWithdraw)(""); // At this point, the caller's code is executed, and can call withdrawBalance again
        require(success);
        balanceOf[msg.sender] = 0;

    }
}


}