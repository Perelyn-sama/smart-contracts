// multi dimensional arrays in solidity interesting
// https://hackernoon.com/arrays-in-solidity-b65c1326f48b
// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.11;

contract Jar {
     uint[][3] public fixedSizeArray;
     uint[2][] public dynamicArray;
     uint[] public arr2 = [7,8];


     constructor() public {
         uint[3] memory memArray = [uint(7), 8, 9];
         uint8[2] memory append = [7, 8];

         fixedSizeArray[0] = memArray;
         fixedSizeArray[1] = new uint[](4);
         fixedSizeArray[2] = [1,3,5,7,9];

         dynamicArray = new uint[2][](3);
         dynamicArray[0] = [1,2];
         dynamicArray[1] = [3,4];
         dynamicArray[2] = [5,6];

         dynamicArray.push(append);

     }

}