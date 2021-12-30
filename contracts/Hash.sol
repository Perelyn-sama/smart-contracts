// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.9.0;

contract HashFunc {
    function hash(string memory text, uint num, address addr) external pure returns(bytes32){
      return  keccak256(abi.encodePacked(text,num, addr));
    }
}