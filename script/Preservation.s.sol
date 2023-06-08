// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/utils/SepoliaInstances.sol";
import "../src/PreservationSolution.sol";
import "../src/Preservation.sol";

contract PreservationSolutionScript is Script, SepoliaInstances {

    // state vars
    PreservationSolution public solution;
    Preservation public preservation;

    // run
    function run() public {

        preservation = Preservation(preservationInstance);

        //deploy solution

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // deploy solution contract
        solution = new PreservationSolution();
        preservation.setFirstTime(uint160(address(solution)));
        preservation.setFirstTime(uint160(address(player)));
        vm.stopBroadcast();
    }

}