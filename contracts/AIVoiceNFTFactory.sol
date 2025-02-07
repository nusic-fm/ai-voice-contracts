// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
import "@openzeppelin/contracts/utils/Strings.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./AIVoiceNFT.sol";


contract AIVoiceNFTFactory is Ownable{
    event AIVoiceNFTDeployed(address _contractAddress, address _owner, string _voiceName, string _name, string _symbol);
    
    address public manager;

    modifier onlyOwnerOrManager() {
        require((owner() == msg.sender) || (manager == msg.sender), "Caller needs to be Owner or Manager");
        _;
    }

    function deployAIVoiceNFT(string memory _voiceName, string memory _name, 
        string memory _symbol, string memory _baseUri) external onlyOwnerOrManager returns (address) {

        AIVoiceNFT nft = new AIVoiceNFT(_voiceName, _name, _symbol, _baseUri);
        emit AIVoiceNFTDeployed(address(nft), msg.sender, _voiceName, _name, _symbol);
        return address(nft);
    }
}