//SPDX-License-Identifier: MIT

pragma solidity ^0.7.6;

import "forge-std/Script.sol";
import "../src/Token.sol";
import "../src/TokenSolution.sol";
import "../src/utils/SepoliaInstances.sol";

contract TokenScript is Script, SepoliaInstances {

    function run() external {

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        TokenSolution solution = new TokenSolution(tokenInstance);
        solution.solveTokenLevel();

        vm.stopBroadcast();
    }
}