// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/utils/SepoliaInstances.sol";
import "../src/NaughtCoinSolution.sol";

contract NaughtCoinSolutionScript is Script, SepoliaInstances {

    NaughtCoinSolution public solution;

    NaughtCoin public naughtcoin;

    // run
    function run() public {
        //deploy solution
        naughtcoin = NaughtCoin(naughtCoinInstance);

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        solution = new NaughtCoinSolution(NaughtCoin(naughtCoinInstance));
        naughtcoin.approve(address(solution), naughtcoin.balanceOf(player));

        solution.triggerTransferFrom(player, naughtcoin.balanceOf(player));


        vm.stopBroadcast();
    }

}