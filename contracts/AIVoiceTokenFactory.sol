// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./AIVoiceToken.sol";

contract AIVoiceTokenFactory is Ownable{
    event AIVoiceTokenDeployed(address contractAddress, address owner, string name, string symbol, uint256 initialSupply);

    AIVoiceToken[] public deployedTokens;
    address public manager;

    modifier onlyOwnerOrManager() {
        require((owner() == msg.sender) || (manager == msg.sender), "Caller needs to be Owner or Manager");
        _;
    }

    function deployAIVoiceToken(
        string memory _name,
        string memory _symbol,
        uint256 _initialSupply,
        address _owner
    ) external onlyOwnerOrManager returns (address) {
        require(_owner != address(0), "Invalid owner address");

        AIVoiceToken token = new AIVoiceToken(_name, _symbol, _initialSupply, _owner);
        deployedTokens.push(token);

        emit AIVoiceTokenDeployed(address(token), _owner, _name, _symbol, _initialSupply);
        return address(token);
    }

    function getDeployedTokens() external view returns (AIVoiceToken[] memory) {
        return deployedTokens;
    }
}
