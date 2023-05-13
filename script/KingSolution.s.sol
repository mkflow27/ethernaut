// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/utils/SepoliaInstances.sol";
import "../src/KingSolution.sol";

contract KingSolutionScript is Script, SepoliaInstances {

    // state vars
    KingSolution public kingSolution;

    // run
    function run() public {
        //deploy solution

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        kingSolution = new KingSolution(address(kingInstance));

        kingSolution.becomeKing{value: 2e15}();

        vm.stopBroadcast();
    }

}