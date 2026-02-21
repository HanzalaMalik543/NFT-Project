// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract NFT is ERC721, Ownable {
    using Strings for uint256;

    uint256 public constant MAX_TOKENS = 10000;
    uint256 private constant TOKENS_RESERVED = 0;
    uint256 public price = 8000000000000; 
    uint256 public constant MAX_MINT_PER_TX = 10;

    bool public isSaleActive;
    uint256 public TotalSupply;
    mapping(address => uint256) private mintedPerWallet;

    string public baseUri;
    string public baseExtension = ".json";

    constructor() ERC721("HANZALA", "hnzla") Ownable(msg.sender) {
        baseUri = "ipfs://xxxxxxxxxxxxxxxxxxxxx/";
        TotalSupply = TOKENS_RESERVED;
    }

    // Public Mint Function
    function mint(uint256 _numTokens) external payable {
        require(isSaleActive, "The sale is paused.");
        require(_numTokens <= MAX_MINT_PER_TX, "Max 10 per transaction.");
        require(mintedPerWallet[msg.sender] + _numTokens <= 10, "Max 10 per wallet.");
        
        uint256 curTotalSupply = TotalSupply;
        require(curTotalSupply + _numTokens <= MAX_TOKENS, "Exceeds MAX_TOKENS");
        require(_numTokens * price == msg.value, "Insufficient funds!");

        for (uint256 i = 1; i <= _numTokens; ++i) {
            _safeMint(msg.sender, curTotalSupply + i);
        }
        mintedPerWallet[msg.sender] += _numTokens;
        TotalSupply += _numTokens;
    }

    // Metadata Functions 
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_ownerOf(tokenId) != address(0), "ERC721Metadata: URI query for nonexistent token");

        string memory currentBaseURI = _baseURI();
        return bytes(currentBaseURI).length > 0
            ? string(abi.encodePacked(currentBaseURI, tokenId.toString(), baseExtension))
            : "";
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseUri;
    }

    //Owner-Only Functions
    function flipSaleState() external onlyOwner {
        isSaleActive = !isSaleActive;
    }

    function setBaseURI(string memory _baseUri) external onlyOwner {
        baseUri = _baseUri;
    }

    function setPrice(uint256 _price) external onlyOwner {
        price = _price;
    }

    function withdrawAll() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No balance to withdraw");

        uint256 balanceOne = (balance * 70) / 100; 
        uint256 balanceTwo = balance - balanceOne; 

        (bool transferOne, ) = payable(0xd78281fb18e044a65a0c788f2a49368EDfFA0FcA).call{value: balanceOne}("");
        
        (bool transferTwo, ) = payable(0x9847B90Af81284f5f4F992cDCE496DDc6fdBc362).call{value: balanceTwo}("");

        require(transferOne && transferTwo, "Transfer failed.");
    }
}