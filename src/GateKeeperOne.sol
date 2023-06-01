// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

contract GatekeeperOne {

  address public entrant;

  modifier gateOne() {
    console.log("mod1before:", gasleft());

    require(msg.sender != tx.origin, "gateOne: failed");
    console.log("mod1before:", gasleft());
    _;

  }

  modifier gateTwo() {
    //console.log("gasleft:", gasleft());
    //console.log("gasleft: modulo", gasleft() % 8191);
    //console.log("gasleft 1:", gasleft());

    //console.log("gasleft 1:", gasleft());
    //console.log("gasleft 1:", gasleft()); // this takes 650 gas
    //console.log("gasleft 1:", gasleft());


    //require(gasleft() % 8191 != 0, "gateTwoTEST: failed");
    //console.log("gasleft 5:", gasleft());

    require(gasleft() % 8191 == 0, "gateTwo: failed");
    //console.log("gasleft:", gasleft());

    _;
  }

  modifier gateThree(bytes8 _gateKey) {
      require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
      require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
      require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part three");
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}