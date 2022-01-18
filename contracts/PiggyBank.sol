// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.9.0;

/// @title Piggybank smart contract
/// @author Perelyn-Sama
/// @notice A Piggy bank smart contract that allows the owner to save money for a particular period and after this period is completed the owner can withdraw from this contract and that would destroy the contract
/// @dev Explain to a developer any extra details

contract PiggyBank {
    address public owner;
    bool public hasBeenDeployed = false;
    uint256 public deployedAt;
    uint256 public end; 
    string public unitStr;
    uint256 public unitNum;

    constructor(string storage _unitStr, uint256 _unitNum)  public {  
        unitStr = _unitStr;
        unitNum = _unitNum;
        owner = msg.sender;
        hasBeenDeployed = true;
        deployedAt = block.timestamp;
        end = deployedAt + _unitNum _unitStr;
    }

    event Deposit(uint amount);
    event Withdraw(uint amount);

    receive() external payable {
        emit Deposit(msg.value);
    }

    function balance() external view returns (uint piggyBal) {
        piggyBal = address(this).balance;
    }

    function withdraw() external {
        require(msg.sender == owner );
        require(block.timestamp >= end, "It's not time yet");
        emit Withdraw(address(this).balance);
        selfdestruct(payable(msg.sender));
    }
}