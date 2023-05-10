//SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;


import "forge-std/Script.sol";
import "../src/Telephone.sol";
import "../src/TelephoneSolution.sol";
import "../src/utils/SepoliaInstances.sol";

interface IEthernaut {
    // the interface defines a different Type as function input
    function createLevelInstance(address _level) external;
}


contract TelephoneScript is Script, SepoliaInstances {
    // run this script twice. First comment out the solution deployment
    // afterwards comment out the level creation tx

    function run() external {

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);
        // create the instance the player (EOA) is playing with
        // IEthernaut(ethernaut).createLevelInstance(telephoneLevel);

        TelephoneSolution solution = new TelephoneSolution(telephoneInstance);
        solution.channgeOwnerOnTelephone(0x834866ad4aCB833C60DE49c26B1b0433b0215a2e);

        vm.stopBroadcast();
    }

}
