pragma solidity ^0.6.4;
contract vul {

  struct Payee {
      address payable addr;
      uint256 value;
  }

  Payee[] payees; // payees를 엄청 큰 size로 할당
  uint256 nextPayeeIndex;

  function payOut() public {
      uint256 i = nextPayeeIndex;
      while (i < payees.length && gasleft() > 200000) {
        payees[i].addr.send(payees[i].value);
        i++;
      }
      nextPayeeIndex = i;
  }
}
