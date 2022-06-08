//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;


import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract MyNFT is ERC721URIStorage{
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    address contractAddress; 
    constructor(address marketPlaceAddress) ERC721("CyberBird", "CYB") {
        contractAddress = marketPlaceAddress;
    }

    struct NFTInfo{
        uint256 royaltyFee;
        address creator;
    }

    mapping(uint256 => NFTInfo) public nftInfo;

    function mintNFT(string memory tokenURI, uint256 royalty) external returns (uint)
    {
        require(royalty > 0, "royality should be between 0 to 10");
        require(royalty < 10, "royality should less that 10");
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        uint256 royaltyFee = royalty;

        nftInfo[newItemId] = NFTInfo(
            royaltyFee,
            payable(msg.sender)
        );

        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);
        setApprovalForAll(contractAddress, true);
        return newItemId;
    }

    function getRoyaltyInfo (uint256 _tokenId) public view returns (NFTInfo memory) {
        return nftInfo[_tokenId];
    }
}