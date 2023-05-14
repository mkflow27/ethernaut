//SPDX-License-Identifier: MIT

pragma solidity 0.8.0;

import "forge-std/Test.sol";

import "../src/Elevator.sol";
import "../src/ElevatorSolution.sol";

/**
 * @title ElevatorTest
 * @author mkflow27
 * @notice UnitTest for the Elevator level. The goal of this level is to have the Elevator contract
 * return true once its public getter for floor is queried. The solution to this level is the external
 * call to isLastFloor of the Building contract. An Interface is given but the function implementation
 * is up to the developer. Meaning: return type is defined but as long as the type matches, anything
 * can be returned.
 */

contract ElevatorTest is Test {
    // state vars
    Elevator public elevator;
    ElevatorSolution public elevatorSolution;

    // setUp
    function setUp() public {
        elevator = new Elevator();
        elevatorSolution = new ElevatorSolution(elevator);
        assertEq(elevator.top(), false);
    }

    // tests
    function testAttack() public {
        elevatorSolution.attack();
        assertEq(elevator.top(), true);
    }
}