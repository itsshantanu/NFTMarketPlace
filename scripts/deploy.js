const hre = require('hardhat');

async function main() {
  const MoonToken = await hre.ethers.getContractFactory('MoonToken');
  const moonToken = await MoonToken.deploy();

  await moonToken.deployed();

  console.log('moonToken deployed to:', moonToken.address);

  // For NFTMarket Place

  const NFTMarket = await hre.ethers.getContractFactory('NFTMarket');
  const nftMarket = await NFTMarket.deploy(moonToken.address);

  await nftMarket.deployed();

  console.log('NFTMarket deployed to:', nftMarket.address);

  // For NFT

  const NFT = await hre.ethers.getContractFactory('MyNFT');
  const nft = await NFT.deploy(nftMarket.address);

  await nft.deployed();

  console.log('NFTToken deployed to:', nft.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
