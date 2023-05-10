//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract DelegationSolution {

    constructor() {

    }

    // address.delegatecall(bytes memory) returns (bool, bytes memory)
    // issues a low-leve DELEGATECALL with the given payload, returns success
    // condition and return data, forwards all available gas, adjustable

    // If contracts do not adhere to the ABI, or to get a more direct control over
    // the encoding, the functions call, delegatecall and staticcall are provided.
    // delegatecall (and the rest) take a single bytes memory param. to encode
    // -abi.encode(arg);
    // -abi.encodePacked(arg);
    // -abi.encodeWithSelector(bytes4, arg);
    // -abi.encodeWithSignature(signatureString, arg);
    // can be used to encode structured data

    // delegatecall only supports gas adjustments value does not work

    // with delegatecall, only the code of the given address is used
    // but all other aspects (storage, balance, msg.sender, etc.) are token from
    // the current contract. The purpose of delegatecall is to use library/logic
    // code which is stored in callee contract but operate on the state of the caller
    // contract

    // low level calls such as delegatell call return false as their first
    // return value in case of an exception instead of "bubbling up"

    // delegatecall returns true as their first return value if the account called
    // is non-existant. Account existance must be checked prior to calling if needed.
}