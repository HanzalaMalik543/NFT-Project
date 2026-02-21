# Hanzala NFT Project 🚀

A professional and gas-optimized Smart Contract for the **Hanzala NFT Collection** based on the ERC721 standard. This project utilizes the industry-standard OpenZeppelin libraries to ensure security and reliability.

## 📝 Project Overview
This smart contract is designed for a collection of 10,000 unique digital assets. It includes features like public minting, owner-reserved tokens, and automated metadata integration.

## ✨ Key Features
* **Standard Compliance**: Built using the ERC721 standard from OpenZeppelin.
* **Gas Optimized**: Implementation of local variable caching and pre-increments (`++i`) for cheaper minting.
* **Controlled Minting**: Limits of 10 tokens per transaction and 10 tokens per wallet to ensure fair distribution.
* **Flexible Metadata**: Easily update the `baseURI` even after deployment.
* **Secure Withdrawals**: Built-in functionality for the owner to withdraw funds from the contract safely.
* **Sale Control**: Ability to toggle the public sale state (`isSaleActive`).

## 🛠 Technology Stack
* **Language**: Solidity ^0.8.14
* **Libraries**: OpenZeppelin (ERC721, Ownable, Strings)
* **Tools**: Remix IDE, GitHub, Git
* **Network**: [Add intended network here, e.g., Ethereum Mainnet / Sepolia Testnet]

## 📜 Contract Details
* **Collection Name**: Hanzala
* **Symbol**: han
* **Max Supply**: 10,000
* **Mint Price**: 0.000008 ETH (8,000,000,000,000 Wei)

## 🚀 How to Use
1.  **Deployment**: Compile and deploy using Remix IDE.
2.  **Toggle Sale**: Use `flipSaleState()` to enable minting.
3.  **Minting**: Call the `mint()` function with the desired number of tokens and the correct ETH value.
4.  **Set URI**: Use `setBaseURI()` to point to your IPFS metadata folder.

## 🛡 Security
This contract inherits from OpenZeppelin's `Ownable`, ensuring that critical functions like setting the price, changing the URI, and withdrawing funds can only be accessed by the contract creator.
