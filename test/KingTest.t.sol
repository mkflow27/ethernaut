//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/utils/SepoliaInstances.sol";
import "../src/KingSolution.sol";
import "../src/King.sol";


contract KingSolutionTest is Test, SepoliaInstances {

    // state vars
    KingSolution public solution;
    King public king;

    // setup
    function setUp() public {

        vm.startPrank(deployer);

        // deploy King contract
        king = new King();
        // deploy solution contract with King contract address
        solution = new KingSolution(address(king));
        vm.stopPrank();
    }

    function testRemainKing() public {
            
            // assert King deployer is current King
            assertEq(king._king(), deployer, "King should be deployer");

            // become king
            solution.becomeKing{value: 1 ether}();
            // assertEq(king._king(), address(solution), "King should be solution");
    
            // check if solution is king
            // assertEq(address(solution), king._king(), "Solution should be king");

    }
}