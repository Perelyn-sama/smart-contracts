// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.9.0;

contract EtherWallet {
    // Owner of the wallet
    address public owner;

    // Set the address that deploys this contract as the owner
    constructor(){
        owner = msg.sender;
    }

    // Give contract the ability to receive ether
    receive() external payable {}

    // Function to withdraw 
    function withdraw(uint _amount) external {
        require(msg.sender == owner, "Caller is not owner");
        payable(msg.sender).transfer(_amount);
    }
    // As the name implies get balance
    function getBalance( ) external view returns (uint) {
        return address(this).balance;
    }
}
