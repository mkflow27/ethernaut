//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Vault.sol";

contract Storage {
    uint256 public exists = 1;
    uint256 private secret = 2;
}

contract VaultTest is Test {

    using stdStorage for StdStorage;

    Vault public vault;
    Storage public store;

    function setUp() public {
        vault = new Vault(bytes32(0x4d61780000000000000000000000000000000000000000000000000000000000));
        store = new Storage();
    }

    function testFindVarStorageSlotNumber() public {
        console.log("_______STORAGE SLOTS BELOW_______");
        //uint256 slot = stdstore.target(address(vault)).sig("password()").find();
        //CONSOLE_ADDRESSconsole.log(slot);
        uint256 slotnew = stdstore.target(address(store)).sig("exists()").find();
        console.log(slotnew);

    }

    function testWriteToVarStorageSlot() public {
        stdstore.target(address(store)).sig("exists()").checked_write(2);
        //console.log("exists should be 2", store.exists());
    }

    function testReadVarFromStorage() public {
        uint256 value = stdstore.target(address(store)).sig("exists()").read_uint();
        console.log("After reading", value);
    }

    function testReadPrivateVarFromStorage() public {
        // Loads a storage slot from an address
        // function load(address target, bytes32 slot) external view returns (bytes32 data);
        // secret sits at storage slot 2
        bytes32 value2 = vm.load(address(store), bytes32(uint256(0)));
        console.log("bytes32 logged");
        console.logBytes32(value2);
    }

    function testSolveVault() public {
        assertEq(vault.locked(), true);
        // password sits at storage slot 1
        bytes32 password = vm.load(address(vault), bytes32(uint256(1)));
        console.logBytes32(password);

        vault.unlock(password);
        assertEq(vault.locked(), false);

    }



}