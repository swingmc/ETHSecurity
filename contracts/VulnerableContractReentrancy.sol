// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VulnerableContractReentrancy {
    mapping(address => uint256) public balances;
    
    function depositFunds() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdrawFunds(uint256 _weiToWithdraw) public {
    require(balances[msg.sender] >= _weiToWithdraw, "Insufficient balance");
    (bool success, ) = msg.sender.call{value: _weiToWithdraw}("");
    require(success, "Transfer failed.");
    balances[msg.sender] -= _weiToWithdraw;
}
}