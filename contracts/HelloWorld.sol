// Simple contract to store and retrieve a number 

// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract HelloWorld {
    // Store number as a state variable 
    uint256 public num = 7;

    // Function to retrive the previously stored number
    function GetNum() public view returns(uint256) {
        return num;
    }
}