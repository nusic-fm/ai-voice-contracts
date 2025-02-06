// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
import "@openzeppelin/contracts/utils/Strings.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "./AIVoiceNFT.sol";


contract AIVoiceNFTFactory {
    event AIVoiceNFTDeployed(address _contractAddress, address _owner, string _voiceName, string _name, string _symbol);

    function deployAIVoiceNFT(string memory _voiceName, string memory _name, 
        string memory _symbol, string memory _baseUri) external returns (address) {

        AIVoiceNFT nft = new AIVoiceNFT(_voiceName, _name, _symbol, _baseUri);
        emit AIVoiceNFTDeployed(address(nft), msg.sender, _voiceName, _name, _symbol);
        return address(nft);
    }
}