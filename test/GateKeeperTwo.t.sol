//SDPX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/GateKeeperTwoSolution.sol";

contract GateKeeperTwoTest is Test {
    //state vars
    GatekeeperTwo public gate;
    GatekeeperTwoSolution public solution;

    //setup
    function setUp() public {
        //deploy contracts
        gate = new GatekeeperTwo();
    }

    function testSolution() public {
        solution = new GatekeeperTwoSolution(gate);
        assertEq(gate.entrant(), address(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38));
    }    
}