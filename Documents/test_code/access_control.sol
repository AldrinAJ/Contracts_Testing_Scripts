pragma solidity ^0.6.4;
contract vul{
      address owner;
      mapping(address => uint256) balances;

      modifier onlyOwner() {
            require(msg.sender != owner); { } // owner가 아닌 사람이 owner의 권한을 가짐
            _;
      }

      function changeOwner(address _new) public onlyOwner {
            owner = _new;
      }

      function Coinlancer(uint256 _totalSupply) public {
            owner = msg.sender;
            balances[owner] = _totalSupply;
      }
}
