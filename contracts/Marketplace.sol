//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

interface GetRoyalty {
    struct NFTInfo{
        uint256 royaltyFee;
        address creator;
    }

    function getRoyaltyInfo(uint256 _tokenId) external view returns (NFTInfo memory info);
}

contract NFTMarket is ReentrancyGuard, ERC721Holder{
    using Counters for Counters.Counter;
    Counters.Counter private _itemsIds;
    IERC20 public tokenAddress; 
    uint256 public platformFee = 25;

    address payable owner; 
    
    constructor(address _tokenAddress) {
        owner = payable(msg.sender);
        tokenAddress = IERC20(_tokenAddress);
    }

    GetRoyalty.NFTInfo info;

    function getRoyalty(address nftContractAddress, uint256 _tokenId) public {
        info = GetRoyalty(nftContractAddress).getRoyaltyInfo(_tokenId);
    }

    struct NFTMarketItem{
        uint256 tokenId;
        uint256 price;
        address nftContract;
        address payable owner;
        address payable seller;
        bool sold;
    }

    mapping(uint256 => NFTMarketItem) public marketItems;

    event MarketItemCreated(
        uint256 indexed tokenId,
        uint256 price,
        uint256 royalty,
        address creator,
        address indexed nftContract,
        address owner,
        address seller, 
        bool sold  
    );


    function listNFTs(address nftContract, uint256 tokenId, uint256 price) external nonReentrant {
        require(price > 0, "Price must be atleast 1 Wei");
        
        _itemsIds.increment();
        uint256 itemId = _itemsIds.current();

        marketItems[itemId] = NFTMarketItem(
            tokenId,
            price,
            nftContract,
            payable(address(0)),
            payable(msg.sender),  
            false
        );

        IERC721(nftContract).safeTransferFrom(msg.sender, address(this), tokenId);

        emit MarketItemCreated( 
            tokenId,
            price,
            info.royaltyFee,
            info.creator,
            nftContract, 
            address(0),
            msg.sender,
            false
            );
    }


    function buyNFT(uint256 tokenId) external payable nonReentrant{

        NFTMarketItem memory readItem = marketItems[tokenId];

        require(readItem.sold == false, "NFT is not up for sale");
        require(msg.sender.balance >= readItem.price, "Account balance is less then the price of the NFT");
        uint256 price = readItem.price;
        uint256 royaltyFee = (price / 100) * info.royaltyFee;
        uint256 marketPlaceFee = price * platformFee / 1000;
        
        tokenAddress.transferFrom(msg.sender, address(readItem.seller), price);
        tokenAddress.transferFrom(msg.sender, address(info.creator), royaltyFee);
        tokenAddress.transferFrom(msg.sender, address(this), marketPlaceFee);

        marketItems[tokenId].owner = payable(msg.sender);
        marketItems[tokenId].sold = true;
           
        IERC721(marketItems[tokenId].nftContract).safeTransferFrom(address(this), msg.sender, tokenId);    
    }
}