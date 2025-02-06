// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract AIVoiceNFT is ERC721, Pausable, Ownable, ReentrancyGuard{
    using Strings for uint256;

    string public defaultURI = "";
    string private baseURI = "";

    string voiceName;

    address public manager;
    uint256 public tokenMinted;
    uint256 public price = 0.001 ether;

    mapping (uint256=>string) tokenVoiceMapping;

    modifier onlyOwnerOrManager() {
        require((owner() == msg.sender) || (manager == msg.sender), "Caller needs to be Owner or Manager");
        _;
    }

    constructor(string memory _voiceName, string memory _name, 
        string memory _symbol, string memory _baseUri) ERC721(_name, _symbol) {
        manager = msg.sender;
        voiceName = _voiceName;
        baseURI = _baseUri;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    function setBaseURI(string calldata _baseuri) public onlyOwnerOrManager {
		baseURI = _baseuri;
	}

    function setDefaultRI(string calldata _defaultURI) public onlyOwnerOrManager {
		defaultURI = _defaultURI;
	}

    function setManager(address _manager) public onlyOwnerOrManager {
        manager = _manager;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "Token does not exists");
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString(),".json")) : defaultURI;
    }

    function mint(string memory _voiceURL) public payable whenNotPaused nonReentrant{
        //require(price == msg.value, "Incorrect Funds Sent" ); // Amount sent should be equal to the price
        tokenVoiceMapping[tokenMinted] = _voiceURL;
        _safeMint(msg.sender, tokenMinted++);
    }

    function mintInternal(address user, string memory _voiceURL) public onlyOwnerOrManager whenNotPaused nonReentrant{
        tokenVoiceMapping[tokenMinted] = _voiceURL;
        _safeMint(user, tokenMinted++);
    }
    
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721)
        returns (bool) {
        // Supports the following `interfaceId`s:
        // - IERC165: 0x01ffc9a7
        // - IERC721: 0x80ac58cd
        // - IERC721Metadata: 0x5b5e139f
        // - IERC2981: 0x2a55205a
        return
            ERC721.supportsInterface(interfaceId);
    }

    function pause() public onlyOwnerOrManager nonReentrant {
        _pause();
    }

    function unpause() public onlyOwnerOrManager nonReentrant {
        _unpause();
    }

    function setPrice(uint256 newPrice) public onlyOwnerOrManager {
        require(newPrice > 0, "Price can not be zero");
        price = newPrice;
    }

    function withdraw() public onlyOwner nonReentrant{
        require(owner() != address(0),"Owner Address is NULL");
        (bool sent1, ) = owner().call{value: address(this).balance}("");
        require(sent1, "Failed to withdraw");
    }

}