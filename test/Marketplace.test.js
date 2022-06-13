const { expect } = require("chai");
const { BigNumber } = require("ethers")
const { ethers } = require("hardhat");

let owner;
let listNFT;
let buyNFTs;


describe("Marketplace", () =>{
    it("should deploy NFTMarket contract", async ()=>{
      const[owner,addr1] = await ethers.getSigners();
      //console.log(owner);
      const MoonToken = await ethers.getContractFactory("MoonToken");
      const moonToken = await MoonToken.deploy();
      await moonToken.deployed();
      const moonTokenAddress = moonToken.address;
      console.log(moonTokenAddress);

      const Marketplace = await ethers.getContractFactory("NFTMarket");
      const nftMarket = await Marketplace.deploy(moonTokenAddress);
      await nftMarket.deployed();
      const nftMarketAddress = nftMarket.address;
      console.log(nftMarketAddress);

      const MyNFT = await ethers.getContractFactory("MyNFT");
      const nft = await MyNFT.deploy(nftMarketAddress);
      await nft.deployed();
      const nftAddress = nft.address;
      console.log(nftAddress);

      await nft.mintNFT('ABCD', 5);
      console.log("token Id is created with name ABCD");

      await nftMarket.connect(owner).listNFTs(nftAddress, 1, 100);
      await nft.balanceOf(owner.address);
      console.log(owner.address);


      await moonToken.connect(owner).transfer(addr1.address, 1000);
      await moonToken.connect(addr1).approve(
        nftMarketAddress,
        BigNumber.from(1000)// 10000
      );
      await nft.balanceOf(owner.address);
      await nftMarket.connect(addr1).buyNFT(1);
      const amount = await nft.balanceOf(addr1.address);
      console.log(amount.toString());

    });

  })