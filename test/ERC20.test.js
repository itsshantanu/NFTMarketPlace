const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("ERC20", function (){
    it("should return correct Symbol", async ()=>{
      const [owner] = await ethers.getSigners();
      console.log(owner);
      const MoonToken = await ethers.getContractFactory("MoonToken");
      const hardhatToken = await MoonToken.deploy();
      await hardhatToken.deployed();
      const ownerBalance = await hardhatToken.balanceOf(owner.address);
      expect(await hardhatToken.totalSupply()).to.equal(ownerBalance);
      console.log(ownerBalance);
      expect(await hardhatToken.symbol()).to.equal("MOON");

    });

    it("should return correct name", async() =>{
      const MoonToken = await ethers.getContractFactory("MoonToken");
      const hardhatToken = await MoonToken.deploy();
      await hardhatToken.deployed();

      expect(await hardhatToken.name()).to.equal("MoonToken");
    })
  })