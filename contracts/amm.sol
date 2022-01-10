// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.9.0;

// constant product 2500000000
// initial value for x and y is 50000,50000

contract Amm {
    uint public x;
    uint public y;
    uint public k;

    // Provide liquidity 
    function provide(uint _x, uint _y) external {
        require(_x == _y, "Pairs should be equal");
        x = _x;
        y = _y;
        k = _x * _y;
    }

    // Get amount of x needed to swap y
    function xfory(uint _x) external view returns(uint) {
        uint newX = x + _x;
        uint newY = k / newX;
        uint res = y - newY;
        return res;
    }

    // Get amount of y needed to swap y
    function yforx(uint _y) external view returns(uint) {
        uint newY = y + _y;
        uint newX = k / newY;
        uint res = x - newX;
        return res;
    }
}