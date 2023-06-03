//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import "../src/NaughtCoinSolution.sol";

contract NaughtCoinTest is Test {

    // state vars
    NaughtCoin public naughtCoin;
    NaughtCoinSolution public solution;

    address public constant PLAYER = 0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38;
    // reference
    // foundry sets 0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38 as the deployer / eoa it uses
    // setup
    function setUp() public {
        // deploy NaughtCoin
        naughtCoin = new NaughtCoin(PLAYER);
        solution = new NaughtCoinSolution(naughtCoin);
    }

    // tests
    function testFailPlayerTransferFails() public {
        //vm.prank(PLAYER);
        console.log(naughtCoin.balanceOf(PLAYER));
        //console.log(naughtCoin.balanceOf(address(this)));
        vm.startPrank(PLAYER);
        naughtCoin.transfer(address(1), naughtCoin.balanceOf(PLAYER));
        vm.stopPrank();
    }

    function testSolveLevel() public {
        // NaughtCoin has the basic ERC20 approve function
        // the approve function allows to set an amount parameter
        // wich allows the target to spend someones tokens.abi
        // The player can approve a fetching contract to fetch
        // the players tokens.

        assertEq(naughtCoin.balanceOf(PLAYER), naughtCoin.balanceOf(PLAYER));
        vm.startPrank(PLAYER);
        naughtCoin.approve(address(solution), naughtCoin.balanceOf(PLAYER));
        vm.stopPrank();
        solution.triggerTransferFrom(PLAYER, naughtCoin.balanceOf(PLAYER));
        assertEq(naughtCoin.balanceOf(PLAYER), 0);
    }

}