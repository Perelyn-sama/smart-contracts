// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.9.0;

interface IERC721 {
    function safeTransferFrom(
        address from,
        address to,
        uint tokenId
    ) external;

    function transferFrom(
        address,
        address,
        uint
    ) external;
}

contract EnglishAuction {
    event Start(address indexed sender, uint startedAt);
    event Bid(address indexed sender, uint amount);
    event Withdraw(address indexed bidder, uint amount);
    event End(address winner, uint amount);

    IERC721 public nft;
    uint public nftId;

    address payable public seller;
    uint public startedAt;
    uint public endAt;
    bool public started;
    bool public ended;

    address public highestBidder;
    uint public highestBid;
    mapping(address => uint) public bids;

    constructor (address _nft, uint _nftId, uint _startingBid)  {
        nft = IERC721(_nft);
        nftId = _nftId;

        seller = payable(msg.sender);
        highestBid = _startingBid;
    }

    function start() external {
        require(!started, "Auction has already started");
        require(msg.sender == seller,"You are not the seller");

        nft.transferFrom(msg.sender, address(this), nftId);
        started = true;
        startedAt = block.timestamp;
        endAt = block.timestamp + 7 days;

        emit Start(msg.sender, startedAt);
    }

    function bid() external payable {
        require(started, "Auction has not started");
        require(block.timestamp < endAt, "Auction has ended");
        require(msg.value > highestBid,"Bid lower than previos bidder");

        if(highestBidder != address(0)){
            bids[highestBidder] += highestBid;
        }

        highestBidder = msg.sender;
        highestBid = msg.value;

        emit Bid(msg.sender, msg.value);
    }

    function withdraw() external {
        uint bal = bids[msg.sender];
        bids[msg.sender] = 0;
        payable(msg.sender).transfer(bal);

        emit Withdraw(msg.sender, bal);
    }

    function end() external {
        require(started, "Auction has not started");
        require(block.timestamp >=  endAt, "Auction has not ended");
        require(!ended, "Auction has ended");

        ended = true;
        if(highestBidder != address(0)){
            nft.safeTransferFrom(address(this), highestBidder, nftId);
            seller.transfer(highestBid);
        }else {
            nft.safeTransferFrom(address(this), seller, nftId);
        }

        emit End(highestBidder, highestBid);
    }


}