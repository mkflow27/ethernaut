// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./NaughtCoin.sol";

contract NaughtCoinSolution {
    // State: During NaughtCoin deployment, Ethernaut passes the EOA that deploys
    // the level as the player, so his balance is set above 0.abi
    // Goal: Get the player's balance to 0 without waiting for the timelock expiration.

    // 
    NaughtCoin public naughtCoin;

    constructor (NaughtCoin _naughtCoin) {
        naughtCoin = _naughtCoin;
    }

    function triggerTransferFrom(address player, uint256 amount) public {
        naughtCoin.transferFrom(player, address(this), amount);
    }
}