pragma solidity ^0.6.4;
contract vul {

mapping (address => uint256) public balanceOf;
    function transfer(address _to, uint256 _value) external  {
        /* Check if sender has balance */
        require(balanceOf[msg.sender] >= _value);
        /* Add and subtract new balances */
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
    }
}
