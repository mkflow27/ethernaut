//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/GateKeeperOneSolution.sol";

contract SampleStorage {
    uint256 x = 1231512561824612318624124;
    address public owner = address(76);
    uint256 y = 123123124124;

    function setY(uint256 _y) public {
        y = _y;
    }

}

contract GateKeeperOneTest is Test {
    // state vars
    SampleStorage public sample;
    GatekeeperOne public gate;
    GateKeeperOneSolution public solution;

    // approach:
    // 1. circumenvent gateOne by having a smart contract call enter()
    // 2.circument gateTwo by attaching a specific gas asmount to the call
    // do some math on the gas amount beforehand
    // 
    // ------- LEARNINGS -------
    // When typecasting bytes and uint it is important to ensure that the byte length and
    // the representation of the bytes8 data align correctly. Example: bytes8 has 8 bytes
    // uint64 also has 8 bytes. 

    // ------- LEARNINGS -------


    // setup

    function setUp() public {
        sample = new SampleStorage();
        gate = new GatekeeperOne();
        solution = new GateKeeperOneSolution(gate);
    }


    // tests

    function testEnterGateKeeper() public {
        console.log("gasleft:", gasleft());

        //uint256 gas = gasleft();
        //uint256 multiplier = 8191;

        uint256 gasToAttach = (8191023);

        address(solution).call(abi.encodeWithSignature("solveLevel()"));
        assertEq(gate.entrant(), address(this));
    }
    function testLogData() public {
        bytes32 valueSlot0 = vm.load(address(sample), bytes32(uint256(0)));
        console.logBytes32(valueSlot0);

        bytes32 valueSlot1 = vm.load(address(sample), bytes32(uint256(1)));
        console.logBytes32(valueSlot1);

        console.log("Y value of contract:");
        bytes32 valueSlot2 = vm.load(address(sample), bytes32(uint256(2)));
        console.logBytes32(valueSlot2);


        console.log("uint256(255) as uint256 and bytes32");
        console.logUint(uint(255));
        // typecasting a uint to bytes32 works as it
        // appends 0
        console.logBytes32(bytes32(uint(255)));

        console.log("uint256(7000) as uint256 and bytes32");
        console.logUint(uint(7000));
        console.logBytes32(bytes32(uint(7000)));

        // uint8 occupies 1 byte (8bits)
        // 1 byte is 2 hex characters
        // 1 byte occupies 1/32 of a slot in evm storage

        console.logUint(uint16(65535));
        console.logBytes32(bytes32(uint(65535)));
        console.logUint(uint(65535));

        console.log("uint16 downcasted to uint8");
        console.logUint(uint8(uint16(65535)));
        console.logBytes32(bytes32(uint(65535)));
        console.logBytes32(bytes32(uint(uint8(uint16(65535)))));
    }

}