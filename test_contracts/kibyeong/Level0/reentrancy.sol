contract reentrancy {

mapping (address => uint) public balanceOf;

	function withdrawBalance() public
	{
	    uint amountToWithdraw = balanceOf[msg.sender];
	    (bool success, ) = msg.sender.call.value(amountToWithdraw)("");
	    require(success);
        balanceOf[msg.sender] = 0;
	}

}