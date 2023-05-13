//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Force.sol";
import "../src/ForceSolution.sol";
import "../src/utils/SepoliaInstances.sol";

contract ForceTest is Test, SepoliaInstances{

    // state vars
    Force public force;
    ForceSolution public forceSolution;

    // setup
    function setUp() public {
        force = new Force();
        require(address(force).balance == 0, "balance should be 0" );
        forceSolution = new ForceSolution{value: 1e18}(address(force));

    }

    // tests
    function test_addBalance() public {
        //
        assertEq(address(force).balance, 0);

        // send
        address forceAddress = address(force);
        bool sent = payable(forceAddress).send(1e18);
        assertFalse(sent);

        // transfer
        vm.expectRevert();
        payable(forceAddress).transfer(1e18);

        // call
        (bool success, bytes memory data) =  address(force).call{value: 1e18}("");
        assertFalse(success);

        // selfdestruct if the solution had a receive function implemented
        // address forceSolutionAddress = address(forceSolution);
        // bool sentToSolution = payable(forceSolutionAddress).send(1e18);
        // assertTrue(sentToSolution);

        // selfdestruct but solution was funded during construction

        forceSolution.forceSendEther();
        assertEq(address(force).balance, 1e18);

    }

}