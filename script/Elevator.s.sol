pragma solidity ^0.8.0;

import "forge-std/Script.sol";

import "../src/Elevator.sol";
import "../src/ElevatorSolution.sol";

import "../src/utils/SepoliaInstances.sol";

contract ElevatorSolutionScript is Script, SepoliaInstances {

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        ElevatorSolution solution = new ElevatorSolution(Elevator(elevatorInstance));
        solution.attack();

        vm.stopBroadcast();
    }
}