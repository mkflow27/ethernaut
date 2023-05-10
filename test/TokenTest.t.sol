//SDPX-License-Identifier: MIT

pragma solidity ^0.7.6;
pragma abicoder v2;

import "forge-std/Test.sol";
import "../src/Token.sol";
import "../src/TokenSolution.sol";
import "../src/utils/SepoliaInstances.sol";

interface TokenInterface {
    function totalSupply() external returns (uint256);
    function balanceOf(address) external returns (uint256);
}

contract TokenTest is Test, SepoliaInstances {

    // state vars

    Token public token;
    TokenSolution public solution;

    // setup
    function setUp() public {
        // deploy Token
        // from an address which is not this contract
        vm.startPrank(deployer);
        // as in the Ethernaut level
        token = new Token(21000000);
        solution = new TokenSolution(address(token));
        vm.stopPrank();
    }

    function test_ItChecksDeployment() public {
        assertEq(token.totalSupply(), 21000000);
        assertEq(token.balanceOf(deployer), 21000000);
    }

    function test_solution() public {
        assertEq(token.balanceOf(player), 0);
        solution.solveTokenLevel();
        assertEq(token.balanceOf(player), 1e18);

    }





}