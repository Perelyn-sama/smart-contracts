// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.9.0;

/// @title Piggybank smart contract
/// @author Perelyn-Sama
/// @notice A Piggy bank smart contract that allows the owner to save money for a particular period and after this period is completed the owner can withdraw from this contract and that would destroy the contract


contract PiggyBank {
    address public owner;
    bool public hasBeenDeployed = false;
    uint256 public deployedAt;
    uint256 public end; 

    uint public second = 1 seconds;
    uint public minute = 1 minutes;
    uint public hour = 1 hours;
    uint public day = 1 days;

    constructor()  public {  
        owner = msg.sender;
        hasBeenDeployed = true;
        deployedAt = block.timestamp;
        end = deployedAt + 2 minutes;
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

    function check(string memory a, string memory b) public returns (bool) {
        if(bytes(a).length != bytes(b).length) {
            return false;
        } else {
            return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
        }
    }

     function getTime(string memory str, uint num) external returns(uint res) {
        if(check(str, 'days')){
            res = num * 86400;   
        }else if(check(str, 'hours')) {
            res = num * 3600;
        }else if(check(str, 'minutes')) {
            res = num * 60;
        }else if(check(str, 'seconds')){
            res = num * 1;
        }else {
            res = 0;
        }
    }