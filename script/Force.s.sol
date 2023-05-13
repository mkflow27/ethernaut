//SDPX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Script.sol";

import "../src/ForceSolution.sol";

import "../src/utils/SepoliaInstances.sol";

contract ForceSolutionScript is Script, SepoliaInstances {

    // state vars

    function run() public {

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        ForceSolution solution = new ForceSolution{value: 1}(forceInstance);
        solution.forceSendEther();

        vm.stopBroadcast();

    }
}