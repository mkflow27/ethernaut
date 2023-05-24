//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Privacy.sol";
import "../src/utils/StorageSample.sol";


contract PrivacySolutionTest is Test {

    // understanding how storage in solidity works

    // understanding how parameter parsing works

    // understanding how casting works

    function setUp() public {

    }

    function testSolve() public {

    }

    // --- Auxilliary custom understanding helpers ------
    /**
     * State vars are stored in storage in a compact way such that multiple values sometimes use the same storage slot.
     * Except for dynamically-sized arrays and mappings, data is stored contiguously, starting from slot 0, so that the
     *  irst storage slot contains the lowest-indexed non-zero storage value, slot 1 contains the next lowest, and so on.
     * 
     */
    function testStorageLayout() public {
        console.log("PRIVACY STORAGE DATA");
        Privacy privacy = new Privacy([bytes32(0), bytes32(0), bytes32(0)]);

        bytes32 valueSlot0 = vm.load(address(privacy), bytes32(uint256(0)));
        console.logBytes32(valueSlot0);

        // block.timestamp in unittest is 1
        bytes32 valueSlot1 = vm.load(address(privacy), bytes32(uint256(1)));
        console.logBytes32(valueSlot1);

        bytes32 valueSlot2 = vm.load(address(privacy), bytes32(uint256(2)));
        console.logBytes32(valueSlot2);

        bytes32 valueSlot3 = vm.load(address(privacy), bytes32(uint256(3)));
        console.logBytes32(valueSlot3);
    }

    function testSomeStorageLayout() public {
        StorageSampleOne storageSampleOne = new StorageSampleOne();

        console.log("SAMPLE STORAGE DATA");


        bytes32 valueSlot0 = vm.load(address(storageSampleOne), bytes32(uint256(0)));
        console.logBytes32(valueSlot0); // logs 0 as default uint256 value is 0

        // logs 0 as a fixed size array and default value 0
        bytes32 valueSlot1 = vm.load(address(storageSampleOne), bytes32(uint256(1)));
        console.logBytes32(valueSlot1); 

        // logs 0 as a fixed size array and default value 0
        bytes32 valueSlot2 = vm.load(address(storageSampleOne), bytes32(uint256(2)));
        console.logBytes32(valueSlot2); 

        // Next is the declaration of the Entry struct. Seems like declarations do not take up storage slots

        // c occupies a slot. It occupies slot3 and put 2 elements in the struct. Just like b
        // every element is uint256 and each will occupy a slot
        // c.id will occupy slot 3 and c.value will occupy slot 4
    }

    function testSecondStorageLayout() public {
        StorageSampleTwo storageSampleTwo = new StorageSampleTwo();

        console.log("Storage Sample Two");

        // is uint8 so occupies slot 0 and 8 bits, so 1 byte
        bytes32 valueSlot0 = vm.load(address(storageSampleTwo), bytes32(uint256(0)));
        console.logBytes32(valueSlot0); // logs 0 as default uint256 value is 0

        // Slot 0 has unallocated space lace, so there is the potential to fill it with
        // more data. This is what happens with b. b is uint16 so occupies slot 0 and 16 bits, so 2 bytes

        // is uint256 so occupies slot 1 and 256 bits, so 32 bytes
        // logs 0x00000000000000000000000000000000000000000000000000000000000000c8
        // which corresponds to 200 in decimal. You can see that storage slot 1
        // has the value of the 6th state variable in the StorageSampleTwo contract
        // The other variables which were defined are therefor stored in the first
        // storage slot
        bytes32 valueSlot1 = vm.load(address(storageSampleTwo), bytes32(uint256(1)));
        console.logBytes32(valueSlot1);

        // Storage slot 0 logs
        // 0x000000000000000f01be03bca4d65a86114668697867982ecfc76f15f8000a07

        // In Ethereum, strings and bytes are padded on the lower-order (right) 
        // side with zero-bytes, while other types (such as numbers and addresses)
        // are padded on the higher-order side.

        // ZZZZZZZZZZCCCCCCCCBBDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDBBBBAA
        // 0x000000000000000f01be03bca4d65a86114668697867982ecfc76f15f8000a07
    }

    function testThirdStorageLayout() public {
        StorageSampleThree storageSampleThree = new StorageSampleThree();

        console.log("Storage Sample Three");

        bytes32 valueSlot0 = vm.load(address(storageSampleThree), bytes32(uint256(0)));
        console.logBytes32(valueSlot0); 

        bytes32 valueSlot1 = vm.load(address(storageSampleThree), bytes32(uint256(1)));
        console.logBytes32(valueSlot1); 

        bytes32 valueSlot2 = vm.load(address(storageSampleThree), bytes32(uint256(2)));
        console.logBytes32(valueSlot2); 

        bytes32 valueSlot3 = vm.load(address(storageSampleThree), bytes32(uint256(3)));
        console.logBytes32(valueSlot3); 

        bytes32 valueSlot4 = vm.load(address(storageSampleThree), bytes32(uint256(4)));
        console.logBytes32(valueSlot4);

        bytes32 valueSlot5 = vm.load(address(storageSampleThree), bytes32(uint256(5)));
        console.logBytes32(valueSlot5);  

        bytes32 valueSlot6 = vm.load(address(storageSampleThree), bytes32(uint256(6)));
        console.logBytes32(valueSlot6);  

        bytes32 valueSlot7 = vm.load(address(storageSampleThree), bytes32(uint256(7)));
        console.logBytes32(valueSlot7);  

        bytes32 valueSlot8 = vm.load(address(storageSampleThree), bytes32(uint256(8)));
        console.logBytes32(valueSlot8);  

        bytes32 valueSlot9 = vm.load(address(storageSampleThree), bytes32(uint256(9)));
        console.logBytes32(valueSlot9);  

        bytes32 valueSlot10 = vm.load(address(storageSampleThree), bytes32(uint256(10)));
        console.logBytes32(valueSlot10);  
    }

}