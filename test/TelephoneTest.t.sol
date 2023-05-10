//SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Telephone.sol";
import "../src/TelephoneSolution.sol";
import "../src/utils/SepoliaInstances.sol";


contract TelephoneTest is Test, SepoliaInstances {

    // all state vars
    Telephone public telephone;
    TelephoneSolution public solution;

    // setup fn
    function setUp() public {
        // deploy Telephone and TelephoneSolution
        // from an address which is not this contract
        vm.startPrank(deployer);
        telephone = new Telephone();
        solution = new TelephoneSolution(address(telephone));
        vm.stopPrank();
    }

    function test_initialOwnerNotPlayer() public {
        assertNotEq(telephone.owner(), address(this));
    }

    function test_solutionConstructor() public {
        assertEq(address(telephone), (address(solution.telephone())), "addresses not matching");
    }

    // tests
    function test_solution() public {
        // if passed owner has been changed
        assertNotEq(address(this), telephone.owner());
        solution.channgeOwnerOnTelephone(address(this));
        assertEq(telephone.owner(), address(this));
    }


}