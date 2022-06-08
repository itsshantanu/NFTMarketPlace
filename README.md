# NFT MarketPlace from Scratch

NFT marketPlace is a platform where user can mint,buy and sell NFTs.

## Environment Variables

To run this project, you will need to add the following environment variables to your .env file

```
    ROPSTEN_API_URL = "https://ropsten.infura.io/v3/YOUR_API_KEY"
    PRIVATE_KEY = "YOUR-METAMASK-PRIVATE_KEY"
```

## NPM Packages:

 - [Openzeppelin](https://docs.openzeppelin.com/)
 - [Hardhat Ethers](https://www.npmjs.com/package/hardhat-ethers)
 - [Chai](https://www.npmjs.com/package/chai)
 - [Ethers](https://www.npmjs.com/package/ethers)
 - [ethereum-waffle](https://www.npmjs.com/package/ethereum-waffle)
 - [dotenv](https://www.npmjs.com/package/dotenv)

## Tech Stack:
 - [Node](https://nodejs.org/en/)
 - [Hardhat](https://hardhat.org/tutorial/)
 - [Solidity](https://docs.soliditylang.org/en/v0.8.13)


## Run Locally:

Clone the github repo:
```
https://github.com/itsshantanu/NFTMarketPlace
```

Install Node Modules
```
npm install
```

Compile
```
npx hardhat compile
```

Test
```
npx hardhat test
```

Deploy on Localhost
```
npx hardhat node
npx hardhat run scripts/deploy.js --network localhost
```

Deploy on Ropsten
```
npx hardhat run scripts/deploy.js --network ropsten
```

Help
```
npx hardhat help
```

## Check at Rinkeby Test Net:
 - [MoonToken](https://ropsten.etherscan.io/address/0xcd7360527C8f8b6196192CC45f69a8F5D7b53da2)
 - [NFTMarket](https://ropsten.etherscan.io/address/0xB837D083294b86F600104F6F0E56A8D4966Da50c)
 - [NFTToken](https://ropsten.etherscan.io/address/0x25ad46407Bb402EcbFdbB742d3De6F208794e037)
