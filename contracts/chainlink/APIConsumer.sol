// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Code from https://docs.chain.link/docs/make-a-http-get-request/

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";

contract APIConsumer is ChainlinkClient {
    using Chainlink for Chainlink.Request;

    uint256 public volume;

    address private oracle;
    bytes32 private jobId;
    uint256 private fee;

    /**
    NetWork: Kovan 
    Oracle: 0xc57B33452b4F7BB189bB5AfaE9cc4aBa1f7a4FD8 (Chainlink Devrel Node)
    Job ID: d5270d1c311941d0b08bead21fea7747
    Fee: 0.1 LINK
     */

     constructor() {
         setPublicChainlinkToken();
         oracle = 0xc57B33452b4F7BB189bB5AfaE9cc4aBa1f7a4FD8;
         jobId = "d5270d1c311941d0b08bead21fea7747";
         fee = 0.1 * 10 ** 18; // (Varies by NetWork and job)
     }

     /**
     Create a chainlink request to retrieve API  response, find the target 
     data, then multiply by 1000000000000000000(to remove decimal places from data)
      */
    function requestVolumeData() public returns (bytes32 requestId) {
        Chainlink.Request memory request = buildChainlinkRequest(jobId, address(this), this.fulfill.selector);

        // Set the URL to perform the GET request on
        request.add("get", "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=ETH&tsyms=USD");

        // Set the path to find the desired data in the API response, where the response format is:
        // {"RAW":
        //   {"ETH":
        //    {"USD":
        //     {
        //      "VOLUME24HOUR": xxx.xxx,
        //     }
        //    }
        //   }
        //  }       
        request.add("path", "RAW.ETH.USD.VOLUME24HOUR");

        // Multiply the result by 1000000000000000000 to remove decimals 
        int timesAmount = 10**18;
        request.addInt("times", timesAmount);

        // Send the request 
        return sendChainlinkRequestTo(oracle, 	request, fee);
    }

    /**
     * Recieve the response in the form of uint256 
     */

     function fulfill(bytes32 _requestId, uint256 _volume) public recordChainlinkFulfillment(_requestId){
         volume = _volume;
     }

     // function withdrawLink() external {} - Implement a withdraw function


}