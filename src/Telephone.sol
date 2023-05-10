// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Task is to become owner of the contract
contract Telephone {

  address public owner;

  constructor() {
    owner = msg.sender;
  }

  function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
}